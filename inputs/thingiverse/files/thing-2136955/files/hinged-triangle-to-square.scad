side = 40;
height = 6;
spacing = 0.8;
ring_width = 1.5;  
pillar_radius = 1;  
chain_hole = "YES";  // [YES, NO]
chain_hole_width = 2.5;

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

module hinged_triangle_to_square(side, height, spacing, ring_width, pillar_radius) {
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

 
	module joint() {
		module joint_ring() {
			difference() {
				circle(joint_ring_outer); 
				circle(joint_ring_inner);
			}	
		}

		difference() {
			linear_extrude(height) joint_ring();
			
			translate([0, 0, height / 2]) 
				linear_extrude(height / 3 + spacing * 2, center = true) 
					joint_ring();
		}

		translate([0, 0, height / 2]) 
			linear_extrude(height / 3, center = true) 
				line(p0, [p0[0] + joint_r_outermost, 0], pillar_radius * 2);
		
		// pillar
		linear_extrude(height) circle(pillar_radius);
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
	
	linear_extrude(height) difference() {
		union() {
			block1();
			block2();
			block3();
			block4();
		}

		polyline([p0, p2, p4, p0], spacing);
	}

	translate(p5) rotate(65) joint();
	translate(p3) rotate(170) joint();
	translate(p1) rotate(275) joint();
}

difference() {
	hinged_triangle_to_square(side, height, spacing, ring_width, pillar_radius);
	if(chain_hole == "YES") {
		translate([spacing * 1.5, spacing, height / 2]) linear_extrude(chain_hole_width, center = true) difference() {
			circle(pillar_radius + spacing + chain_hole_width);
			circle(pillar_radius + spacing);
		}
	}
}

