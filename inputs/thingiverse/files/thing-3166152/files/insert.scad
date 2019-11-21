include <scad-utils/morphology.scad>

$fn = 90;

dead_l = 15;
insert_l = 70;
insert_h = 21;
insert_w = 16.5;
insert_h_dead = 17;
extra_l = 10;

m5_dia = 4.7;
m5_head_dia = 8.5;
m5_head_h = 5;

m4_dia = 3.5;
m4_nut_dia = 7.8;

bearing_outer_d = 16;
cutouts_tolerance = 0.5;

bearing_something = 3;

roundness = 4;

module insert_dummy_dead() {
  linear_extrude(height=dead_l) {
    difference() {
      rounding(r=roundness) square([insert_w, insert_h_dead]);
      translate([insert_w/2,insert_h-bearing_outer_d/2+bearing_something]) circle(d=m5_head_dia);
    }
  }
}

module insert_dummy() {
  linear_extrude(height=insert_l+extra_l) {
    difference() {
      rounding(r=roundness) square([insert_w, insert_h]);
      translate([insert_w/2,insert_h-bearing_outer_d/2+bearing_something]) circle(d=m5_dia);
    }
  }
}

module bearing_cutout() {
  linear_extrude(height=5+cutouts_tolerance) {
    union() {
      translate([0,(bearing_outer_d+cutouts_tolerance)/4]) square([(bearing_outer_d+cutouts_tolerance),(bearing_outer_d+cutouts_tolerance)/2], center=true);
      circle(d=bearing_outer_d+cutouts_tolerance);
    }
  }
}

module m4_cutout() {
  translate([0,10.3,0]) rotate([-90,0,0]) cylinder(d=m4_dia,h=insert_h-10);
  rotate([-90,0,0]) cylinder(d=m4_nut_dia,h=10, $fn=6);
}


difference() {
  union() {
    insert_dummy_dead();
    translate([0,0,dead_l]) insert_dummy();
  }
  translate([insert_w/2,insert_h-bearing_outer_d/2+bearing_something,dead_l+m5_head_h]) bearing_cutout();
  translate([insert_w/2,insert_h-bearing_outer_d/2+bearing_something,dead_l-0.01]) cylinder(d=m5_head_dia,h=m5_head_h+0.02);
  translate([insert_w/2,insert_h-bearing_outer_d/2+bearing_something,dead_l+m5_head_h]) bearing_cutout();
  translate([insert_w/2,insert_h-bearing_outer_d/2+bearing_something,dead_l+insert_l-25]) bearing_cutout();
  translate([insert_w/2,insert_h-bearing_outer_d/2+bearing_something,dead_l+insert_l-25]) cylinder(d=m5_head_dia,h=extra_l+25+0.02);
  translate([insert_w/2,0,dead_l+insert_l+extra_l/2]) m4_cutout();
}