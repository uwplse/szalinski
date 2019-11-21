
cable_diameter = 6;		// [1:0.5:20]
height = 7;				// [5:1:30]
string = "Text";
tag_width = 20;			// [10:1:50]


/* [Extra] */

thickness = 1.8;			// [0.5:0.1:3]
gap_ratio = 0.85;		// [0.5:0.025:0.95]
hook_length = 3;		// [0:1:10]
text_height_ratio = 0.8;// [0.5:0.1:1]


/* [Hidden] */

$fn = 32;
e = 0.01;


difference()
{
	diam = cable_diameter + thickness;
	minkowski()
	{
		linear_extrude(height=e)
		{
			union()
			{
				difference()
				{
					circle(d=diam);
					circle(d=diam-e);
					translate([0, -diam/2+e]) square([diam/2+e, diam * gap_ratio]);
				}
				translate([0, -diam/2]) square([tag_width, e]);
				hookY = (gap_ratio-0.5)*2;
				hookX = sqrt(1-hookY*hookY);
				polygon(points = [diam/2 * [hookX, hookY], (diam/2 + hook_length) * [hookX, hookY], diam/2 * [hookX, hookY+e]]);
				
			}
		}
		
		cylinder(height, d=thickness);
	}	

	translate([0, -diam/2, height * (1-text_height_ratio)/2]) rotate([90, 0, 0]) linear_extrude(height = thickness) text(string, font="Liberation Sans:style=Bold", size = height * text_height_ratio);
}
