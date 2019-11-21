/* [General] */

// Two per motor (one on each side of the frame) is recommended.
count = 2; // [1:16]

/* [Slicer Setup] */

// Try to match your printer's nozzle
nozzle_diameter = 0.4;

// Set to the layer thickness you will use in your slicer.
layer_thickness = 0.2;

// Recommended: 2 or 3 depending on layer thickness
layer_count = 2;

/* [Motor Setup] */

// Make sure it is big enough to not bind the motor c-clip.
center_hole_diameter = 7;

// Recommend adding 0.15-0.25 depending on your printer.
screw_hole_diameter = 3.15;

// This is center-to-center distance of two opposing screws
mounting_pattern_diameter_1 = 19.0;

// This is center-to-center distance of the other pair of screws
mounting_pattern_diameter_2 = 16.0;

// Recommend adding 0.25 or more if using washers
screw_head_diameter = 5.75;

/* [Advanced] */

// Resolution of circles (lower renders faster)
resolution = 16; // [16:Low, 32:Med, 64:High]

// Multiplier that effects the radius of the inner corner. 1.0 makes it the same as screw_head_diameter.
inner_corner_multiplier = 1.0;

/* [Hidden] */

$fn = resolution;

// Calculated

height = layer_thickness * layer_count;
motor_mount_max_r = max(mounting_pattern_diameter_1,mounting_pattern_diameter_2)/2;
motor_mount_min_r = min(mounting_pattern_diameter_1,mounting_pattern_diameter_2)/2;

// Round up to ensure no partial lines (based on nozzle_diameter)

function round_up_to_nearest_multiple(val, num) = num * ceil(val/num);
screw_hole_diameter_rounded = round_up_to_nearest_multiple(screw_hole_diameter, nozzle_diameter);
screw_head_diameter_rounded = round_up_to_nearest_multiple(screw_head_diameter, nozzle_diameter);
center_hole_diameter_rounded = round_up_to_nearest_multiple(center_hole_diameter, nozzle_diameter);

inner_corner_d = round_up_to_nearest_multiple((screw_head_diameter * inner_corner_multiplier), nozzle_diameter);
corner_offset = (screw_head_diameter_rounded + inner_corner_d) / 2;

module primary_form() {
  difference() {
    translate([0,0,height/2]) cube([corner_offset*2, corner_offset*2, height], center=true);

    for(v=[[corner_offset,corner_offset,-0.1],
            [corner_offset,-corner_offset,-0.1],
            [-corner_offset,corner_offset,-0.1],
            [-corner_offset,-corner_offset,-0.1]])
      translate(v) cylinder(d=inner_corner_d, h=height+0.2);
  }

  hull() {
    translate([motor_mount_max_r,0,0]) cylinder(d=screw_head_diameter_rounded, h=height);
    translate([-motor_mount_max_r,0,0]) cylinder(d=screw_head_diameter_rounded, h=height);
  }

  hull() {
    translate([0,motor_mount_max_r,0]) cylinder(d=screw_head_diameter_rounded, h=height);
    translate([0,-motor_mount_max_r,0]) cylinder(d=screw_head_diameter_rounded, h=height);
  }
}

module center_cutout() {
  cylinder(d=center_hole_diameter_rounded, h=height*2+0.1, center=true);
}

module screws_cutout() {
  for(i=[0:3]) {
    rotate([0,0,i*90]) {
      hull() {
        translate([motor_mount_max_r,0,0]) cylinder(d=screw_hole_diameter_rounded, h=height*2+0.1, center=true);
        translate([motor_mount_min_r,0,0]) cylinder(d=screw_hole_diameter_rounded, h=height*2+0.1, center=true);
      }
    }
  }
}

module soft_mount() {
  difference() {
    primary_form();
    center_cutout();
    screws_cutout();
  }
}

rows = ceil(sqrt(count));
cols = ceil(sqrt(count));
outside_d = motor_mount_max_r*2 + screw_head_diameter_rounded + 1;
for(i=[0:count-1]) {
  x_offset = floor(i/rows)*(outside_d+1);
  y_offset = floor(i % cols)*(outside_d+1);

  translate([x_offset, y_offset, 0]) soft_mount();
}

/* A few useful presets:
 *   11xx motors:
 *     - center_hole_diameter = 4;
 *     - screw_hole_diameter = 2.25;
 *     - mounting_pattern_diameter_1 = 9.0;
 *     - mounting_pattern_diameter_2 = 9.0;
 *     - screw_head_diameter = 4.25;
 *
 *   2204-2206 motors:
 *     - center_hole_diameter = 7;
 *     - screw_hole_diameter = 3.15;
 *     - mounting_pattern_diameter_1 = 16.0;
 *     - mounting_pattern_diameter_2 = 19.0;
 *     - screw_head_diameter = 5.75;
 */


