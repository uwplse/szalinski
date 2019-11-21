module tore(smallr, bigr)
{
    rotate_extrude() translate([bigr, 0, 0]) circle(r=smallr);
}

module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module encoche()
{
	intersection()
	{
		difference()
		{
			cylinder(h=10, r=84.5);
			cylinder(h=10, r1=84.5, r2=79);
		}
		translate([-2, 78]) cube([4, 8, 10]);
	}
}

$fn=200;
scale([0.5, 0.5, 0.5]) union()
{
	difference()
	{
		cylinder(h=14, r=85);
		translate([0, 0, 2]) cylinder(h=35, r=83.5);
		for (a = [0:7])
			rotate([0, 0, 22.5+a*45]) translate([0, 78, 33]) rotate([-90, 0, 0]) cylinder(h=10, r=30);
	}
	for (a = [0:7])
		rotate([0, 0, a*45]) encoche();
}
