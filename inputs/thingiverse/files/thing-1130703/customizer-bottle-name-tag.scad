use <write/Write.scad>

/* [Font Options] */
//text size
font_size = 9;

font_thickness = 1.5; //The "height" of the relief of the letters.

y_offset = 0;

font_height = 26;

bottom_radius=17.5;

top_radius = 13;

how_thick = 2;

/* [Label] */
your_name = "Awesome Maker";

font_style = "Letters.dxf"; //[Letters.dxf,orbitron.dxf,knewave.dxf,braille.dxf,BlackRose.dxf]

// The dimensions given below are perfect for a bottle of Club-Mate.

// The first five parameters can be used to adjust the text;
// the last four to adjust the size and shape of the name tag.
// All measurements are in millimeters (that includes size, thickness, radius, etc.)

create_name_tag(
	name 		= your_name,
	font 		= font_style,
	text_size 	= font_size,
	text_thickness 	= font_thickness,	// The "height" of the relief of the letters.
	text_offset_y 	= y_offset,	// Use this to adjust the vertical position of the text. Positive is up, negative down.
	height 			= font_height,	// Height of the entire name tag.
	radius_bottom 	= bottom_radius,	// Inner radius at the base of the name tag.
	radius_top 		= top_radius,	// Inner radius at the top of the name tag.
	thickness 		= how_thick		// The thickness of the name tag.
);

// -------------------------------------------------------------------//

module create_name_tag(
	name,
	font,
	text_size,
	text_thickness,
	text_offset_y,
	height,
	radius_bottom,
	radius_top,
	thickness) {

	outer_radius_bottom = radius_bottom + thickness;
	outer_radius_top = radius_top + thickness;
	cube_size = max(outer_radius_bottom, outer_radius_top);

	difference() {
		union () {
			cylinder(r1=outer_radius_bottom, r2=outer_radius_top, h=height, $fa=1);
			rotate([0, 0, -45]) writecylinder(name, [0,0,0], 15, height+text_offset_y, h=text_size, t=text_thickness*10, font=font);
		}
		translate([0,0,-0.01]) cylinder(r1=radius_bottom, r2=radius_top, h=height+0.02, $fa=1);
		difference () {
			cylinder(r1=outer_radius_bottom+(text_thickness*10), r2=outer_radius_top+(text_thickness*10), h=height);
			translate([0,0,-0.01]) cylinder(r1=outer_radius_bottom+text_thickness, r2=outer_radius_top+text_thickness, h=height+0.02, $fa=1);
		}
		translate([0,0,-0.01]) cube([cube_size, cube_size, height+0.02]);
	}
}