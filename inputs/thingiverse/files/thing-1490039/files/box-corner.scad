/* Copyright (C) Peter Ivanov <ivanovp@gmail.com>, 2016 */
/* License: Creative Commons - Attribution - Non-commercial (CC BY-NC) */

cube_size = 13; // [10:50]
// M3 = 5.5 mm, M4 = 7 mm, M5 = 8 mm, M6 = 10 mm
nut_size = 5.5; // [5:0.1:20]
// M3 = 3 mm, M6 = 6 mm, and so on...
nut_diameter = 3; // [3:0.1:20]
// M3 = 2.6 mm, M4 = 3.44 mm, M5 = 4.24 mm, M6 = 5.24 mm
nut_height = 2.6; // [2:0.1:15]
// Only three nuts should be installed anyway
nut_sinks_on_all_sides = 0; // [0:No, 1:Yes]
// Allowance, it will be added to nut size, diameter and height
epsilon = 0.1; // [0.0:0.05:0.5]
//epsilon = 0.1; // tul keves
//epsilon = 0.5; // tul sok

/* [Hidden] */
fn = 30;

difference()
{
    cube(cube_size, cube_size, cube_size);
    translate([cube_size / 3, 0, cube_size / 3]) 
    {
        rotate([-90, 0, 0]) 
        {
            translate([0, 0, cube_size]) hexagon(nut_size + epsilon, (nut_height * 2 + epsilon) * nut_sinks_on_all_sides, 0);
            cylinder(d = nut_diameter + epsilon, h = cube_size + epsilon, $fn=fn);
            hexagon(nut_size + epsilon, nut_height * 2 + epsilon, 90);
        }
    }
    translate([0, cube_size / 3, cube_size * 2 / 3]) 
    {
        rotate([0, 90, 0]) 
        {
            translate([0, 0, cube_size]) hexagon(nut_size + epsilon, (nut_height * 2 + epsilon) * nut_sinks_on_all_sides, 0);
            cylinder(d = nut_diameter + epsilon, h = cube_size + epsilon, $fn=fn);
            
            hexagon(nut_size + epsilon, nut_height * 2 + epsilon, 0);
        }
    }
    translate([cube_size * 2 / 3 , cube_size * 2 / 3, 0]) 
    {
        rotate([0, 0, 90]) 
        {
            translate([0, 0, cube_size]) hexagon(nut_size + epsilon, nut_height * 2 + epsilon, 0);
            cylinder(d = nut_diameter + epsilon, h = cube_size + epsilon, $fn=fn);
            hexagon(nut_size + epsilon, (nut_height * 2 + epsilon) * nut_sinks_on_all_sides, 0);
        }
    }
}

module hexagon(width, height, baseAngle) 
{
  bwidth = width / 1.75;
  for (angle = [baseAngle, baseAngle + 60, baseAngle + 120]) 
  {
      rotate([0, 0, angle]) cube([bwidth, width, height], true);
  }
}
