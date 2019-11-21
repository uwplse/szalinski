
diameter = 50; //case smaller ellips diameter
diam2=80; //case larger ellips diameter

weight = 25; // height in mm
groove = 5; // size of the inner piece in percent : %
cursor = 100; // [10:100]
// the gap between the inner and outer piece
margin = 0.1;
//  smoothing (0.5 to 2 is good values)
edges = 3; //edges thickness

cable=3; //cable diameter

	d = percent(cursor, diameter - 3);

resize([diam2,diameter,weight])
rotate([180,0,0])
	difference()
	{
		plug();

		if (d > 2)
		{
			translate([0, 0, -edges])
			plug(weight + (2 * edges), d);
		}
        
        translate([0,0,-cable/2])
        {
        cube([cable,diameter+weight,weight], center=true);
        cube([diameter+weight,cable,weight], center=true);
        }
        translate([0,0,weight/2-edges/2])
        {
        rotate([0,90,0])
        cylinder(h=diameter+weight,d=cable,center=true,$fn=60);
        rotate([90,0,0])
        cylinder(h=diameter+weight,d=cable,center=true,$fn=60);
        }
	}


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

	// Form Creation
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

function percent(x, y) = ((y) / 100) * x;

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