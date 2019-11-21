
// Parametric dihedral connector for a diamond kite. Adjustable for different rod
// diameters and angles.
//
// Michael Ang
// http://michaelang.com
//
// For further work, please see my Polygon Construction Kit (Polycon)
// http://www.michaelang.com/project/polycon
//
// This file is licensed under Creative Commons Attribution-NonCommercial-ShareAlike 
// CC BY-NC-SA
// http://creativecommons.org/licenses/by-nc-sa/4.0/

// Circle smoothness
$fn = 20;

/* [Global] */

// Dihedral angle, degrees up from horizontal
angle = 15;

// Length of the connector tubes
tube_length = 15;

// Width of your rod (adjust to get a tight fit)
inner_diameter = 4;

// Thickness of walls
wall_thickness = 2;

/* [Hidden] */
cut_overlap = 0.2;  // Pieces to be cut out need to go past what they're cutting

inner_radius = inner_diameter / 2;
outer_radius = inner_radius + wall_thickness;

// Create a completely solid version of the connector.
// We'll cut (difference) out the holes from the connector later.
module outer_tubes() {
	rotate([90,0,0]) {
		cylinder(r = outer_radius, h = tube_length * 2, center = true);
	}

	rotate([0,90-angle,0]) {
		cylinder(r = outer_radius, h = tube_length);
	}

	rotate([0,-(90-angle),0]) {
		cylinder(r = outer_radius, h = tube_length);
	}
}

// Create the shape that we'll cut out to make space for the rods to come into
// the connector.
module inner_tubes() {
	rotate([90,0,0]) {
		cylinder(r = inner_radius, h = tube_length * 2 + cut_overlap, center = true);
	}

	rotate([0,90-angle,0]) {
		cylinder(r = inner_radius, h = tube_length + cut_overlap);
	}

	rotate([0,-(90-angle),0]) {
		cylinder(r = inner_radius, h = tube_length + cut_overlap);
	}
}

// Use some math to make a solid brace between the angled tubes to
// make the connector stronger.
module dihedral_support(angle, inner_diameter, wall_thickness, tube_length)
{
	// Point at center of tube opening
	right_tube_center = [tube_length * cos(angle), 0, tube_length * sin(angle)];

	// Find top-right point
	outer_radius = inner_diameter / 2 + wall_thickness;
	offset_to_top_right = [-outer_radius * sin(angle), 0, outer_radius * cos(angle)];

	right_endpoint = right_tube_center + offset_to_top_right;

	width = right_endpoint[0] * 2;
	height = right_endpoint[2] - (outer_radius - 0.1);
	depth = wall_thickness;

	translate([-width/2,-depth/2,right_endpoint[2] - height]) {
		cube(size=[width, depth, height]);
	}
}

// Make the connector
difference() {
	union() {
		// Create a solid version of the connector by adding the tubes and the dihedral
	   // support.
		outer_tubes();
		dihedral_support(angle, inner_diameter, wall_thickness, tube_length);
	}
	// Subtract out the holes for the rods
	inner_tubes();
}