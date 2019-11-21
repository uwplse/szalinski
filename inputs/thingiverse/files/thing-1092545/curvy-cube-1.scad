curvetype = 1; // [1, 2, 3]
size = 50;
// Wall thickness, between inside and outside of cube.  Only relevant for Hollow style
thickness = 5;
// Adds thickness to walls portion that would be 0 width.  Only used for Curve Type 3
MinWall = 3;
solid = 0; // [1:Solid, 0:Hollow]
detail = 100;

module CurvyCube() {
  $fn = detail;
  translate([0,0,size/2]) {
    difference() {
      intersection() {
        difference() {
          union() {
            difference() {
              cube(size=size*1.5, center=true);
              rotate([0,0,45]) rotate([atan(2/sqrt(2)),0,0]) translate([0,0,size*4]) cube(size=size*8, center=true);
            }
            rotate([0,-90,0]) cylinder(h=size*2, r1=0,r2=size*2);
            rotate([-90,0,0]) cylinder(h=size*2, r1=0,r2=size*2);
            rotate([0,180,0]) cylinder(h=size*2, r1=0,r2=size*2);
          }
          rotate([0,0,0]) cylinder(h=size*2, r1=0,r2=size*2);
          rotate([90,0,0]) cylinder(h=size*2, r1=0,r2=size*2);
          rotate([0,90,0]) cylinder(h=size*2, r1=0,r2=size*2);
        }
      cube(size=size, center=true);
      }
    if (!solid) cube(size=size-thickness*2, center=true);
    }
  }
}

module dualRadiusCone(d, thick, angle) {
  r = d/2;
  $fn = detail;
  s = (r - thick) / r;
  err = 0.01; // avoid coincident faces
  rotate([0,0,angle]) 
    union() {  
      intersection() {
        cylinder(h=r+err, r1=0,r2=r+err);
        rotate([0,0,0]) translate([-err,-err,err]) cube(size=r*2);
      }
      scale([1,s,1]) intersection () { 
        cylinder(h=r+err, r1=0,r2=r+err);
        rotate([0,0,270]) translate([-err,-err,err]) cube(size=r*2);
      }
      scale([s,s,1]) intersection() {
        cylinder(h=r+err, r1=0,r2=r+err);
        rotate([0,0,180]) translate([-err,-err,err]) cube(size=r*2);
      }
      scale([s,1,1]) intersection () { 
        cylinder(h=r+err, r1=0,r2=r+err);
        rotate([0,0,90]) translate([-err,-err,err]) cube(size=r*2);
      }
    }  
}

module CurvyCube3() {
  $fn = detail;
  err = 0.001;
  translate([0,0,size/2]) rotate([0,0,0]){
    difference() {
      intersection() {
        cube(size=size, center=true);
        union() {
          difference() {
            cube(size=size*1.5, center=true);
            rotate([0,0,45]) rotate([atan(2/sqrt(2)),0,0]) translate([0,0,size*4]) cube(size=size*8, center=true);
            rotate([0,-90,0]) dualRadiusCone(size, MinWall, -90);
            rotate([-90,0,0]) dualRadiusCone(size, MinWall, -90);
            rotate([0,180,0]) dualRadiusCone(size, MinWall, 180);
          }
          rotate([0,0,0]) dualRadiusCone(size, MinWall, 90);
          rotate([90,0,0]) dualRadiusCone(size, MinWall, 180);
          rotate([0,90,0]) dualRadiusCone(size, MinWall, 0);
        }
      }
      if (!solid) cube(size=size-thickness*2, center=true);
    }
  }
}

module CurvyCube2() {
  $fn = detail;
  translate([0,0,size/2]) {
    difference() {
      difference() { 
        cube(size=size, center=true);
        rotate([0,90,0]) cylinder(h=size*2, r1=0,r2=size*2);
        rotate([0,-90,0]) cylinder(h=size*2, r1=0,r2=size*2);
      }
      difference() {
        translate([-size, -size, 0]) cube(size=size*2);
        rotate([90,0,0]) cylinder(h=size*2, r1=0,r2=size*2);
        rotate([-90,0,0]) cylinder(h=size*2, r1=0,r2=size*2);
      }
      if (!solid) cube(size-thickness*2, size-thickness*2, size-thickness*2, center=true);
    }
  }
}

if (curvetype == 1) {
  color("DeepSkyBlue", 1) CurvyCube();
  //color("orange", 1) translate([10,-10,size+10]) rotate([180,0,0]) rotate([0,0,-90])  CurvyCube();
} else if (curvetype == 2) {
  color("Red", 1) CurvyCube2();
  //color("silver", 1) translate([0.01,0.01,size*1.75]) rotate([180,0,0]) rotate([0,0,-90]) CurvyCube2();
} else if (curvetype == 3) {
  color("lime", 1) CurvyCube3();
  //color("magenta", 1) translate([size,-size,size*1.75]) rotate([180,0,0]) rotate([0,0,-90]) CurvyCube3();
}
