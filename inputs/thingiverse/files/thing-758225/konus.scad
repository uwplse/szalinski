// cone height
conus_height = 30;
// cone diameter
conus_diameter = 30;
// cone thickness
conus_thickness = 2;
// cone fn (>=3)
conus_fn = 50;

conus2_height = conus_height-conus_thickness;
conus2_diameter = conus_diameter-conus_thickness;

difference(){
  cylinder(h=conus_height, d1=conus_diameter, d2=0, $fn=conus_fn);
  cylinder(h=conus2_height, d1=conus2_diameter, d2=0, $fn=conus_fn);
}