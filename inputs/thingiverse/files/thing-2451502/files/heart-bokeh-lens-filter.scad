// could be changed
lens_outer_radius=52;
heart_size_factor=0.008;
wall_thickness=3;
shaft_leght=8;

//don`t change!
heart_scale=lens_outer_radius*heart_size_factor;

module flat_heart() {
  square(20,center=true);

  translate([10, 0, 0])
  circle(10);

  translate([0, 10, 0])
  circle(10);
}

difference()
{
    translate([0,0,0])cylinder(wall_thickness+shaft_leght,d=lens_outer_radius+wall_thickness);
    translate([0,0,wall_thickness])cylinder(shaft_leght,d=lens_outer_radius);

    linear_extrude(height=wall_thickness) 
    translate([-(heart_scale*3),-(heart_scale*3),0])scale([heart_scale,heart_scale,heart_scale])flat_heart();
}

