// Oogoo Ball Mould
//TrevM 22/11/2014

/* [Global] */

// What quality?
$fn = 110;	// [20,30,40,50,60,70,80,90,100]

// Ball Diameter (mm)?
dia = 110;

// Mould thickness (mm)?
th = 2;

// lip?
lip = 1;	// [0,1]

/* [Hidden] */

rad = dia / 2;			// radius of ball
dx = dia + (th * 2);	// diameter of mould (with thickness)
rx = dx / 2;			// radius of mould

half(lip);
//full();

module full()
{
	translate([-rx-(th*2),0,0]) half(0);
	translate([ rx+(th*2),0,0]) half(1);
}

module half(lip)
{
	br=rad*3/4;
	difference()
	{
		union()
		{
			translate([0,0,rx]) sphere(r=rx);	//outside mould
			cylinder(r=rad*3/4,h=rad);			//base
			if (lip == 1)
			{
				translate([0,0,rx-th]) cylinder(r=rx+th,h=th*2);	//lip
				translate([0,0,rx-(th*2)])	cylinder(r1=rx-(th/2),r2=rx+th,h=th+0.1); //lead in
			}
		}
		translate([0,0,rx]) sphere(r=rad);	//inside mould
		translate([0,0,rx]) cylinder(r=rx+0.3,h=rx+0.1);	// remove top
	}
}
