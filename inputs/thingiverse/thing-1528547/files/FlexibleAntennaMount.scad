$fn = 90*1;

EPS = 0.1*1;

// Inner diameter of antenna tubes
DIA_ANT_TUBE = 2; // [1:5]
DIA_ANT_OUTER_TUBE = DIA_ANT_TUBE + 3;

// Length of tubes (the last 5 mm will be solid, so make this your antenna length +5)
TUBE_LEN = 100; // [20:200]
TUBE_CTR_OFFS = 0.25*1;

// Diameter of mounting holes
DIA_MOUNT_HOLES = 3.1; // [2:4]

// Mounting holes distance 
WIDTH_MOUNT_HOLES = 35; // [20:60]

// Width of the base
BASE_WIDTH = DIA_ANT_OUTER_TUBE + DIA_MOUNT_HOLES + 0.1; 

BASE_LENGTH = WIDTH_MOUNT_HOLES + 2 * DIA_MOUNT_HOLES + 0.1;
BASE_HEIGHT = 5*1;

rotate([-90, 0, -45]) 
difference() {
	union() {
		// base
		translate([-BASE_LENGTH/2, -BASE_WIDTH, 0])
			cube ([BASE_LENGTH, BASE_WIDTH, BASE_HEIGHT]);
		// tubes
		translate([TUBE_CTR_OFFS, -DIA_ANT_OUTER_TUBE/2, 0])
			rotate([0, 45, 0]) {
				cylinder(d = DIA_ANT_OUTER_TUBE, h = TUBE_LEN);
				translate([-DIA_ANT_OUTER_TUBE/2, 0, 0])
					cube([DIA_ANT_OUTER_TUBE, DIA_ANT_OUTER_TUBE/2, TUBE_LEN]);
			}
		translate([-TUBE_CTR_OFFS, -DIA_ANT_OUTER_TUBE/2, 0])
			rotate([0, -45, 0]) {
				cylinder(d = DIA_ANT_OUTER_TUBE, h = TUBE_LEN);
				translate([-DIA_ANT_OUTER_TUBE/2, 0, 0])
					cube([DIA_ANT_OUTER_TUBE, DIA_ANT_OUTER_TUBE/2, TUBE_LEN]);
			}
	}
	// hollow tubes
	translate([TUBE_CTR_OFFS, -DIA_ANT_OUTER_TUBE/2, 0])
		rotate([0, 45, 0])
			translate([0, 0, -10 - EPS])
					cylinder(d = DIA_ANT_TUBE, h = TUBE_LEN + 10 + 2 * EPS - 5);
	translate([-TUBE_CTR_OFFS, -DIA_ANT_OUTER_TUBE/2, 0])
		rotate([0, -45, 0])
			translate([0, 0, -10 - EPS])
					cylinder(d = DIA_ANT_TUBE, h = TUBE_LEN + 10 + 2 * EPS - 5);
	// cut below base
	translate([-BASE_LENGTH/2 - EPS, -BASE_WIDTH - EPS, -5]) cube ([BASE_LENGTH + 2*EPS, BASE_WIDTH + 2*EPS, 5]);
	// mounting holes
	translate([WIDTH_MOUNT_HOLES/2, -BASE_WIDTH + 3, - EPS])
		cylinder(d = DIA_MOUNT_HOLES + 0.1, h = BASE_HEIGHT + 2*EPS);
	translate([-WIDTH_MOUNT_HOLES/2, -BASE_WIDTH + 3, - EPS])
		cylinder(d = DIA_MOUNT_HOLES + 0.1, h = BASE_HEIGHT + 2*EPS);
}