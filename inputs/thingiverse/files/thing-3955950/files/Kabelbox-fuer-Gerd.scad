// -----------------------------------------------------
// Kabelbox fuer Gerd
//
//  Detlev Ahlgrimm, 26.10.2019
// -----------------------------------------------------

// inner width
x=150;    // [50:200]

// inner depth
y=100;    // [50:200]

// inner height
z=50;     // [20:150]

// wall thickness
ws=1.2;   // [1.0:0.05:4]

// radius hex
hexr=12;  // [5:20]

// diameter cable feed
cfd=30;   // [10:40]

/* [Hidden] */
$fn=100;
//s=[150, 100, 50];
s=[x, y, z];

// -----------------------------------------------------
//  wie cube() - nur abgerundet gemaess "r"
// -----------------------------------------------------
module cubeR(v, r=1) {
  assert(r<=v.x/2 && r<=v.y/2 && r<=v.z/2);   // Requires version "nightly build"
  hull() {
    translate([    r,     r,     r]) sphere(r=r);
    translate([v.x-r,     r,     r]) sphere(r=r);
    translate([    r, v.y-r,     r]) sphere(r=r);
    translate([v.x-r, v.y-r,     r]) sphere(r=r);

    translate([    r,     r, v.z-r]) sphere(r=r);
    translate([v.x-r,     r, v.z-r]) sphere(r=r);
    translate([    r, v.y-r, v.z-r]) sphere(r=r);
    translate([v.x-r, v.y-r, v.z-r]) sphere(r=r);
  }
}

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

module theThing() {
  difference() {
    union() {
      difference() {
          cubeR([s.x+2*ws, s.y+ws+3, s.z+ws+3], 3);
          translate([-0.1, -0.1, s.z+ws]) cube([s.x+2*ws+1, s.y+2*ws+3, 10]);
          translate([ws, ws, ws]) cube([s.x, s.y+ws+3.1, s.z+0.1]);
          translate([5, 5, -0.1]) HexPatternV2([s.x+2*ws-2*5, s.y+ws-2*5, ws+0.2], r=hexr, w=3, i=false);
      }
      translate([s.x/2+ws, s.y, 0]) cylinder(d=cfd+10, 2*ws);
    }
    translate([s.x/2+ws, s.y, -0.2]) cylinder(d=cfd, 2*ws+0.4);
    translate([-0.1, s.y+ws, -0.2]) cube([s.x+2*ws+0.2, cfd, s.z+ws+0.3]);
  }
  for (i = [0, 1]) {
      translate([i*(s.x+2*ws), 0, ws]) mirror([i, 0, 0])
      difference() {
          translate([0, s.y/2-5, s.z]) rotate([0, 90, 90]) linear_extrude(10) polygon([ [0,0], [0,15], [15,0] ]);
          translate([-20, s.y/2-5+ws, s.z-20]) cube([20-ws, 10-2*ws, 20-2*ws]);
          translate([-7, s.y/2, s.z-2*ws+0.25]) cylinder(d=4, 20);
      }
  }
  translate([s.x/2+ws-10/2, ws, 0]) rotate([0, 0, -90]) translate([0, -(s.y/2-5), ws]) difference() {
      translate([0, s.y/2-5, s.z]) rotate([0, 90, 90]) linear_extrude(10) polygon([ [0,0], [0,15], [15,0] ]);
      translate([-20, s.y/2-5+ws, s.z-20]) cube([20-ws, 10-2*ws, 20-2*ws]);
      translate([-7, s.y/2, s.z-2*ws+0.25]) cylinder(d=4, 20);
  }
  intersection() {
    union() {
      translate([3, 3, ws]) cylinder(r=3, h=s.z);
      translate([s.x+2*ws-3, 3, ws]) cylinder(r=3, h=s.z);
      translate([ws, s.y+ws-3, ws]) cube([3, 3, s.z]);
      translate([s.x+ws-3, s.y+ws-3, ws]) cube([3, 3, s.z]);
      
      translate([0, s.y+ws-3, 0]) cube([s.x/2-cfd/2, 3, 2*ws]);
      translate([s.x/2+ws+cfd/2, s.y+ws-3, 0]) cube([s.x/2-cfd/2, 3, 2*ws]);
      
      translate([ws, s.y/2, ws]) cylinder(r=3, h=s.z);
      translate([s.x+ws, s.y/2, ws]) cylinder(r=3, h=s.z);
    }
    cubeR([s.x+2*ws, s.y+ws+3, s.z+ws+3], 3);
  }
}

rotate([0, 0, 180]) // drehen fuer die Thingiverse-Preview
theThing();
