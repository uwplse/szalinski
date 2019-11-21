$fn = 50;

a = 120;
b = 25;
c = 5;
d = 30;
e = 12;
f = 36;
g = 8;
h = 9.22/2;
i = 4.75/2;

difference()
{
	color("grey") linear_extrude(height = b) union()
	{
		square(size = [a, c]);
		translate([e, c]) square(size = [g, d]);
		translate([e+g+f, c]) square(size = [g, d]);
		translate([e+g+f+g+f, c]) square(size = [g, d]);
	}

	color("green") translate([e/2, c/2, b/2]) rotate([-90, 0, 0]) union()
	{
		cylinder(r = h, h = c);
		translate([0,0,-c]) cylinder(r = i, h = c);
	}

	color("green") translate([a - e/2, c/2, b/2]) rotate([-90, 0, 0]) union()
	{
		cylinder(r = h, h = c);
		translate([0,0,-c]) cylinder(r = i, h = c);
	}
}