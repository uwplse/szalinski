// input your N
n_multi_3_segments = 33; 
triangle_thickness = 3;
spacing = 0.65;

module joint(inner_length, inner_width, height, thickness) {
    $fn = 24;

	// U 
	linear_extrude(height, center = true) difference() {
	    offset(delta = thickness, chamfer = true) 
		    square([inner_length, inner_width], center = true);
			
	    square([inner_length, inner_width], center = true);
		
		translate([-thickness / 2 - inner_length / 2, 0, 0]) 
		    square([thickness, inner_width], center = true);
	}
	
	// ring
	translate([height / 2 + inner_length / 2 + thickness / 2, 0, 0]) 
	rotate([90, 0, 0])
	linear_extrude(thickness, center = true) difference() {
	    union() {
			circle(height / 2);
			translate([-height / 4, 0, 0]) square([height / 2, height], center = true);
		}
		circle(height / 2 - thickness);
	}
}


module fish_triangle(side_length, triangle_thickness, spacing) {
    joint_thickness = triangle_thickness / 3 * 2;	
	
	slot_width = joint_thickness * 3 + spacing * 4;

	slot_height = joint_thickness + spacing * 2;

	radius = side_length * cos(30) * 2 / 3;
	
	translate([0, 0, (radius - 1) / 2 + 1]) union() {
		rotate([0, -90, 0])  union() {
			// triangle
			linear_extrude(triangle_thickness, center = true)   difference() {
				offset(r = 1) circle(radius - 1, $fn = 3);
				// slot
				// -(radius - 1) / 2 - 1 + joint_thickness
				translate([(joint_thickness + spacing * 2) / 2 -(radius - 1) / 2 - 1 + joint_thickness, 0, 0]) square([slot_height, slot_width], center = true);
			}		
			
			// stick
			translate([-(radius - 1) / 2 - 1, 0, 0]) rotate([90, 0, 0]) rotate([0, 90, 0]) 
			    linear_extrude(joint_thickness * 2 + spacing * 2) 
				    circle(triangle_thickness / 3, $fn = 24);
		}
		
		joint_height = joint_thickness * 3 + spacing * 2;
		joint_width = joint_thickness + spacing * 2;
		translate([joint_width, 0, joint_height / 2 -(radius - 1) / 2 - 1])
			rotate([90, 0, 0]) joint(joint_thickness, joint_width, joint_height, joint_thickness);
	}
}

module head(triangle_length, contact_thickness) {
    $fn = 24;
	
	radius = triangle_length * cos(30) * 2 / 3;
	r = triangle_length * sin(60) / 4;
	
	translate([0, 0, (radius - 1) / 2 + 1]) rotate([0, -90, 0])
	union() {
		difference() {
			hull() {
				linear_extrude(contact_thickness, center = true) 
					offset(r = 1) circle(radius - 1, $fn = 3);
							
					translate([triangle_length / 14 * 3, 0, triangle_length / 2]) sphere(r);
					
					translate([-triangle_length / 4 , 0, triangle_length / 2]) sphere(r);
			}
			
			linear_extrude(triangle_length * 1.5, center = true) translate([-triangle_length / 2 - (radius - 1) / 2 - 1, 0, 0]) square([triangle_length, triangle_length], center = true);
			
			translate([0, 0, triangle_length / 1.25]) rotate([90, 0, 0]) 
		 scale([0.75, 1, 1]) linear_extrude(triangle_length, center = true) circle(triangle_length / 1.5, $fn = 3);
		}
		
		// eyes
		translate([triangle_length / 4, triangle_length / 5, triangle_length / 5]) sphere(triangle_length / 10);
		
		translate([triangle_length / 4, -triangle_length / 5, triangle_length / 5]) sphere(triangle_length / 10);
	}
}

module spiral_moving_fish(segments, triangle_thickness, spacing) {

    head_side_length = 25.4;
	
    $fn = 25;
	
	joint_thickness = triangle_thickness / 3 * 2;
	slot_width = joint_thickness + spacing * 2;
	slot_height = joint_thickness * 3 + spacing * 2;
	
	offset = joint_thickness * 2.5 + slot_width + spacing;
	radius = head_side_length * cos(30) * 2 / 3;
	
	init_angle = 360 * 1.5;
	ray_length = 25.8;
	children_per_step = 3;
	steps = segments / children_per_step + 1;	
	
	step = (radius / 2 * 3 - slot_height * (segments < 9 ? 2.3 : 1.9)) / segments;

	module archimedean_spiral_for_fish(init_angle, ray_length, steps, children_per_step) {
		a = ray_length / 360;
		angles = find_angles([init_angle], ray_length, steps + 1);
		
		head_r = a * init_angle;
		
		// head
		rotate(init_angle) translate([head_r, 0, 0]) rotate(90) union() { // head
			fish_triangle(head_side_length, triangle_thickness, spacing); 
			head(head_side_length, triangle_thickness);
		}
		
		// triangles
		for(i = [1:steps - 1]) {
			child_step = (angles[i] - angles[i - 1]) / children_per_step;
			for(j = [0:children_per_step]) {
				angle = angles[i - 1] + child_step * j;
				r = a * angle;
				rotate(angle) 
					translate([r, 0, 0]) 
						rotate(90) if(i == steps - 1 && j == children_per_step) {
							fish_triangle(head_side_length - (i * 3 + j) * step, triangle_thickness, spacing);
							
						    // tail
							translate([triangle_thickness * 5, 0, 0]) linear_extrude(slot_height)  union() {
								difference() {
									circle(head_side_length / 3);
									translate([head_side_length / 4, 0, 0]) 
										circle(head_side_length / 3);
								}
								
								// ring
								difference() {
									offset(r = triangle_thickness / 2.4) circle(triangle_thickness / 1.2);
									circle(triangle_thickness / 1.2);
								}
							}
						} else {
						    
						    fish_triangle(head_side_length  - (i * 3 + j) * step, triangle_thickness, spacing);
						}
			}
		}
		
		
	}	
	
	PI = 3.14159;
 
	function find_angles(angles, ray_length, n, i = 1) =
    i == n ? angles :
        find_angles(concat(angles, [angles[i - 1] + ray_length * 64800 / (PI * angles[i - 1] * ray_length)]), ray_length, n, i + 1);
	
	archimedean_spiral_for_fish(init_angle, ray_length, steps, children_per_step);
}

spiral_moving_fish(n_multi_3_segments * 3, triangle_thickness, spacing);