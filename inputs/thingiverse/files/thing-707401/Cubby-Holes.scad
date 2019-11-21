//
// Cubby Holes
//

//Number of columns
number_of_cols = 5;
//Number of rows
number_of_rows = 3;
nbr_cols1 = number_of_cols - 1;
nbr_rows1 = number_of_rows - 1;

//Width of cubby hole (mm)
cubby_hole_width = 10.5;
//Depth of cubby hole (mm)
cubby_hole_depth = 10.5;
//Height of cubby hole (mm)
cubby_hole_height = 24;

//Thickness of outer walls (mm)
outer_wall_thickness = .8;
//Thickness of inner walls (mm)
inner_wall_thickness = .4;
//Thickness of bottom (mm)
bottom_thickness = 1;

outer_x = outer_wall_thickness + (number_of_cols * cubby_hole_width) + (nbr_cols1 * inner_wall_thickness) + outer_wall_thickness;
outer_y = outer_wall_thickness + (number_of_rows * cubby_hole_depth) + (nbr_rows1 * inner_wall_thickness) + outer_wall_thickness;
outer_z = bottom_thickness + cubby_hole_height;

module holder(){
	difference() {
		cube([outer_x, outer_y, outer_z]);
		for( row = [0 : nbr_rows1] ){
			translate([0, (row * (cubby_hole_depth + inner_wall_thickness)), 0])
			for( col = [0 : nbr_cols1] ){
				translate([outer_wall_thickness + (col * (cubby_hole_width + inner_wall_thickness)), outer_wall_thickness, bottom_thickness]) cube([cubby_hole_width, cubby_hole_depth, cubby_hole_height]);
			}
		}
	}
}

holder();
