/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   9 December 2017
 * =====================================
 *
 * Top hat:
 *   https://www.thingiverse.com/thing:2453990
 *
 * Units are in millimetres.
 */

/* [Laptop measure] */
// Thickness of your laptop screen. You should include 0.2 to 0.5mm clearance.
laptop_tickness = 6.6; // measured 6.3

/* [Advanced] */
$fn = 80;
head_radius = 6.8;
bust_width = 25;
bust_height = 18;
neck_height = 3;
wall = 1.6;

// Top hat - centered
*scale([0.5, 0.5, 0.5]) {
	translate([14.5, -915.7, -184]) {
		import("../top_hat.stl");
	}
}

bust();

module bust() {
	// Chest
	difference() {
		translate([
			-bust_width/2,
			-(laptop_tickness/2 + wall),
			0
		]) {
			cube([
				bust_width,
				laptop_tickness + 2*wall,
				bust_height + wall
			]);
		}

		translate([
			-(bust_width/2 + 0.1),
			-(laptop_tickness/2),
			-0.1
		]) {
			cube([
				bust_width + 0.2,
				laptop_tickness,
				bust_height + 0.1
			]);
		}
	}

	// Neck
	translate([0, 0, bust_height + wall]) {
		cylinder(
			r1 = laptop_tickness/2 + wall,
			r2 = (laptop_tickness/2 + wall) / 2,
			h = neck_height + head_radius
		);
	}

	// Head
	translate([
		0,
		0,
		bust_height + wall + head_radius + neck_height
	]) {
		sphere(r=head_radius);
	}
}
