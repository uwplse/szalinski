// Oogoo Ball Mould
//TrevM 15/11/2014

/* [Global] */

// What quality?
$fn = 60;	// [20,30,40,50,60,70,80,90,100]

// Ball Diameter (mm)?
dia = 70;

// Mould thickness (mm)?
th = 2;

/* [Hidden] */

rad = dia / 2;			// radius of ball
dx = dia + (th * 2);	// diameter of mould (with thickness)
rx = dx / 2;			// radius of mould

half();
//full();

module full()
{
	translate([-rx - th,0,0]) half();
	translate([ rx + th,0,0]) half();
}

module half()
{
	difference()
	{
		union()
		{
			translate([0,0,rx + 0.1]) sphere(r = rx);
			cylinder(r = rad * 3 / 4,h = rad);
		}
		translate([0,0,rx + 0.1]) sphere(r = rad);
		translate([-rx,-rx,rx + 0.1]) cube([dx,dx,rx]);
	}
}
