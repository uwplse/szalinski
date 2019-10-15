//makes nicer circles:
$fa = 1;
$fs = 0.1;

cd = 9;
cl = 82;

rotate([90,0,90])
difference()
{
	translate([0,0,-2])
	cube([cd+2,cd+2,cl+2], true);

	translate([0,0,-cl/2])
	cylinder(cl, d = cd, true);
	
	translate([0,(cd+2)/2,-2])
	cube([1,cd+2,cl+2], true);
}

