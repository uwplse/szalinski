$fn = 50;

r1 = 8/2; // big mounting holes
r2 = 3.4/2; // PCB mounting hols
a = 85; // distance between large mounting holes (centers)
b = 100; // lift arm of the bracket, sets the angle of the bracket
d = 56; // distance between PCB mounting holes (centers)
c = d+20; // extra size for the PCB mount part of the bracket

tab_size = 10;  // square tab size

thickness = 3.2; // thickness of the bracket and tabs
sc = 0.8; // center removal scale factor
mink = 1.5; // r1*mink(owski) produces the rounded edges and the hole material

translate([0,0,thickness]) rotate([180,0,0]) union()
{
	linear_extrude(height = thickness) difference()
	{
		minkowski()
		{
			polygon(points = [[0,0], [a,0], [b*cos(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b))), b*sin(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b)))]], paths = [[0,1,2,0]]);
			circle(r = mink*r1);
		}

		circle(r = r1);
		translate([a,0]) circle(r = r1);
		
		translate([a/2-(a/2)*sc,b*sin(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b)))/2-(b*sin(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b)))/2)*sc]) scale(v = [sc,sc]) minkowski()
		{
			polygon(points = [[0,0], [a,0], [b*cos(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b))), b*sin(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b)))]], paths = [[0,1,2,0]]);
			circle(r = mink*r1);
		}
	}

	//translate([tab_size/2+mink*r1, tab_size/2+mink*r1,0])
	translate([b*cos(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b))), b*sin(acos((pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b)))]) rotate([0,0,-acos((pow(a,2)+pow(c,2)-pow(b,2))/(2*a*c))]) translate([tab_size/2, mink*r1-thickness, -tab_size/2]) rotate([90,0,0]) union()
	{
		translate([0,thickness,-thickness]) linear_extrude(height = thickness) difference()
		{
			square([tab_size, tab_size], center = true);
			translate([0,-tab_size/2+r2*mink]) circle(r = r2);
		}

		translate([0,thickness,-thickness]) translate([d,0]) linear_extrude(height = thickness) difference()
		{
			square([tab_size, tab_size], center = true);
			translate([0,-tab_size/2+r2*mink]) circle(r = r2);
		}
	}
}