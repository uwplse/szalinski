//
// Net for the Chestahedron, kites only.
// *** Alpha software 20140530 by bobnet
// Ugly but it works...
//

// size
size = 30;

module kite (radius)
{
	fifth = 360/5;			// angle
	phi = (1+sqrt(5))/2;	// the golden ratio
	innerRadius = (radius/phi)/phi;

   hull() {
	polygon (points = [
		[0,0],
		[cos(2.5*fifth)*innerRadius, sin(2.5*fifth)*innerRadius], 
		[cos(2*fifth)*radius, sin(2*fifth)*radius]
	], convexity = N);


	mirror([0,1,0])
	polygon (points = [
		[0,0],
		[cos(3*fifth)*radius, sin(3*fifth)*radius], 
		[cos(3.5*fifth)*innerRadius, sin(3.5*fifth)*innerRadius]
	], convexity = N);
   }
}

// 3 kite shapes

linear_extrude(height = 1, center = true, convexity = 10, twist = 0)
rotate (a=90, v=0,1,0) color("Turquoise") kite (size);
linear_extrude(height = 1, center = true, convexity = 10, twist = 0)
rotate (a=-360/5) color("Turquoise") kite(size);
linear_extrude(height = 1, center = true, convexity = 10, twist = 0)
rotate (a=-(360/5)*2) color("Turquoise") kite(size);

// one dot to join them!!!
linear_extrude(height = 1, center = true, convexity = 10, twist = 0)
circle (r = 0.01);