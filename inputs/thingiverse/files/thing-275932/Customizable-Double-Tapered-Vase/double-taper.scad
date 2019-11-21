/* [General Settings] */

// Full height of the vase (mm).
vase_height = 100;

// Top and bottom parts are tapered to fit through a waist belt of this radius (mm).
waist_radius = 22;

// Waist belt is located somewhere between top (1) and bottom (0) of vase.
waist_location  = 0.33;

/* [Bottom Part] */

// Bottom part is a star or regular polygon with this many points.
bottom_points = 6;

// Depth of indentation on sides of bottom part (mm). Set to 0 for a regular polygon or larger values for a pointier star.
bottom_indent = 5;

// Radius from center axis to points of bottom part (mm).
bottom_radius = 32;

// Clockwise twist of bottom part as it rises (degrees).
bottom_twist = 0;

/* [Top Part] */

// Clockwise orientation of top face relative to bottom face (degrees).
top_rotation = 0;

// Top part is a star or regular polygon with this many points.
top_points = 6;

// Depth of indentation on sides of top part (mm). Set to 0 for a regular polygon or larger values for a pointier star.
top_indent = 0;

// Radius from center axis to points of top part (mm).
top_radius = 30;

// Clockwise twist of top part as it descends (degrees).
top_twist = 35;


union() {
	Part(bottom_points, bottom_radius, waist_location * vase_height, bottom_twist, bottom_indent);
	
	translate([0, 0, vase_height]) rotate([0, 0, -top_rotation]) mirror([0, 0, 180])
	Part(top_points, top_radius, (1 - waist_location) * vase_height, top_twist, top_indent);
}

// waist marker
// # translate([0, 0, (waist_location * vase_height)-0.1]) cylinder(r=waist_radius, h=0.2);

module Part(sides, base_radius, waist_height, twist, indent) {
	
	// To set the extrusion scaling correctly, first calculate final radius, as constrained by waist
	taper_radius = ((waist_height * waist_radius) - ((vase_height - waist_height) * (base_radius - waist_radius))) / waist_height;
	taper_scale = taper_radius / base_radius;

	// If the part is waist-constrained such that it tapers to a point before full height, only extrude to height of that point
	taper_height = ((waist_height * waist_radius) / (base_radius - waist_radius)) + waist_height;
	extrusion_height = min(vase_height, taper_height);

	linear_extrude(
			height = extrusion_height,
			twist  = twist,
			scale  = taper_scale,
			slices = round(extrusion_height))
	Star(
			points = sides,
			outer  = base_radius,
			indent = indent);
}

module Star(points, outer, indent) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;

	// if indent 0, inner radius is calculated to located edges
	// of regular polygon with points sides and outer circumradius
	inner = (outer * cos(increment/2)) - indent;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

			assign(	x_outer = x(outer, increment * p),
					y_outer = y(outer, increment * p),
					x_inner = x(inner, (increment * p) + (increment/2)),
					y_inner = y(inner, (increment * p) + (increment/2)),
					x_next  = x(outer, increment * (p+1)),
					y_next  = y(outer, increment * (p+1))) {
				polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}
		}
	}
}
