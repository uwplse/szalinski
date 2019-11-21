buttom_symbol_inside = "π";
buttom_symbol_outside = "π";

characters = "3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609433057270365759591953092186117381932611793105118548074462379962749567351885752724891227938183011949129833673362440656643086021394946395224737190702179860943702770539217176293176752384674818467669405132000568127145263560827785771342757789609173637178721468440901224953430146549585371050792279689258923";

bottom_quote = "I will love you until Pi runs out of decimal places.";

thickness = 2;

inner_wall = "YES";


// Creates a vector containing the current point [x, y] and the angle of the turtle.
// Parameters:
//     x - the x coordinate of the turtle.
//     y - the y coordinate of the turtle.
//     angle - the angle of the turtle.
// Return:
//     the turtle vector [[x, y], angle].
function turtle(x, y, angle) = [[x, y], angle];

// Moves the turtle forward the specified distanc
// Parameters:
//     turtle - the turtle vector [[x, y], angle].
// Return:
//     the new turtle vector after forwarding
function forward(turtle, length) = 
    turtle(
        turtle[0][0] + length * cos(turtle[1]), 
        turtle[0][1] + length * sin(turtle[1]), 
        turtle[1]
    );
    

// Returns a new turtle vector with the given point.
// Parameters:
//     turtle - the turtle vector [[x, y], angle].
//     point - the new point of the turtle.
// Return:
//     the new turtle vector
function set_point(turtle, point) = [point, turtle[1]];

// Returns a new turtle vector with the given angle.
// Parameters:
//     turtle - the turtle vector [[x, y], angle].
//     angle - the angle of the turtle.
// Return:
//     the new turtle vector
function set_angle(turtle, angle) = [turtle[0], angle];

// Turns the turtle the specified number of degrees.
// Parameters:
//     turtle - the turtle vector [[x, y], angle].
//     angle - number of degrees.
// Return:
//     the new turtle vector
function turn(turtle, angle) = [turtle[0], turtle[1] + angle];

// Revrese a string, returns a vector which uses all characters as elements.
// Parameters: 
//     string - a string to be reversed.
// Returns:
//     A vector containing reversed characters.
function reverse(string) = [for(i = [len(string) - 1:-1:0]) string[i]];

// Get the tail of a vector.
// Parameters: 
//     index - the first index when tailing
//     vector - the original vector.
// Returns:
//     The tail of a vector.
function tailFrom(index, vector) = [for(i = [len(vector) - index:len(vector) - 1]) vector[i]];

// Moves the turtle spirally. The turtle forwards the 'length' distance, turns 'angle' degrees, minus the length with 'step' and then continue next spiral until the 'end_length' is reached. 
// Parameters: 
//     turtle - the turtle vector [[x, y], angle].
//     length - the beginning length.
//     step - the next length will be minus with the decreasing_step.
//     angle - the turned degrees after forwarding.
//     ending_length - the minimum length of the spiral.
//     text - the text to be spined.
//     ch_angle - used to rotate the character.
module spin_out_characters(turtle, length, step, angle, ending_length, text, ch_angle = 0, index = 0) {
    font_size = 5;

    if(index < len(text) && length < ending_length) {
	
		translate([turtle[0][0], turtle[0][1], 0]) 
			rotate([ch_angle, ch_angle, turtle[1]]) 
				text(text[index], valign = "center", halign = "center", size = font_size, font = "Courier New:style=Bold");
				
        turtle_after_turned = turn(forward(turtle, length), -angle);
        spin_out_characters(turtle_after_turned, length + step, step, angle, ending_length, text, ch_angle, index + 1);
    }
}

// It will reverse the text, and do the same thing as spin_out_characters.
// Parameters: 
//     turtle - the turtle vector [[x, y], angle].
//     length - the beginning length.
//     step - the next length will be minus with the decreasing_step.
//     angle - the turned degrees after forwarding.
//     ending_length - the minimum length of the spiral.
//     text - the text to be spined.
module spin_in_characters(turtle, length, step, angle, ending_length, text) {
    inner_diameter = length * 10;
	outer_diameter = ending_length * 10;
	
	spin_out_characters(turtle, length, step, -angle, ending_length, tailFrom((outer_diameter - inner_diameter) / 10 / step + 1, reverse(text)), 180);	
}

module spiral_characters(symbol, text, outer_diameter, height, spin) {
    inner_diameter = 30;
	step = 0.05;
	angle = 12;
	
	beginning_length = inner_diameter / 10;
	
	outer_length = outer_diameter / 10;
	inner_length = beginning_length;
	
	linear_extrude(height) union() {
		text(symbol, valign = "center", halign = "center", size = inner_diameter * 1.5 / 2, font = "Times New Roman:style=Bold");
		
		if(spin == "OUT") {
			translate([0, inner_diameter / 2, 0])  
				spin_out_characters(turtle(0, 0, 0), inner_length, step, angle, outer_length, text);
		} else {	
			rotate(180) translate([0, -inner_diameter / 2, 0]) 
				spin_in_characters(turtle(0, 0, 0), inner_length, step, angle, outer_length, text, 180);			
		}
	}		
}


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
//     buttom_symbol_inside - the bottom symbol of the inside
//     buttom_symbol_outside - the bottom symbol of the outside
//     characters - the characters around the tower
//     thickness - the character thickness
//     inner_wall - `"YES"` will add an inner wall with the thickness of the half `thickness` value.
module tower_of_characters(buttom_symbol_inside, buttom_symbol_outside, bottom_quote, characters, thickness = 1, inner_wall = "NO") {
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
			    text(buttom_symbol_inside, font = "Times New Roman:style=Bold", size = font_size * 5, halign = "center", valign = "center");
				
		translate([0, 0, -z_desc * len_of_characters - font_size])  rotate(180) mirror([1, 0, 0]) scale(1.2) 
		    scale(1.1) spiral_characters(buttom_symbol_outside, bottom_quote, 80, height = font_size, spin = "OUT");				
    }
}



tower_of_characters(buttom_symbol_inside, buttom_symbol_outside, bottom_quote, characters, thickness, inner_wall = inner_wall);

