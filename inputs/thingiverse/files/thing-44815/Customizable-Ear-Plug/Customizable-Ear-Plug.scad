 /* ----------------------------------------------------------------------------
	Public Variables
---------------------------------------------------------------------------- */
type = 0; // [0:Solid,1:Hollowed,2:Star,3:Heart]
// or ear hole in mm
diameter = 20;
// or height in mm
weight = 11;
// (baby) in mm
groove = 1; 
// or the size of the inner piece in percent : %
cursor = 100; // [10:100]
// or the gap between the inner and outer piece
margin = 0.1;
//  smoothing (0.5 to 2 is good values)
edges = 1;


/* ----------------------------------------------------------------------------
	Plugs Creation
---------------------------------------------------------------------------- */
if (type == 1)
{
	hollowed_plug();
}
else if (type == 2)
{
	star_plug();
}
else if (type == 3)
{
	heart_plug();
}
else
{
	plug();
}


/* ----------------------------------------------------------------------------
	Heart Plug Module
---------------------------------------------------------------------------- */
module heart_plug()
{
	d = percent(cursor, diameter / 1.414);
	half_d = d / 2;
	y = ((half_d * 1.414) - half_d) / 3;
	
	difference()
	{
		plug();
		translate([0, -y, -0.01])	
		heart(d, weight + 0.02);
	}
	
	translate([diameter + 3, -y, 0])
	heart(d - margin, weight);
}


/* ----------------------------------------------------------------------------
	Star Plug Module
---------------------------------------------------------------------------- */
module star_plug()
{
	d = percent(cursor, (diameter / 2) - 1.5);
	half_d = d / 2;
	
	difference()
	{
		plug();
		translate([0, 0, -0.01])	
		parametric_star(5, weight + 0.02, half_d, d);
	}
	
	translate([diameter + 3, 0, 0])
	parametric_star(5, weight, half_d - margin, d - margin);
}


/* ----------------------------------------------------------------------------
	Hollowed Plug Module
---------------------------------------------------------------------------- */
module hollowed_plug()
{
	d = percent(cursor, diameter - 3);

	difference()
	{
		plug();

		if (d > 2)
		{
			translate([0, 0, -edges])
			plug(weight + (2 * edges), d);
		}
	}
}


/* ----------------------------------------------------------------------------
	Filled Plug Module
---------------------------------------------------------------------------- */
module plug(w = weight, d = diameter, g = groove, e = edges)
{
	// External Radius
	r = (d / 2) + g;

	// Curves Points
	p1 = [-e, 0];
	p2 = [0, e];
	p3 = [0, w - e];
	p4 = [-e, w];
	
	// Curves Cursors
	c1 = [0, 0];
	c2 = [-g * 2, w / 2];
	c3 = [0, w];	

	// Plug Creation
	rotate_extrude($fn = 180)
	translate([r, 0, 0])
	union()
	{
		Curve(p1, p2, c1, 10, true);
		Curve(p2, p3, c2, 40, false);
		Curve(p3, p4, c3, 10, true);
		polygon(points=[p1, p2, c2, p3, p4, [-r, w], [-r, 0]]);
	}
}


/* ----------------------------------------------------------------------------
	Heart Module By Skarab, 2013
---------------------------------------------------------------------------- */
module heart(s = 10, h = 10) 
{
	// Sizes
	hs= s / 2;
	qs= s / 4;

	// Circles
	
	// Curves Points
	p1 = [-hs, 0];
	p2 = [0, -3 * qs];
	p3 = [hs, 0];
	p4 = [(qs * cos(30)) - qs, qs * sin(30)];
	p5 = [(qs * cos(150)) + qs, qs * sin(150)];
	
	// Curves Cursors
	c1 = [-hs, -qs];
	c2 = [hs, -qs];
	c3 = [0, qs * sin(150) / 2];

	translate([0, qs, 0])
	linear_extrude(height = h) 
	union() 
	{
		
		translate([-qs, 0, 0]) circle(qs, $fn = 50);
		translate([qs, 0, 0]) circle(qs, $fn = 50);
		Curve(p1, p2, c1, 20, true);
		Curve(p2, p3, c2, 20, true);
		Curve(p4, p5, c3, 20, false);
		polygon(points=[p1, p2, p3]);
		polygon(points=[p4, c3, [0, 0]]);
		polygon(points=[p5, c3, [0, 0]]);
	}
}


/* ----------------------------------------------------------------------------
	Return X percent From Y
---------------------------------------------------------------------------- */
function percent(x, y) = ((y) / 100) * x;


/* ----------------------------------------------------------------------------
	Parametric star
	(c)  2010 Juan Gonzalez-Gomez (Obijuan) juan@iearobotics.com
	GPL license

	http://www.thingiverse.com/thing:5052

	The 2*N points of an N-ponted star are calculated as follows:
	There are two circunferences:  the inner and outer.  Outer points are located
	at angles: 0, 360/N, 360*2/N and on the outer circunference
	The inner points have the same angular distance but they are 360/(2*N) rotated
	respect to the outers. They are located on the inner circunference

	INPUT PARAMETERS:
	N: Number of points
	h: Height
	ri: Inner radius
	ro: outer radius
---------------------------------------------------------------------------- */
module parametric_star(N = 5, h = 3, ri = 15, re = 30)
{
	// Calculate and draw a 2D tip of the star
	// n: Number of the tip (from 0 to N-1)
  	module tipstar(n) 
	{
     		i1 =  [ri*cos(-360*n/N+360/(N*2)), ri*sin(-360*n/N+360/(N*2))];
	    	e1 = [re*cos(-360*n/N), re*sin(-360*n/N)];
	    	i2 = [ri*cos(-360*(n+1)/N+360/(N*2)), ri*sin(-360*(n+1)/N+360/(N*2))];
	    	polygon([ i1, e1, i2]);
  	}

	// Draw the 2D star and extrude
	// The star is the union of N 2D tips. 
	// A inner cylinder is also needed for filling
	// A flat (2D) star is built. The it is extruded
    	linear_extrude(height = h) union() 
	{
      	for (i=[0:N-1]) 
		{
         		tipstar(i);
      	}
      	rotate([0,0,360/(2*N)]) circle(r=ri+ri*0.01,$fn=N);
    	}
}


/* ----------------------------------------------------------------------------
	Curve Module By Skarab, 2013
	Original script By Don B, 2011
	Released into the Public Domain
	http://www.thingiverse.com/thing:8931 
---------------------------------------------------------------------------- */
module Curve(p1, p2, cursor, steps = 5, filled = true) 
{
	stepsize1 = (cursor - p1) / steps;
	stepsize2 = (p2 - cursor) / steps;

	for (i = [0:steps - 1])
	{
		assign(point1 = p1 + stepsize1 * i) 
		assign(point2 = cursor + stepsize2 * i) 
		assign(point3 = p1 + stepsize1 * (i + 1))
		assign(point4 = cursor + stepsize2 * (i + 1))  
		{
			assign(bpoint1 = point1 + (point2 - point1) * (i / steps))
			assign(bpoint2 = point3 + (point4 - point3) * ((i + 1) / steps)) 
			{
				polygon(points=[bpoint1, bpoint2, filled ? p1 : cursor]);
			}
		}
	}
}