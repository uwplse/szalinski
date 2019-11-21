// License: GNU LGPL 2.1 or later.
// © 2013 by Peter-Paul van Gemerden

/* [Basic Settings] */

width = 40;
height = 130;
rod_diameter = 10;
test_object = "Full Render"; // [Test Object,Full Render]
quality = 30; // [30:Draft,60:Medium,90:High (recommended),120:Rediculous]

/* [Bracket] */

// Thickness of the entire bracket.
thickness = 10;
// Depth of the ridge. Will be subtracted from Thickness. For best results, use the thickness of your sheet material, e.g. 6mm.
ridge_thickness = 6;
// How far below the ridge should the flange extend?
flange_height = 16;
screwhole_size = 4.6;
screwhole_extra_length = 2;
// Offset from the center of the bracket.
screwhole_offset = 12.5;

/* [Rod support] */

// The amount of extra room for the rod support.
rod_diameter_tolerance = 0.4;
// The thickness of the snap fit ridges inside the rod support.
rod_snap_fit = 0.4;
rod_support_depth = 17;
rod_support_back_wall = 3;
// How much the top corners should be rounded.
rounding = 5;

//------------ Calculated values --------------//
rod_r = rod_diameter / 2;
wall = 0.08*width;
top_width = 2*(rod_r+wall) + rod_diameter_tolerance + rounding;
$fn = quality;

//------------------ Code ---------------------//

if (preview_tab == "Rod support") {
  if (test_object == "Test Object")
    rotate([0, 0, -90]) test();
  else
    rotate([0, 0, -90]) full();
} else {
  if (test_object == "Test Object")
    test();
  else
    full();
}

module full() {
  difference() {
    union() {
      body();
      rod_support();
      flange();
    }
    rod_gap();
  }
}

module test() {
  scale([1, 1, 0.3])
  difference() {
    rod_support();
    rod_gap();
  }
}

module body() {
  difference() {
    body_shape();
    body_cutout();
  }
}

module body_shape(h=height, w1=width, w2=top_width, t=thickness, r=rounding) {
  hull() {
    translate([-w1/2, 0, 0])
      cube([w1, 0.001, t]);
    translate([0, h-2*r, 0])
    body_top_rounded_cube(w2, 2*r, t, r);
  }
}

module body_top_rounded_cube(x, y, z, r) {
  x = x + 0.001;
  y = y + 0.001;
  minkowski() {
    translate([-x/2 + r, r, 0])
      cube([x-2*r, y-2*r, z-0.001]);
    cylinder(r=r, h=0.001);
  }
}

module body_cutout() {
  translate([0,wall,thickness-ridge_thickness])
  difference() {
    body_shape(height-2*wall, width-2*wall, top_width-2*wall, r=rounding/3);
    vertical_strut();
  }
}

module vertical_strut() {
  translate([-wall/2, 0, 0])
    cube([wall, height, thickness]);
}

module rod_support() {
  rr = 2*rounding;
  z = rod_support_depth + rod_support_back_wall;
  hull() {
    translate([0, height-rr, 0])
      body_top_rounded_cube(top_width, rr, z, rounding);
    translate([0, height-rod_r, 0])
      difference() {
        cylinder(r=top_width/2, h=z);
        translate([-50, 0, -0.1])
          cube([100, 100, z+0.2]);
      }
  }
}

module rod_gap() {
  translate([0, height-rod_r, -0.1])
  difference() {
    union() {
      cylinder(r=rod_r, h=rod_support_depth+0.1);
      translate([-rod_r, 0, 0])
        cube([rod_diameter, rod_r+0.1, rod_support_depth]);
    }
    translate([-rod_r, 0, 0]) snap_fit_bump();
    translate([rod_r, 0, 0]) snap_fit_bump();
  }
}

module snap_fit_bump(invert=false) {
  translate([0, rod_r - rod_snap_fit, 0])
    cylinder(r=rod_snap_fit, h=rod_support_depth, $fn=4);
}

module flange() {
  xd = screwhole_offset;
  yd = flange_height / 2;
  difference() {
    translate([-width/2, -flange_height, 0])
      cube([width, flange_height, thickness-ridge_thickness]);
    translate([-xd, -yd, 0]) screwhole();
    translate([xd, -yd, 0]) screwhole();
  }
}

module screwhole() {
  translate([0, -screwhole_extra_length/2, -0.1])
  hull() {
    cylinder(r=screwhole_size/2, h=thickness);
    translate([0, screwhole_extra_length, 0])
      cylinder(r=screwhole_size/2, h=thickness);
  }
}

// DEPRECATED
module diagonal_strut() {
  translate([wall-width/2,0,0])
    rotate([0,0,-asin((width/2)/height)])
    cube([wall, sqrt(pow(height,2)+pow(width/2,2)), thickness]);
}
