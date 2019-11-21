side=180.5;
corner=10;
pegd=1;
thick=2;
side2=side+thick;
corner2=corner+thick;
height=9;
hh=1.1;
$fn=100;

intersection()
{
	union()
	{
		difference()
		{
			union()
			{
				difference()
				{
					cube([side2, side2, height]);
					cube([corner2, corner2, height]);
					translate([side2-corner2, 0, 0]) cube([corner2, corner2, height]);
					translate([side2-corner2, side2-corner2, 0]) cube([corner2, corner2, height]);
					translate([0, side2-corner2, 0]) cube([corner2, corner2, height]);
				}
				translate([corner2, corner2, 0]) cylinder(r=corner2, h=height);
				translate([side2-corner2, corner2, 0]) cylinder(r=corner2, h=height);
				translate([side2-corner2, side2-corner2, 0]) cylinder(r=corner2, h=height);
				translate([corner2, side2-corner2, 0]) cylinder(r=corner2, h=height);
			}
			translate([thick/2, thick/2, hh]) union()
			{
				difference()
				{
					cube([side, side, height]);
					cube([corner, corner, height]);
					translate([side-corner, 0, 0]) cube([corner, corner, height]);
					translate([side-corner, side-corner, 0]) cube([corner, corner, height]);
					translate([0, side-corner, 0]) cube([corner, corner, height]);
				}
				translate([corner, corner, 0]) cylinder(r=corner, h=height);
				translate([side-corner, corner, 0]) cylinder(r=corner, h=height);
				translate([side-corner, side-corner, 0]) cylinder(r=corner, h=height);
				translate([corner, side-corner, 0]) cylinder(r=corner, h=height);
			}
		}

		translate([thick/2, thick/2, 0])
		{
			translate([side/2-5, 0, hh+6]) rotate([0, 90, 0]) cylinder(h=10, r=pegd);
			translate([side/2-5, side, hh+6]) rotate([0, 90, 0]) cylinder(h=10, r=pegd);
			translate([0, side/2-5, hh+6]) rotate([-90, 0, 0]) cylinder(h=10, r=pegd);
			translate([side, side/2-5, hh+6]) rotate([-90, 0, 0]) cylinder(h=10, r=pegd);
		}
	}
	cube([side2, side2, height]);
}
