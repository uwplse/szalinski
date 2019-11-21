// Length of Box (X-Axis)
Length=195;		// [20:500]

// Width of Box (Y-Axis)
Width=120;		// [20:500]

// Height of Box (Z-Axis)
Height=50;		// [15:500]

// Wall Thickness
Wall=2;			// [0.5:0.1:5]


difference()
{
	union()
	{
		cube([Length, Width, Height - 5 - 2]);
		translate([0, 0, Height - 5 - 2]) hull()
		{
			translate([0, 0, -1]) cube([Length, Width, 1]);
			translate([-Wall, -Wall, 2]) cube([Length + Wall * 2, Width + Wall * 2, 5]);
		}
		translate([0, 0, Height]) cube([Length, Width, 2]);
	}
	
	translate([Wall, Wall, Wall]) cube([Length - Wall * 2, Width - Wall * 2, Height + Wall]);
	
	translate([-0.4, -0.4, Height - 5 + 0.1]) cube([Length + 0.8, Width + 0.8, 7]);
}
