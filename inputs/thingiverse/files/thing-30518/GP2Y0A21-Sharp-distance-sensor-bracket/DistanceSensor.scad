$fn = 50;

inches_to_mm = 25.4;

hole_1_diameter = 0.185*inches_to_mm;
hole_2_diameter = 0.140*inches_to_mm;
sensor_hole_center = 37;
support_height = 9;
sensor_height = 21;
bracket_length = 15;
bracket_thickness = 4;

// -------------------------- part --------------------

distance_sensor_bracket();

// ------------------------- module definition ----------------

module distance_sensor_bracket()
{
  linear_extrude(height = bracket_thickness) union()
  {
    difference()
    {
      square([support_height+sensor_hole_center, support_height]);
      translate([support_height/2, support_height/2]) circle(r=hole_2_diameter/2);
      translate([support_height/2+sensor_hole_center, support_height/2]) circle(r=hole_2_diameter/2);
    }
    
    translate([sensor_hole_center/2, support_height]) square([support_height, sensor_height]);
  }
  
  translate([sensor_hole_center/2, support_height+sensor_height,0]) rotate([90,0,0]) linear_extrude(height = bracket_thickness) difference()
  {
    square([support_height, bracket_length]);
    translate([support_height/2, bracket_length-support_height/2]) circle(r=hole_1_diameter/2);
  }
}