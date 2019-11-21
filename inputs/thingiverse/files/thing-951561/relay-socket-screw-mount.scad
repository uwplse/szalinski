// Number of circle elements
fn = 45;
// Tolerance to ensure difference() leaves no 2d plane
dt = 0.1;
// Tolerance of the first part
t = 0.3;
// Tolerance of the second part
t2 = 0.2;

// Length of the tab
x1 = 27.35;
// Length of the bottom of the receiver
x3 = 1.1;
// Length of the plate
x2 = x1 + x3 + 32;
// Width of the tab
y1 = 5.85;
// Width of the tab to plate connector
y2 = 3.85;
// Width of the plate
y3 = 10.2;
// Distance between parts
y4 = 5;
// Height of the tab
z1 = 2.15;
// Height of the tab to plate connector
z2 = 3.85 - z1;
// Height of the plate
z3 = 6;
// Diameter of the hole, 4.5 allows for an M4 bolt
o = 4.5;
x4 = x2 - t; // Position of the hole

union() {
	// Add tolerances
	x1t = x1 - t;
	x3t = x3 + t;
	y1t = y1 - 2 * t;
	y2t = y2 - 2 * t;
	z1t = z1 - 2 * t;
	z2t = z2 + 2 * t;
	z5 = z1t + z2t;
	
	translate([x3t, (y3 - y1t) / 2, 0]) {
		cube([x1t, y1t, z1t]);
		translate([0, (y1t - y2t) / 2, z1t]) {
			cube([x1t, y2t, z2t]);
		}
	}
	translate([0, 0, z5]) {
		cube([x2, y3, z3]);
	}
	translate([x4, 0, z5]) {
		eye(o, z3 / 2, y3, tolerance = t, fn = fn);
	}
}

translate([0, y3 + y4, 0]) union() {
	// Add tolerances
	x1t = x1 + t2;
	x3t = x3 - t2;
	y1t = y1 + 2 * t2;
	y2t = y2 + 2 * t2;
	z1t = z1 + 2 * t2;
	z2t = z2 - 2 * t2;
	z5 = z1t + z2t;
	
	difference() {
		cube([x1 + x3, y3, z5]);
		translate([x3t, (y3 - y1t) / 2, 0]) {
			translate([0, (y1t - y2t) / 2, 0]) cube([x1t + dt, y2t, z2t + dt]);
			translate([0, 0, z2t]) cube([x1t + dt, y1t, z1t]);
		}
	}
	translate([0, 0, z5]) {
		cube([x2, y3, z3]);
	}
	translate([x4, 0, z5]) {
		eye(o, z3 / 2, y3, tolerance = t2, fn = fn);
	}
}

module eye(holeDiameter, edgeThickness, height, tolerance = 0, fn = 20) {
	outerD = 2 * edgeThickness + holeDiameter;
	outerR = outerD / 2;
	
	translate([outerR, 0, outerR]) {
		rotate([270, 0, 0]) difference() {
			union() {
				cylinder(h = height, d = outerD, $fn = fn);
				translate([-outerR, 0, 0]) cube([outerD, outerR, height]);
			}
			cylinder(h = height, d = holeDiameter + 2 * tolerance, $fn = fn);
		}
	}
}