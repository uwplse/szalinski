radius = 25;
height = 30;
line_width = 1.25;
thickness = 2;
fn = 24;
 
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

///////////////////
// Turtle Spirally
//

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


////////////////////////////////
// Symmetrical virtual triangle

// Use the given points, draw a ployline. Repeat the previous step after rotate 120 and 240 degrees.
// Parameters: 
//     points - the coordinates of the polyline segments.
//     line_width  - the line width.
module virtual_triangle(points, line_width = 1) {
    polyline(points, line_width);
    rotate([0, 0, 120]) polyline(points, line_width);
    rotate([0, 0, 240]) polyline(points, line_width);
}

// Draw a symmetrical virtual triangle. 
// Parameters: 
//     points - the coordinates of the polyline segments of a single virtual_triangle.
//     length - the length of a triangle side.
//     x_tris - the numbers of triangles in the x directions
//     y_tris - the numbers of triangles in the y directions
//     line_width  - the line width.
module symmetrical_virtual_triangle(points, length, x_tris, y_tris, line_width = 1) {
    height = length * sqrt(3) / 2;
    x_numbers = x_tris % 2 == 0 ? x_tris + 1 : x_tris;
    y_numbers = y_tris - 1; //(y_tris % 2 == 0 ? y_tris + 1 : y_tris) - 1;
    for(y_factor = [0 : y_numbers]) {
        for(x_factor = [0 : x_numbers]) {
            x_offset = length / 2 * x_factor + (y_factor % 2) * length / 2;
            y_offset = height * y_factor;
            
            if(x_factor % 2 == 0) {
                if(x_factor != 0 || y_factor % 2 != 0) {
                    translate([x_offset, y_offset, 0]) 
                        virtual_triangle(points, line_width); 
                } 
            } else {
                if(x_factor != x_numbers || y_factor % 2 == 0) {
                    translate([x_offset, height / 3 + y_offset, 0])   
                    mirror([0, 1, 0]) 
                        virtual_triangle(points, line_width);
                } 
            }
        }
    }
}

/* Examples
points1 = [
    [17.5, -10], 
    [9.5, -10],
    [5, -2.5],
    [1.5, -2.5],
    [0, 0],
    [-1.5, -2.5],
    [-5, -2.5],
    [-9.5, -10],
    [-17.5, -10]
];

linear_extrude(2) symmetrical_virtual_triangle(points1, 35, 10, 4, 1);

points2 = [
    [10, -6], 
    [-6.5, -6],
    [-3, 0],
    [0, 0]
];

linear_extrude(2) translate([225, 0, 0]) symmetrical_virtual_triangle(points2, 20, 10, 4, 0.5);

points3 = [
    [0, 0], 
    [1.5, 2.5], 
    [1.5, -6],
    [-4, -6],
    [-6.5, 0]
];

linear_extrude(2) translate([0, 200, 0]) symmetrical_virtual_triangle(points3, 20, 10, 4, 0.5);
*/

//////////////
// String API
//

// Returns a new string that is a substring of this string. The substring begins at the specified `begin` and extends to the character at index `end` - 1. Thus the length of the substring is `end` - `begin`.
// Parameters: 
//     begin - the beginning index, inclusive.
//     end - the ending index, exclusive.
// Returns:
//     The resulting string.
function sub_string(string, begin, end, result = "") =
    end == undef ? sub_string(string, begin, len(string)) : (
        begin == end ? result : sub_string(string, begin + 1, end, str(result, string[begin]))
    );


// Splits this string around matches of the given delimiting character.
// Parameters: 
//     string - the source string.
//     delimiter - the delimiting character.    
function split(string, delimiter) = 
        len(search(delimiter, string)) == 0 ? [string] : split_string_by(search(delimiter, string, 0)[0], string);
        
function split_string_by(indexes, string, strings = [], i = -1) = 
    i == -1 ? split_string_by(indexes, string, [sub_string(string, 0, indexes[0])], i + 1) : (
        i == len(indexes) - 1 ? concat(strings, sub_string(string, indexes[i] + 1)) : 
                split_string_by(indexes, string, concat(strings, sub_string(string, indexes[i] + 1, indexes[i + 1])), i + 1)
    );        

// Parse string to number
// Parameters: 
//     string - the source string.
// Results:
//     The resulting number.
function parse_number(string) = string[0] == "-" ? -parse_positive_number(sub_string(string, 1, len(string))) : parse_positive_number(string);
    
function str_num_to_int(num_str, index = 0, mapper = [["0", 0], ["1", 1], ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9]]) =  
    index == len(mapper) ? -1 : (
        mapper[index][0] == num_str ? mapper[index][1] : str_num_to_int(num_str, index + 1)
    );
    
function parse_positive_int(string, value = 0, index = 0) =
    index == len(string) ? value : parse_positive_int(string, value * pow(10, index) + str_num_to_int(string[index]), index + 1);

function parse_positive_decimal(string, value = 0, index = 0) =
    index == len(string) ? value : parse_positive_decimal(string, value + str_num_to_int(string[index]) * pow(10, -(index + 1)), index + 1);
    
function parse_positive_number(string) =
    len(search(".", string)) == 0 ? parse_positive_int(string) :
        parse_positive_int(split(string, ".")[0]) + parse_positive_decimal(split(string, ".")[1]);

// for MakerBot Customizer
function strs_to_points(xs, ys, points = [], index = 0) = 
    index == len(xs) ? points : strs_to_points(xs, ys, concat(points, [[parse_number(xs[index]), parse_number(ys[index])]]), index + 1);

// ==

// Create a triangle which is 1/fn of a circle. 
// Parameters:
//     r  - the circle radius 
//     fn - the same meaning as the $fn of OpenSCAD
module one_over_fn_for_circle(r, fn) {
    a = 360 / fn;
	x = r * cos(a / 2);
	y = r * sin(a / 2);
	polygon(points=[[0, 0], [x, y],[x, -y]]);
}

// Transform a model inito a cylinder.
// Parameters:
//     length - the model's length 
//     width  - the model's width
//     square_thickness - the model's thickness
//     fn - the same meaning as the $fn of OpenSCAD
module square_to_cylinder(length, width, square_thickness, fn) {
    r = length / 6.28318;
    a = 360 / fn;
	y = r * sin(a / 2);
	for(i = [0 : fn - 1]) {
	    rotate(a * i) translate([0, -(2 * y * i + y), 0]) intersection() {
		    translate([0, 2 * y * i + y, 0]) 
		        linear_extrude(width) 
				    one_over_fn_for_circle(r, fn);
			translate([r - square_thickness, 0, width]) 
	            rotate([0, 90, 0]) 
	                children(0);
		}
	}
}

module zentangle(width, length, line_width, thickness) {
	xs = "-8.75.5 -4.75 -2.5 -0.75 0 0.75 2.5 4.75 8.75"; 
	ys = "-5 -5 -1.5 -2.5 0 -2.5 -1.5 -5 -5"; 
	triangle_side_length = 17.5; 
	x_triangles = 0.2 * width;
	y_triangles = 0.075 * length; 
	
	linear_extrude(thickness) union() {
		intersection() {
			square([width, length]);
			translate([-triangle_side_length / 2.75, 0, 0]) symmetrical_virtual_triangle(strs_to_points(split(xs, " "), split(ys, " ")), triangle_side_length, x_triangles, y_triangles, line_width);
		}

		difference() {
			square([width, length]);
			offset(delta = -line_width * 2) square([width, length]);
		}
	}
}

module zentangle_bracelet(radius, height, line_width, thickness, fn) {
    length = 6.28318 * radius;
	width  = height;
	square_to_cylinder(length + line_width * 2,  width, 2, fn)  
		zentangle(width, length, line_width, thickness);
}

zentangle_bracelet(radius, height, line_width, thickness, fn);

// zentangle(height, 6.28318 * radius, line_width, thickness);
