// -----------------------------------------------------
// Eier-Lager
//
//  Detlev Ahlgrimm, 12.12.2018
// -----------------------------------------------------

// area for a single egg [hd, hd]
hd=50;

// lower diameter
ed1=35;
// lower height
h1=10;

// upper diameter
ed2=48;
// upper height
h2=30;

// wall thickness
ws=0.8;

/* [Hidden] */
$fn=100;

// -----------------------------------------------------
// ein 2D-Trapez ([0,0] liegt mittig auf l1)
//  l1  : untere Laenge
//  l2  : obere Laenge
//  h   : Hoehe
// -----------------------------------------------------
module Trapez2D(l1, l2, h) {
  d=(l1-l2)/2;
  polygon([ [-l1/2,0], [-l1/2+d,h], [l1/2-d,h], [l1/2,0] ]);
}



if(ed1>ed2) { 
  text("error: ed1>ed2");
} else if(h2<5) {
  text("error: h2<5");
} else if((ed2+2*ws)>hd) {
  text("error: (ed2+2*ws)>hd");
} else if((ed2-ed1)/2>h2) {
  text("error: (ed2-ed1)/2>h2 ... degree <45!");
} else {
  difference() {
    union() {
      for(y=[0, hd]) {
        translate([0, y,  0]) cylinder(d1=ed2+2*ws, d2=ed1+2*ws, h=h2);
        translate([0, y, h2]) cylinder(d=ed1+2*ws, h=h1);
      }
      translate([-ws/2,        0,  0]) cube([ws, hd, h1+h2]);
      translate([-hd/2,    -hd/2,  0]) cube([hd, 2*hd, 5]);
      translate([ hd/2,  -hd/2+7,  0]) rotate([0, 0, -90]) linear_extrude(5) Trapez2D(4, 8, 4);
      translate([ hd/2, hd*1.5-7,  0]) rotate([0, 0, -90]) linear_extrude(5) Trapez2D(4, 8, 4);
      translate([-hd/2,  hd/2-5, 5/2]) rotate([-90, 0, 0]) cylinder(d=3, h=10);
    }
    for(y=[0, hd]) {
      translate([0, y,   -0.001]) cylinder(d1=ed2, d2=ed1, h=h2+0.002);
      translate([0, y, h2-0.001]) cylinder(d=ed1, h=h1+0.002);
    }
    translate([-hd/2-0.001,  -hd/2+7, -0.1]) rotate([0, 0, -90]) linear_extrude(5.2) Trapez2D(4.6, 8.4, 4.1);
    translate([-hd/2-0.001, hd*1.5-7, -0.1]) rotate([0, 0, -90]) linear_extrude(5.2) Trapez2D(4.6, 8.4, 4.1);
    translate([       hd/2,   hd/2-6,  5/2]) rotate([-90, 0, 0]) cylinder(d=3.6, h=12);
  }
}
