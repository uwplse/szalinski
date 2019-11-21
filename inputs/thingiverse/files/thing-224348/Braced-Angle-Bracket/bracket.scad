// preview[view:north east, tilt:top diagonal]

/* [Dimensions] */

span = 80;

bracket_thickness = 5;

bracket_width = 25;

// Brace thickness is limited to prevent obstructing holes.
brace_thickness = 4;

// You may want to re-orient the model before printing if you change which braces are enabled.
top_brace = 0; // [0:Off, 1:On]

bottom_brace = 1; // [0:Off, 1:On]

hole_diameter = 8;

// Position  as a percentage of distance from corner to edge.
inner_hole_position = 20; // [0:100]

// Position as a percentage of distance from corner to edge.
outer_hole_position = 80; // [0:100]

// Select Inner Face to center holes in space available above/between braces.
hole_centering = 0; // [0:Outer Face, 1:Inner Face]

/* [Hidden] */

hole_radius = hole_diameter / 2;
get_bracket_width = max(bracket_width, hole_diameter);
get_brace_thickness = min(brace_thickness, bracket_width/2 - hole_radius);
get_inner_hole_spacing = inner_hole_position / 100;
get_outer_hole_spacing = outer_hole_position / 100;
hole_height = (hole_centering == 0 ? bracket_width/2 :  (bracket_width - (top_brace * get_brace_thickness) - (bottom_brace * get_brace_thickness))/2 + (bottom_brace * get_brace_thickness));

// Bracket points form an "L" shape; [0, 0] is the outer corner of the bracket.
module bracket() {
	linear_extrude(height=get_bracket_width)
		polygon(points=[[0, 0], [span, 0], [span, bracket_thickness], [bracket_thickness, bracket_thickness], [bracket_thickness, span], [0, span]]);
}	

// Brace points form a triangle; [bracket_thickness, bracket_thickness] is the inner corner of the bracket.
module brace() {
	linear_extrude(height=get_brace_thickness)
		polygon(points=[[bracket_thickness, bracket_thickness], [span, bracket_thickness], [bracket_thickness, span]]);
}

module hole() {
	cylinder(h = bracket_thickness + 2, r = hole_radius, $fn = 24);
}

module left_hole(spacing) {
	translate([bracket_thickness + hole_radius + (spacing * (span - bracket_thickness - hole_diameter)), -1, hole_height])
		rotate([-90, 0, 0])
			hole();
}

module top_hole(spacing) {
	translate([-1, bracket_thickness + hole_radius + (spacing * (span - bracket_thickness - hole_diameter)), hole_height])
		rotate([0, 90, 0])
			hole();
}


difference() {
	union() {
		bracket();		

		if (bottom_brace == 1) {
			brace();
		}

		if (top_brace == 1) {
			translate([0, 0, get_bracket_width - get_brace_thickness]) brace();
		}
	}

	left_hole(get_inner_hole_spacing);
	left_hole(get_outer_hole_spacing);

	top_hole(get_inner_hole_spacing);
	top_hole(get_outer_hole_spacing);
}
