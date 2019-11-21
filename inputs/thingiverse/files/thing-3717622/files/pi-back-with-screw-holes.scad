//pi_back_with_screw_holes.scad by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Diameter of the screw holes
SCREW_HOLE_DIAMETER = 3.5;
//Diameter of the screw head
SCREW_HEAD_DIAMETER = 5.25;

/* [Advanced] */
SCREW_HOLE_HEIGHT = 15;
SCREW_HEAD_HEIGHT = 2;
SCREW_HOLE_POS_X = 58;
SCREW_HOLE_POS_Y = 49;


/////////////
// Modules //
/////////////
module screwHole() {
	cylinder(r=SCREW_HOLE_DIAMETER/2, h=SCREW_HOLE_HEIGHT); //gap for screw thread
	cylinder(r=SCREW_HEAD_DIAMETER/2, h=SCREW_HEAD_HEIGHT); //gap for screw head
	translate([0, 0, SCREW_HEAD_HEIGHT]) cylinder(r1=SCREW_HEAD_DIAMETER/2, r2=SCREW_HOLE_DIAMETER/2, h=SCREW_HEAD_HEIGHT/2); //Cone to prevent 90 degree overhanging edges
}

module screwHole2() {
	union() {
		cylinder(r=SCREW_HOLE_DIAMETER/2, h=SCREW_HOLE_HEIGHT); //gap for screw thread
		cylinder(r=SCREW_HEAD_DIAMETER/2, h=SCREW_HEAD_HEIGHT); //gap for screw head
		translate([0, 0, SCREW_HEAD_HEIGHT]) cylinder(r1=SCREW_HEAD_DIAMETER/2, r2=SCREW_HOLE_DIAMETER/2, h=SCREW_HEAD_HEIGHT/2); //Cone to prevent 90 degree overhanging edges
	}
}


////////////////
// Main Model //
////////////////

//Use $fn = 24 if it's a preview. $fn = 96 for the render
$fn = $preview ? 24 : 96;

difference() {
	import("pi_back.stl");

	screwHole();

	translate([SCREW_HOLE_POS_X, 0, 0])
	screwHole();

	translate([0, SCREW_HOLE_POS_Y, 0])
	screwHole();

	translate([SCREW_HOLE_POS_X, SCREW_HOLE_POS_Y, 0])
	screwHole();
}