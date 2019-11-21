rows = 3; // [2:100]
filename = ""; // [image_surface:100x100]
pattern_thickness = 1.5; 
cube_width = 20;
spacing = 0.8;
hole_radius = 2.3; 
edge_width = 2; 
plane_top = "NO"; // [YES, NO]

module part_for_carve_a_sink(hole_radius, height, edge_width) {
    $fn = 24;
	
    module part_for_h_carving() {
	    leng = hole_radius + edge_width + 1;
		rotate([0, 90, 0]) 
			linear_extrude(leng) 
				circle(hole_radius);
		rotate([-90, 0, 0]) 
			linear_extrude(leng) 
				circle(hole_radius);
		linear_extrude(2 * hole_radius, center = true) 
		    square(leng);
	}

	linear_extrude(height) 
	    circle(hole_radius);

    translate([0, 0, height / 4]) 
	    part_for_h_carving();
	translate([0, 0, height * 3 / 4]) 
	    part_for_h_carving();
}

module joint_H(cube_width, hole_radius, edge_width, spacing) {
    $fn = 24;
	
    r = hole_radius + edge_width;
	axis_radius = hole_radius - spacing / 2;
	
    module half_H() {
		translate([r, 0, 0]) 
		union() {
			linear_extrude(cube_width) 
				circle(axis_radius);
				
			translate([0, 0, cube_width / 4]) 
				rotate([0, -90, 0]) 
					linear_extrude(r + spacing) 
						circle(axis_radius);
						
			translate([0, 0, cube_width * 3 / 4]) 
				rotate([0, -90, 0]) 
					linear_extrude(r + spacing) 
						circle(axis_radius);
		}	
	}
	
    translate([spacing / 2, 0, 0]) 
	    half_H();
    translate([-spacing / 2, 0, 0]) 
	    mirror([1, 0, 0]) half_H();
}

module a_dancing_cube_no_joint(cube_width, holes, hole_radius, edge_width, spacing) {
    $fn = 24;

    corner_r = hole_radius + edge_width;
	
    module rc_cube() {
		linear_extrude(cube_width) hull() {
		    translate([corner_r, corner_r, 0]) circle(corner_r);
			translate([cube_width - corner_r, corner_r, 0]) circle(corner_r);
			translate([cube_width - corner_r, cube_width - corner_r, 0]) circle(corner_r);
			translate([corner_r, cube_width - corner_r, 0]) circle(corner_r);
		}
	}

	module carved_parts() {
	    if(holes > 0) {
			translate([corner_r, corner_r, 0]) 
				rotate(180) 
					part_for_carve_a_sink(hole_radius, cube_width, edge_width);
					
			translate([cube_width - corner_r, corner_r, 0]) 
				rotate(270) 
					part_for_carve_a_sink(hole_radius, cube_width, edge_width);
		}
			
        if(holes > 2) {			
			translate([cube_width - corner_r, cube_width - corner_r, 0]) 
				rotate(360) 
					part_for_carve_a_sink(hole_radius, cube_width, edge_width);
		}	

		if(holes > 3) {	
			translate([corner_r, cube_width - corner_r, 0]) 
				rotate(90) 
					part_for_carve_a_sink(hole_radius, cube_width, edge_width);		
        }			
	}
	rotate(135) translate([-cube_width / 2, -cube_width / 2, 0])
	
	difference() {
		rc_cube();
		carved_parts();			
	}
}

module dancing_cubes(rows, cube_width, spacing, hole_radius, edge_width, has_holes = true, has_joints = true) {
	corner_r = hole_radius + edge_width;
	h_join_leng = 2 * corner_r + spacing;
	//cube_offset = 2 * (cube_width / 2 - corner_r) * sqrt(2) + h_join_leng;
	cube_offset = cube_width + spacing;
	
	function is_corner(row, column) = 
	    (row == 0 && (column == 0 || column == rows - 1)) ||
		(row == rows - 1 && (column == 0 || column == rows - 1))
	;

	module corner_cube(row, column) {
	    a = row == 0 && column == 0 ? 0 : (
		        row == 0 && column == rows - 1 ? -90 : (
			        row == rows - 1 && column == 0 ? 90 : 180
			    )
		    );
			
		rotate(a) 
		    a_dancing_cube_no_joint(cube_width, 2, hole_radius, edge_width, spacing);	
	}
	
	function is_side(row, column) = 
	    row * column == 0 || 
		row == rows - 1 || 
		column == rows - 1;
		
	module side_cube(row, column) {
	        a = column == 0 ? 0 : ( 
			    row == 0 ? -90 : (
				    column == rows - 1 ? 180 : 90
				)
			);
			
			rotate(a) 
			    a_dancing_cube_no_joint(cube_width, 3, hole_radius, edge_width, spacing);			
	}

	function is_even(n) = n % 2 == 0;
	
	for(r = [0:rows - 1]) {
		for(c = [0:rows - 1]) {
			translate([cube_offset * r, cube_offset * c, 0]) rotate(is_even(r + c) ? 45 : -45) if(has_holes) {
			    union() {
					if(is_corner(r, c)) {
						corner_cube(r, c);			
					} else if(is_side(r, c)) {
						side_cube(r, c);
					} else {
						a_dancing_cube_no_joint(cube_width, 4, hole_radius, edge_width, spacing);			
					}	
				}		
			} else {
			    a_dancing_cube_no_joint(cube_width, 0, hole_radius, edge_width, spacing);
			}
		}
	}

	if(has_joints) {
		joint_offset_x = cube_width / 2 - corner_r;
		joint_offset_y = h_join_leng / 2 + cube_width / 2 - corner_r;
		
		for(r = [0:rows - 2]) {
			for(c = [0:rows - 1]) {
				translate([
						c * cube_offset + (is_even(r + c) ? - joint_offset_x : joint_offset_x), 
						 joint_offset_y + cube_offset * r, 
						0
				]) rotate(90) joint_H(cube_width, hole_radius, edge_width, spacing);
				
				translate([
					joint_offset_y + cube_offset * r,
					cube_offset * c + (is_even(r + c) ? joint_offset_x : -joint_offset_x), 
					0
				]) joint_H(cube_width, hole_radius, edge_width, spacing);
			}
		}
	}
}

module dancing_cubes_2(rows, filename, pattern_thickness, cube_width, spacing, hole_radius, edge_width) {
	block_width = cube_width + spacing / 2;
	range_width = block_width * rows + spacing;
	scale_factor = range_width / 100;
	
	module pattern(has_holes = true, has_joints = true) {
		intersection() {
			translate([cube_width / 2, cube_width / 2, 0]) 
				dancing_cubes(rows, cube_width, spacing, hole_radius, edge_width, has_holes, has_joints);
				
            
            intersection() {
                linear_extrude(pattern_thickness) square(range_width);
                scale([scale_factor, scale_factor, pattern_thickness]) surface(filename); 
            }            
            
		}		
	}
	
	module plane_pattern() {
		intersection() {
			translate([cube_width / 2, cube_width / 2, 0]) 
				dancing_cubes(rows, cube_width, spacing, hole_radius, edge_width, has_joints = false);
				
			linear_extrude(spacing) square(range_width);
		}
		
		translate([0, 0, spacing]) intersection() {
			translate([cube_width / 2, cube_width / 2, 0]) 
				dancing_cubes(rows, cube_width, spacing, hole_radius, edge_width, has_holes = false, has_joints = false);
				
			linear_extrude(pattern_thickness / 2) square(range_width);
		}
		
		translate([0, 0, spacing + pattern_thickness / 2]) 		
			pattern(has_holes = false, has_joints = false);
	}
	
	translate([0, 0, cube_width])
		if(plane_top == "YES") {
			plane_pattern();
		} else if(filename != "") {
			pattern();
		}
	
	translate([cube_width / 2, cube_width / 2, 0]) 
		dancing_cubes(rows, cube_width, spacing, hole_radius, edge_width);
}

dancing_cubes_2(rows, filename, pattern_thickness, cube_width, spacing, hole_radius, edge_width, plane_top);

