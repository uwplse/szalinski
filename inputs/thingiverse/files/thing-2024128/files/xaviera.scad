/*
 * Copyright © 2017 by Jarek Cora <jarek@stormdust.net>
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License.
 */

// Marker for non-configurable values
function const(x) = x;
// Minimum angle of a fragment - circle has no more fragments than 360 divided by this number
$fa = const(1);
// The minimum size of a fragment
$fs = const(0.4);
// Workaround for CSG operations
eps = const(0.01);

// Height of the vase in milimeters
height = 75; // [50:200]

// Width of the base in milimeters
width = 50; // [30:100]

// Wall thickness in milimeters
wall_thickness = 2; // [2:5]


module solid_shape(size, shrink_by = 0) {
  decor = 0.1 * size;
  starting_size = size - 2 * decor;
  offset(r = decor - shrink_by)
    difference() {
      square(starting_size, true);
      for (i = [-size / 2, size / 2]) {
        translate([i, 0, 0]) circle(r = 2 * decor);
        translate([0, i, 0]) circle(r = 2 * decor);
      }
    }
}

module hollow_shape(size, thickness) {
  difference() {
    solid_shape(size);
    solid_shape(size, thickness);
  }
}


module vase(size, height, wall_thickness) {
  linear_extrude(height = height, convexity = 8, twist = 180)
    hollow_shape(size, wall_thickness);

  linear_extrude(height = wall_thickness, convexity = 8, twist = 180 * (wall_thickness / height)) 
    solid_shape(size);
}

vase(width, height, wall_thickness);
