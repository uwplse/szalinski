/*	screwcap

	This OpenSCAD program creates lenscaps that loosely
	screw into standard lens filter threads.  The thread
	pitches are tiny, so a more easily printable profile
	is used instead of truly standard one; the loose fit
	is appropriate for a lenscap intended merely to
	protect the lens, but don't try to pick-up the lens
	by the cap -- it isn't deeply seated in the thread.

	So, what are the standard filter sizes?  Anybody?
	I couldn't find an authoritative list.  Wikipedia
	simply lists some common sizes and says the thread
	pitch can be 0.5, 0.75, or 1mm and "a few sizes
	(e.g., 30.5mm) come in more than one pitch."  Great.
	There are some comments on the WWW about "C" meaning
	coarse thread... 1mm pitch?  Thus, I'm leaving it up
	to the user to specify....

	I've written an Instructable giving more details....

	(C) 2014 Hank Dietz
*/

use <write/Write.scad>

/* [Global] */

// What is the filter major diameter (size)?
cap_diameter = 490; // [240:24mm,250:25mm,270:27mm,300:30mm.305:30.5mm,340:34mm,355:35.5mm,365:36.5mm,370:37mm,375:37.5mm,390:39mm,405:40.5mm,430:43mm,460:46mm,480:48mm,490:49mm,520:52mm,530:53mm,550:55mm,580:58mm,620:62mm,670:67mm,720:72mm,770:77mm,820:82mm,860:86mm (86M or 86C),940:94mm (94C),950:95mm (95C),1050:105mm (105C),1070:107mm (107 or 107C),1100:110mm,1120:112mm,1125:112.5mm,1250:125mm (125C),1270:127mm,1380:138mm,1450:145mm]

// What is the filter thread pitch?
cap_pitch = 75; // [50:Fine 0.5mm, 75:Standard 0.75mm, 100:Coarse 1.0mm, 150:Very coarse 1.5mm]

// Tolerance to allow for inaccurate filament placement (usually extrusion diameter/2), in microns?
cap_tolerance = 125; // [0:500]

// How thick do you want the cap grip to be, in microns?  Thicker uses more material, but feels nicer and can accept labels on both sides.
cap_thick = 1000; // [1000:5000]

// How do you want the cap labeled?
cap_label_position = "inside"; // [no:No markings, inside:Size on the inside, outside:Size on the outside,both:Size on the inside and name on the outside]

// The name to use on the outside would be:
cap_name = "LensCap";

/* [Hidden] */

$fn=30;
tol=0.25;
mystep=5;


module male_thread(P, D_maj, Tall, tol=0, step=mystep) {
	// male thread is also called external thread
	assign(H=sqrt(3)/2*P)
	assign(fudge=0.0001)
	intersection() {
		translate([0, 0, Tall/2])
		cube([2*D_maj, 2*D_maj, Tall], center=true);
		for(k=[-P:P:Tall+P]) translate([0, 0, k])
		for(i=[0:step:360-step]) hull() for(j = [0,step]) {
			rotate([0,0,(i+j)])
			translate([D_maj/2, 0, (i+j)/360*P])
			rotate([90, 0, 0])
			linear_extrude(height=0.1, center=true, convexity=10)
			polygon(points=[
[-H*2/8-P/8-tol, 0],
[P/2-H*2/8-P/8-tol, P/2],
[-H*2/8-P/8-tol, P],
[-D_maj/2-fudge, P],
[-D_maj/2-fudge, 0]],
				paths=[[0,1,2,3,4]],
				convexity=10);
		}
	}
}


module mkgrip(Dia, Tall=5, Bumps=90, Flats=10, Chamfer=false) {
	assign(Bumpd=Dia*3.141592654/Bumps)
	union() {
		for (i=[0 : 1 : Bumps])
		assign(pos=i*360/Bumps)
		assign(fpos=pos*Flats)
		assign(foff=(0.5-sin(fpos))/1.5*Bumpd/2)
		if (foff < Bumpd)
		assign(off=Dia/2+foff)
		translate([sin(pos)*off, cos(pos)*off, 0])
		cylinder(r=Bumpd/2, h=Tall, center=true, $fn=8);

		if (Chamfer == true) {
			translate([0, 0, Tall/2-Bumpd/2])
			difference() {
				cylinder(r2=Dia/2, r1=Dia/2-2*Bumpd, h=Bumpd);
				cylinder(r=Dia/2-2*Bumpd, h=Bumpd);
			}
		}
	}
}


module print_part() {
	assign(dia=cap_diameter/10)
	assign(lab=str(dia))
	assign(mag=((dia<49) ? 0.5 : 1))
	assign(pitch=cap_pitch/100.0)
	assign(ctol=cap_tolerance/1000.0)
	assign(thick=cap_thick/1000)
	union() {
		echo(str("Making Screw-On M-", dia, " X ", pitch, " LensCap."));
		difference() {
			cylinder(r=(dia+6)/2, h=thick);
			mkgrip(dia+6, Tall=3*thick, Bumps=90, Flats=10, Chamfer=false);
			if ((cap_label_position == "inside") || (cap_label_position == "both")) {
				echo(str("Inside is marked ", dia, "."));
				translate([0, 0, thick])
				scale([mag*2/len(lab), mag*2/len(lab), 1])
				write(lab,t=1,h=20,center=true);
			}
			if (cap_label_position == "outside") {
				echo(str("Outside is marked ", dia, "."));
				rotate([0,180,0])
				scale([mag*2/len(lab), mag*2/len(lab), 1])
				write(lab,t=1,h=20,center=true);
			} else if (cap_label_position == "both") {
				echo(str("Outside is marked ", cap_name, "."));
				rotate([0,180,0])
				scale([mag*3/len(cap_name), mag*3/len(cap_name), 1])
				write(cap_name,t=1,h=20,center=true);
			}
		}
		translate([0, 0, thick-0.5])
		intersection() {
			difference() {
				male_thread(pitch, dia-ctol, 3, 0.25);
				cylinder(r=(dia-3)/2, h=50, center=true, $fn=90);
			}
			cylinder(r1=(dia/2)+4, r2=(dia/2)-1, h=3, $fn=90);
		}
	}
}

print_part();
