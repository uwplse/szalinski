// Number of segments per circle (higher values = smoother circles, but larger files)
segments_per_circle = 60; // [12:180]

$fn = segments_per_circle;

// The outer radius of the bottom of the body of the hat (in millimeters)
hat_outer_rad_bottom = 25.4;  // [1:150]
// The rate of taper from the bottom of the hat to the top
hat_taper = 1.1; // [1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0]

hat_outer_rad_top = hat_outer_rad_bottom * hat_taper;
hat_inner_rad = hat_outer_rad_bottom * 0.95;

// Height of the hat (in millimeters)
total_hat_hgt = 45; // [1:150]

// Thickness of the brim (in millimeters)
hat_brim_hgt = 3; // [1:150]

hat_hgt = total_hat_hgt - hat_brim_hgt;

// Width of the brim (in millimeters)
hat_brim_width = 9.5; // [0:150]

hat_brim_rad = hat_outer_rad_bottom + hat_brim_width;

difference() {
	union() { // the outside of the hat
		cylinder(h = hat_brim_hgt, r = hat_brim_rad, center = false);
		translate([0, 0, hat_brim_hgt]) cylinder(h = hat_hgt, r1 = hat_outer_rad_bottom, r2 = hat_outer_rad_top, center = false);
	}
	union() { // hollow out the inside
		cylinder(h = hat_hgt - hat_inner_rad, r = hat_inner_rad, center = false);
		translate([0, 0, hat_hgt - hat_inner_rad - 0.01]) cylinder(h = hat_inner_rad, r1 = hat_inner_rad, r2 = 0, center = false);
	}
}

