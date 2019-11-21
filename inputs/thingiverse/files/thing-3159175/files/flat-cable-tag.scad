
string = "Text";
tag_length = 20;			// [10:1:100]
part = "both"; 				// [both:Both,base:Base,text:Text]


/* [Extra] */

base_thickness = 1;			// [0.1:0.1:2]
text_thickness = 0.2;		// [0.1:0.1:2]
height = 7;					// [5:1:30]
diameter = 10;				// [5:1:30]


/* [Hidden] */

$fn = 32;
e = 0.01;

ringTh = 2 * base_thickness;



module tag(string, len)
{
    if (part == "base" || part == "both") union()
    {
        translate([-diameter/2 - ringTh, 0, 0]) difference()
        {
            hull()
            {
                for (y = [-diameter/2 , diameter/2])
                    translate([0, y, 0]) cylinder(base_thickness, d = diameter + 2*ringTh);
            }
            
            hull()
            {
                for (y = [-diameter/2 , diameter/2])
                    translate([0, y, -e]) cylinder(base_thickness + 2*e, d = diameter);
            }
        }

        translate([-e, -height/2, 0]) cube([len+diameter, height, base_thickness]);
    }

	if (part == "text" || part == "both")
	{
		color("black") translate([diameter, -height * 0.4, base_thickness]) linear_extrude(height = text_thickness) 
			text(string, font="Liberation Sans:style=Bold", size = height * 0.8);
	}
}


// One tag.

tag(string, tag_length);


// Full set of tags.

*union()
{
	for (x = [0, 50])
	{
		translate([x, 0, 0]) tag("DP1", 16);
		translate([x, 25, 0])tag("DP2", 16);
		translate([x, 50, 0])tag("HDMI1", 25);
		translate([x, 75, 0])tag("HDMI2", 25);
		translate([x, 100, 0])tag("HDMI3", 25);
		translate([x, 125, 0])tag("HDMI4", 25);
	}

	translate([100, 0, 0]) tag("PC1", 16);
	translate([100, 25, 0]) tag("PC2", 16);
	translate([100, 50, 0]) tag("PC3", 16);

	translate([0, 150, 0]) tag("Monitor 1", 35);
	translate([0, 175, 0]) tag("Monitor 2", 35);
	translate([60, 150, 0]) tag("Monitor 3", 35);
	translate([60, 175, 0]) tag("Monitor 4", 35);

	translate([100, 75, 0]) tag("Xbox S", 27);
	translate([100, 100, 0]) tag("Xbox X", 27);
	translate([100, 125, 0]) tag("Xbox S", 27);
	translate([120, 150, 0]) tag("Xbox X", 27);
}
