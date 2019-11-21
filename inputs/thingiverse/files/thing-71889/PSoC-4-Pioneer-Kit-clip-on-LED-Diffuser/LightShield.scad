$fn = 50;

a = 2.6;
b = 2;
c = 2;
d = 4.5;
e = 2;
f = b;
g = 4;
h = 2;
i = e;
j = 6.5;
k = 5.2;

linear_extrude(height = k) union()
{
	square([h, j+i]);
	square([h+g+f, i]);
	translate([h+g,0]) square([f, e+d+c]);
	//color("red") translate([h+g-a, e+d]) polygon(points = [[0,0], [a,0], [a,c]], path = [0,1,2]);
	color("red") translate([h+g-a, e+d]) square([a, c]);
}