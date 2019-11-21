buttom_symbol = ";";

characters = "That's weird.It's never done that before.It worked yesterday.How is that possible?It must be a hardware problem.What did you type in wrong to get it to crash?There is something funky in your data.I haven't touched that module in weeks!You must have the wrong version.It's just some unlucky coincidence.I can't test everything!THIS can't be the source of THAT.It works, but it hasn't been tested.Somebody must have changed my code.Did you check for a virus on your system?Even though it doesn't work, how does it feel?You can't use that version on your system.Why do you want to do it that way?Where were you when the program blew up?It works on my machine.                                             ";

thickness = 2;

inner_wall = "YES";

function PI() = 3.14159;

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 90.
// Parameters: 
//     radius - the radius of arc
//     angle - the angle of arc
//     width - the width of arc
module a_quarter_arc(radius, angle, width = 1) {
    outer = radius + width;
    intersection() {
        difference() {
            offset(r = width) circle(radius, $fn=48); 
            circle(radius, $fn=48);
        }
        polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
    }
}

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 360.
// Parameters: 
//     radius - the radius of arc
//     angle - the angle of arc
//     width - the width of arc
module arc(radius, angles, width = 1) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;
    outer = radius + width;
    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_arc(radius, angle_difference, width);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            arc(radius, [0, 90], width);
            rotate(90) a_quarter_arc(radius, angle_difference - 90, width);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            arc(radius, [0, 180], width);
            rotate(180) a_quarter_arc(radius, angle_difference - 180, width);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            arc(radius, [0, 270], width);
            rotate(270) a_quarter_arc(radius, angle_difference - 270, width);
       }
}

// Create a 3D character around a cylinder. The `radius` and `arc_angle` determine the font size of the character. 
// Parameters: 
//     character - 3D character you want to create
//     arc_angle - angle which the character go across
//     radius - the cylinder radius
//     font - the character font
//     thickness - the character thickness
//     font_factor - use this parameter to scale the calculated font if necessary
module cylinder_character(character, arc_angle, radius, font = "Courier New:style=Bold", thickness = 1, font_factor = 1) {
    half_arc_angle = arc_angle / 2;
    font_size = 2 * radius * sin(half_arc_angle) * font_factor;

    rotate([0, 0, -half_arc_angle]) intersection() {
       translate([0, 0, -font_size / 5]) 
             linear_extrude(font_size * 1.5) 
                 arc(radius, [0, arc_angle], thickness);
    
       rotate([90, 0, 90 + half_arc_angle]) 
            linear_extrude(radius + thickness) 
                text(character, font = font, size = font_size, halign = "center");
    }
} 


// It has the same visual effect as `cylinder_character`, but each character is created by the `text` module. Use this module if your `arc_angle` is small enough and you want to render a model quickly. 
// Parameters: 
//     character - 3D character you want to create
//     arc_angle - angle which the character go across
//     radius - the cylinder radius
//     font - the character font
//     thickness - the character thickness
//     font_factor - use this parameter to scale the calculated font if necessary
module fake_cylinder_character(character, arc_angle, radius, font = "Courier New:style=Bold", thickness = 1, font_factor = 1) {
    half_arc_angle = arc_angle / 2;
    font_size = 2 * radius * sin(half_arc_angle) * font_factor;

    translate([radius, 0, 0]) rotate([90, 0, 90]) 
        linear_extrude(thickness) 
            text(character, font = font, size = font_size, halign = "center");
} 

// Create a chain text around a cylinder.
// Parameters: 
//     text - the text you want to create
//     radius - the cylinder radius
//     thickness - the character thickness
module chain_text(text, radius, thickness = 1) {
    arc_angle = 360 / len(text);

    for(i = [0 : len(text) - 1]) {
        rotate([0, 0, i * arc_angle]) 
            cylinder_character(text[i], arc_angle, radius, thickness = thickness);
    }
}

// Create a chain text around a cylinder for Chinese characters. It uses the font "微軟正黑體".
// Parameters: 
//     text - the text you want to create
//     radius - the cylinder radius
//     thickness - the character thickness
module chain_text_chinese(text, radius, thickness = 1) {
    arc_angle = 360 / len(text);

    for(i = [0 : len(text) - 1]) {
        rotate([0, 0, i * arc_angle]) 
            cylinder_character(text[i], arc_angle, radius, "微軟正黑體", thickness, 0.85);
    }
}

// Create a character tower. If you want to print it easily, set the `inner_wall` parameter to `"YES"`. It will add an inner wall with the thickness of the half `thickness` value.
// Parameters: 
//     symbol - the bottom symbol
//     characters - the characters around the tower
//     thickness - the character thickness
//     inner_wall - `"YES"` will add an inner wall with the thickness of the half `thickness` value.
module tower_of_characters(symbol, characters, thickness = 1, inner_wall = "NO") {
    radius = 40;
    
    characters_of_a_circle = 40;
    arc_angle = 360 / characters_of_a_circle;
    
    half_arc_angle = arc_angle / 2;
    font_size = 2 * radius * sin(half_arc_angle);
    z_desc = font_size / characters_of_a_circle;
	
	len_of_characters = len(characters);

    // characters
	
	for(i = [0 : len_of_characters - 1]) {
		translate([0, 0, -z_desc * i])
			rotate([0, 0, i * arc_angle]) 
				fake_cylinder_character(characters[i], arc_angle, radius, thickness = thickness, font_factor = 1.05);
				
		translate([0, 0, font_size - 1 -z_desc * i])
			rotate([-1.5, 0, i * arc_angle - half_arc_angle])
				linear_extrude(1.2) 
					arc(radius, [0, arc_angle], thickness);

		if(inner_wall == "YES") {                    
			translate([0, 0, 0.2 - z_desc * i])
				rotate([-1.5, 0, i * arc_angle - half_arc_angle])
					linear_extrude(font_size) 
						arc(radius, [0, arc_angle], thickness / 2);
		}
	} 
    
    // bottom
    
    difference() {
        translate([0, 0, -z_desc * len_of_characters]) 
            linear_extrude(font_size) 
                circle(radius + thickness * 1.5, $fn=48);
            
        translate([0, 0, -z_desc * len_of_characters + font_size * 3 / 4]) 
            linear_extrude(font_size) 
			    text(symbol, font = "Courier New:style=Bold", size = font_size * 5, halign = "center", valign = "center");
    }
}

// Create a character tower for chinese. It uses the font "微軟正黑體". If you want to print it easily, set the `inner_wall` parameter to `"YES"`. It will add an inner wall with the thickness of the half `thickness` value.
// Parameters: 
//     symbol - the bottom symbol
//     characters - the characters around the tower
//     thickness - the character thickness
//     inner_wall - `"YES"` will add an inner wall with the thickness of the half `thickness` value.
// Create a character tower for chinese. It uses the font "微軟正黑體". If you want to print it easily, set the `inner_wall` parameter to `"YES"`. It will add an inner wall with the thickness of the half `thickness` value.
// Parameters: 
//     symbol - the bottom symbol
//     characters - the characters around the tower
//     thickness - the character thickness
//     inner_wall - `"YES"` will add an inner wall with the thickness of the half `thickness` value.
module tower_of_chinese_characters(symbol, characters, thickness = 1, inner_wall = "NO") {
    radius = 40;
    
    characters_of_a_circle = 30;
	arc_angle = 360 / characters_of_a_circle;
    
    half_arc_angle = arc_angle / 2;
    font_size = 2 * radius * sin(half_arc_angle);
    z_desc = font_size / characters_of_a_circle;


    // characters
    
    for(i = [0 : len(characters) - 1]) {
        translate([0, 0, -z_desc * i])
            rotate([0, 0, i * arc_angle]) 
                fake_cylinder_character(characters[i], arc_angle, radius, font = "微軟正黑體", thickness = thickness, font_factor = 0.75);
                
        translate([0, 0, font_size - 1 -z_desc * i])
            rotate([-2, 0, i * arc_angle - half_arc_angle])
                linear_extrude(1.2) 
                    arc(radius, [0, arc_angle], thickness);

        if(inner_wall == "YES") {                    
            translate([0, 0, 0.2 - z_desc * i])
                rotate([-2, 0, i * arc_angle - half_arc_angle])
                    linear_extrude(font_size) 
                        arc(radius, [0, arc_angle], thickness / 2);
        }
    } 
    
    // bottom
  
    difference() {
        translate([0, 0, -z_desc * len(characters)]) 
            linear_extrude(font_size) 
                circle(radius + thickness * 1.5, $fn=48);
            
        translate([0, 0, -z_desc * len(characters) + font_size * 3 / 4]) 
            linear_extrude(font_size) 
			    text(symbol, font = "微軟正黑體", size = font_size * 5, halign = "center", valign = "center");
    }
}


tower_of_characters(buttom_symbol, characters, thickness, inner_wall = inner_wall);
