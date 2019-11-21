

// Electrum seeds are generally all lowercase
//text = "drink coffee feel good be happy brew more repeat often";

// but uppercase is more legible
text = "DRINK COFFEE FEEL GOOD BE HAPPY BREW MORE REPEAT OFTEN";

height = 4;
diameter = 70; 
symbol = "B";
spin = "IN"; // [OUT,IN]

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

module spiral_characters(symbol, text, outer_diameter, height) {
    inner_diameter = 30;
	step = 0.05;
	angle = 12;
	
	beginning_length = inner_diameter / 10;
	
	outer_length = outer_diameter / 10;
	inner_length = beginning_length;

    // bottom
    difference() {
        
        linear_extrude(height) 
            circle(outer_diameter / 2 + 3);
    
        translate([0,0,3]) {
            linear_extrude(height / 2) 
                circle(outer_diameter / 2 + 1);
        }
        
    }
	
	linear_extrude(height) union() {
		text(symbol, valign = "center", halign = "center", size = inner_diameter * 1.3 / 2, font = "Times New Roman:style=Bold");
        text("||", valign = "center", halign = "center", size = inner_diameter * 1.3 / 2, font = "Times New Roman:style=Bold");
		
		if(spin == "OUT") {
			translate([0, inner_diameter / 2, 0])  
				spin_out_characters(turtle(0, 0, 0), inner_length, step, angle, outer_length, text);
		} else {	
			rotate(180) translate([0, -inner_diameter / 2, 0]) 
				spin_in_characters(turtle(0, 0, 0), inner_length, step, angle, outer_length, text, 180);			
		}
	}		
}

spiral_characters(symbol, text, diameter, height);
    
