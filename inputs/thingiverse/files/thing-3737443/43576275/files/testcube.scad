cube_size = 20;
letter_devider = 1.61803398875;
letter_depth = 0.5;
wall_thicknes = 1;
sphere_faces = 128;
font = "Mono:style=Bold";

x_text = "X";
y_text = "Y";
z_text = "Z";

letter_size = cube_size / letter_devider;
letter_shift = cube_size / 2;

module label(text, size, depth, font){
	resize([size, size, depth * 2])
		linear_extrude(height = depth, center=true){
			text(text, font=font, halign="center", valign="center");	
		}
}

difference(){
	cube([cube_size, cube_size, cube_size]);

	translate([letter_shift, 0, letter_shift])
	rotate([90 ,0, 0])
		resize([letter_size, letter_size, letter_depth * 2])
			label(x_text, letter_size, letter_depth, font);

	translate([0, letter_shift, letter_shift])
		rotate([90 ,0, 90 * 3])
			label(y_text, letter_size, letter_depth, font);

	translate([letter_shift, letter_shift, cube_size])
		rotate([0, 0, 0])
			label(z_text, letter_size, letter_depth, font);

	translate([letter_shift, letter_shift, 0])
		rotate([0, 0, 0])
			label(z_text, letter_size, letter_depth, font);

	intersection() {
	 translate([cube_size, cube_size, 0])
	 	sphere(r = cube_size - wall_thicknes, $fn = sphere_faces);
	 translate([0, 0, wall_thicknes])
	 	cube([cube_size + 1, cube_size + 1, cube_size]);
	}
}

