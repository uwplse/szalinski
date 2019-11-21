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
$fs = const(0.2);

// Radius of the cup bottom
major = 25; // [20:60]
// Height of the cup
height = 80; // [50:150]
// Radius of the bars
minor = 4; // [3:10]

scale = const(1.25);
step = const(360 / 16);

module torus(major_radius, minor_radius) {
    rotate_extrude() translate([major_radius, 0, 0]) circle(r = minor_radius);
}

translate([0, 0, minor]) {
  linear_extrude(height = height , center = false, twist = 135, scale = scale) {
    difference() {
      circle(r = major + 1);
      circle(r = major - 1);
    }
    for (a = [0 : step : 359]) {
      rotate([0, 0, a]) translate([major, 0 , 0]) circle(minor);
    }
  }
  translate([0, 0, height]) torus(major * scale, minor * scale);
}
translate([0, 0, minor]) torus(major, minor);
cylinder(r = major, h = minor);


