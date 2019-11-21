//Rounded cube module - faster than minkowski!
//variables with "customizer" in them are only for the Thingiverse customizer and are not essential.


customizer_x=10;
customizer_y=10;
customizer_z=10;

customizer_facets=32;
customizer_rounding_radius=1;

module rounded_cube(size_x,size_y,size_z,facets,rounding_radius)
{
	hull()
	{
		translate([rounding_radius,rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);

		translate([rounding_radius,rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
	}
}

rounded_cube(customizer_x,customizer_y,customizer_z,customizer_facets,customizer_rounding_radius);
