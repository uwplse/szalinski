// Customizable Polygon Morph Vase

use <MCAD/regular_shapes.scad>;

// Number of sides of bottom polygon
bottom_sides = 4;

// Circumradius of bottom polygon (mm from center to corner)
bottom_radius = 25;

// Number of sides of top polygon
top_sides = 8;

// Circumradius of top polygon (mm from center to corner)
top_radius = 40;

// Height of vase in millimeters
vase_height=60;

// Clockwise rotation of top relative to bottom in degrees
vase_twist=0;

// Keep the bottom at z 0 if the bottom is trimmed
translate([0, 0, bottom_radius > top_radius ? -1 : 0])

// Trim vertical extension from end with larger radius
difference() {
	
	// The convex hull of the top and bottom shape forms the body of the vase.
	hull() {
	
		// Bottom
		linear_extrude(height=1)
		reg_polygon(
			sides=bottom_sides,
			radius=bottom_radius);
	
		// Top
		translate([0, 0, vase_height])
		rotate([0, 0, -vase_twist])
		linear_extrude(height=1)
		reg_polygon(
			sides=top_sides,
			radius=top_radius);
	}
	
	if (bottom_radius > top_radius) {
		linear_extrude(height = 1) circle(r = bottom_radius + 1);
	} else {
		translate([0, 0, vase_height]) linear_extrude(height=2) circle(r = top_radius + 1);
	}
}