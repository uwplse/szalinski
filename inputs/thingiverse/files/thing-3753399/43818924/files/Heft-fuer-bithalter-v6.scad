/*


*/


/* Modules */
include <../Modules/Module_Geometrical_Objects.scad>;

/* Globals */
$fn=50;
h1=15;
h2=50;
d2=20;
h3=10;

//!translate([d2/2, 0, 0])
//rotate([90, 0, 0])
//!rotate_extrude(angle = 360, convexity = 12)
//circle(d=3.0);
//cylinder(d=3.0, h=1);

/* Aufnahme für Bits oder Bithalter */
if (1)
difference()
{
//	cylinder(d1=30, d2=23, h=h1);
	cylinder(d1=14, d2=14, h=h1);
#	hexHub(6.3+0.5, h1);
}

/* Anschlussstück */
if (1)
translate([0, 0, -h3])
cylinder(d1=d2, d2=14, h=h3);


/* Heft */
if (1)
{
	translate([0, 0, -h2-h3])
	difference()
	{
		//hexHub(30, h2);
		cylinder(d=d2, h=h2);
		
		for (i=[0:30:360])
		{
			rotate([0, 0, i])
			translate([d2/2+1.5, 0, 0])
			cylinder(d=5, h=h2+23);
		}
	}
	/* Botenplatte */
	translate([0, 0, -h2-h3])
	rotate_extrude(convexity = 10)
	translate([d2/2-3, 0, 0])
	circle(r = 3, $fn = 100);
}

