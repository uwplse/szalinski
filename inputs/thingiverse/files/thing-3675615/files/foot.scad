$fn = 80;
$fs=1.75/4;

// Scaling factor to compensate shrinkage characteristic of used filament
scale_for_filament = 1.002; // PETG 0.002% shrink

// Outer diameter of the foot in mm
outer_diameter = 18.45;

// Inner diameter of the foot in mm
inner_diameter = 15.65;

// Wall thickness in mm; choose a multiple of the filament width
foot_thickness = 1.2;

// angle of rotation around X axis in degrees
table_leg_angle = 5;

// preview[view:south east, tilt:top]

module table_foot()
{
  difference()
  {
    rotate([table_leg_angle,0,0])
    difference()
    {
      union()
      {
        cylinder(d=outer_diameter + 2 * foot_thickness,h = 16);
        sphere(d=outer_diameter + 2 * foot_thickness);
      }
      translate([0, 0, 2])
      difference()
      {
        cylinder(d=outer_diameter,h=15);
        cylinder(d=inner_diameter - 0.2,h=16);
      }
      translate([0, 0, 4]) cylinder(d=outer_diameter,h=13);
    }
    translate([0, 0, -4 - 15]) cylinder(d=outer_diameter,h=15);
  }
}

scale(scale_for_filament) table_foot();

