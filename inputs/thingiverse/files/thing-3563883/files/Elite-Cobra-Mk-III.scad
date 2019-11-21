// -----------------------------------------------------
//  Elite Cobra Mk III
//
//  Detlev Ahlgrimm, 14.04.2019
// -----------------------------------------------------

part=2;           // [0:Cobra Mk II, 1:Socket, 2:Cobra Mk II on Socket]
radius=1.5;       // [1.5:0.05:3]
height_socket=30; // [25:100]
angle_socket=10;  // [0:30]
full_brackets=1;  // [0:False, 1:True]

/* [Hidden] */
$fn=6;

//%translate([0, 0, 29]) import("/home/dede/thingiverse/cobra3_modded250_1800470.stl");

// -----------------------------------------------------
//  r : Radius der Stangen
//  w : Breite der Halte-Streben
// -----------------------------------------------------
module CobraMk3(r=radius, w=0.5) {
  hh=r*sqrt(3)/2;
  vect= [ [0, 17.8, r], [60, 11.1, r], [88, -5.5, r], [22, -16.5, r], [-22, -16.5, r], [-88, -5.5, r], [-60, 11.1, r],    // Heck aussen
          [10, -9.5, r], [10, 9.5, r], [34.5, 5.2, r], [34.5, -5.2, r],       // Triebwerk rechts
          [-10, -9.5, r], [-10, 9.5, r], [-34.5, 5.2, r], [-34.5, -5.2, r],   // Triebwerk links
          [62, -4.7, r], [62, 3.3, r], [72, -2.5, r],                         // Steuerduese rechts
          [-62, -4.7, r], [-62, 3.3, r], [-72, -2.5, r],                      // Steuerduese links
          [82, -2, 24], [-82, -2, 24],                                        // zweite Ebene
          [0, 17.8, 45],                                                      // dritte Ebene
          [22, 0, 81], [-22, 0, 81],                                          // Front
          [0, 0, 81], [0, 0, 95]                                              // Laser
        ];
  lins= [ [0,1], [1,2], [2,3], [3,4], [4,5], [5,6], [6,0],
          [7,8], [8,9], [9,10], [10,7],
          [11,12], [12,13], [13,14], [14,11],
          [15,16], [16,17], [17,15],
          [18,19], [19,20], [20,18],
          [21,2], [21,1],
          [22,5], [22,6],
          [23,0], [23,1], [23,6],
          [24,23], [24,1], [24,3], [24,21],
          [25,23], [25,4], [25,6], [25,22],
          [24,25],
          [26,27]
        ];

  *!for(i=vect) {
    translate(i) sphere(r=r);
  }

  for(i=lins) {
    hull() {
      translate(vect[i[0]]) sphere(r=r);
      translate(vect[i[1]]) sphere(r=r);
    }
  }

  for(m=[0, 1]) mirror([m, 0, 0]) {
    translate([-10-w/2, -9.5-6.5, r-hh]) cube([w, 6.5, 2*hh]);    // Halterung Triebwerk links
    if(full_brackets) translate([-34.5-w/2, -5.2-9, r-hh]) cube([w, 9, 2*hh]);
    translate([-10-w/2, 9.5, r-hh]) cube([w, 6.5, 2*hh]);
    if(full_brackets) translate([-34.5-w/2, 5.2, r-hh]) cube([w, 9, 2*hh]);

    translate([-62-w/2, -4.7-5, r-hh]) cube([w, 5, 2*hh]);      // Halterung Steuerduese links
    translate([-62-w/2, 3.3, r-hh]) cube([w, 7, 2*hh]);
    if(full_brackets) translate([-72-10, -2.5-w/2, r-hh]) cube([10, w, 2*hh]);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Sockel() {
  r=radius+0.4;
  a=atan(16.7/81);
  y=20;

  translate([0, 0, height_socket]) difference() {
    union() {
      hull() {
        sphere(d=2*r+4, $fn=20);
        translate([0, 10, -height_socket+10]) sphere(d=2*r+4, $fn=20);
      }
      hull() {
        rotate([a+angle_socket, 0, 0]) translate([-22, y, 0]) sphere(d=2*r+4, $fn=20);
        translate([0, 10, -height_socket+10]) sphere(d=2*r+4, $fn=20);
      }
      hull() {
        rotate([a+angle_socket, 0, 0]) translate([ 22, y, 0]) sphere(d=2*r+4, $fn=20);
        translate([0, 10, -height_socket+10]) sphere(d=2*r+4, $fn=20);
      }
      translate([0, 10, -height_socket]) cylinder(d=2*r+4, h=10, $fn=20);
      translate([0, 10, -height_socket]) cylinder(d1=30, d2=27, h=3);
    }
    translate([-30, -r, 0]) cube([60, 2*r, 3*r]);
    rotate([a+angle_socket, 0, 0]) translate([-22-r, 0, 0]) cube([2*r, 60, 3*r]);
    rotate([a+angle_socket, 0, 0]) translate([ 22-r, 0, 0]) cube([2*r, 60, 3*r]);
  }
}

if(part==0) {
  CobraMk3();
} else if(part==1) {
  Sockel();
} else {
  Sockel();
  translate([0, 0, height_socket]) rotate([90-angle_socket, 0, 180]) translate([0, 16.5, -radius]) CobraMk3();
}
