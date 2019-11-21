$fa = 1;
$fs = 0.05;

d_screw = 4.5; // diameter of screw
r1      = 4;   // radius of corners,  1/2 thickness 
d1      = 52;  // depth of hook
w       = 100; // outer width of hook

d2      = d1 * 0.7; // inner hook depth.
h       = d1 + r1 * 8;

h2  = d1-d2;
r2 = (pow(d1 - 1.5*r1,2) + pow(h2,2)) / (2 * h2) ;  // radius of hook

module 2d_back() {
  hull() {
    circle(r1);
    translate([0,h]) circle(r1);
  }
}

module 2d_hook_bottom() {
  difference() {
    hull() {
      circle(r1);
      translate([d1,d1]) circle(r1);
      translate([0,d2])  circle(r1);
    }

    translate([0,r2 + d2]) circle(r2);
  }
}

module 2d_hook() {
  difference() {
    offset(-r1) offset(r1) {
      2d_hook_bottom();
      2d_back();
    }
    offset(r1/4) offset(-r1*2 -r1/4) 2d_hook_bottom();
  }
}


module object() {
  intersection() {
    difference() {
      rotate([90,0,0])
      translate([0,0,-w/2])
      linear_extrude(w, convexity=10) 2d_hook(); 

      translate([d1 + r1,0,-r1*2 - 1]) resize([d1*1.999,w-r1*4,d1*2 + r1*4 + 2]) cylinder();
    }

    translate([d1 + r1,0,-r1*2 - 1]) resize([d1*3,w,d1*2 + r1*4 + 2]) cylinder();
  }
}

module hook() {
  sz = (h - (h-d1)/2);
  sy = w/2 * 0.375;
  difference() {
  object();
    for(p = [[0,sy,sz],[0,-sy,sz]]) {
      translate(p) {
        rotate([0,-90,0])
        translate([0,0,-r1*2.1/2])
        union() {
          cylinder(d=d_screw, h=r1*2.1);
          cylinder(d1=d_screw*2, d2=d_screw, h=d_screw);
        }
      }
    }
  }
}

rotate([0,-90,0]) hook();
