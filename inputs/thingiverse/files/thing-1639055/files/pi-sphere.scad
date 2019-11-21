radius = 30;
style = "Shell"; // [No shell, Shell, Inverted]
thickness = 1;

module characters_sphere(characters, sphere_radius, bottom_radius, font_size, char_gaps, floor_density, begining_factor, thickness, style) {
    b = sphere_radius * begining_factor;
	
    module chars() {
	    for(i = [0:(180 * floor_density - b) / char_gaps]) {
			j = b + i * char_gaps;
			rotate([0, 0, j ])
				rotate([0, -90 + j / floor_density, 0])
				     
					translate([sphere_radius, 0, characters[i] == "." ? -font_size / 3 : 0]) rotate([90, 0, 90]) 
					    linear_extrude(thickness) 
						    text(characters[i], valign = "center", halign = "center", size = font_size, font = "Arial Black");
					 
						
								
							
		}
	}
	
	module line() {
	    step = style == "Shell" ? 1 : 0.5;
		for(i = [0:(180 * floor_density - b) / step]) {
			j = b + i * step;
			rotate([0, 0, j ])
				rotate([0, -90 + j / floor_density, 0])
					 translate([sphere_radius, 0, 0])
						rotate([90, 0, 90]) 
							linear_extrude(thickness) 
								translate([-font_size / 2, font_size / 2, 0]) square([0.5, style == "Inverted" ? thickness / 2 : thickness]);
								
							
		}
	}
	
	module bottom() {
		translate([0, 0, -sphere_radius - thickness * 1.5]) 
		union() {
			linear_extrude(thickness * 3) 
				circle(bottom_radius, center = true, $fn = 48);
			
			color("black") linear_extrude(thickness * 4) 
				rotate([0, 0, -90]) text("π", valign = "center", halign = "center", size = bottom_radius * 1.5, font = "Broadway");
		}	
	}
	
	module shell() {
	    fn = style == "Shell" ? 24 : 48;
		difference() {
			sphere(sphere_radius + thickness / 2, $fn = fn);
			sphere(sphere_radius - thickness / 2, $fn = fn);
			linear_extrude(sphere_radius * 2) 
					circle(bottom_radius * 1.2, center = true, $fn = 24);
		}
	}
	

	if(style == "Inverted") {
		difference() {
			shell();
			chars();
			line();
		} 
	} else {
		chars();
		line();
        if(style == "Shell") {
		    shell();
		}
	}
	bottom();
}

module pi_sphere(radius, style, thickness) {
    characters = "3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196442881097566593344612847564823378678316527120190914564856692346034861045432664821339360726024914127372458700660631558817";
    sphere_radius = 30;
	bottom_radius = 10;	
	font_size = 6;
	char_gaps = 15;
	floor_density = 30;
	begining_factor = 30;
	
	s = radius / sphere_radius;
	
	scale(s) 
	    characters_sphere(characters, sphere_radius, bottom_radius, font_size, char_gaps, floor_density, begining_factor, thickness / s, style);
}


pi_sphere(radius, style, thickness);
	
    