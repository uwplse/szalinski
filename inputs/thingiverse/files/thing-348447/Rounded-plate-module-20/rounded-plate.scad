//Rounded plate module - faster than minkowski!
//variables with "customizer" in them are only for the Thingiverse customizer and are not essential.


customizer_x=15;
customizer_y=10;
customizer_z=1;

customizer_facets=32;
customizer_rounding_radius=1;

module rounded_plate(size_x,size_y,size_z,facets,rounding_radius)
{
	hull()
	{
		translate([rounding_radius,rounding_radius,0]) cylinder (h=size_z, r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,0]) cylinder (h=size_z,r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,0]) cylinder (h=size_z,r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,0]) cylinder (h=size_z,r=rounding_radius,$fn=facets);
	}
}

rounded_plate(customizer_x,customizer_y,customizer_z,customizer_facets,customizer_rounding_radius);
