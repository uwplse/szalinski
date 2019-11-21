use <ISOThread.scad>

$fn = 96;

SCREW_HOLE_M         = 5;   //Diameter of the screws used. e.g. M5 in this case
SCREW_HOLE_SPACING   = 20;  //Space between the centre of the screw holes
SCREW_HOLE_PERIMETER = 10;  //Distance between the centre of the screw holes and the outside edge
PLATE_1_THICKNESS    = 5;   //Thickness of the plate which attaches to the A10/A10M
PLATE_2_THICKNESS    = 10;  //Thickness of the plate which attaches to the LCD board
PLATE_ANGLE          = 30;  //Angle to tilt the LCD plate. 0 = vertical.
PLATE_SEPARATION     = 0;   //Extra distance to move plate 2 to the right
THREAD_TOLERANCE     = 0.3; //Extra width added to thread to correct for tolerance

translate([0, 0, PLATE_SEPARATION + PLATE_2_THICKNESS]) rotate([0, PLATE_ANGLE-90, 0]) union() {
	//Plate 1
	difference() {
		cube([SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER, PLATE_1_THICKNESS, SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER]);
		
		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) cylinder(r=SCREW_HOLE_M/2 + THREAD_TOLERANCE, h=PLATE_1_THICKNESS);
	}

	//Plate 2
	translate([-PLATE_SEPARATION, 0, PLATE_2_THICKNESS * sin(PLATE_ANGLE)]) rotate([-PLATE_ANGLE, 0, 90]) difference () {
		cube([SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER, PLATE_2_THICKNESS, SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER]);

		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER])                    rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE);
		translate([SCREW_HOLE_PERIMETER,                    0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE);
		translate([SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING, 0, SCREW_HOLE_PERIMETER+SCREW_HOLE_SPACING]) rotate([-90, 0, 0]) iso_thread(m=SCREW_HOLE_M, l=PLATE_2_THICKNESS, t=THREAD_TOLERANCE);
	}

	//Separation Plate
	translate([-PLATE_SEPARATION, 0, 0]) cube([PLATE_SEPARATION, PLATE_1_THICKNESS, SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER]);

	//Filler Plate for angled bracket
	PolyPoints = [
	  [  0,        0,        0 ],  //0
	  [ -PLATE_2_THICKNESS * cos(PLATE_ANGLE),    0,                    0 ],  //1
	  [ -PLATE_2_THICKNESS * cos(PLATE_ANGLE),    PLATE_1_THICKNESS,    0 ],  //2
	  [  0,                                       PLATE_1_THICKNESS,    0 ],  //3
	  [  0,                                       0,                    SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER ],  //4
	  [ -(SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER)*sin(PLATE_ANGLE),     0,                   (PLATE_2_THICKNESS*sin(PLATE_ANGLE))+((SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER)*cos(PLATE_ANGLE)) ],  //5
	  [ -(SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER)*sin(PLATE_ANGLE),    PLATE_1_THICKNESS,    (PLATE_2_THICKNESS*sin(PLATE_ANGLE))+((SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER)*cos(PLATE_ANGLE)) ],  //6
	  [  0,                                       PLATE_1_THICKNESS,    SCREW_HOLE_SPACING + 2*SCREW_HOLE_PERIMETER ]]; //7
	PolyFaces = [
	  [0,1,2,3],  // bottom
	  [4,5,1,0],  // front
	  [7,6,5,4],  // top
	  [5,6,2,1],  // right
	  [6,7,3,2],  // back
	  [7,4,0,3]]; // left
	translate([-PLATE_SEPARATION, 0, 0]) polyhedron(PolyPoints, PolyFaces);
}
