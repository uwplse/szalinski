chars = "There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies."; 
bottom_symbol = ";";
style = "No shell"; // [No shell, Shell, Inverted]
// only usable when there's a shell
top_radius = 25; 
bottom_radius = 15;
sphere_radius = 40;
font_name = "Arial Black";
font_size = 7.5;
char_gap = 16; 
floor_density = 31;
top_offset = 35;
thickness = 2;

module text_sphere(chars, bottom_symbol, sphere_radius, top_radius, bottom_radius, font_name, font_size, char_gap, floor_density, top_offset, thickness, style) {

    b = sphere_radius * top_offset;
	
    module chars() {
	    for(i = [0:(180 * floor_density - b) / char_gap]) {
			j = b + i * char_gap;
			rotate([0, 0, j ])
				rotate([0, -90 + j / floor_density, 0])
				     
					translate([sphere_radius, 0, chars[i] == "." ? -font_size / 3 : 0]) rotate([90, 0, 90]) 
					    linear_extrude(thickness) 
						    text(chars[i], valign = "center", halign = "center", size = font_size, font = font_name);
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
				rotate([0, 0, -90]) text(bottom_symbol, valign = "center", halign = "center", size = bottom_radius * 1.5, font = font_name);
		}	
	}
	
	module shell() {
	    fn = style == "Shell" ? 24 : 48;
		difference() {
			sphere(sphere_radius + thickness / 2, $fn = fn);
			sphere(sphere_radius - thickness / 2, $fn = fn);
			linear_extrude(sphere_radius * 2) 
					circle(top_radius, center = true, $fn = 24);
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

text_sphere(chars, bottom_symbol, sphere_radius, top_radius, bottom_radius, font_name, font_size, char_gap, floor_density, top_offset, thickness, style);

	
    