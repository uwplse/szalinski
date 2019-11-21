// -----------------------------------------------------
// Oral-B Zahnbuersten-Staender
//
//  Detlev Ahlgrimm, 11.2018
// -----------------------------------------------------

// number of slots
slots=4;      // [2:6]
// distance between slots
distance=30;  // [20:50]
// 
depth=25;     // [20:40]
height=40;    // [20:60]

// wall thickness
wt=1.6;     // [0.4:0.05:3]

/* [Hidden] */
$fn=100;
lro=7;                            // Loch-Radius oben
li=(slots-1)*distance+2*lro;      // Laenge innen ohne die Radien

// -----------------------------------------------------
//    v : Abmessungs-Vektor
//    r : Radius der Aussparungen
//    w : Wandstaerke zwischen den Aussparungen
//    i : invertieren (true:Sechseck-Umrandungen, false:Sechsecke)
//    a : anschraegen 45 Grad (bei true)
// -----------------------------------------------------
module HexPatternV2(v, r=10, w=1, i=true, a=false) {
  dx=r*1.5;
  dy=r*0.866025;      // 0.866025=sqrt(3)/2
  sy=(i) ? -0.1 : 0;
  az=(i) ? 0.2 : 0;
  r1=(a) ? r-w/2-(v.z+0.2) : r-w/2;

  intersection() {
    difference() {
      if(i) cube(v);
      for(yi=[0:1:v.y/dy+1]) {
        for(xi=[0:1:v.x/(2*dx)+1]) {
          if((yi%2)==1) {
            translate([xi*2*dx+dx, yi*dy, sy]) cylinder(r1=r1, r2=r-w/2, h=v.z+az, $fn=6);
          } else {
            translate([xi*2*dx, yi*dy, sy]) cylinder(r1=r1, r2=r-w/2, h=v.z+az, $fn=6);
          }
        }
      }
    }
    if(!i) cube(v);
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Base(r=20, h=30) {
  difference() {
    hull() {
      cylinder(r=r, h=h);
      translate([li, 0, 0]) cylinder(r=r, h=h);
    }
    translate([0, 0, -0.1]) hull() {
      cylinder(r=r-wt, h=h+0.2);
      translate([li, 0, 0]) cylinder(r=r-wt, h=h+0.2);
    }
  }
  intersection() {
    translate([-r, -r, 0]) HexPatternV2([li+2*r, r*2, wt], r=8, w=wt);
    hull() {
      cylinder(r=r, h=h);
      translate([li, 0, 0]) cylinder(r=r, h=h);
    }
  }  
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Staender(r=20, h=30) {
  difference() {
    union() {
      Base(r, h);
      for(i=[0:slots-1]) {
        difference() {    // die Sockel
          translate([lro+i*distance, -r+wt, h/2]) rotate([-90, 0, 0]) cylinder(r1=10, r2=7.5, 3);
          translate([lro+i*distance, -r+wt, h/2]) rotate([-90, 0, 0]) cylinder(r=7, 3.1);
          // Aussparung, um den Farbring erkennen zu koennen
          translate([lro+i*distance, -r+wt+3.1, h/2]) rotate([90, 0, 0]) linear_extrude(3.1) polygon([[-2,0], [2,0], [5,11], [-5,11]]);
          translate([lro+i*distance, -r+wt+3.1, h/2]) rotate([90, 180, 0]) linear_extrude(3.1) polygon([[-2,0], [2,0], [5,11], [-5,11]]);
        }
      }
    }
    for(i=[0:slots-1]) {  // die Loecher
      translate([lro+i*distance, r-wt-0.1, h/2]) rotate([-90, 0, 0]) cylinder(r=lro, wt+0.2);
      translate([lro+i*distance,   r-wt/2, h/2]) rotate([-90, 0, 0]) cylinder(r1=lro, r2=lro+1, wt/2+0.1);
      translate([lro+i*distance,   -r-0.1, h/2]) rotate([-90, 0, 0]) cylinder(r=3, wt+0.2);
      translate([lro+i*distance,  -r+wt/2, h/2]) rotate([-90, 0, 0]) cylinder(r1=3, r2=4, wt/2+0.1);
    }
  }
  // die Fuesse
  translate([   4, -r-2,   5]) rotate([-90, 0, 0]) cylinder(r1=2, r2=4, h=2);
  translate([   4, -r-2, h-5]) rotate([-90, 0, 0]) cylinder(r1=2, r2=4, h=2);
  translate([li-4, -r-2,   5]) rotate([-90, 0, 0]) cylinder(r1=2, r2=4, h=2);
  translate([li-4, -r-2, h-5]) rotate([-90, 0, 0]) cylinder(r1=2, r2=4, h=2);
}

if(li+height>180) {
  rotate([0, 0, -45]) translate([-li/2, 0, 0]) Staender(r=height/2, h=depth);
} else {
  Staender(r=height/2, h=depth);
}

