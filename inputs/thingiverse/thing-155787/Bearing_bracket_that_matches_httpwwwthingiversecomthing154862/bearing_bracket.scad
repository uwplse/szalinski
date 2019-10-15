// preview[view:north west, tilt:top diagonal]
bearings_outer_radio = 14;
bearings_inner_radio = 10;
bracket_wall_width = 3;
bracket_depth = 25.4; // 1 inch
//lengths of tabs
bracket_flaps =  25.4;
bracket_bolts_diameter = 4; 
bracket_round_end = "yes"; //[yes,no]

module BearingForNemaCSG(nema_side, bearings_outer_radio, bearings_inner_radio)
{
	side = nema_side+bracket_wall_width*2;
	if (bracket_round_end=="yes")
	{

		difference()
		{
			translate( [-bracket_wall_width,-bracket_wall_width,nema_side/2]) 
				cube([side,bracket_depth,nema_side]);
	
			translate( [nema_side/2,bracket_depth/2-bracket_wall_width,nema_side/2]) 
				rotate(90,[1,0,0]) 
				{
					cylinder(r = side/2, h = bracket_depth, $fn = 40,center=true);
				}

		}
	}

	translate( [nema_side/2,bracket_depth/2,nema_side/2]) 
		rotate(90,[1,0,0]) 
		{
			cylinder(r = bearings_outer_radio, h = bracket_depth, $fn = 40,center=true);
		}

	translate( [nema_side/2,bracket_depth/2-bracket_wall_width,nema_side/2]) 
		rotate(90,[1,0,0]) 
		{
			cylinder(r = bearings_inner_radio, h = bracket_depth, $fn = 40,center=true);
		}

}


//units are in millimeters
M3 = 3.0/2.0;
nema17_side = 42.2;
nema17_bolts = 31.04;
nema17_depth = 33.8;
nema17_crown = 11;
nema17_bolt_radious = M3;

difference()
{
	union()
	{
		cube([nema17_side+bracket_wall_width*2, bracket_depth, nema17_side+bracket_wall_width*2]);

		translate([-bracket_flaps,0,0])
			cube([nema17_side+(bracket_wall_width+bracket_flaps)*2,bracket_depth,bracket_wall_width]);		
	}

	translate([bracket_wall_width + nema17_side + bracket_wall_width + bracket_flaps/2,bracket_depth/2,0])
		cylinder(r = bracket_bolts_diameter/2, h = 30, $fn = 40,center=true);

	translate([-bracket_flaps/2,bracket_depth/2,0])
		cylinder(r = bracket_bolts_diameter/2, h = 30, $fn = 40,center=true);


	translate([bracket_wall_width,bracket_wall_width,bracket_wall_width])


	BearingForNemaCSG(nema17_side, bearings_outer_radio, bearings_inner_radio);

}

	//BearingForNemaCSG(nema17_side, bearings_radio,bearings_radio/2);

