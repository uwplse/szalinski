/* Created by Warren Hodgkinson */

/* [Mitre Box] */
length = 100;
width = 30;
thickness = 3;
height = 20;

/* [Mounting holes] */
screw_head_diameter = 3;
screw_shaft_diameter = 1;
screw_positions = [-40, -20, 0, 20, 40];

/* [Cuts] */
/*
A cut is:
[0] : offset along length
[1] : angle
[2] : cut thickness
*/
cuts = [[0, 60, 3], [-30, 30, 3], [20, 45, 3]];

/* [Hidden] */
$fd = 0.1;
$fa = 1;
$fs = 0.1;
hl = length / 2;
hw = width / 2;
ht = thickness / 2;

module base() {
  translate([-hw, -hl, 0]) scale([width, length, thickness]) cube();
}

module wall() {
  translate([-ht, -hl, thickness]) resize([thickness, length, height - thickness]) cube();
}

module left_wall() {
  translate([-hw + ht, 0, 0]) wall();
}

module right_wall() {
  translate([hw - ht, 0, 0]) wall();
}

module cut(c) {
  translate([0, c[0], 0]) rotate([0, 0, 90+c[1]]) translate([-ht, -hl, thickness]) resize([c[2], length, height]) cube();
}

module cuts() {
  for (c = cuts) {
    cut(c);
  }
}

module screw_hole() {
  cylinder(d2 = screw_head_diameter, d1 = screw_shaft_diameter, h = thickness * 1.001);
}

module screw_holes() {
  for (pos = screw_positions) {
    translate([0, pos, 0]) screw_hole();
  }
}

module mitre_box() {
  difference() {
    union() {
      base();
      left_wall();
      right_wall();
    }
    union() {
      cuts();
      screw_holes();
    }
  }
}

mitre_box();
