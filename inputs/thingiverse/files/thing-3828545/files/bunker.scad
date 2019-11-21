// Copyright 2019 Pascal de Bruijn
// Licensed Creative Commons - Attribution - Share Alike

/* [Building] */

// Base size of the building (peek-to-peek hex in millimeters)
hex_size = 37;

// Approximate building storey height (in millimeters)
storey_height = 9.8;

/* [Windows] */

// How high your windows should be (in millimeters)
window_height = 3;

// How wide your windows should be (in millimeters)
window_width = 5;

// How far the window cavity should protrude into the building (in millimeters)
window_depth = 2;

// How thick the window frame is (in millimeters) (needs to be twice your nozzle size to print vertically)
window_frame_width = 1.2;

// How deep the window frame is (in millimeters)
window_frame_depth = 0.5;

/* [Doors] */

// How high your door should be (in millimeters)
door_height = 7;

// How wide your doors should be (in millimeters)
door_width = 5;

// How far the door cavity should protrude into the building (in millimeters)
door_depth = 2;

// How thick the door frame is (in millimeters) (needs to be twice your nozzle size to print vertically)
door_frame_width = 1.2;

// How deep the door frame is (in millimeters)
door_frame_depth = 0.5;

/* [Base] */

// How high the base should be (in millimeters)
base_height = 4.2;

// How much clearance the base should have around the building (in millimeters)
base_top_clearance = 1.5;

// How much much larger the bottom of the base should be than the bottom (in millimeters)
base_bottom_clearance = 2;

// Should the base be hollowed out (in millimeters)
base_cavity_depth = -1;

// How thick in the base edge should be (in millimeters)
base_cavity_clearance = 3;

/* [Model] */

// Overall model scale (as percentage)
model_scale = 100;

// Size of the die that should fit in the die cavity (in millimeters)
die_size = 12;

// Rounding of the die cavity (in millimeters)
die_round_radius = 2;

// Do you want to model to be hollow
hollow = 0; // [0:Solid,1:Hollow]



/* [Hidden] */

door_div = 3;

hex_size_scaled = hex_size - (base_top_clearance * 2) - (base_bottom_clearance * 2);



scale(v=[model_scale / 100, model_scale / 100, model_scale / 100])
{
  difference()
  {
    union()
    {
    
      // base
      translate([0, 0, 0 - base_height])
        cylinder(base_height, (hex_size_scaled / 2) + base_top_clearance + base_bottom_clearance, (hex_size_scaled / 2) + base_top_clearance, $fn = 6);

      // main building
      cylinder(storey_height, (hex_size_scaled / 2), (hex_size_scaled / 2), $fn = 6);

      // upper building
      translate([0, 0, storey_height])
        cylinder(storey_height, (hex_size_scaled / 2), (hex_size_scaled / 2) / 3, $fn = 6);

      // door frames
      for (a = [1:6])
        rotate(a * 60)
          if ((a % door_div) == 0)
            translate([-(door_width / 2) - door_frame_width, (hex_size_scaled * (cos(30)/2)) - door_depth + door_frame_depth, 0])
              cube([door_width + (door_frame_width * 2), door_depth, door_height + door_frame_width]);
          else
            translate([-(door_width / 2) - window_frame_width, (hex_size_scaled * (cos(30)/2)) - window_depth + window_frame_depth, door_height - window_height - window_frame_width])
              cube([window_width + (window_frame_width * 2), window_depth, window_height + window_frame_width * 2]);

    }

    union()
    {
      // base cavity
      translate([0, 0, 0 - base_height - (base_height - base_cavity_depth)])
        cylinder(base_height, (hex_size_scaled / 2) + base_top_clearance + base_bottom_clearance - base_cavity_clearance, (hex_size_scaled / 2) + base_top_clearance - base_cavity_clearance, $fn = 6); 

      // hollow
      if (hollow)
        translate([0, 0, 0])
          minkowski ()
          {
            cylinder(storey_height * 5.5 - (hex_size / 2) - 13, 1, 1, $fn = 48);
            sphere(r = (hex_size / 2) - 13);
          }

      // hidden die cavity
      if (die_size > 0)
        rotate(45)
          translate([0, 0, 0 - base_height])
            minkowski()
            {
              cylinder(die_size, (die_size / 2) + die_round_radius, (die_size / 2), $fn = 4);
              sphere(r = die_round_radius, $fn = 30);
            }
      
      // door cavities
      for (a = [1:6])
        rotate(a * 60)
          if ((a % door_div) == 0)
            translate([-door_width / 2, (hex_size_scaled * (cos(30)/2)) - door_depth, 0])
              cube([door_width, door_depth + door_frame_depth + 1, door_height]);
          else
            translate([-door_width / 2, (hex_size_scaled * (cos(30)/2)) - door_depth, door_height - window_height])
              cube([window_width, window_depth + window_frame_depth + 1, window_height]);

      // flat roof
      translate([0, 0, storey_height * 1.38])
        cylinder(storey_height, hex_size_scaled, hex_size_scaled, $fn = 6);
        
      // make sure nothing protrudes down from the bottom
      translate([0, 0, 0 - base_height - hex_size_scaled])
        cylinder(hex_size_scaled, hex_size_scaled, hex_size_scaled, $fn = 6);        
        
    }
  }
}
