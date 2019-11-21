include <helix_extrude.scad>

precision = 20;

axelRadius = 10;
height = 200;
angle = 360 * 5;

trapezoidHeight = 30;

// Module used to create the polygon
// (to make it easier to re-use with rotate_extrude)
module helixPolygon() {
	// Move the trapezoid away from the center
	translate([axelRadius, 0, 0]) {
		// Simple trapezoid
		polygon([
			[0, 0],
			[20, 10],
			[20, trapezoidHeight-10],
			[0, trapezoidHeight]
		]);
	}
}


translate([-50, 0, 0]) {
	// Axel
	color([0, 0, 1, 0.3])
		cylinder(h=height, r=axelRadius, $fn=precision);

	// Helix
	helix_extrude(angle=angle, height=height-trapezoidHeight, $fn=precision)
		helixPolygon();
}

// For comparaison with "rotate_extrude"
translate([50, 0, 0])
	rotate_extrude($fn=precision)
		helixPolygon();

// DNA double-helix
translate([0, 150, 0]) {
	dnaRadius = 20;

	union() {
		helix_extrude(angle=360*5, height=200, $fn=precision) {
			translate([dnaRadius, 0, 0]) {
				circle(r=3);
			}
		}
		helix_extrude(angle=360*5, height=200, $fn=precision) {
			translate([-dnaRadius, 0, 0]) {
				circle(r=3);
			}
		}

		for (i=[1:60])
			translate([0, 0, i*3.25])
				rotate([0, 90, i*29.25])
					cylinder(r=1, h=dnaRadius * 2, center=true, $fn=precision);
	}
}
