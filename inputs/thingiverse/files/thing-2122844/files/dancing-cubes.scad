rows = 3; // [2:100]
cube_width = 20;
spacing = 0.8;
hole_radius = 2.3; 
edge_width = 2; 

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
		translate([corner_r, corner_r, 0]) 
			rotate(180) 
				part_for_carve_a_sink(hole_radius, cube_width, edge_width);
				
		translate([cube_width - corner_r, corner_r, 0]) 
			rotate(270) 
				part_for_carve_a_sink(hole_radius, cube_width, edge_width);
			
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

module dancing_cubes(rows, cube_width, spacing, hole_radius, edge_width) {
	corner_r = hole_radius + edge_width;
	h_join_leng = 2 * corner_r + spacing;
	cube_offset = 2 * (cube_width / 2 - corner_r) * sqrt(2) + h_join_leng;
	
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

	for(r = [0:rows - 1]) {
		for(c = [0:rows - 1]) {
			translate([cube_offset * r, cube_offset * c, 0]) union() {
				if(is_corner(r, c)) {
					corner_cube(r, c);			
				} else if(is_side(r, c)) {
				    side_cube(r, c);
				} else {
					a_dancing_cube_no_joint(cube_width, 4, hole_radius, edge_width, spacing);			
				}	
			}		
		}
	}

	joint_offset = (cube_width / 2 - corner_r) * sqrt(2) + corner_r + spacing / 2;

	for(r = [0:rows - 2]) {
		for(c = [0:rows - 1]) {
			translate([c * cube_offset, joint_offset + cube_offset * r, 0]) rotate(90) joint_H(cube_width, hole_radius, edge_width, spacing);
			
			translate([joint_offset + cube_offset * r, cube_offset * c, 0]) 
				joint_H(cube_width, hole_radius, edge_width, spacing);
		}
	}
}
dancing_cubes(rows, cube_width, spacing, hole_radius, edge_width);
