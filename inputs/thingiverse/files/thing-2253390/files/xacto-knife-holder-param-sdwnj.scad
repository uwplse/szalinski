//Diameter of knife handle in mm
tool_diameter = 9.15; // My x-acto gripster
tool_rad = tool_diameter / 2;
//Base is this many times handle radius
base_multiplier = 4;
//Height of base (bottom disk) in mm
base_height = 8;
//Height of conical cap
cap_height = 41;
//Base of cap is this many times handle radius
cap_base_multiplier = 3;
//Width of wall at top of cap in mm
cap_top_wall_width = 1.5;
//Extra space to adjust for tight or loose fit
tool_space_margin = 0.55;
//Depth of handle hole in mm
handle_hole_depth = 8;
//Width of cutout for blade
blade_hole_width = 3;
//Size of ridge showing orientation of blade in mm
orientation_ridge_size = 4;
//$fn=90; //uncomment for pretty preview render
difference()
{
	union()
	{
		//Base
		cylinder(r=tool_rad*base_multiplier, 
            h=base_height);

		//Cap
		cylinder(h=cap_height,
            r1=tool_rad*cap_base_multiplier, 
            r2=tool_rad+cap_top_wall_width*2);
        
        //Orientation Ridge
        translate([-blade_hole_width/2,
            -(tool_rad+cap_top_wall_width+orientation_ridge_size),])
        cube([blade_hole_width,
            (tool_rad+cap_top_wall_width+orientation_ridge_size)*2,
            cap_height,
            ]);
        
	}

	//Blade
	translate([-blade_hole_width/2,-(tool_rad+1),base_height])
	cube([blade_hole_width,(tool_rad+1)*2,cap_height]);

	//Top Opening
	translate([0,0,cap_height-handle_hole_depth])
	cylinder(r1=tool_rad,
        r2=tool_rad+tool_space_margin,
        h=handle_hole_depth+1);

	//Rounded resting area for knife
	translate([0,0,cap_height-handle_hole_depth+1])
	sphere(r=tool_rad+tool_space_margin);
}
