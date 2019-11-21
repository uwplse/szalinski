// -----------------------------------------------------
// Bit-Halterung
//
//  Detlev Ahlgrimm, 29.11.2018
// -----------------------------------------------------

// what to render
part=1;     // [0:debug, 1:base, 2:cap, 3:cut-debug]

// inner diameter
dia=95;    // [25:180]

// distance between bits
rb=5;       // [1:0.1:10]

// floor thickness (base+cap)
ft=1;       // [0.5:0.1:5]

// cover wall thickness
cwt=1.5;    // [1:0.05:4]

// debug rotate
dr=0;       // [0:120]
// debug height cap
dh=0;       // [0:20]

/* [Hidden] */
$fn=100;
db=8.1;   // Durchmesser eines Bits (inkl. Spiel)
hb=26;    // Hoehe eines Bits (inkl. Spiel)


// -----------------------------------------------------
//  Liefert true, wenn der Kreis mit dem Radius ri an
//  den Koordinaten [x,y] in dem Kreis mit dem Radius
//  ra liegt.
// -----------------------------------------------------
function KreisInKreis(x, y, ri, ra) = sqrt(x*x + y*y)+ri < ra;


// -----------------------------------------------------
//    v : Abmessungs-Vektor
//    r : Radius der Aussparungen
//    w : Wandstaerke zwischen den Aussparungen
//    i : invertieren (true:Sechseck-Umrandungen, false:Sechsecke)
//    a : anschraegen 45 Grad (bei true)
//   cd : Aussparung muss vollstaendig innerhalb Kreis-Durchmesser cd liegen
// -----------------------------------------------------
module HexPatternV2centered(v, r=10, w=1, i=true, a=false, cd=0) {
  dx=r*1.5;
  dy=r*0.866025;      // 0.866025=sqrt(3)/2
  sy=(i) ? -0.1 : 0;
  az=(i) ? 0.2 : 0;
  r1=(a) ? r-w/2-(v.z+0.2) : r-w/2;

  intersection() {
    difference() {
      if(i) translate([-v.x/2, -v.y/2, 0]) cube(v);
      for(yi=[-floor((v.y/dy+1)/2) : 1 : (v.y/dy+1)/2]) {
        for(xi=[-floor((v.x/(2*dx)+1)/2) : 1 : (v.x/(2*dx)+1)/2]) {
          if(cd==0 || KreisInKreis(xi*2*dx+(yi%2)*dx, yi*dy, r, cd/2)) {
            translate([xi*2*dx+(yi%2)*dx, yi*dy, sy]) cylinder(r1=r1, r2=r-w/2, h=v.z+az, $fn=6);
          }
        }
      }
    }
    if(!i) translate([-v.x/2, -v.y/2, 0]) cube(v);
  }
}


// -----------------------------------------------------
//  r : Radius
//  h : Hoehe (>=2)
// -----------------------------------------------------
module AngefasterCylinder(r, h) {
  hull() rotate_extrude() translate([r, 0, 0]) polygon([ [-1,0], [0,1], [0,h-1], [-1,h] ]);
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Base() {
  difference() {
    union() {
      AngefasterCylinder(r=(dia+6)/2+cwt+2, h=3);
      AngefasterCylinder(r=(dia+6)/2, h=ft+10);
    }
    translate([0, 0, ft]) HexPatternV2centered([dia, dia, 10.2], cd=dia, r=(db+rb)/2, w=rb, i=false);
    translate([0, 0, 3]) BajonettSchneider();
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module BajonettSchneider() {
  difference() {
    rotate_extrude() translate([(dia+6)/2, 0, 2]) polygon([ [0.01,0], [-2,0], [-2,3], [0.01,5] ]);
    for(a=[0:120:359]) rotate([0, 0, a]) {
      translate([0, 0, -0.1]) cube([(dia+6)/2+0.1, 8, 7.2]);
      difference() {
        translate([(dia+6)/4, 2, -0.1]) cylinder(r=(dia+6)/4, h=5.2);
        translate([0, -(dia+6)/4, -0.2]) cube([(dia+6)/2, (dia+6)/4, 5.4]);
      }
    }
  }
  for(a=[0:120:359]) rotate([0, 0, a])
    translate([0, 0, 3]) intersection() {
      difference() {
        cylinder(d=dia+6.1, h=ft+6);
        translate([0, 0, -0.1]) cylinder(d=dia+6-4, h=ft+6.2);
      }
      translate([0, -9, -0.1]) cube([(dia+6.1)/2+0.2, 9, ft+6.2]);
    }
}
//!BajonettSchneider();


// -----------------------------------------------------
//
// -----------------------------------------------------
module Deckel() {
  difference() {
    union() {
      cylinder(d=dia+6+0.6+2*cwt, h=ft+hb-3);
      translate([0, 0, ft+hb-3]) cylinder(d1=dia+6+0.6+2*cwt, d2=dia+6+0.6+2*cwt-2*ft, h=ft);
    }
    translate([0, 0, -0.1]) cylinder(d=dia+6+0.6, h=ft+hb-3);
  }
  intersection() {
    translate([0, 0, 0]) rotate_extrude() translate([(dia+6+0.6)/2, 0, 0]) polygon([ [0.1,0], [-2,0], [-2,3], [0.1,5] ]);
    for(a=[0:120:359]) rotate([0, 0, a])
      translate([0, -8, -0.1]) cube([(dia+6+0.6+0.2)/2, 7, 7.2]);
  }
  translate([0, 0, ft+hb-3]) rotate_extrude() translate([(dia+6+0.6)/2, 0, 0]) polygon([ [0.1,0], [0.1,-ft], [-ft,0] ]);
}



if(part==0) {
  render() Base();
  translate([0, 0, 3.1+dh]) rotate([0, 0, -dr]) Deckel();
} else if(part==1) {
  render() Base();
} else if(part==2) {
  translate([0, 0, hb+2*ft]) rotate([180, 0, 0]) Deckel();
} else if(part==3) {
  render() difference() {
    union() {
      rotate([0, 0, dr]) Base();
      translate([0, 0, 3.1+dh]) Deckel();
      %translate([0, 0, ft+0.1]) cylinder(d=db, h=hb-0.2);
    }
    translate([-dia, -dia-4, -1]) cube([2*dia, dia, 40]);
  }
}
