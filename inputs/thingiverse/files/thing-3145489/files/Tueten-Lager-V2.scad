// -----------------------------------------------------
// Tueten-Lager V2
//
//  Detlev Ahlgrimm, 10.2018
// -----------------------------------------------------

/* [main parameters] */

part=0;       // [0:assembled, 1:floor, 2:side north, 3:side south, 4:side east, 5:side west]

// inner width
xi=170;      // [20:200]

// inner length
yi=65;     // [20:200]

// inner height
zi=40;      // [20:150]

// wall thinckess
wt=2.0;     // [0:0.05:4]

// radius Hex
rs=11;      // [1:0.1:40]

// backlash
bl=0.3;     //  [0:0.05:1]


/* [Hidden] */
$fn=100;

// -----------------------------------------------------
//    x : Breite
//    y : Laenge
//    z : Hoehe
//    r : Radius der Aussparungen
//    w : Wandstaerke zwischen den Aussparungen
//    i : invertieren (true:Sechseck-Umrandungen, false:Sechsecke)
//    a : anschraegen (bei true)
// -----------------------------------------------------
module HexPattern(x, y, z, r=3, w=1, i=true, a=false) {
  h=r-(r/2*1.732);  // 1.732=sqrt(3)
  dx=3*r+2*w;
  dy=(r-h)+w;
  r1=(a) ? r-(z+0.2) : r;
  intersection() {
    difference() {
      if(i) cube([x, y, z]);
      for(yi=[0:1:y/dy+1]) {
        for(xi=[0:1:x/dx+1]) {
          if((yi%2)==1) {
            translate([xi*dx, yi*dy, -0.1]) cylinder(r1=r1, r2=r, h=z+0.2, $fn=6);
          } else {
            translate([xi*dx+dx/2, yi*dy, -0.1]) cylinder(r1=r1, r2=r, h=z+0.2, $fn=6);
          }
        }
      }
    }
    if(!i) cube([x, y, z]);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Wand(v, wt, rs=10) {
  difference() {
    cube([v.x+2*wt, v.y+2*wt, v.z]);
    translate([wt, wt, -0.1]) cube([v.x, v.y, v.z+0.2]);
  }
  translate([wt, wt, 0]) HexPattern(v.x, v.y, v.z, rs, wt/2);
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Boden() {
  difference() {
    union() {
      cube([xi+4*wt+2*bl, yi+4*wt+2*bl, wt]);
      translate([wt+bl, wt+bl, 0]) cube([xi+2*wt, yi+2*wt, 2*wt]);
    }
    translate([2*wt+bl, 2*wt+bl, -0.1]) cube([xi, yi, 2*wt+0.2]);
  }
  Wand([xi+2*wt+2*bl, yi+2*wt+2*bl, wt], wt, rs);
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module SeiteX() {
  translate([wt+bl, wt, wt+bl]) rotate([90, 0, 0]) Wand([xi, zi, wt], wt, rs);
  translate([xi+3*wt+bl, wt, wt+bl+zi+wt]) linear_extrude(wt) polygon([[0,0], [0,2], [-0.5,2], [-2.5,0]]);
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module SeiteY() {
  translate([wt, 0, wt+bl]) rotate([0, -90, 0]) Wand([zi, yi+2*wt+2*bl, wt], wt, rs);
  translate([wt, wt+bl, wt+bl+zi+wt]) linear_extrude(wt) polygon([[0,0], [2,0], [2,0.5], [0,2.5]]);
}

if(part==0) {
  Boden();
  SeiteX();
  translate([xi+4*wt+2*bl, yi+4*wt+2*bl, 0]) mirror([1, 0, 0]) mirror([0, 1, 0]) SeiteX();
  SeiteY();
  translate([xi+4*wt+2*bl, yi+4*wt+2*bl, 0]) mirror([1, 0, 0]) mirror([0, 1, 0]) SeiteY();
} else if(part==1) {
  Boden();
} else if(part==2) {
  rotate([-90, 0, 0]) mirror([1, 0, 0]) mirror([0, 1, 0]) SeiteX();
} else if(part==3) {
  rotate([90, 0, 0]) SeiteX();
} else if(part==4) {
  rotate([0, -90, 0]) SeiteY();
} else if(part==5) {
  rotate([0, 90, 0]) mirror([1, 0, 0]) mirror([0, 1, 0]) SeiteY();
}
