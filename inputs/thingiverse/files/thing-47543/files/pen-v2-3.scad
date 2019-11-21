// personalized pen/pencil holder maker

use <write/Write.scad>	// which does the cool writing
use <utils/build_plate.scad>	 // build plate

crossSection=0*0;		// 1=cross section pen to check measurements

cartstyle = 4*1;	// 1= Pilot Hi-Tec C push in front, screw tip cover on to hold
						// 2= Pilot Hi-Tec C push in back, push in plug to hold
						// 3= http://www.pennstateind.com/library/PKEXEC-PEN_ins.pdf
						// 4= Pilot G2 push in back
						// 5= Fit over a pencil

// Note that only capstyle 4 has been printed recently, so the others may not work any more, but 
// the code is left for potential future utility.

// text to embed in pen, don't make it longer than the pen body (with room for the cap) or things get weird

// label = text string
// squish = scaling factor to make text fit
// sh = scaling factor for height of writing
// letterspace = letter spacing, 1=normal, 0=all stacked, 0.9=tight, etc.
// txs = text shift as a percentage of pen diameter, to center writing over pen body.
//    For Orbitron, if there are descenders, use 0.15, for no descenders use -0.05

// Label
label="laird@popk.in";
// Handed
Handed= 0; //[0:Right, 180:Left]
// Font
Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
f=Font;
// Scaling factor for text, 1=normal, 0.7 = narrow, 1.5 = wide
squish=0.69;
fno=6+0;
// Spacing between letters, 1=normal, 0.7 crushed together, 1.5 = spread apart
letterspace=1;
// Vertical position of text (make sure it's centered). Around 0 for mixed case, 0.15 if no descenders.
txs=0.15;

// Color to print? For dualstrusion, generate both 'black' and 'white' and merge for dualstrusion.
c=0; // [0: Single Extruder, 1:Black, 2:White]
// Parts: All, body, cap, or plug. Print the pieces one at a time if you want to use different colors, or all at once for convenience.
parts=1; // [1:All parts, 2:Body, 3: Cap, 4:Plug]

//label="max@popk.in";f="orbitron.dxf";squish=0.6;letterspace=1;sh=0.7;

// Gap between cap and body, 0.1 = tight. Adjust for your printer to get a tight fit, requiring a bit of a push but not impossible.
clearance=0.1;
// Print support under the tip to reduce warping
support=1;	// [1:Support, 0:No support]
// Print 'ears' on the ends of the pen to reduce warping
ears=1; //[1:Ears, 0:No ears]

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

// End Customizer params

g=0.05*1;		// tiny amount to force overlaps between aligned shapes

// geometry
// h=height of barrel in mm
// id = inner diameter
// d = outer diameter
// fn = number of sides of barrel, 30=pretty round, 6=hexagon, etc.
// fno = outer number of sides

// what are we fitting around? Comment out all but what you want, because OpenSCAD
// doesn't support conditional assignment, apparently.

//if (cartstyle == 1) {	// Pilot Hi-Tec C push in front
/*
	h=115;
	id=6.2;
	d=8.6;
	tod=7; // tip outer diameter
	th=6.4;
	snh = 4; // snap height (distance to 'snap' from end of pen body)
	snw = 1;	// width of snap
	snd = 9.5; // diameter of 'snap' area
	std = 8.5;	// diameter of snap tip
	
	g=0.05;		// tiny amount to force overlaps between aligned shapes
//	}
*/

//if (cartstyle == 2) {	// Pilot Hi-Tec C push in from back of pen body)
/*
	h=115;
	id=6.2;
	d=8.6;
	tod=7; // tip outer diameter
	th=6.4;
	snh = 4; // snap height (distance to 'snap' from end of pen body)
	snw = 1;	// width of snap
	snd = 9.5; // diameter of 'snap' area
	std = 8.5;	// diameter of snap tip
	
	ttotalh=9;
	ttd=2.7;
	ttr=ttd/2;
	tth=3;
	ttz=0;
	tmd=3.6;
	tmr=tmd/2;
	tmh=2.5;
	tnh=ttotalh-tmh-tth;
	tnz=tth;
	tmz=ttotalh-tmh;
	
	echo(ttotalh);
	echo(tth, ttr);
	echo(tnh, tnz);
	echo(tmh, tmr, tmz);
//	}
*/

/*
// if (cartstyle == 3) {	// http://www.pennstateind.com/library/PKEXEC-PEN_ins.pdf
	h = 73	;
	id=9.525;
	d=11;
	fn = 32;
	fno=fn;
//	}
*/

//if (cartstyle == 4) { // Pilot G2 push in back
	plugh=5*1;
	h=92+plugh+plugh;	// height of cartridge plus plug
	id=7*1; // diameter of cart is 6.5, so add 0.5mm for clearance
	d=11.5*1;		// diameter of pen body (the outside)
	tod=10*1; // tip outer diameter
	tor=tod/2;
	th=6.4*1;

	// 'snap' is the area at the front and back of the pen that holds the cap on
	snh = 4*1; // snap height (distance to 'snap' from end of pen body)
	snw = 1*1;	// width of snap (along length of pen)
	snd = d*1; // diameter of 'snap' area, matches hi-tec C cap
	std = snd-1*1;	// diameter of snap tip, are forward of snap ring

	ttotalh=9*1;
	ttd=3.5*1;	// tip of tip inner diameter
	ttod=5.2*1;	// tip of tim outer diameter
	ttr=ttd/2;
	ttor=ttod/2;
	tth=3*1;		// height of tip of tip
	ttz=0*1;
	tmd=4*1;	// tip middle diameter (was 7)
	tmr=tmd/2;
	tmh=2.5*1;	// tip middle height
	tnh=ttotalh-tmh-tth;	// tip niddle height (cone shaped part between middle and pen)
	tnz=tth;
	tmz=ttotalh-tmh;
	
	echo(ttotalh);
	echo(tth, ttr);
	echo(tnh, tnz);
	echo(tmh, tmr, tmz);
//	}

/*
//if (cartstyle==5) {// to fit over a pencil
	h = 100;
	id = 7.25;
	d=9;
	fn = 6;
	fno=fn; 
//	}
*/

platformx = ttotalh+h+50;
platformxcenter = 10*1;
platformy = ttotalh+snh;
platformz = 0.3*1;

// barrel shape
// h = 100;id = 7.25;d=9;fn = 6; fno=fn; // to fit over a pencil
// h = 100;id = 7.25;d=20;fn = 6; fno = 3; // to fit over a pencil, chunky triangle

st = 0.1*1; // support thickness, so one layer prints

// then compute from above
r = d/2;	// outer radius, used to generate geometry
ir = id/2;	// inner radius
u = -1*1;		// additional letter height beyond body of pen
u2 = 1*1;		// additional vertical height
fh=d+u;	// font height
fd=d+u2;
bh=1.5*h;	// core body height
snr=snd/2;
str = std/2;
echo("str ",str);

plugth = 5*1;	// how far plug extends past end of pen
plugr = ir-0.2;	// if it fits
plugsnapheight = 0.3*1;

// Space between the Letters and the border
spacing=0*1; // makes letters closer together

// How big the letters are
textheight=d;

// The space between the letters.

// Calc the width of the text.
// A BIG thanks to HarlanDMii for this code
textwidth=(.6875*fh*letterspace);  
width=textwidth*(len(label));

pr = 5*1;	// pad radius keeping tip from curling
pt = 0.3*1;	// pad thickness
po=1*1;		// pad overlap with pen body

echo ("width ",width);

module body() {
	// body shape
	echo("body or", r);
	echo("snap or", snr);
	echo("snap top or", str);

	rotate([90,0,90]) translate ([0,0,-h/2+snh]) cylinder(r=r, h=h-2*snh, $fn=fno); // body
	if (cartstyle == 1) {
		rotate([-90,0,90]) translate([0,0,h/2]) cylinder(h=th,r=tor, $fn=32); // tip
		translate([-((h/2)+pr+th-po),0,-fh/2]) cylinder(r=pr, h=pt);	// pad
		}
	else {
		rotate([-90,0,90]) translate([0,0,h/2]) cylinder(h=ttotalh,r2=ttor, r1=tor, $fn=32); // tip cone
		}
	rotate([-90,0,90]) translate([0,0,h/2-snh]) cylinder(h=snw,r=snr, $fn=32); // snap
	rotate([-90,0,90]) translate([0,0,h/2-snh]) cylinder(h=snh,r=str, $fn=32); // end
	rotate([90,0,90]) translate([0,0,h/2-snh]) cylinder(h=snw,r=snr, $fn=32); // snap
	rotate([90,0,90]) translate([0,0,h/2-snh]) cylinder(h=snh,r=str, $fn=32); // end

	if (support) {
		for (supportx = [-ttr:ttr:ttr]) {
			rotate([-90,0,90]) translate([supportx,0,h/2-snh]) cube([platformz/2,r,ttotalh+snh]); //cube([platformz,ir,ttotalh]); 
			}
		rotate([-90,0,90]) translate([-ttr,0,h/2+ttotalh-platformz]) cube([2*ttr,r,platformz/2]); //cube([platformz,ir,ttotalh]); 
		}
	}

coreh = h+th;

module tip1core() {
	difference() {
		cylinder(r=ir, h=coreh, $fn=fn); // inner cylinder to subtract
		//translate([0,0,h/2]) cylinder(r=ir+10, $fn=fn);
		}
	}

// through tip

module tip2core() {
	cylinder(r=ttr, h=tth+g, $fn=fn);								// tip of tip cylinder
	translate([0,0,tth]) cylinder(r1=ttr, r2=tmr, h=tnh+g, $fn=fn);	// tip middle
	translate([0,0,tmz]) cylinder(r=tmr, h=tmh+g+1, $fn=fn);	// tip middle to pen body
	translate([0,0,ttotalh+1]) cylinder(r=ir, h=h+th, $fn=fn);	// main body core
	echo("core IR ",ir);
	for (offset = [0:1.5:9]) {
		translate([0,0,ttotalh+h-(plugh-.5)+offset]) cylinder(h=1,r=ir+0.3, $fn=fn); // another snap
		}
	translate([0,0,ttotalh+h-(plugh-1.4)]) difference() {
		 
			cylinder(h=5,r=ir+0.3, $fn=fn); // another snap
		for (pa = [0, 90, 180, 270]) {
			rotate([0,0,pa]) translate([1,1,-0.1]) cube([plugr,plugr,plugh+1]);
			}
		}
	}

module core() {
	rotate([90,0,90]) translate ([0,0,-h/2-ttotalh-g]) {
		if (cartstyle == 1) {
			tip1core();
			}
		if ((cartstyle == 2) || (cartstyle == 4)) {
			tip2core();
			}
		plugCore();	
		}
	}

module plugCore() {
	}

module writeText() {
	scale ([squish,sh,1]) rotate([0,0,Handed]) translate([0,d*txs,fd/4]) write(label,h=fh,t=fd/2, space=letterspace, center=true, font=f);
	}

module writing() {
	if (trimtext) {
		intersection() {
			writeText();
			translate([-h/2, 0, 0])
				rotate([90,0,90]) 
					cylinder(r=snr, h=h, $fn=fn);	
			}
		}
	else {
		writeText();
		}
	}

module pen() {
   if (c==0) {
   		union() {
			color("yellow") body();
			color("black") writing();
			}
		}
	if (c==1) {
		color("black") writing();
		}
	if (c==2) {
		color("white") difference() {
			body();
			writing();
			}
		}
	}

// alignment dots for dialstruder STL alignment, commented out as they're no longer needed

b=4*1; // 1 mm 'buffer' between pen body and alignment dot
dx = b+h/2; // length plus a safety margin
dy = b+fh/2; // width
//dz = -fh/2; // down to bottom of pen

//translate([dx,dy, 0]) cube(1);
//translate([dx,-dy, 0]) cube(1);
//translate([-dx,dy, 0]) cube(1);
//translate([-dx,-dy, 0]) cube(1);

module printable() {
	difference() {
		translate([0,0,fh/2-platformz]) {
			difference() {
				pen();
				core();
			}
		}
		translate([-h,-10,-5]) cube([2*h,20,5]);
		}
	}

// cap, same for all pens?

caph=27+5+10; // height of cap
capod=17*1;	// outer diameter of cap
capor=capod/2;
capir=snr+clearance;
echo("cap ir ",capir);

echo("snap radius",snr);
echo("pen diameter",d);
echo("std",std);

capsd=std+clearance;	// snap inner diameter of cap
echo("capsd",capsd);
captop = 1*1;
capwidheight=10;
cappor=capor*1.5;

echo("cap or ",capor);
echo("cap ir ",capir);
echo("snap top r ", str);

//joinheight=clipt+clipg+capor-capir;

module capcore() {
	translate([0,0,captop]) cylinder(r=str+clearance, h=caph, $fn=fn);
	translate([0,0,caph-capwidheight]) cylinder(r=capir, h=capwidheight+g, $fn=fn);
	}

module cap() {
	difference() {
		/*rotate([0,0,360/12])*/ cylinder(r=capor,h=caph,$fn=fno);
		capcore();
		}
	//translate([capor+clipg,-clipw/2,0]) cube([clipt,clipw,caph]);
	//echo ("join height", joinheight);
	//echo ("clip width",clipw);
	//echo ("clip thickness", clipt);

	//translate([capir,-clipw/2,0]) cube([joinheight,clipw,clipjoin]);
	}

module plug() {
	echo("plug height ",plugh);
	echo("radius ",plugr);
	rotate([0,0,360/12]) cylinder(h=plugth, r=str, $fn=fn);
	translate([0,0,plugth]) cylinder(h=plugh,r=plugr, $fn=fn); // fits into core
	translate([0,0,plugth+plugh-1.5]) {
		difference() {
			echo ("snap height ", plugh-1.5);
			cylinder(h=1,r=plugr+plugsnapheight, $fn=fn); // another snap
			for (pa = [0, 90, 180, 270]) {
				rotate([0,0,pa]) translate([1,1,-0.1]) cube([plugr,plugr,1.2]);
				}
			}
		}
	if (0) {
		cylinder(r=cappor,h=platformz);	// mouse around plug
		}
	}

p=0*1;

module print_cap() {
	if (c!=1) color("yellow") translate([-(h/2+ttotalh+capor+2),p*20,0]) cap();
	}

//translate([20,20,0]) capcore();
//translate([0,-20,0]) core();
//translate([0,-40,0]) core();

module print_body() {
	translate([0,0,p*20]) difference() {
		printable();
		if (crossSection) translate([-h/2-ttotalh,0,0]) cube([h+ttotalh+plugh,h,h]);
		}
	}

module print_plug() {
   if (c!=1) color("yellow") translate([h/2+ttotalh,p*20,0]) plug();
	}

module print_support() {
	translate([-h/2-ttotalh,0,0]) cylinder(r=platformy,h=platformz);	// mouse around tip
	translate([h/2+ttotalh,0,0]) cylinder(r=cappor,h=platformz);	// mouse around plug
	translate([-h/2-ttotalh,0.6*r,0]) cube([2*ttotalh,platformy-0.6*r,platformz]);
	rotate([180,0,0]) translate([-h/2-ttotalh,0.6*r,-platformz]) cube([2*ttotalh,platformy-0.6*r,platformz]);
	}

if ((parts==1) || (parts==3)) translate([h/2,30,0]) print_cap();
if ((parts==1) || (parts==4)) translate([-h/2,30,0]) print_plug();
if ((parts==1) || (parts==2)) print_body();
if ((c!=1) && (ears==1) && (parts != 3) && (parts != 4)) print_support();
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
