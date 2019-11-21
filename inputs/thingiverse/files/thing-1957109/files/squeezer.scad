/*
 * Copyright © 2016 by Jarek Cora <jarek@stormdust.net>
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License.
 */

// Marker for non-configurable values
function const(x) = x;

// Minimum angle of a fragment - circle has no more fragments than 360 divided by this number
$fa = const(1);
// The minimum size of a fragment
$fs = const(0.1);
// Workaround for CSG operations
eps = const(0.1);

// Needs to be slightly more then the width of your toothpaste tube. Default value works for most tubes.
slit_length = 60; // [40:1:100]

slit_l = slit_length;

// Values tested to be just right, no need to mess with them
wall_t = const(5);
ball_d = const(36);
slit_w = const(4);

total_h = const(12);
total_l = slit_l + 2 * wall_t;
total_w = 2 * wall_t + slit_w;


module fin(length, projected_width, thickness) {
  // Fin is rotated 45 degrees, so it is sqrt(2) times longer then its projected width.
  // Additionally it's edge is hald of a cylinder width diameters equal to thickness
  fin_width = (sqrt(2) * projected_width) - thickness / 2;

  rotate ([0, -45, 0]) {
    cube([fin_width, length, thickness], center = true);
    translate([fin_width / 2, 0, 0]) rotate ([90, 0, 0]) cylinder(h = length, d = thickness, center = true);
  }
}

module half_sphere(diameter) {
  difference() {
    sphere(d = diameter, center = true);
    translate([diameter / 2 ,0 ,0]) cube(diameter + eps, center = true);
  }
}

module quarter_sphere(diameter) {
  intersection() {
    sphere(d = diameter, center = true);
    translate([diameter / 2, 0, -diameter / 2]) cube(diameter + eps, center = true);
  }
}

difference() {
  union() {
    // Main body
    difference() {
      union() {
        translate([0, 0, -eps]) linear_extrude(height = total_h + eps) {
          offset (r = 1) square([total_w -2, total_l - 2], center = true);
        }
        half_sphere(ball_d);
        translate([0, 0, total_h]) quarter_sphere(0.85 * ball_d);
      }
      // Bottom cut-off
      translate([0, 0, -(ball_d / 2)]) cube([ball_d + eps, total_l, ball_d], center = true);
      // Slit
      cube([slit_w, slit_l, ball_d + eps], center = true);
    }
    // Fin
    translate ([-2.2, 0, 5])  fin(slit_l - 2, slit_w + 1, 1.2);
  }
  // Thumb cut-out
  translate([-15, 0, 13]) sphere(d = 24, center = true);
}
