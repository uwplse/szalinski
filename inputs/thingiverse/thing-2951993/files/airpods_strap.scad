length = 370;		// [200:10:500]
thickness = 0.9;	// [0.4:0.05:3]


/* [Hidden] */

$fa=2;
$fs=0.5;
e = 0.01;

h = 3;
th = thickness;
d = 6.2;
step = 1;	

a = 90;
b = length * 2/PI - a;	// Raw estimation.

difference()
{
	union()
	{
		for (x = [-a, a])
			translate([x, 0, 0]) cylinder(h, d=d+2*th);

		for (ang = [-90:step:90-step])
		{
			hull()
			{
				translate([sin(ang) * a, cos(ang) * b, 0]) cylinder(th, d=th);
				translate([sin(ang+step) * a, cos(ang+step) * b, 0]) cylinder(th, d=th);
			}
		}
	}

	for (x = [-a, a])
		translate([x, 0, -e]) cylinder(h+2*e, d=d);
}
	
	
	

