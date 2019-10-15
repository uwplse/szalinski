// Cable Holder by xifle
// 05.03.2017
// v3

// preview[view:north, tilt:top diagonal]
/* [Parameters] */

// The thickness of the table (mm)
TABLE_HEIGHT = 24.7;

// The depth of the cable holder (mm)
DEPTH = 30;

// diameter of the cable to hold, some space will be added (mm)
CABLE = 6;

// height of the cylinder on top of the cable holder clip (mm)
CYLINDER_HEIGHT = 12;

// wall thickness (mm)
WALL = 3; 

// space between table and wall, this will be at least the thickness of the cable (plus 1.5mm spacing) (mm)
WALLTABLESPACE = 3;

/* [Hidden] */

// additional space for cable
CABLEWSPACE = CABLE+1.5;

$fs = 0.01;
ADDSPACE = max(max(WALLTABLESPACE,CABLEWSPACE),WALL)-WALL;

//ADDSPACE = WALLTABLESPACE-WALL;
OUTER_RADIUS = CABLEWSPACE*1.8;
WIDTH = OUTER_RADIUS*2.3;

rotate([0,180,0])
difference() {
union() {

	translate([TABLE_HEIGHT/2+2*WALL+CYLINDER_HEIGHT/2,0,DEPTH/2+WALL+ADDSPACE])
	rotate([0,90,0])
	cylinder(h=CYLINDER_HEIGHT, r=OUTER_RADIUS, center=true);


	difference() {

	translate([WALL,0,WALL+ADDSPACE/2])
	cube([TABLE_HEIGHT+2*WALL, WIDTH, DEPTH+ADDSPACE ], center=true);

	translate([WALL, WALL,0])
	cube([TABLE_HEIGHT, WIDTH*2, DEPTH], center=true);

	}

}

translate([0,0,DEPTH/2+WALL+OUTER_RADIUS+ADDSPACE])
cube([(TABLE_HEIGHT+2*WALL+CYLINDER_HEIGHT)*2, WIDTH, 2*OUTER_RADIUS], center=true);

translate([0,0,DEPTH/2+WALL+ADDSPACE])
cube([(TABLE_HEIGHT+2*WALL+CYLINDER_HEIGHT)*2, CABLEWSPACE, CABLEWSPACE*2], center=true);

}