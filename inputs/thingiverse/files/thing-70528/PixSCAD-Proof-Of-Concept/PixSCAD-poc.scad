//Makerbot Hackathon 2013
//PixSCAD
//Proof Of Concept for a picture to OpenSCAD Customizable Thingi
//Team - Alex Tanchoco (LionAlex)
//	Cameron Stern (SternDesignworks)
//	Allister McKenzie (Dion)


grid_height = 8;
grid_width = 8;

grid_overall_diameter = 4;
grid_lower_diameter = 3.5;
grid_upper_diameter = 2; // 
grid_maximum_height = 5; //

grid_polygons = 3;

grid_base_height = 1;

translate( [-grid_overall_diameter/2, -grid_overall_diameter/2,0] )
	cube( [grid_overall_diameter*(grid_width+1), grid_overall_diameter*(grid_height+1),grid_base_height] );

for ( x=[0:1:grid_height] ) {
	for( y=[0:1:grid_width] ) {
		translate( [x*grid_overall_diameter,y*grid_overall_diameter,grid_base_height] )
			cylinder( h=(x+y)/4, r1=grid_lower_diameter/2, r2=grid_upper_diameter/2, $fn=grid_polygons+x/2+y/2 );
			//cylinder( h=(x+y)/4, r=grid_lower_diameter/2, $fn=grid_polygons+x/2+y/2 );
	}
}