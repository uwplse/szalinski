segs_for_sd = 4;
segs_for_micro_sd = 2;
spacing = 0.6;

module triangle(triangle_length, joint_thickness) {
	offset_len = 1;
	radius = 0.5 * triangle_length / cos(30) - offset_len;
	translate([joint_thickness, 0, radius * sin(30) + offset_len]) 
		rotate([0, -90, 0]) 
			linear_extrude(joint_thickness) 
				offset(r = offset_len) 
					circle(radius, $fn = 3);
}

module sd_card_holder_fish(segs_for_sd, segs_for_micro_sd, spacing) {
    $fn = 24;
	
	joint_thickness = 3; 
	sd_thickness = 1.5;
	sd_inner_length = 25;
	sd_inner_width = 3;
	sd_inner_depth = 10;

    sd_outer_length = sd_inner_length + 2 * sd_thickness;	
	sd_outer_width = sd_inner_width + 2 * sd_thickness;
	
	micro_sd_length = 12;
	micro_sd_thickness = 1.5;
	micro_sd_depth = 8;
	

	triangle_length = sd_outer_length;
	half_length = triangle_length / 2;
    double_thickness = joint_thickness * 2;
	
	step = (triangle_length * sin(60) - double_thickness) / (segs_for_sd + 0.4);

	module joint() {
	    translate([joint_thickness * 2 / 3, 0, 0]) union() {
			difference() {
				union() {
					translate([1.25 * joint_thickness, 0, joint_thickness]) 
						linear_extrude(double_thickness, center = true) difference() {
							offset(r = joint_thickness / 2) 
								square([joint_thickness, joint_thickness], center = true);
							square([joint_thickness, joint_thickness], center = true);
						}
				}
				linear_extrude(double_thickness) 
					square([double_thickness, joint_thickness], center = true); 
			}

			translate([sd_outer_width + joint_thickness * 0.85, 0, joint_thickness]) rotate([90, -90, 0])
			linear_extrude(joint_thickness - spacing * 2, center = true) difference() {
				union() {
					circle(joint_thickness);
					translate([-joint_thickness, 0, 0]) 
						square([double_thickness, joint_thickness]);
				}
				circle(joint_thickness / 2.5 + spacing);
			}
		}
		
		translate([sd_outer_width / 6 + spacing / 2, 0, joint_thickness]) rotate([90, 0, 0]) 
			linear_extrude(double_thickness, center = true) 
				circle(joint_thickness / 2.5);
	}

	module fish_body_tail() {
		for(i = [0:(segs_for_sd + segs_for_micro_sd) - 1]) {
			translate([(sd_outer_width * 1.6 - spacing / 2) * i, 0, 0]) union() {
			    difference() {
				    if(i < segs_for_sd) {
						difference() {
							translate([sd_outer_width / 2,  0, 0]) 
								linear_extrude(joint_thickness * 2 + spacing + sd_thickness + sd_inner_depth) 
									square([sd_outer_width, sd_outer_length], center = true);
							
							// SD card slot
							translate([sd_outer_width / 2, 0, joint_thickness * 2 + spacing + sd_thickness]) 
								linear_extrude(sd_inner_depth) 		
									square([sd_inner_width, sd_inner_length], center = true);
						}
					} else {
					    difference() {
							translate([sd_outer_width / 2,  0, 0]) 
								linear_extrude(joint_thickness * 2 + spacing + sd_thickness + sd_inner_depth) 
									square([sd_outer_width, sd_outer_length], center = true);
							
							// micro SD card slot
							translate([sd_outer_width / 2, micro_sd_length / 2 + sd_thickness / 2, joint_thickness * 2 + spacing + sd_thickness + sd_inner_depth - micro_sd_depth]) 
								linear_extrude(micro_sd_depth) 		
									square([micro_sd_thickness, micro_sd_length], center = true);
									
							translate([sd_outer_width / 2, -micro_sd_length / 2 - sd_thickness / 2, joint_thickness * 2 + spacing + sd_thickness + sd_inner_depth - micro_sd_depth]) 
								linear_extrude(micro_sd_depth) 		
									square([micro_sd_thickness, micro_sd_length], center = true);
						}
					}
					
					linear_extrude(sd_outer_width + spacing) 
							square([sd_outer_width * 2, sd_outer_width / 2], center = true); 
				}
				joint();
			}
		}
		
		// tail
		translate([(sd_outer_width * 1.6 - spacing / 2) * (segs_for_sd + segs_for_micro_sd + 1), 0, 0])
		linear_extrude(double_thickness) union() {
			difference() {
				circle(joint_thickness * 4);
				translate([joint_thickness * 3.2, 0, 0]) circle(joint_thickness * 4);
			}
		}
	}

	module head() {
	    r = triangle_length * sin(60) / 4;
		difference() {
			hull() {
				triangle(triangle_length, joint_thickness);
				
				translate([-half_length, 0, half_length]) sphere(r);
				
				translate([-half_length, 0, joint_thickness]) sphere(r);
			}
			
			// flatten chin
			translate([0, 0, -half_length])
			    linear_extrude(half_length) 
				    square([triangle_length * 2, triangle_length], center = true);
			
			// mouth
			scale([1, 1, 0.75]) 
			    translate([-triangle_length / 1.425, 0, triangle_length / 2.25])
			        rotate([0, -90, 90])
   					    linear_extrude(triangle_length * 2, center = true)  
						    circle(triangle_length / 1.5, $fn = 3);
		}

		// eyes
		translate([-triangle_length / 8, triangle_length / 5, triangle_length / 1.75]) 
			sphere(triangle_length / 10);
			
		translate([-triangle_length / 8, -triangle_length / 5, triangle_length / 1.75]) 
			sphere(triangle_length / 10);
	}

	fish_body_tail();
	translate([-sd_outer_width - spacing / 2, 0, 0]) head();
	translate([-sd_outer_width * 1.55, 0, 0]) joint();
}

sd_card_holder_fish(segs_for_sd, segs_for_micro_sd, spacing);











