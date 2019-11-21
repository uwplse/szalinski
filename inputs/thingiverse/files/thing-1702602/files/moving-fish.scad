triangle_length = 35;
triangle_numbers = 6;
triangle_thickness = 3;
spacing = 0.6;

module triangle(triangle_length, triangle_thickness) {
	offset_len = 1;
	radius = 0.5 * triangle_length / cos(30) - offset_len;
	translate([triangle_thickness, 0, radius * sin(30) + offset_len]) 
		rotate([0, -90, 0]) 
			linear_extrude(triangle_thickness) 
				offset(r = offset_len) 
					circle(radius, $fn = 3);
}

module moving_fish(triangle_length, triangle_numbers, triangle_thickness, spacing) {
    $fn = 24;

	half_length = triangle_length / 2;
    double_thickness = triangle_thickness * 2;
	
	step = (triangle_length * sin(60) - double_thickness) / (triangle_numbers + 0.4);

	module joint() {
		difference() {
			union() {
				translate([1.25 * triangle_thickness, 0, triangle_thickness]) 
					linear_extrude(double_thickness, center = true) difference() {
						offset(r = triangle_thickness / 2) 
							square([triangle_thickness, triangle_thickness], center = true);
						square([triangle_thickness, triangle_thickness], center = true);
					}
			}
			linear_extrude(double_thickness) 
				square([double_thickness, triangle_thickness], center = true); 
		}


		translate([triangle_thickness / 2, 0, triangle_thickness]) rotate([90, 0, 0]) 
			linear_extrude(double_thickness, center = true) 
				circle(triangle_thickness / 2.5);

		translate([triangle_thickness * 3, 0, triangle_thickness]) rotate([90, -90, 0])
		linear_extrude(triangle_thickness - spacing * 2, center = true) difference() {
			union() {
				circle(triangle_thickness);
				translate([-triangle_thickness, 0, 0]) 
					square([double_thickness, triangle_thickness]);
			}
			circle(triangle_thickness / 2.5 + spacing);
		}
	}

	module fish_body_tail() {
		for(i = [0:triangle_numbers]) {
			translate([triangle_thickness * 2.5 * i, 0, 0]) union() {
				difference() {
					triangle(triangle_length - step * i, triangle_thickness);
					linear_extrude(double_thickness + spacing) 
							square([double_thickness, triangle_thickness], center = true); 
				}
				joint();
			}
		}
		
		// tail
		translate([triangle_thickness * 2.5 * (triangle_numbers + 2.5), 0, 0])
		linear_extrude(double_thickness) union() {
			difference() {
				circle(triangle_thickness * 4);
				translate([triangle_thickness * 3.2, 0, 0]) circle(triangle_thickness * 4);
			}
			// ring
			difference() {
				offset(r = triangle_thickness / 2) circle(triangle_thickness);
				circle(triangle_thickness);
			}
		}
	}

	module head() {
	    r = triangle_length * sin(60) / 4;
		difference() {
			hull() {
				triangle(triangle_length, triangle_thickness);
				
				translate([-half_length, 0, half_length]) sphere(r);
				
				translate([-half_length, 0, triangle_thickness]) sphere(r);
			}
			
			// flatten chin
			translate([0, 0, -half_length])
			    linear_extrude(half_length) 
				    square([triangle_length * 2, triangle_length], center = true);
			
			// mouth
			scale([1, 1, 0.75]) 
			    translate([-triangle_length / 1.5, 0, triangle_length / 2.25])
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
	head();
}

moving_fish(triangle_length, triangle_numbers, triangle_thickness, spacing);











