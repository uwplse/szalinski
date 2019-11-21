$fn = 90*1;

EPS = 0.1*1;
WAND = 2*1;


CABLE_TIE_WIDTH = 3*1;
CABLE_TIE_THICK = 1.5*1;

// Inner diameter of standoffs
STANDOFF_DIAMETER = 5; // [3:6]
STANDOFF_DIA = STANDOFF_DIAMETER + 0.2;

// Outer diameter of standoffs
STANDOFF_OUTER_DIAMETER = STANDOFF_DIAMETER + 3;

// Length of standoffs
STANDOFF_LENGTH = 35; // [16:60]

// Distance between standoffs (middle to middle)
STANDOFF_DISTANCE = 28; // [15:50]

// Distance from middle of standoffs to XT60 connector
DISTANCE_STANDOFF_XT60 = 21; // [5:30]

XT60_WIDTH = 15.5*1;
XT60_HEIGHT = 8*1;
XT60_DEPTH = 16*1;


SHIFT = 0*1;

difference() {
	union() {
		translate([0, -DISTANCE_STANDOFF_XT60, STANDOFF_LENGTH - XT60_DEPTH])
			translate([0, -XT60_HEIGHT,  XT60_DEPTH])
				rotate([-90,0,0])
					xt60();
		// laschen
		hull() {
			hull() {
				translate([-STANDOFF_DISTANCE/2 - SHIFT, 0, STANDOFF_LENGTH - XT60_DEPTH])
					cylinder(d = STANDOFF_OUTER_DIAMETER, h = XT60_DEPTH);
				translate([-XT60_WIDTH/2 - WAND - EPS, -5, STANDOFF_LENGTH - XT60_DEPTH])
					cube([EPS, 5 + STANDOFF_OUTER_DIAMETER/2, XT60_DEPTH]);
			}
			hull() {
			translate([STANDOFF_DISTANCE/2 - SHIFT, 0, STANDOFF_LENGTH - XT60_DEPTH])
					cylinder(d = STANDOFF_OUTER_DIAMETER, h = XT60_DEPTH);
				translate([XT60_WIDTH/2 + WAND, -5, STANDOFF_LENGTH - XT60_DEPTH])
					cube([EPS, 5 + STANDOFF_OUTER_DIAMETER/2, XT60_DEPTH]);
			}
		}
		translate([-XT60_WIDTH/2 - WAND, -DISTANCE_STANDOFF_XT60, STANDOFF_LENGTH - XT60_DEPTH])
			cube([XT60_WIDTH+2*WAND, DISTANCE_STANDOFF_XT60 - 5, XT60_DEPTH]);
		// standoff pillars
		translate([-STANDOFF_DISTANCE/2 - SHIFT, 0, 0])
			cylinder(d = STANDOFF_OUTER_DIAMETER, h = STANDOFF_LENGTH);
		translate([STANDOFF_DISTANCE/2 - SHIFT, 0, 0])
			cylinder(d = STANDOFF_OUTER_DIAMETER, h = STANDOFF_LENGTH);
	}
	// holes standoffs
	translate([-STANDOFF_DISTANCE/2 - SHIFT, 0, -EPS])
		cylinder(d = STANDOFF_DIA, h = STANDOFF_LENGTH + 2*EPS);
	translate([STANDOFF_DISTANCE/2 - SHIFT, 0, -EPS])
		cylinder(d = STANDOFF_DIA, h = STANDOFF_LENGTH + 2*EPS);
}
			
module xt60() {
	difference() {
		// XT60 body
		translate([-(XT60_WIDTH + 2*WAND)/2, XT60_DEPTH, 0])
			rotate([90, 0, 0])
				linear_extrude(height = 16, center = false, convexity = 10, twist = 0)
					polygon(points=[[0, 8], [19.5, 8], [19.5, 0], [17.5, 0], [17.5, 5], [4.5, 5], [2, 3], [2, 0], [0, 0]]);
		// cable tie holes
		translate([-XT60_WIDTH/2 - WAND - EPS, 2, 8-1.5/2-1.5])
			cube([XT60_WIDTH + 2*WAND + 2*EPS, CABLE_TIE_WIDTH, CABLE_TIE_THICK]);
		translate([-XT60_WIDTH/2 - WAND - EPS, 9, 8-1.5/2-1.5])
			cube([XT60_WIDTH + 2*WAND + 2*EPS, CABLE_TIE_WIDTH, CABLE_TIE_THICK]);
	}

}