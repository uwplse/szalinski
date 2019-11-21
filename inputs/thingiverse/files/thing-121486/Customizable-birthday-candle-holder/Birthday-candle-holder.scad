// Birthday candle holder by teejaydub

// preview[view:north, tilt:top]
/* [Global] */

// The diameter of the birthday candle [mm]
CANDLE_DIAMETER = 5.8;  //first try: 5.3, too small; 5.5 - 5.7, works but tight

// The outer diameter of the candle holder [mm]
OUTER_DIAMETER = 15;

/* [Hidden] */

CANDLE_RADIUS = CANDLE_DIAMETER / 2;
OUTER_RADIUS = OUTER_DIAMETER / 2;

HOLE_HEIGHT = CANDLE_RADIUS * 5;  // of the cutting hole object
CANDLE_HEIGHT = CANDLE_RADIUS;  // height of the candle above the floor
CANDLE_DEPTH = CANDLE_RADIUS * 1;  // how much the candle is buried in the holder

BASE_HEIGHT = CANDLE_HEIGHT + CANDLE_DEPTH;  // of the base object
BASE_RADIUS = CANDLE_RADIUS * 1.8;

PETAL_RADIUS = BASE_RADIUS / 1.7;

BOWL_RADIUS = OUTER_DIAMETER;

difference() {
	intersection() {
		union() {
			// Base
			translate([0, 0, BASE_HEIGHT / 2])
				cylinder(h = BASE_HEIGHT, r = BASE_RADIUS, center = true, $fn=35);
	
			// Flowers
			intersection() {
				union() {
					petal(0);
					petal(120);
					petal(240);
				}

				// Enforce a 45-degree angle on the petals so no support is needed.
				translate([0, 0, 50])
					cylinder(h = 100, r1 = 0, r2 = 100, center = true);
			}
		}

		// We want a circular outline.
		cylinder(h = 100, r = OUTER_RADIUS, center = true);
	}

	// Hole for the candle
	translate([0, 0, CANDLE_HEIGHT + HOLE_HEIGHT / 2])
		cylinder(h = HOLE_HEIGHT, r = CANDLE_RADIUS, center = true, $fn=15);

	// Shallow bowl
	translate([0, 0, BOWL_RADIUS + BASE_HEIGHT + 0.3])
		sphere(r = BOWL_RADIUS, center = true);
}

module petal(angle) {
	translate([0, 0, BASE_HEIGHT + PETAL_RADIUS * 0.7 - 1])
	rotate([0, 90, angle])
		cylinder(h = OUTER_DIAMETER, r = PETAL_RADIUS, center = true);
}