text = "There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.";
symbol = ";";
diameter = 87.5; 
fn = 48;

///////////////////
// Turtle Graphics
//

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

// Draw a character of the spin_characters.
// Parameters: 
//     turtle - the turtle vector [[x, y], angle].
//     ch - the character to be draw.
//     max_length - the max_length of the spin_characters.
//     min_length - min_length of the spin_characters.
//     n - the n-th character.
module draw_a_character(turtle, ch, max_length, min_length, n) {
    angle = 12;
	step = 0.05;
	
	characters_per_circle = 30;
	top_layers = 2;
	total_characters = (max_length - min_length) / step;
	circles = total_characters / characters_per_circle;
	z_angle_per_circle = 90 / (circles + top_layers);
	z_angle_per_ch = z_angle_per_circle / characters_per_circle;
	stand_up_angle = 90 / total_characters;
	
	translate([turtle[0][0], turtle[0][1], sin(90 - z_angle_per_circle * top_layers - z_angle_per_ch * n)  * max_length / 2 * 10])  
		rotate([stand_up_angle * n, 0, turtle[1]]) 
			 linear_extrude(20) 
				text(ch, valign = "center", halign = "center", size = 5, font = "Courier New:style=Bold");
}

// Moves the turtle spirally. The turtle forwards the 'length' distance, turns 'angle' degrees, minus the length with 'step' and then continue next spiral.
// Parameters: 
//     turtle - the turtle vector [[x, y], angle].
//     length - the current length.
//     max_length - the maxmimu length when spinning out
//     min_length - the minmimu length when spinning in
//     text - the text to be spined.
module spin_characters(turtle, length, max_length, min_length, text, index = 0, spin_out = true) {
    angle = 12;
	step = 0.05;
	
    if(spin_out && index < len(text) && length < max_length) {
		draw_a_character(turtle, text[index], max_length, min_length, index);
		
        spin_characters(
		    turn(forward(turtle, length), angle), 
			length + step, 
			max_length, 
			min_length, 
			text, 
			index + 1 
		);
		
    } else if(index < len(text) && length >= min_length + step * 7) {
		draw_a_character(turtle, text[index], max_length, min_length, index);

        spin_characters(
		    turn(forward(turtle, length), angle), 
			length - step, 
			max_length, 
			min_length, 
			text, 
			index + 1, 
			false
		);
	}
}

module spiral_characters(diameter, text, symbol, fn) {
    $fn = fn;
    
    inner_diameter = 30;
	
	beginning_length = inner_diameter / 10;
	
	max_length = (diameter - 2) / 10;
	min_length = beginning_length;
	
	difference() {
		union() {
			intersection() {
				sphere(diameter / 2);
				union() {
					linear_extrude(diameter) 
						text(symbol, valign = "center", halign = "center", size = inner_diameter * 1.5 / 2, font = "Times New Roman:style=Bold");
						
					translate([0, -inner_diameter / 2, 0]) 
						spin_characters(
							turtle(0, 0, 0), 
							beginning_length, 
							max_length, 
							min_length,
							text
						);
				}
			}
			sphere((diameter - 2) / 2);
			translate([0, 0, -(diameter / 2)])
				linear_extrude(diameter / 2, scale = 1 / 1.5) 
					mirror([1, 0, 0]) 
					    text(symbol, valign = "center", halign = "center", size = inner_diameter * 1.5 / 2, font = "Times New Roman:style=Bold");
		}
		sphere((diameter - 2) / 2 - 2);
	}
}

spiral_characters(diameter, text, symbol, fn);


    
