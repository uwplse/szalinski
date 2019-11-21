inner_cylinder_height = 7.5; // [5.0:15.0]
inner_cylinder_diameter = 59; // [20.0:70.0]
outer_cylinder_height = 4; // [2.0:6.0]
outer_cylinder_diameter = 80; // [30.0:90.0]
fillet_radius = 2; // [0.0:3.0]
axle_diameter = 9; // [3.0:12.0]
smooth = 90; // [16:180]

/* [Hidden] */
pad = 0.1;

difference()
{
  union()
  {
    translate([0,0,outer_cylinder_height])
    {
      cylinder(d=inner_cylinder_diameter, h=inner_cylinder_height, $fn=smooth);
    }
    cylinder(d=outer_cylinder_diameter, h=outer_cylinder_height, $fn=smooth);
  }
  translate([0,0,-pad/2])
    cylinder(d=axle_diameter, h=inner_cylinder_height+outer_cylinder_height + pad, $fn=36);

  // Top fillet
  translate([0,0,inner_cylinder_height+outer_cylinder_height])
    rotate([180,0,0])
      cylinder_fillet(inner_cylinder_diameter/2);

  // Bottom fillet
  cylinder_fillet(outer_cylinder_diameter/2);
}

// http://www.thingiverse.com/thing:6455
module cylinder_fillet(cylinder_r)
{
  difference()
  {
    rotate_extrude(convexity=10, $fn = smooth)
      translate([cylinder_r-fillet_radius+pad,-pad,0])
        square(fillet_radius+pad,fillet_radius+pad);
    rotate_extrude(convexity=10,  $fn = smooth)
      translate([cylinder_r-fillet_radius,fillet_radius,0])
        circle(r=fillet_radius,$fn=smooth);
  }
}