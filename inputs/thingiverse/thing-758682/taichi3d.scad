// Diameter in mm
outer_diameter = 36; 
// any number
// Width in mm 
line_thickness = 4; 
// any number
// Thickness in mm
item_thickness = 5; 
// any number
module dr_build_outer(diameter,thickness,width) 
	{
	difference()
		{
		union()
			{
			cylinder(r=diameter/2 ,h=width, $fn=50);
			}
		union()
			{
			cylinder(r=(diameter/2)-thickness ,h=width, $fn=50);
			}
		}
	}
module dr_build_inner(diameter,thickness,width) 
	{
	difference()
		{
		union()
			{
			cylinder(r=(diameter+thickness)/4 ,h=width, $fn=50);
			}
		union()
			{
			cylinder(r=(diameter+thickness)/4-thickness ,h=width, $fn=50);
			}
		}
	}
module dr_half_build(diameter,thickness,width) 
	{
	difference()
		{
		union()
			{
			dr_build_outer(diameter,thickness,width);
			translate([0,(diameter/4)-thickness/4,0]) dr_build_inner(diameter,thickness,width);
			}
		union()
			{
			translate([0,-diameter/2,0]) cube([diameter/2,diameter,width]);
			}
		}	
	}
module dr_build(diameter,thickness,width) 
	{
	difference()
		{
		union()
			{
			dr_half_build(diameter,thickness,width);
			rotate([180,180,0]) dr_half_build(diameter,thickness,width);
			}
		union()
			{
			}
		}	
	}

dr_build(outer_diameter,line_thickness,item_thickness);
