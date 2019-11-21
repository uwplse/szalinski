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

module hive(s)
{
	cylinder(h=4.11, r1=2.1*s, r2=1.4, $fn=6);
}

function f(x, y) =
	let(r=sqrt(x*x+y*y))
	-pow(r/43, 10);

xscale=1.2;
yscale=xscale;
hscale=0.8;
difference()
{
	cylinder(h=8, r=83/2, $fn=200);
	intersection()
	{
		translate([0, 0, -0.1]) cylinder(h=8.2, r=81/2, $fn=200);
		union()
		{
			for (x = [-8:8])
				for (y = [-10:10])
				{
					translate([x*5*1.4142, y*4, -0.1]) hive(1);
					translate([(x+0.5)*5*1.4142, y*4+2, -0.1]) hive(1);
					translate([0, 0, 8]) rotate([0, 180, 0])
					{
//						translate([x*5*1.4142, y*4, -0.1]) scale([xscale+f(x*5*1.4142, y*4), yscale+f(x*5*1.4142, y*4), hscale+f(x*5*1.4142, y*4)]) hive();
//						translate([(x+0.5)*5*1.4142, y*4+2, -0.1]) scale([xscale+f((x+0.5)*5*1.4142, y*4+2), yscale+f((x+0.5)*5*1.4142, y*4+2), hscale+f((x+0.5)*5*1.4142, y*4+2)]) hive();
						translate([x*5*1.4142, y*4, -0.1]) hive(1.3+f(x*5*1.4142, y*4));
						translate([(x+0.5)*5*1.4142, y*4+2, -0.1]) hive(1.3+f((x+0.5)*5*1.4142, y*4+2));
					}
				}
		}
	}
}
