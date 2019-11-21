use <write/Write.scad>;

use <utils/build_plate.scad>

// Constants

pi=3.1415926*1; // pi
cup=236.588237*1000; // 1 cup in cubic mm
$fn=64*1; // smoothness

// Print (plated) or Preview (stretched tall)
preview=0; // [0:Print, 1:Preview]

// Diameter (inside of the largest ring)
diameter=60;

// Height of each ring. This is the height when collapsed.
h=20;

// Number of rings
numRings = 3;

// Spacing between walls
spacing=4;

// Thickness of walls
tt=2;

// Gap between parts. Make as small as your printer allows.
g=0.6;

// View
half=0; //[0:Whole thing, 1:Cross section]

// Handle shape
handle=2; //[0:None, 1:Vertical, 2:Round]
// Handle Size
handleSize = 10;
// Radius of hole in handle (for round handle, so you can hang it up)
holeSize=2.5;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

// end of parameters

// How many cups?
//scale = 1; //[1:Cup, 0.5:Half Cup, 0.25:Quarter Cup]
// Label Line 1
//label1 = "Laird";
// Label Line 1
//label2 = "Cup";
// Font Size
fsize=5;

s=spacing+tt;
fullHeight=numRings*(h-tt);

echo("Height = ",fullHeight," mm.");

or=diameter/2;
ir=or-(numRings-1)*s;

echo(str("Outer radius ",or," and inner radius ",ir,"."));

echo(str("ir=",ir," and or=",or,"."));
v=(1/3)*pi*fullHeight*(ir*ir+or*or+ir*or);
echo(str("vol=",v,"."));

cups=v/cup;
label3=str(floor(cups*100+.5)/100," Cups");	// Round to 0.01 cups, to avoid long numbers

echo(label3);

//%translate([0,-or-10,0]) write(label3);

module ring(radius, thickness, height, slant) {
	difference() {
		cylinder(r=radius+thickness, h=height);
		// offsets to avoid parallel faces
		translate([0,0,-.1]) cylinder(r=radius, h=height+.2);
		}
	}

// ring

module ring2(ir1, or1, ir2, or2, height) {
	difference() {
		cylinder(r1=ror1, r2=or2, h=height);
		translate([0,0,-.01]) cylinder(r1=ir1, r2=ir2, h=height+.02);
		}
	}

module writeText() {
	translate([0,fsize,0]) write(label1,center=true,h=fsize,t=tt*2/3);	// First line
	translate([0,-fsize,0]) write(label2,center=true,h=fsize,t=tt*2/3);	// Second line
	}

o=tt/2;//overlap
b=o/2;//bump

h1=0;
h2=o;
h3=h2+b;
h4=h3+b;
h8=h;
h7=h8-o;
h6=h7-b;
h5=h6-b;

r1=g;
r2=g+o;
r4=s;
r3=s-tt;
r5=s+b;
r6=r4+o;

points = [[r2,h1],[r1,h2],[r2,h4],[r3,h4],[r3,h8],[r6,h8],
				[r4,h7],[r5,h6],[r4,h5],[r4,h4],[r5,h3],[r4,h2],[r6,h1],[r2,h1]];

// Uncomment the following for testing the polygon and the extrusion
//rotate_extrude() 
//polygon(points,convexity=10);
//rotate_extrude() 
//translate([s,0,0]) polygon(points,convexity=10);

module cup() {
	difference() {
		union() {
			cylinder(r=ir-tt,h=tt);
			echo(str("Rings from ",ir," to ",or," step ",s,"."));
			for (rad=[ir:s:or]) {
				translate([0,0,preview*((rad-ir)/s)*(h-tt)]) rotate_extrude() translate([rad-s,0,0]) 
					polygon(points,convexity=10);
				}
			}
		//scale([-1,1,1]) writeText();
		}
	
	translate([0,0,preview*(fullHeight-h+tt)]) difference() {
		translate([or,0,0]) {
			if (handle==1) translate([0,-tt,0]) cube([handleSize,2*tt,h]); // handle
			if (handle==2) difference() {
				cylinder(r=handleSize, h=h);
				translate([tt+holeSize, 0, -.1]) cylinder(r=holeSize, h=h+.2);
				translate([-or,0,-1]) cylinder(r=or-o, h=h+2);
				}
			}
		}
	
	//translate([0,0,tt]) writeText();
	}

difference() {
	cup();
	if (half) translate([-200,-200,-1]) cube([400,200,100]);	// chop in half to check alignments
	}

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);