// Total height of the pot
height = 110;

// Diameter at the top / outer diameter of the brim 
outer_diameter_top = 140;

// Diameter at the bottom / diameter of the slats
outer_diameter_bottom = 100;

// Thickness of the body of the pot, including the slats
wall_thickness = 1.5;

// Height of the brim
brim_height = 10;

// Thickness of the brim - preferrably more than the wall thickness
brim_thickness = 4; // [2:10]

// Height of the slats / elevation of the drainage holes
drainage_slat_height = 5; // [0:20]

// Edge length of the square drainage holes.
drainage_holes_size = 3; // [1:20]

// Number of slats.
number_of_slats = 24; // [4:24]





module pot()
{
	$fn=180;
	outer_radius_bottom = outer_diameter_bottom / 2;
	pot_cone_height = height+2*wall_thickness-brim_height-drainage_slat_height;
	pot_cone_radius = outer_diameter_top/2+wall_thickness/2-brim_thickness/2;
	
	
	union()
	{
		difference()
		{
			union()
			{
				difference()
				{
					translate([0,0,drainage_slat_height])
						cylinder( h = pot_cone_height, r2 = pot_cone_radius, r1 = outer_diameter_bottom/2 );

					union()
					{
						difference()
						{
							translate([0,0,wall_thickness + drainage_slat_height])
								cylinder( h = pot_cone_height, 
										  r2 = pot_cone_radius - wall_thickness, 
										  r1 = outer_diameter_bottom/2 - wall_thickness);
							
							slatsRoofDie( wall_offset = -wall_thickness );
						}
						slatsRoofDie( wall_offset = 0 );
					}
				}
				slats();
			}
			drainageHolesDie();
		}
		brim();
	}

}



module singleDrainageHole()
{
	translate( [outer_diameter_bottom/2 - 1.5*drainage_holes_size, 0, drainage_slat_height] )
	union()
	{
		// pierces through the slats and the roofs above them horizontally
		rotate( 45, [0,1,0] )
			cube( [ drainage_holes_size, 
					outer_diameter_bottom * PI / number_of_slats, 
					drainage_holes_size ],
				  center = true );
		// pierces through the roof vertically to make sure that the hole is as big as specified
		rotate( 45, [0,0,1] )
		translate( [-drainage_holes_size/2, -drainage_holes_size/2, 0 ] )
			cube( [ drainage_holes_size, 
					drainage_holes_size, 
					outer_diameter_bottom * PI / number_of_slats ] );
	}
}


module drainageHolesDie()
{
	union()
	{
		for( slat_n = [ 0 : number_of_slats - 1  ] )
		{
			rotate(slat_n*360/number_of_slats, [ 0, 0, 1 ] )
				singleDrainageHole();
		}
	}
}


module singleSlatRoofDie( wall_offset )
{
	tilt = asin(tan(180/number_of_slats)); // don't even ask...
	roofVOffsetForWallThickness = (wall_thickness/2); // not correct, but good enough small tilt angles.
	cube_size = 2*outer_diameter_bottom;
	cube_diameter = PI*outer_diameter_bottom/number_of_slats;

	rotate( 180/number_of_slats, [0,0,1] ) 			// rotate between two slats
	translate( [0,0,drainage_slat_height - roofVOffsetForWallThickness] ) 	// raise such that it aligns with the slats
	rotate(tilt, [0,1,0]) 							// tilt such that the angle of horizontal intersection equals the slat angle
	rotate( -90-45, [1,0,0]) 						//let the box hang down at one edge on the x-axis
	translate( [-outer_diameter_bottom/1.5, 0, 0 ] ) 					// center on the x-axis
	translate( [wall_offset, wall_offset, wall_offset] ) 			// apply specified wall thickness
		cube( [cube_size, cube_diameter, cube_diameter] );
}

// Original version of building the slats roof , using union over for-loop
// This was way too slow, probably due to the n-fold intersection points at the center.
// The workaround is to unify the slat roofs recursively in adjacent pairs by bisecting the full range.
//module slatsRoofDie( wall_offset )
//{
//	union()
//	{
//		for( slat_n = [ 0 : number_of_slats - 1  ] )
//		{
//			rotate(slat_n*360/number_of_slats, [ 0, 0, 1 ] )
//				singleSlatRoofDie( wall_offset);
//		}
//	}
//}

module slatsRoofDie( wall_offset )
{
	slatsRoofDieRange( wall_offset, 0, number_of_slats - 1 );
}



module slatsRoofDieRange( wall_offset, n_from, n_to )
{
	n_middle = floor( (n_from + n_to ) / 2);
	if( n_from >= n_to )
	{
		rotate(n_from*360/number_of_slats, [ 0, 0, 1 ] )
			singleSlatRoofDie( wall_offset );
	}
	else
	{
		union()
		{
			slatsRoofDieRange( wall_offset = wall_offset, n_from = n_from, n_to = n_middle );
			slatsRoofDieRange( wall_offset = wall_offset, n_from = n_middle+1, n_to = n_to );
		}
	}
}



module brim()
{
	brim_radius = outer_diameter_top/2;
	
	translate([0,0,height-brim_height])
	intersection()
	{
		difference()
		{
			cylinder( r=brim_radius, h=brim_height );
			
			union()
			{
				translate([0,0,-1])
					cylinder( r=brim_radius-brim_thickness, h=brim_height+2 );
				translate([0,0,-brim_thickness/2])
					cylinder( r1=brim_radius, r2=brim_radius-brim_thickness, h=brim_thickness );
			}
		}
		translate([0,0,-brim_thickness/2])
			cylinder( r1=brim_radius-brim_thickness, 
				      r2=brim_radius+brim_height-brim_thickness,
					  h=brim_height+brim_thickness/2 );
	}
}

module slats()
{
	union()
	{
		for( slat_n = [ 0 : number_of_slats - 1  ] )
		{
			rotate(slat_n*360/number_of_slats, [ 0, 0, 1 ] )
				singleSlat();
		}
	}
}

module singleSlat()
{
	translate( [-outer_diameter_bottom/2, -wall_thickness/2, 0 ] )
		cube( [outer_diameter_bottom, wall_thickness, drainage_slat_height] );
}


pot();


