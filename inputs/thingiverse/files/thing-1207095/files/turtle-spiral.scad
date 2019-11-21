height = 5;
beginning_length = 100;
decreasing_step = 0.5;
angle = 89;
ending_length = 5;
line_width = 1;

//////////////
// 2D Drawing
//

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
module polyline(points, width = 1, index = 0) {
    if(index < len(points)) {
        if(index == 0) {
            polyline(points, width, index + 1);
        } else {
            line(points[index - 1], points[index], width);
            polyline(points, width, index + 1);
        }
    }
}

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
    
// Moves the turtle spirally. The turtle forwards the 'length' distance, turns 'angle' degrees, minus the length with 'step' and then continue next  spiral until the 'min_length' is reached. 
// Parameters: 
//     turtle - the turtle vector [[x, y], angle].
//     length - the beginning length.
//     decreasing_step - the next length will be minus with the decreasing_step.
//     angle - the turned degrees after forwarding.
//     ending_length - the minimum length of the spiral.
module spiral(turtle, length, decreasing_step, angle, ending_length = 10, line_width = 1) {
    if(length > ending_length) {
        turtle_after_forwarded = forward(turtle, length);
        line(turtle[0], turtle_after_forwarded[0], line_width);
        turtle_after_turned = turn(turtle_after_forwarded, angle);
        spiral(turtle_after_turned, length - decreasing_step, decreasing_step, angle, ending_length, line_width);
    }
}

linear_extrude(height) 
    spiral(turtle(0, 0, 0), beginning_length, decreasing_step, angle, ending_length, line_width);

    
