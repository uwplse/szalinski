//Diameter of vial
tool_diameter = 20.5; // Container Store 4 dram glass vial SKU#: 688480
tool_rad = tool_diameter / 2;
//Base is this many times larger than radius of vial
base_multiplier = 2.75;
//Height of base (bottom disk)
base_height = 4;
//Height of conical cap
cap_height = 12;
//Cap base is this many times larger than radius of vial
cap_base_multiplier = 2;
//Width of the wall at top of cap
cap_top_wall_width = 3;
//Added space to adjust for a tighter or looser fit
tool_space_margin = 0.6;

//$fn=60;
difference()
{
	union()
	{
		//Base
		cylinder(r=tool_rad*base_multiplier, h=base_height);

		//Cap
        translate([0,0,base_height])
		cylinder(h=cap_height,
            r1=tool_rad*cap_base_multiplier,
            r2=tool_rad+cap_top_wall_width);
	}

	//Top Opening
	translate([0,0,base_height])
	cylinder(r1=tool_rad,
        r2=tool_rad+tool_space_margin,
        h=cap_height+1);
}
