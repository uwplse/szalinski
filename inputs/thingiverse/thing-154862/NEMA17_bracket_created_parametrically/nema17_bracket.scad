// preview[view:north west, tilt:top diagonal]

bracket_wall_width = 3;
bracket_depth = 25.4; // 1 inch
//lengths of tabs
bracket_flaps =  25.4;
bracket_bolts_diameter = 4; 
bevel_inner_corners = "yes"; //[yes,no]


module NemaForCSG(nema_side, nema_depth, nema_bolts, nema_crown, nema_bolt_radious)
{
	//bevel corners
	r1 = nema_side/2- nema_bolts/2;
	r2 = sqrt(2)* r1 ;
	r=(r2-r1)*2;
	
	
	difference()
	{
	
		union()
		{
			cube([nema_side,nema_depth,nema_side]);
	
			translate( [nema_side/2,0,nema_side/2]) 
				rotate(90,[1,0,0]) 
				{
					cylinder(r = nema_crown, h = 30, $fn = 40,center=true);
				}

			translate( [nema_side/2,0,nema_side/2])
			{
				//bolt holes
				for(j=[1:4])
				{		
					rotate(90*j,[0,1,0]) 
						translate( [nema_bolts/2.0,0,nema_bolts/2.0]) 
							rotate(-90,[1,0,0]) 
							{
								cylinder(r = nema_bolt_radious, h = 30, $fn = 20,center=true);
							}
				}
			}
		}	

		if (bevel_inner_corners == "yes")
		{
			//bevel
			translate( [nema_side/2,0,nema_side/2])
			{
			
				for(j=[1:4])
				{
					rotate(90*j,[0,1,0]) 
						translate( [nema_side/2,nema_depth/2,nema_side/2]) 
					rotate(45,[0,1,0]) 
					cube([30,50,r], center = true);
				}
			}
		}
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
	NemaForCSG(nema17_side, nema17_depth, nema17_bolts, nema17_crown, nema17_bolt_radious);

}