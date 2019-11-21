// -----------------------------------------------------
// Rueckenkratzer / Back scratcher
//
//  Detlev Ahlgrimm, 05.2018
// -----------------------------------------------------

// height of the back scratcher
height=50;  // [25:5:100]

// radius of the back scratcher
radius=25;  // [15:5:50]

// diameter of the wooden rod
rod=15;     // [10:25]


/* [Hidden] */
$fn=100;

// -----------------------------------------------------
//  Eine quadratische Pyramide mit 45 Grad Winkel
//
//  s : Vergroesserungsfaktor bzgl. 2*2*1mm
// -----------------------------------------------------
module Pyramide(s=1) {
  scale([s,s,s])
  polyhedron([[-1,-1,0], [1,-1,0], [1,1,0], [-1,1,0], [0,0,1]], 
             [[3,4,2], [2,4,1], [0,1,4], [4,3,0], [0,3,2,1]], convexity=10);
}
//!Pyramide(2.5);

// -----------------------------------------------------
//  Eine Flaeche aus Pyramiden
//
//  xc  : Anzahl Pyramiden auf der X-Achse
//  yc  : Anzahl Pyramiden auf der Y-Achse
//  s   : Vergroesserungsfaktor fuer die Pyramide
// -----------------------------------------------------
module PyramidenFlaeche(xc, yc, s=1) {
  for(y=[0:yc-1]) {
    for(x=[0:xc-1]) {
      translate([s+x*2*s, s+y*2*s, 0]) Pyramide(s);
    }
  }
}
//!rotate([90, 0, 0]) PyramidenFlaeche(5, 10, 2);

// -----------------------------------------------------
//
// -----------------------------------------------------
module Backscratcher(r=25) {
  np=height/5;
  ha=height;
  hi=ha-5;
  for(a=[0:60:360]) {
    x=sin(a)*r;
    y=cos(a)*r;
    translate([x, y, 0]) rotate([0, 0, -a-60/2])
      translate([0, 0, ha]) rotate([-90, 0, 0]) union() {
        PyramidenFlaeche(radius/5, np, 2.5);
        translate([0, 0, -3]) cube([r, ha, 3.01]);
      }
    xr=sin(a)*(r-3/2);
    yr=cos(a)*(r-3/2);
    translate([xr, yr, ha]) rotate([0, 0, -a-60/2]) rotate([0, 90, 0]) cylinder(r=3/2+0.5, h=r-3/2);
    translate([xr, yr, ha]) sphere(r=3/2+0.5);
  }
  difference() {
    union() {
      cylinder(d=rod+6, h=hi);
      for(a=[0:60:360]) {
        rotate([0, 0, -a-60/2]) translate([0, -3/2, 0]) cube([r-2, 3, hi]);
      }
    }
    translate([0, 0, -0.1]) cylinder(d=rod, h=hi-10);
    translate([0, 0, hi-10.2]) cylinder(d1=rod, d2=4, h=10.3);
  }
}

module LaengsSchnittDebug() {
  difference() {
    Backscratcher(25);
    translate([-30, -30, -1]) cube([60, 30, 60]);
  }
}
//!LaengsSchnittDebug();

Backscratcher(radius);
