model = "CONTAINER"; // [CONTAINER, COVER, BOTH]
side = 120;
height = 20;
shell_thickness = 1.5;
spacing = 0.8;
ring_number = 3;
ring_width = 2;  
pillar_radius = 1.5;  

module line(point1, point2, width = 1, cap_round = true) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    if(cap_round) {
        translate(point1) circle(d = width, $fn = 24);
        translate(point2) circle(d = width, $fn = 24);
    }

    polygon(points=[
        point1 + offset1, point2 + offset1,  
        point2 + offset2, point1 + offset2
    ]);
}

module polyline(points, width = 1) {
    module polyline_inner(points, index) {
        if(index < len(points)) {
            line(points[index - 1], points[index], width);
            polyline_inner(points, index + 1);
        }
    }

    polyline_inner(points, 1);
}


module hinged_triangle_to_square(model, side, height, shell_thickness, spacing, ring_number, ring_width, pillar_radius) {
    $fn = 24;
	
	half_spacing = spacing / 2;
	half_side = side / 2;

	cos50 = cos(50);
	cos60 = cos(60);
	sin50 = sin(50);
	sin60 = sin(60);

	p1_p7_leng = half_side * sin60 * sin50;
	p5_p8_leng = half_side * sin60 * cos(40); 

	p0 = [0, 0];
	p1 = [half_side * cos60, half_side * sin60];
	p2 = [half_side, side * sin60];
	p3 = [side - half_side * cos60, half_side * sin60];
	p4 = [side, 0];
	p5 = [side - half_side * cos60, 0];
	p6 = [half_side * cos60, 0];
	p7 = [p1[0] + p1_p7_leng * cos50, p1[1] - p1_p7_leng * sin50];
	p8 = [p5[0] - p5_p8_leng * cos50, p5_p8_leng * sin50];

	joint_r_outermost = pillar_radius + spacing + ring_width + spacing;
	joint_ring_outer = pillar_radius + spacing + ring_width;
	joint_ring_inner = pillar_radius + spacing;
	
	
	
    joint_height = height / (ring_number - 1);
    
	module joint() {
		module joint_ring() {
			difference() {
				circle(joint_ring_outer); 
				circle(joint_ring_inner);
			}	
		}

		difference() {
			linear_extrude(joint_height) joint_ring();
			
			translate([0, 0, joint_height / 2]) 
				linear_extrude(joint_height / 3 + spacing * 2, center = true) 
					joint_ring();
		}

		translate([0, 0, joint_height / 2]) 
			linear_extrude(joint_height / 3, center = true) 
				line(p0, [p0[0] + joint_r_outermost, 0], pillar_radius * 2);
		
		// pillar
		linear_extrude(joint_height) circle(pillar_radius);
	}
	
	module joints() {
		translate(p5) rotate(65) joint();
		translate(p3) rotate(170) joint();
		translate(p1) rotate(275) joint();
	}

    module block1() {
		difference() {
			polygon([p0, p1, p7, p6]);
			line(p1, p7, spacing);
			line(p3, p6, spacing);
			
			translate(p1) 
				rotate(275) 
					circle(joint_r_outermost);
		}	
	}
	
    module block2() {
		difference() {
			polygon([p1, p2, p3, p7]);
			line(p1, p7, spacing);
			line(p3, p6, spacing);
			
			translate(p3) 
				rotate(170) circle(joint_r_outermost);
				
			translate(p1) 
				circle(joint_ring_inner);
		}
	}
	
    module block3() {
		difference() {
			polygon([p5, p8, p3, p4]);
			line(p3, p6, spacing);
			line(p5, p8, spacing);
			
			translate(p5) 
				rotate(65) circle(joint_r_outermost);
				
			translate(p3) 
				rotate(170) circle(joint_ring_inner);
		}
	}	
	
    module block4() {
		difference() {
			polygon([p6, p8, p5]);
			line(p3, p6, spacing);
			line(p5, p8, spacing);
			
			translate(p5) 
				rotate(65) circle(joint_ring_inner);
		}
	}		
	
	module triangle() {
		difference() {
			union() {
				block1();
				block2();
				block3();
				block4();
			}

			polyline([p0, p2, p4, p0], spacing);
		}	
	}
	
	module triangle_to_square_container() {
		difference() {
			linear_extrude(height) triangle();
			
			translate([0, 0, shell_thickness]) 
				linear_extrude(height) 
					offset(r = -shell_thickness) 
						triangle();
		}
		
		for(i = [0:ring_number - 2]) {
			translate([0, 0, joint_height * i]) joints();
		}	
	}
	
	module cover() {
	    rotate([180, 0, 0]) union() {
			linear_extrude(shell_thickness) triangle();
			
			translate([0, 0, -shell_thickness * 2]) linear_extrude(shell_thickness * 2) difference() {
				offset(r = -shell_thickness - spacing) triangle();
				offset(r = -shell_thickness * 2 - spacing) triangle();
			}	
		}
	}
	

	if(model == "CONTAINER" || model == "BOTH") {
        triangle_to_square_container();
	}
	
	if(model == "COVER" || model == "BOTH") {
        cover(); 
	}
	
    


}


hinged_triangle_to_square(model, side, height, shell_thickness, spacing, ring_number, ring_width, pillar_radius);

