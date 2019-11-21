/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   9 December 2017
 * =====================================
 *
 * Units are in millimetres.
 */

spintop_diameter = 20;
toothpick_diameter = 2.1;
point_diameter = 2;

point_max_distance = 5;

$fn = 40;

rotate([180, 0, 0]) {
	spintop_dice();
}

module spintop_dice() {
	spintop_radius = spintop_diameter / 2;
	toothpick_radius = toothpick_diameter / 2;
	point_radius = point_diameter / 2;

	// Distance from the center to the face (using Pythagorean theorem)
	spintop_short_radius = sqrt(spintop_radius*spintop_radius - (spintop_radius/2)*(spintop_radius/2));

	// Point base
	cylinder(r1 = 0, r2 = spintop_radius, h = spintop_radius, $fn = 6);

	// Dice
	difference() {
		translate([0, 0, spintop_radius]) {
			difference() {
				cylinder(r = spintop_radius, h = spintop_radius, $fn = 6);
				// Toothpick hole
				translate([0, 0, 0.1]) {
					cylinder(r = toothpick_radius, h = spintop_radius + 0.1);
				}
			}
		}

		// Numbers (opposite faces adds up to 7 - no consecutive number next to each other)
		// 1
		translate([0, spintop_short_radius, spintop_radius*1.5]) {
			sphere(r = point_radius);
		}
		// 6
		rotate([0, 0, 180]) {
			translate([0, spintop_short_radius, spintop_radius*1.5]) {
				for (
					x = [-point_max_distance/2, point_max_distance/2],
					z = [-point_max_distance/2, 0, point_max_distance/2]
				) {
					translate ([x, 0, z]) {
						sphere(r = point_radius);
					}
				}
			}
		}

		// 2
		rotate([0, 0, -120]) {
			translate([0, spintop_short_radius, spintop_radius*1.5]) {
				translate ([point_max_distance/2, 0, point_max_distance/2]) {
					sphere(r = point_radius);
				}
				translate ([-point_max_distance/2, 0, -point_max_distance/2]) {
					sphere(r = point_radius);
				}
			}
		}
		// 5
		rotate([0, 0, 60]) {
			translate([0, spintop_short_radius, spintop_radius*1.5]) {
				sphere(r = point_radius);
				for (
					x = [-point_max_distance/2, point_max_distance/2],
					z = [-point_max_distance/2, point_max_distance/2]
				) {
					translate ([x, 0, z]) {
						sphere(r = point_radius);
					}
				}
			}
		}

		// 3
		rotate([0, 0, 120]) {
			translate([0, spintop_short_radius, spintop_radius*1.5]) {
				sphere(r = point_radius);
				translate ([point_max_distance/2, 0, point_max_distance/2]) {
					sphere(r = point_radius);
				}
				translate ([-point_max_distance/2, 0, -point_max_distance/2]) {
					sphere(r = point_radius);
				}
			}
		}
		// 4
		rotate([0, 0, -60]) {
			translate([0, spintop_short_radius, spintop_radius*1.5]) {
				for (
					x = [-point_max_distance/2, point_max_distance/2],
					z = [-point_max_distance/2, point_max_distance/2]
				) {
					translate ([x, 0, z]) {
						sphere(r = point_radius);
					}
				}
			}
		}
	}
}
