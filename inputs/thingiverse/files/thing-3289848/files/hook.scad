/* [Hook] */

// Diameter of the small part of the hook
d1 = 6;   // [1:0.5:20]
// Diameter of the large part of the hook
d2 = 12;  // [5:1:50]
// Height of the hook
h = 0.8;  // [0.1:0.1:2]
// Width of the hook
w = 0.8;  // [0.1:0.1:1]
// Length of the connection between the two part of the hook
l = 8;    // [0:1:50]
// Extra size of the ends of the hook
x = 0.6;  // [0:0.1:5]

/* [Hidden] */

epsilon = 0.001;
$fn = 50;

module cylinder_3_4th(d, h, w) {
  difference() {
    cylinder(h, d = d+2*w);
    translate([0, 0, -epsilon]) {
      cylinder(h + 2 * epsilon, d = d);
      cube([d/2+w+epsilon, d/2+w+epsilon, h+2*epsilon]);
    }
  }
}

cylinder_3_4th(d1, h, w);
translate([l, (d1+d2)/2 + w, 0])
  rotate([0, 0, 180])
    cylinder_3_4th(d2, h, w);
translate([0, d1 / 2, 0])
  cube([l,w,h]);
translate([(d1 + w) / 2, 0, 0])
  cylinder(h, d = w + x);
translate([l - (d2 + w) / 2, (d1 + d2) / 2 + w, 0])
  cylinder(h, d = w + x);