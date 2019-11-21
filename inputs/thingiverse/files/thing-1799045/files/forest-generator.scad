style = "MIRROR"; // [TABLE_DECORATION, TREES, INVERTED, MIRROR]
trunk_angle = 86; // [1:90]
max_trunk_length = 400;
min_trunk_length = 2;
width = 1.5;
thickness = 1.5;
spacing = 0.5;
k1 = 1.5;
k2 = 1.0;

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

function warp(turtle, length) = set_point(turtle[0][0] + length * cos(turtle[1]), turtle[0][1] + length * sin(turtle[1]));

// Draws a line between the points.
//
// Parameters: 
//     point1 - the start point [x1, y1] of the line.
//     point2 - the end point [x2, y2] of the line.
//     width  - the line width.
//     cap_round - ends the line with round decorations that has a radius equal to half of the width of the line.
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

// Creates a polyline, defined by the vector of the segment points. 
//
// Parameters: 
//     points - the coordinates of the polyline segments.
//     width  - the line width.
module polyline(points, width = 1) {
	module polyline_inner(points, width, index) {
		if(index < len(points)) {
			line(points[index - 1], points[index], width);
			polyline_inner(points, width, index + 1);
		}
	}
	
	polyline_inner(points, width, 1);
}


// Style: TREES, INVERTED, MIRROR
module forest(trunk_angle, max_trunk_length, min_trunk_length, style = "TREES", k1 = 1.5, k2 = 1.0, width = 1) {
	k = 1.0 / (k1 + 2 *  k2 + 2 * (k1 +  k2) * cos(trunk_angle));
	
	module trunk(t, length) {
        if (length > min_trunk_length) {
		    // baseline
			if(style != "INVERTED") {
			    line(t[0], forward(t, length)[0], width);
			} else {
			    inverted_trunk(t, length);
			}
			
			if(style == "MIRROR") {
				 mirror([0, 1, 0]) inverted_trunk(t, length);
			} 
			
			trunk(t, k * k1 * length);
			
			// left side of "k * k1 * length" trunks
			t1 = turn(
			    forward(t, k * k1 * length),
				trunk_angle
			);			
			trunk(t1, k * k1 * length);
			
			// right side of "k * k1 * length" trunks
			t2 = turn(
			    forward(t1, k * k1 * length), 
				-2 * trunk_angle
			);
			trunk(t2, k * k1 * length);
			
			// "k * length" trunks
			t3 = turn(
			    forward(t2, k * k1 * length), 
				trunk_angle
			);
			trunk(t3, k * length);
			
			// left side of "k *  k2 * length" trunks
			t4 = turn(
			    forward(t3, k * length), trunk_angle
			);
			trunk(t4, k *  k2 * length);
			
			// right side of "k *  k2 * length" trunks
			t5 = turn(
			    forward(t4, k *  k2 * length), -2 * trunk_angle
		    );
			trunk(t5, k *  k2 * length);
		
		    // "k *  k2 * length" trunks
			trunk(
			    turn(
				    forward(t5, k *  k2 * length), 
					trunk_angle
				), 
				k *  k2 * length
			);
        }
	}
	 
	module inverted_trunk(t, length) {
	    
		if(k * k1 * length > min_trunk_length) {
			t1 = forward(t, k * k1 * length);
			t2 = forward(turn(t1, trunk_angle), k * k1 * length);
			t3 = forward(turn(t2, -2 * trunk_angle), k * k1 * length);
			offset(r = width * 0.25) polygon([t1[0], t2[0], t3[0]]);
			
			if(k * length > min_trunk_length && k * k2 * length > min_trunk_length) {
				t4 = forward(turn(t3, trunk_angle), k * length);				
				t5 = forward(turn(t4, trunk_angle), k * k2 * length);
				t6 = forward(turn(t5, -2 * trunk_angle), k * k2 * length);
				offset(r = width * 0.25) polygon([t4[0], t5[0], t6[0]]);
		        
			}
		}
	}
	
    trunk(turtle(0, 0, 0), max_trunk_length);
	
	if(style == "INVERTED") {
	    line([0, 0], [max_trunk_length, 0], width);
	}
}

if(style == "TABLE_DECORATION") {
	linear_extrude(thickness) 
		forest(trunk_angle, max_trunk_length, min_trunk_length, "TREES", k1, k2, width);

	translate([0, -5, 0]) union() {
		linear_extrude(width * 2) mirror([0, 1, 0]) {		
			translate([0, thickness * 1.25, 0]) forest(
				trunk_angle, max_trunk_length, 
				min_trunk_length, "INVERTED", k1, k2, width
			);
		} 
		
		difference() {
			linear_extrude(width * 2) 
				line([0, 0], [max_trunk_length, 0], thickness * 2.5);
				
			translate([max_trunk_length / 2, 0, width]) 
				linear_extrude(width)
					square([max_trunk_length + width + spacing, thickness + spacing], center = true);
			
		}
	}
} else {
	linear_extrude(thickness) 
		forest(trunk_angle, max_trunk_length, min_trunk_length, style, k1, k2, width);
}