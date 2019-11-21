//A10_A10M_Angled_LCD_Mount_Bracket_v1.scad by MegaSaturnv

use <ISOThread.scad>
//NOTE: This openSCAD model requires RevK's ISO/UTS thread OpenSCAD library here: https://www.thingiverse.com/thing:2158656

$fn = 96;

SCREW_HOLE_M         = 5;   //Diameter of the screws used. e.g. M5 in this case
SCREW_HOLE_SPACING   = 20;  //Space between the centre of the screw holes
SCREW_HOLE_PERIMETER = 10;  //Distance between the centre of the screw holes and the outside edge
PLATE_1_THICKNESS    = 5;   //Thickness of the plate which attaches to the A10/A10M
PLATE_2_THICKNESS    = 10;  //Thickness of the plate which attaches to the LCD board
PLATE_SEPARATION     = 25;  //Extra distance to move plate 2 to the right
THREAD_TOLERANCE     = 0.3; //Extra width added to thread to correct for tolerance

translate([0, 0, PLATE_SEPARATION + PLATE_2_THICKNESS]) rotate([0, -90, 0]) union() {
	//Plate 1
	difference() {
		cube([SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER, PLATE_1_THICKNESS, SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER]);
		
		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
	}

	//Plate 2
	translate([-PLATE_SEPARATION, 0, 0]) rotate([0, 0, 90]) difference () {
		cube([SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER, PLATE_2_THICKNESS, SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER]);

		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE);
		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE); 
	}

	//Separation Plate
	translate([-PLATE_SEPARATION, 0, 0]) cube([PLATE_SEPARATION, PLATE_1_THICKNESS, SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER]);
}
