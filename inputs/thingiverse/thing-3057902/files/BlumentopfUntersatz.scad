// -----------------------------------------------------
// BlumentopfUntersatz
//
//  Detlev Ahlgrimm, 08.2018
// -----------------------------------------------------

// Diameter
dia=300;  // [50:380]

// Height
hgt=1;    // [1:5]

render=0; //  [0:all together/assembled, 1:arm part, 2:center part, 3:center part + 140mm, 4:all together + 140mm]

/* [Hidden] */
$fn=50;
wt=2;


// -----------------------------------------------------
//   r : Radius (innen)
//   w : Wandstaerke
//   h : Hoehe
// -----------------------------------------------------
module Rohr(r, w, h) {
  difference() { cylinder(r=r+w, h=h); translate([0, 0, -0.1]) cylinder(r=r, h=h+0.2); }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module UntersatzDrittel() {
  translate([3, 3, 0]) rotate([0, 0, -45+180]) difference() {
    cylinder(r=10, hgt);
    translate([-10, 0, -0.1]) cube([20, 10, hgt+0.2]);
  }
  for(a=[15, 75]) {
    rotate([0, 0, a]) translate([10, -wt/2, 0]) cube([dia/2-10-3, wt, hgt]);
  }
  difference() {
    Rohr(dia/2-wt-3, wt, hgt);
    translate([-dia/2, -dia/2, -0.1]) cube([dia, dia/2, hgt+0.2]);
    translate([-dia/2, -0.1, -0.1]) cube([dia/2, dia/2+0.2, hgt+0.2]);
  }
}
//!rotate([0, 0, -15]) UntersatzDrittel();
//!UntersatzDrittel();


// -----------------------------------------------------
//
// -----------------------------------------------------
module Untersatz() {
  for(a=[0:120:359]) {
    rotate([0, 0, a]) translate([3, 3, 0]) UntersatzDrittel();
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Untersatz_plus140mm(lng=49) {
  for(a=[0:120:359]) {
    rotate([0, 0, a]) translate([lng+3, lng+3, 0]) UntersatzDrittel();
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Verbinder() {
  difference() {
    cylinder(r=17, h=hgt);
    for(a=[0:120:359]) {
      rotate([0, 0, a]) translate([6, 6, -0.1]) rotate([0, 0, -45+180]) difference() {
        cylinder(r=10.4, hgt+0.2);
        translate([-11, 0.2, -0.1]) cube([22, 11, hgt+0.4]);
      }
    }
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Verbinder_plus140mm(lng=49) {
  difference() {
    for(a=[0:120:359]) {
      rotate([0, 0, a]) translate([lng, lng, 0]) rotate([0, 0, -45+180]) difference() {
        cylinder(r=17, h=hgt);
        translate([-18, 0, -0.1]) cube([36, 18, hgt+0.4]);
      }
    }
    for(a=[0:120:359]) {
      rotate([0, 0, a]) translate([lng+6, lng+6, -0.1]) rotate([0, 0, -45+180]) difference() {
        cylinder(r=10.4, hgt+0.2);
        translate([-11, 0.2, -0.1]) cube([22, 11, hgt+0.4]);
      }
    }
  }
  cylinder(d=10, h=hgt);
  for(a=[0:120:359]) {
    hull() {
      cylinder(d=wt, h=hgt);
      rotate([0, 0, a]) translate([lng, lng, 0]) rotate([0, 0, -45+180]) cylinder(d=wt, h=hgt);
    }
  }
}



if(render==0) {
  rotate([0, 0, -45]) Untersatz();
  rotate([0, 0, -45]) Verbinder();
} else if(render==1) {
  translate([4, 4, 0]) UntersatzDrittel();
} else if(render==2) {
  Verbinder();
} else if(render==3) {
  Verbinder_plus140mm();
} else if(render==4) {
  rotate([0, 0, -45]) Untersatz_plus140mm();
  rotate([0, 0, -45]) Verbinder_plus140mm();
}
