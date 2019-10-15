//Rounded cube module - faster than minkowski!
//variables with "customizer" in them are only for the Thingiverse customizer and are not essential.


customizer_x=2;
customizer_y=10;
customizer_z=5;

customizer_facets=16;
customizer_rounding_radius=1;
customizer_wall_thickness=0.1;

module rounded_cube(size_x,size_y,size_z,facets,rounding_radius)
{
	hull()
	{
		translate([rounding_radius,rounding_radius,rounding_radius])
            sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,rounding_radius])
             sphere (r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,rounding_radius])
             sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,rounding_radius])
             sphere (r=rounding_radius,$fn=facets);

		translate([rounding_radius,rounding_radius,size_z-rounding_radius])
             sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,size_z-rounding_radius])
             sphere (r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,size_z-rounding_radius])
             sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,size_z-rounding_radius])
             sphere (r=rounding_radius,$fn=facets);
	}
}

  rad = customizer_rounding_radius;
  facs = customizer_facets;
  wall = customizer_wall_thickness;
  x = customizer_x + wall;
  y = customizer_y;
  z = customizer_z;
  inside = 2 * wall;
  small_x = customizer_x - 4 * wall;
  small_y = customizer_y - 4 * wall;
  small_z = customizer_z - 4 * wall;
difference() {
  rounded_cube( x, y, z, facs, rad );
  translate( [ rad, -1 * rad, wall ] )
      cube( [ wall, y + rad, z + rad ] );
  
  translate( [ inside, inside, inside ] )
  rounded_cube( small_x, small_y, small_z, facs, rad - 2 * wall );
}
