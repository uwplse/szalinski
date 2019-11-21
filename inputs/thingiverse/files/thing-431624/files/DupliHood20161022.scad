/*	DupliHood -- a slide copying attachment

	This OpenSCAD program creates a slide copy mount that
	screws into the filter mount of a macro lens.  There
	are a multitude of issues -- the most obvious of which
	is that not all macro lenses can focus to 1:1, but the
	fact that you'll often want to copy film slides using
	a camera with a smaller sensor means 1:1 isn't needed,
	and you can always stick an extension tube behind your
	macro lens....

	This program currently supports making copy attachments
	for 6x6cm and 35mm slides. Each slide copier consists
	of two parts, a threaded tube and a spring holder for
	the slide. The tube length is dependent on the lens you
	use and the ratio of the film size you want to copy to
	the sensor size of your camera, thus you must customize
	the filter screw thread and length for it. The slide
	holder is specific to the film format only. The springs
	are printed with enough flex and clearance to accomodate
	glass-mounted slides, but also work fine with standard
	cardboard slide mounts.

	In fact, there is an optional third part to DupliHood:
	a diffuser to fit behind the slide. I don't recommend
	using it because 3D-printed parts often don't transmit
	light evenly enough to be a good diffuser.

	I've written an Instructable giving more details....

	Revisions:

	20140817	Original release
	20140824	Removed print_part() left over from lenscaps,
				increased spring bump & space around film area,
				added thread alignment test part
	20161022	Removed [Global] directive (Customizer is broken!)

	(C) 2014 Hank Dietz
*/

// What is the filter major diameter (size)?
thread_diameter = 550; // [240:24mm,250:25mm,270:27mm,300:30mm.305:30.5mm,340:34mm,355:35.5mm,365:36.5mm,370:37mm,375:37.5mm,390:39mm,405:40.5mm,430:43mm,460:46mm,480:48mm,490:49mm,520:52mm,530:53mm,550:55mm,580:58mm,620:62mm,670:67mm,720:72mm,770:77mm,820:82mm,860:86mm (86M or 86C),940:94mm (94C),950:95mm (95C),1050:105mm (105C),1070:107mm (107 or 107C),1100:110mm,1120:112mm,1125:112.5mm,1250:125mm (125C),1270:127mm,1380:138mm,1450:145mm]

// What is the filter thread pitch?
thread_pitch = 75; // [50:Fine 0.5mm, 75:Standard 0.75mm, 100:Coarse 1.0mm, 150:Very coarse 1.5mm]

// Tolerance to allow for inaccurate filament placement (usually extrusion diameter/2), in microns?
thread_tolerance = 100; // [0:500]

// Thread rotation angle (to align slide mask with the camera)?
thread_rotate = 45; // [0:359]

// What is the distance from the lens front to the slide mount?
tube_length = 125; // [20:200]

// What is the slide format?
film = "film6x6"; // [film6x6:Mounted 6x6cm slides,film35:Mounted 35mm (135 format) slides]

// Which part do you want to make?
part = "exploded"; // [tube:The threaded tube,springpart:The spring cap that holds the slide, diffuser:The optional diffuser,exploded:Exploded view of all three parts,align:Test part for thread rotational alignment]

/* [Hidden] */

use <write/Write.scad>


filmx=((film == "film6x6") ? 60 : 36);
filmy=((film == "film6x6") ? 60 : 24);
framex=((film == "film6x6") ? 70 : 50);
framey=((film == "film6x6") ? 70 : 50);
framez=3.25;
frametol=1;
lip=2;
diag=sqrt(((framex+frametol)*(framex+frametol))+((framey+frametol)*(framey+frametol)));
innertall=80;
overlap=5;
spring=1;

$fn=90;
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

module springpart() {
	union() {
		echo(str("Making Spring Holder for ", film, "."));

		difference() {
			// outer rim
			cylinder(r=diag/2+lip+lip, h=framez+spring+overlap);

			// slide holder
			translate([0, 0, framez+spring])
			cylinder(r=diag/2+lip, h=1000);

			// slide removal access, shifted up as of 20140824
			translate([0, 500-(framey/2)+frametol/4, 0])
			cube([framex+frametol, 1000, 1000], center=true);
		}

		difference() {
			union() {
				// spring
				translate([0, 0, spring/2])
				cube([framex, (framey+frametol)*1, spring], center=true);

				// bump on the spring, thicker as of 20140824
				difference() {
					translate([0, filmy/7, -filmy*2+spring*3])
					rotate([0, 90, 0])
					cylinder(r=filmy*2, h=framex, center=true, $fn=180);
					translate([0, 0, -500])
					cube([1000, 1000, 1000], center=true);
				}
			}

			// clear film area + double tolerance as of 20140824
			translate([0, 500-(filmy+frametol)/2-frametol, 0])
			cube([filmx+2*frametol, 1000, 1000], center=true);
		}
	}
}

module diffuser() {
	echo(str("Making optional diffuser for ", film, "."));

	translate([0, 0, overlap*2+1])
	mirror([0, 0, 1])
	union() {
		difference() {
			// outer rim
			cylinder(r=diag/2+lip+lip+lip, h=overlap);
			cylinder(r=diag/2+lip+lip, h=1000, center=true);
		}

		translate([0, 0, overlap])
		difference() {
			cylinder(r=diag/2+lip+lip+lip, h=overlap+1);
			cylinder(r1=diag/2+lip+lip-1, r2=diag/2+lip+lip+lip-1, h=overlap);
			translate([0, 0, -500])
			cube([1000, 1000, 1000], center=true);
		}
	}
}

module tube(len=125) {
	assign(dia=thread_diameter/10)
	assign(mag=((dia<49) ? 0.5 : 1))
	assign(pitch=thread_pitch/100.0)
	assign(ctol=thread_tolerance/1000.0)
	union() {
		echo(str("Making Screw-On M-", dia, " X ", pitch, " Slide Copy tube ", len, "mm long."));

		// base
		difference() {
			// flat
			cylinder(r=diag/2+lip, h=overlap);
			translate([0, 0, lip])
			cylinder(r=diag/2, h=overlap);

			// clear film area
			hull() {
				translate([0, 0, -1])
				cube([filmx, filmy, 2], center=true);
				translate([0, 0, 1+lip])
				cube([filmx+lip, filmy+lip, 2], center=true);
			}
		}

		// tube
		translate([0, 0, overlap])
		intersection() {
			difference() {
				union() {
					cylinder(r1=diag/2+lip, r2=dia/2, h=len-overlap-3);
					for (rot=[0,180])
					rotate([0, 0, rot])
					translate([0, diag/2+lip-40/2, lip*2+12])
					rotate([90, 0, 180])
					scale([0.8, 1, 1])
					write("DUPLIHOOD", t=40, h=12, center=true);
				}
				translate([0, 0, -0.01])
				cylinder(r1=diag/2, r2=dia/2-lip, h=len-overlap-3+0.02);
			}
			translate([0, 0, -0.1/2])
			cylinder(r1=diag/2+lip+1, r2=dia/2+1, h=len-overlap-3+0.1);
		}

		// screw filter part
		translate([0, 0, len-3])
		intersection() {
			difference() {
				rotate([0, 0, thread_rotate]) // roughly align thread
				male_thread(pitch, dia-ctol, 3, 0.25);
				cylinder(r=dia/2-lip, h=1000, center=true);
			}
			cylinder(r1=(dia/2)+4, r2=(dia/2)-1, h=3, $fn=90);
		}
	}
}

module aligntest() {
	assign(dia=thread_diameter/10)
	assign(mag=((dia<49) ? 0.5 : 1))
	assign(pitch=thread_pitch/100.0)
	assign(ctol=thread_tolerance/1000.0)
	union() {
		echo(str("Making Screw-On M-", dia, " X ", pitch, " thread alignment test."));

		// base
		difference() {
			union() {
				cylinder(r=dia/2, h=1);

				translate([0, 0, 1])
				// screw filter part
				rotate([0, 0, thread_rotate]) // roughly align thread
				male_thread(pitch, dia-ctol, 3, 0.25);
			}

			translate([0, 0, 2])
			cylinder(r=dia/2-2, h=4);

			difference() {
				hull() {
					cylinder(r=.75*dia/2, h=100, center=true);
					cube([0.001, dia-2*lip, 100], center=true);
				}
				cube([dia*5, 12, 200], center=true);
			}

			translate([0, 0, -10/2+1])
			rotate([180, 0, 0])
			write(str("rotate ", thread_rotate), t=10, h=6, center=true);
		}
	}
}

print_part();

module print_part() {
	if (part == "tube") {
		color("gray")
		tube(tube_length);
	} else if (part == "springpart") {
		color("white")
		springpart();
	} else if (part == "diffuser") {
		color("white")
		diffuser();
	} else if (part == "exploded") {
		union() {
			color("white")
			diffuser();
			translate([0, 0, lip+overlap*2+1])
			union() {
				color("white")
				springpart();
				translate([0, 0, lip*6])
				color("gray")
				tube(tube_length);
			}
		}
	} else {
		color("red")
		aligntest();
	}
}



