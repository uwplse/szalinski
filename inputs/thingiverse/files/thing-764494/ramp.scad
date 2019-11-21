// Parametric script for creating a printable ramp.

// The angle of the ramp.
theta = 30;

// How wide the ramp is.
width = 50;

// The minimum material thickness to use. The ramp will end up being a bit thicker at the points, but it will have this thickness on the walls.
thickness = 3.0;

// The length of the ramp.
ramp_length = 50;

// computed parameters
outer_triangle_height = sin(theta) * ramp_length;
outer_triangle_base = cos(theta) * ramp_length;
outer_triangle_hypot = ramp_length;

// even though the material width is x, you can't just add x all around if you want a smooth ramp lip
// the key is to realize that there's a right triangle you can draw that's similar to the main triangle
// and them from that you can draw another right triangle to fill in the space until the rectangular 
// wall begins
//
//    /|\   /
//   / | \ /
//  /  |  /
// / A | / A hollow interior

// the upper triangle has a leg of "wall thickness" and an angle of 180 - 90 - theta
// which lets us compute the upper triangle's hypotenuse
// sine(theta) = thickness/hypotenuse => hypotenuse = thickness/sine(theta)
upper_hypot = thickness/sin(90 - theta);

// upper_hypot is one leg of the bottom triangle. we can use tangent to find the base, which is the
// delta between the ramp lip and the interior
// tan(theta) = Opp/Adj => Adj = Opp/tan(theta)
lip_base = upper_hypot/tan(theta);

// for the upper corner, we have this
//     /|
//    / |
//   /  |
//  / /||
// / / ||

// can form a square of wall thickness on each side, but that leaves you a right triangle
// whose hypotenuse is the far wall of the ramp drop-off
// the inner tip of the triangle is thus offset that hypotenuse (vertical)
// and the the hypotenuse of the triangle formed by joining the top across to the side and using
// wall thickness as a leg

non_ramp_angle = 90 - theta; // because triangle is 180, and we know there's a 90 in lower right
y_offset_1 = thickness/sin(non_ramp_angle);

final_tip_angle = 180 - (90 + (90 - theta));
complementary_angle = 180 - final_tip_angle - 90;
y_offset_2 = thickness/tan(complementary_angle);


total_y_offset = y_offset_1 + y_offset_2;
x_offset = thickness/sin(complementary_angle);

// y offset = sine(90 - theta) = thickness/y_offset => thickness/sin(90-theta) = y_offset

inner_triangle_y_offset = thickness/sin(90 - theta);

// x_offset = cos(180 - 90 - theta
linear_extrude(height=width)
	polygon(points=[[0,0],
	  [outer_triangle_height,0],
	  [0,outer_triangle_base],
	  [0,outer_triangle_base - lip_base],
	  [outer_triangle_height - total_y_offset, thickness],
	  [0,thickness]]);
