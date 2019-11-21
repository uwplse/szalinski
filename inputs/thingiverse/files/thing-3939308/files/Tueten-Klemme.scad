// -----------------------------------------------------
// Tueten-Klemme
//
//  Detlev Ahlgrimm, 26.10.2019
// -----------------------------------------------------

// length
kl=70;  // [20:200]

// width
kb=10;  // [8:15]

// height
kh=10;  // [6:15]

a=-45;  // [-45:0]

/* [Hidden] */
$fn=100;


// -----------------------------------------------------
//  wie cube() - nur abgerundet gemaess "r"
// -----------------------------------------------------
module cubeR(v, r=1) {
  //assert(r<=v.x/2 && r<=v.y/2 && r<=v.z/2);   // Requires version "nightly build"
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
*!cubeR([10, kb+1, kh], 2);
module cubeRspezial(v, r=1) {
  hull() {
    cube([v.x/2, v.y, v.z]);
    translate([0, v.y-0.1, 0]) cube([v.x, 0.1, v.z]);
    translate([v.x,     r,     r]) sphere(r=r);
    translate([v.x,     r, v.z-r]) sphere(r=r);
  }
}
*cubeRspezial([10, kb+1, kh], 2);

// -----------------------------------------------------
//
// -----------------------------------------------------
module Gelenk1(r=5, h=10, ws=1.6) {
  intersection() {
    difference() {
      union() {
        cylinder(r=r, h=h);
        translate([0, 0, 0]) cube([r+2, r, h]);
      }
      translate([0, 0, -0.1]) cylinder(r1=r-ws+0.5, r2=r-ws, h=0.61);
      translate([0, 0, 0.5]) cylinder(r=r-ws, h=h);
      translate([-r, -r, ws]) cube([2*r, r, h-2*ws]);
    }
    *translate([-10, -kb/2-1, 0]) cubeR([kl, kb+1, kh], 2);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Gelenk2(r=5, h=10, ws=1.6) {
  intersection() {
    difference() {
      union() {
        cylinder(r1=r-ws-1, r2=r-ws-0.4, h=0.5);  // fetten ersten Layer abfangen
        translate([0, 0, 0.5]) cylinder(r=r-ws-0.4, h=h-0.5);
        translate([0, -r-1, ws+0.4]) cube([r-ws-0.4, r+1, h-2*ws-0.8]);
        rotate([0, 0, 35]) translate([-(r-ws-0.4)/2, -r-1, ws+0.5]) cube([r-ws-0.4, r+1, h-2*ws-1]);
        rotate([0, 0, 60]) translate([-(r-ws-0.4)/2, -r-1, ws+0.5]) cube([r-ws-0.4, r+1, h-2*ws-1]);
        difference() {
          translate([0, -r-1, 0]) cube([r+2, r, h]);
          *translate([0, -r-1, 0]) cubeRspezial([r+2, r, h], 2);
          translate([0, 0, -0.1]) cylinder(r1=r+1, r2=r+0.5, h=0.7);
          translate([0, 0, 0.5]) cylinder(r=r+0.5, h=h-0.49);
        }
      }
      translate([0, 0, 0.75]) cylinder(r=0.7, h=h-1.5);  // eine "Innenwand" zur Verstaerkung
    }
    *translate([-10, -kb/2-1, 0]) cubeR([kl, kb+1, kh], 2);
  }
}
*Gelenk2();

// -----------------------------------------------------
//
// -----------------------------------------------------
module Gelenk(r=5, h=10, ws=1.6) {
  Gelenk1(r, h, ws);
  rotate([0, 0, a]) Gelenk2(r, h, ws);
}
*!difference() {
  Gelenk(r=kb/2, h=kh);
  translate([-20, -20, kh/2]) cube([40, 40, kh]);
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module konvex() {
  translate([kb/2+0.5, -kb/2-1, 0]) union() {
    difference() {
      //cubeR([kl, kb+1, kh], 2);
      cube([kl, kb+1, kh]);
      translate([-0.1, -0.1, -0.1]) cube([kl+0.2, 0.1+kb/2+1, kh+0.2]);
      translate([kl-2.1, kb+1-2.2, 1.7]) cube([2.2, 2.3, kh-3.4]);
    }
    translate([4, kb/2+1, kh/2]) rotate([0, 90, 0]) linear_extrude(kl-8) offset(0.1) polygon([ [kh/4,0], [-kh/4,0], [0,-kh/4] ]);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Sperre() {
  difference() {
    linear_extrude(kh-4) polygon([ [0,0], [-1,0], [-1,0.5], [0,2] ]);
    translate([0, 2.5, -0.1]) rotate([90, 0, 0]) linear_extrude(3) polygon([ [-4,4], [-4,0], [0.1,0] ]);
    translate([0, -0.5, kh-4+0.1]) rotate([-90, 0, 0]) linear_extrude(3) polygon([ [-4,4], [-4,0], [0.1,0] ]);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module konkav() {
  translate([kb/2+0.5, -kb/2-1, 0]) difference() {
    //cubeR([kl+2, kb+1, kh], 2);
    cube([kl+2, kb+1, kh]);
    translate([-0.1, kb/2, -0.1]) cube([kl+0.3, kb/2+1.1, kh+0.2]);
    translate([3, kb/2, kh/2]) rotate([0, 90, 0]) linear_extrude(kl-6) offset(0.1) polygon([ [kh/4,0], [-kh/4,0], [0,-kh/4] ]);
    translate([kl+0.2-1, 2, -0.1]) cube([1, kb/2, kh+0.2]);
  }
  translate([kb/2+0.5+kl+0.21, kb/2-2, 2]) Sperre();
}

Gelenk(r=kb/2, h=kh);
konvex();
rotate([0, 0, a]) konkav();

