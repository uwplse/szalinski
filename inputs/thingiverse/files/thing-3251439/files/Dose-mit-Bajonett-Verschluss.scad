// -----------------------------------------------------
// Dose mit Bajonett-Verschluss
//    .... als Spin-Off meiner Bit-Halterung
//
//  Detlev Ahlgrimm, 30.11.2018
// -----------------------------------------------------

// what to render
part=1;     // [1:base, 2:cap, 3:cut-debug]

// inner diameter (base)
dia=95;     // [25:180]

// inner height (base)
ihb=20;     // [10:100]

// inner height (cap)
ihc=0;      // [0:100]

// floor thickness (base, cap)
ft=1;       // [0.5:0.05:5]

// wall thickness (base, cap)
wt=1.5;    // [1:0.05:4]

// debug rotate
dr=0;       // [0:120]
// debug height cap
dh=0;       // [0:20]

/* [Hidden] */
$fn=100;

// -----------------------------------------------------
//  Hier koennen die Innerein der Base() eingestellt
//  werden!
// -----------------------------------------------------
module BaseInwards() {
  //translate([-wt/2, -dia/2, 0]) cube([wt, dia, ihb]);
  //translate([-dia/2, -wt/2, 0]) cube([dia, wt, ihb]);
}





// -----------------------------------------------------
//  ri  : Innenradius ( max(Aussenradius)==ri+wt+2 )
//  h   : Hoehe ( >=9 )
// -----------------------------------------------------
module BasisWand(ri, h) {
  rotate_extrude() translate([ri, 0, 0]) polygon([ [0,0], [wt,wt], [wt,h-8-2], [wt+2,h-8], [wt+2, h-1], [wt+1, h], [0,h] ]);
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Base() {
  difference() {
    union() {
      BasisWand(dia/2, ft+ihb);   // Wand
      cylinder(d=dia, h=ft);      // Boden
      translate([0, 0, ft]) rotate_extrude() translate([dia/2, 0, 0]) polygon([ [0.1,0], [-1,0], [0.1,1] ]);
    }
    translate([0, 0, ft+ihb-7]) BajonettSchneider(dia/2+wt+2);
  }
  translate([0, 0, ft]) intersection() {
    union() {
      translate([0, 0, -0.1]) cube([1, 1, 0.1]);  // Dummy
      BaseInwards();
    }
    cylinder(d=dia, h=ihb);
  }
}


// -----------------------------------------------------
//  r : Aussenradius (Innenradius==r-2)
//  h : Hoehe
// -----------------------------------------------------
module BajonettSchneider(r, h=10) {
  difference() {
    rotate_extrude() translate([r, 0, 2]) polygon([ [0.1,0], [-2,0], [-2,3], [0.1,5] ]);
    for(a=[0:120:359]) rotate([0, 0, a]) {
      translate([0, 0, -0.1]) cube([r+0.2, 8, 5.2]);
      difference() {
        translate([r/2, 2, -0.1]) cylinder(r=r/2, h=5.2);
        translate([0, -r/2, -0.2]) cube([r, r/2, 5.4]);
      }
    }
  }
  for(a=[0:120:359]) rotate([0, 0, a])
    translate([0, 0, 3]) intersection() {
      difference() {
        cylinder(r=r+0.1, h=h-3);
        translate([0, 0, -0.1]) cylinder(r=r-2, h=h+0.2);
      }
      translate([0, -9, 0]) rotate([0, 90, 0]) linear_extrude(r+0.2) polygon([ [0,0], [-(h-3),-2], [-(h-3),11], [0,9] ]);
    }
}
//!BajonettSchneider(dia/2, 10);


// -----------------------------------------------------
//
// -----------------------------------------------------
module Deckel() {
  difference() {
    cylinder(r=dia/2+wt+2+0.5+wt, h=7.3+ihc);
    translate([0, 0, -0.1]) cylinder(r=dia/2+wt+2+0.5, h=7.3+ihc+0.2);
  }
  intersection() {
    rotate_extrude() translate([dia/2+wt+2+0.8, 0, 0]) polygon([ [0.1,0], [-2,0], [-2,3], [0.1,5] ]);
    for(a=[0:120:359]) rotate([0, 0, a])
      translate([0, -8, -0.1]) cube([dia/2+wt+2+0.81, 7, 7.2]);
  }
  translate([0, 0, 7.3+ihc]) {
    rotate_extrude() translate([dia/2+wt+2+0.5, 0, 0]) polygon([ [0.1,0], [0.1,-1], [-1,0] ]);
    cylinder(r1=dia/2+wt+2+0.5+wt, r2=dia/2+wt+2+0.5+wt-ft, h=ft);
  }
  rotate_extrude() translate([dia/2+wt+2+0.5, 0, 0]) polygon([ [0,0], [0,-1], [0.5,-1], [wt,0] ]);
}


if(part==1) {
  render() Base();
} else if(part==2) {
  translate([0, 0, 7.3+ihc+ft]) rotate([180, 0, 0]) Deckel();
} else if(part==3) {
  render() difference() {
    union() {
      rotate([0, 0, dr]) Base();
      translate([0, 0, ft+ihb-7+0.1+dh]) Deckel();
    }
    translate([-dia, -dia-4, -1]) cube([2*dia, dia, ft+ihb+8+ihc+ft+dh]);
  }
}

