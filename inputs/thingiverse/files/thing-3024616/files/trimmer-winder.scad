// Created in 2018 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// https://www.thingiverse.com/thing:3024616

teeth_count = 7;
//teeth_count = 15;

teeth_count_sizing = 15;
outer_diam = 43;
inner_diam = 39;
teeth_inner = 26/2 + 2;
teeth_outer = 26/2 + 5.5;
teeth_innercurvdiam = 2;
gear_depth = 3;
base_depth = 2;
$fa=1;
$fs=0.4;
cone_base_diam = 14;
rod_diam = 9;
cone_len = 18;
rod_len = 22;
rod_edges = 6;


module Gears() {
  difference() {
    cylinder(d=outer_diam, h=gear_depth);
    translate([0, 0, -0.01])
      cylinder(d=inner_diam, h=gear_depth+0.02);
  }

  for (t=[0:teeth_count-1]) {
    rotate([0, 0, t*360/teeth_count])
      translate([teeth_inner, 0, 0])
        Tooth();
  }
}


module Cone() {
  translate([0, 0, gear_depth-0.001])
    cylinder(d1=cone_base_diam, d2=rod_diam, h=cone_len-gear_depth+0.001,
             $fn=rod_edges);
  cylinder(d=cone_base_diam, h=gear_depth, $fn=rod_edges);
}

module Rod() {
  cylinder(d=rod_diam, h=rod_len, $fn=rod_edges);
  translate([0, 0, rod_len-0.001])
    cylinder(d1=rod_diam, d2=rod_diam*2/3, h=rod_diam/3, $fn=rod_edges);
}



cylinder(d=outer_diam, h=base_depth);
translate([0, 0, base_depth-0.001])
  Gears();

translate([0, 0, base_depth-0.001])
  Cone();
translate([0, 0, cone_len-0.002])
  Rod();

module Tooth() {
  teeth_outer_width = teeth_outer * tan(360/teeth_count_sizing);
  translate([teeth_innercurvdiam/2, 0, 0])
  hull() {
    translate([0, -teeth_innercurvdiam/2, 0])
      cylinder(d=teeth_innercurvdiam, h=gear_depth);
    translate([teeth_outer - teeth_inner,
               0,
               0])
      scale([1, 2*teeth_outer_width / teeth_innercurvdiam, 1])
        intersection() {
          cylinder(d=teeth_innercurvdiam, h=gear_depth);
          translate([-teeth_innercurvdiam/2-0.001,
                     -teeth_innercurvdiam/2-0.001,
                     -0.001])
            cube([teeth_innercurvdiam+0.002,
                  teeth_innercurvdiam/2+0.001,
                  gear_depth+0.002]);
        }
  }
}

