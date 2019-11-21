/* [Basic] */
radius = 40;
height = 3;
thickness = 1;
width = 1;


/* [Advanced] */
min = 0.1;
k1 = 0.9;
k2 = 0.3;

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

module polyline(points, width = 1) {
    module polyline_inner(points, index) {
        if(index < len(points)) {
            line(points[index - 1], points[index], width);
            polyline_inner(points, index + 1);
        }
    }

    polyline_inner(points, 1);
}

module fern_leaf(turtle, leng, min, k1, k2, width = 1) {
    t1 = forward(turtle, leng);
    polyline([turtle[0], t1[0]], width);
    if(leng > min) {
        fern_leaf(turn(t1, 70), k2 * leng, min, k1, k2, width);
        t2 = forward(t1, k1 * leng);
        polyline([t1[0], t2[0]], width);
        t3 = turn(t2, -69.0);
        fern_leaf(t3, k1 * k2 * leng, min, k1, k2, width);
        fern_leaf(turn(t3, 68.0), k1 * k1 * leng, min, k1, k2, width);
    }
}

module fern_leaf_stencil(radius, height, thickness, width, min, k1, k2) {
    $fn = 48;

    linear_extrude(thickness) difference() {
        union() {
            difference() {
                translate([radius, 0, 0]) scale([1, 0.5, 1])
                    circle(radius / 1.5);
                translate([radius, 0, 0]) scale([1, 0.5, 1])
                    circle(radius / 2.5);
            }
            circle(radius);
        }
        translate([-radius, 0, 0]) 
            fern_leaf([[0, 0], 0], radius * 2 / 10, min, k1, k2, width);
    }

    linear_extrude(height) difference() {
        circle(radius + thickness);
        circle(radius);
    }
}

fern_leaf_stencil(radius, height, thickness, width, min, k1, k2);
