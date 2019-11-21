// Customizable Twisted Polygon Vase

use <MCAD/regular_shapes.scad>;

/* [Vase Design] */

// Vases is an extruded regular polygon
number_of_sides = 5;

// Height of vase (mm)
vase_height = 80;

// Bottom circumradius (mm from center to corner)
bottom_radius = 25;

// Top circumradius (mm from center to corner)
top_radius = 40;

// Clockwise twist of top surface relative to bottom (degrees).
top_rotation = 72;

// Low values yield a faceted appearance. High values yield a smooth appearance. No effect if 0 rotation.
slice_layers = 4;

/* [Hidden] */

top_scale = top_radius / bottom_radius;

linear_extrude(
		height = vase_height,
		twist  = top_rotation,
		slices = slice_layers,
		scale  = top_scale)

reg_polygon(
		sides  = number_of_sides,
		radius = bottom_radius);
