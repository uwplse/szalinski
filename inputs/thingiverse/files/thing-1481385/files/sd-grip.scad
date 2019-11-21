// SD card grip. Includes a support wall for easy printing. After printing
// remove the support wall with a knife, and glue the SD card with 
// super glue.

// Round surfaces smoothness. Small numbers such as 3, 4, 5 give interesting 
// results
$fn=120;

// Total model model.
total_length = 24;

// Total model width. Typically matches the width of the SD crd.
total_width = 24;

// Total model thickness.
total_thickness = 5;

// SD slot depth. Make sure it's small enough to enable proper insertion
// of the SD card, including extra distance for those 'toggle' in/oout
// mechanism when available.
sd_slot_depth = 2.0;

// SD slot thickness.
sd_slot_thickness = 2.4;

// Diameter of the grip thumb hole.
grip_hole_diameter = 17;

// Minimal distance between sd card slot and grip thumb hole.
sd_slot_to_grip_min_wall = 3;

// Thickness of slot support wall. Cut with a knife after printing. 
// Set to achive wall thickness of a single extrusion pass. Set
// to zero to disable.
support_wall_thickness = 0.5;

// Small positive numbers for maintaining manifold. No need tto change.
eps1 = 0.01;
eps2 = 2*eps1;
eps4 = 4*eps1;

// Part before any cutting.
module body() {
  intersection() {
    hull() {
      translate([-(total_length-total_width/2), 0, 0]) 
          cylinder(d=total_width, h=total_thickness);
      translate([-eps1, -total_width/2, 0]) 
          cube([eps1, total_width,      total_thickness]);
    }
    // Intesection is useful in case total_length < total_width.
    translate([-total_length, -total_width/2, 0])
      cube([total_length, total_width, total_thickness]);
  }
}

// Substractive.
module sd_slot() {
  cube_x = (support_wall_thickness <= 0)
      ? sd_slot_depth + eps1
      : sd_slot_depth - support_wall_thickness;
  translate([-sd_slot_depth, 
             -(total_width/2 + eps1), 
             (total_thickness - sd_slot_thickness)/2])
  #cube([cube_x, 
         total_width+eps2, 
         sd_slot_thickness]);  
}

// Substractive.
module grip_hole() {
  difference() {
    translate([-(total_length-total_width/2), 0, -eps1])
      cylinder(d=grip_hole_diameter, h=total_thickness+eps2);
    translate([-(sd_slot_depth+sd_slot_to_grip_min_wall),
               -total_width/2,
               -eps2 ])
        cube([sd_slot_depth+sd_slot_to_grip_min_wall, 
               total_width, 
               total_thickness+eps4]);
  }
}

module main() {
  difference() {
    body();
    sd_slot();
    grip_hole();
  }
}

main();

