//Total diameter of the cup including the lip
cup_diameter = 72;	

//The thickness of the cup lip.
lip_height = 2;

//The thickness of the printed lid.		
lid_thickness = 0.6;	

/* [Hidden] */

$fn=50;

cup_radius = cup_diameter / 2;
difference()
{
	union()
	{
	
		cylinder(h = lip_height + lid_thickness + 0.01, r1 = cup_radius + 1, r2 = cup_radius + 1, center = false);
		
		translate ([0,0,lip_height + lid_thickness])
		{
			cylinder(h = 1, r1 = cup_radius + 1, r2 = cup_radius, center = false);
		}
	}

	union()
	{
		translate ([0,0,lid_thickness])
		{
			cylinder(h = lip_height+0.01, r1 = cup_radius, r2 = cup_radius, center = false);
		}
		translate ([0,0,lid_thickness + lip_height])
		{
			cylinder(h = 1.01, r1 = cup_radius, r2 = cup_radius-1, center = false);
		}
	}
}
