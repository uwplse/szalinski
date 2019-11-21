chars = "3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196442881097566593344612847564823378678316527120190914564856692346034861045432664821339360726024914127372458700660631558817";
symbol = "π";
char_gap = 18;

module chars_sphere(chars, symbol, sphere_radius, bottom_radius, font_size, char_gap, floor_density, begining_factor, thickness) {
    b = sphere_radius * begining_factor;
	
    module chars() {
	    for(i = [0:(180 * floor_density - b) / char_gap]) {
			j = b + i * char_gap;
			rotate([0, 0, j ])
				rotate([0, -90 + j / floor_density, 0])
				     
					translate([0, 0, chars[i] == "." ? -font_size / 3 : 0]) rotate([90, 0, 90]) 
					    linear_extrude(sphere_radius) 
						    text(chars[i], valign = "center", halign = "center", size = font_size, font = "Arial Black");
		}
	}
	
	module line() {
	    step = 1;
		for(i = [0:(180 * floor_density - b) / step]) {
			j = b + i * step;
			rotate([0, 0, j ])
				rotate([0, -90 + j / floor_density, 0])
					 translate([0, 0, 0])
						rotate([90, 0, 90]) 
							linear_extrude(sphere_radius) 
								translate([-font_size / 2, font_size / 2, 0]) square([0.5, thickness]);
								
							
		}
	}
	
	module pi() {
		linear_extrude(thickness * 15) 
			circle(bottom_radius, center = true, $fn = 48);
		
		linear_extrude(thickness * 18) 
			rotate(135) text(symbol, valign = "center", halign = "center", size = bottom_radius * 1.5, font = "Broadway");
		
	}
	
	chars();
    line();
	pi();
}

module text_pendant(chars, symbol) {
    radius = 20;
    sphere_radius = 20;
	bottom_radius = 8;	
	font_size = 6;
	char_gap = 18;
	floor_density = 19;
	begining_factor = 38;
	
	s = radius / sphere_radius;
	
	
	scale([s, s, s / 3]) 
	    rotate(-135) chars_sphere(chars, symbol, sphere_radius, bottom_radius, font_size, char_gap, floor_density, begining_factor, 1 / s);
	  
	// chain
	translate([0, 1, 0]) union() {
		translate([0, radius, 0]) rotate_extrude($fn = 96) 
			translate([radius / 6, 0, 0]) 
				rotate([0, 0, 90]) 
					circle(radius / 20, $fn = 24);
					
		translate([0, radius * 1.2, 0]) 
			rotate([90, 90, 90])
				rotate_extrude($fn = 96) 
					translate([radius / 6, 0, 0]) 
						rotate([0, 0, 90]) 
							circle(radius / 20, $fn = 24); 
	}
}


text_pendant(chars, symbol, char_gap); 

	
    