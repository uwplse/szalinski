// -----------------------------------------------------
// Auto-Smartphone-Halterung
//
//  Detlev Ahlgrimm, 13.05.2019
// -----------------------------------------------------

sp_x=83;    // [60:100]
sp_y=16;    // [10:20]
sp_z=100;   // [50:150]
ws=1.5;     // [0.5:0.01:3]

bottom_opening=0;   // [0:false, 1:true]

/* [Hidden] */
$fn=100;

//innen=[83, 16, 100];
innen=[sp_x, sp_y, sp_z];

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

rotate([90, 0, 0])
difference() {
  union() {
    cubeR([innen.x+2*ws, innen.y+2*ws, innen.z+ws], 5);
    translate([ws+10, 0, innen.z+ws]) rotate([-90, 0, 0]) cylinder(r=5, h=ws);
    translate([ws+innen.x-10, 0, innen.z+ws]) rotate([-90, 0, 0]) cylinder(r=5, h=ws);
  }
  translate([ws, ws, ws]) cubeR([innen.x, innen.y, innen.z+5*ws], 5);
  translate([ws+10, -0.1, innen.z+ws]) rotate([-90, 0, 0]) cylinder(r=2, h=2*ws);
  translate([ws+innen.x-10, -0.1, innen.z+ws]) rotate([-90, 0, 0]) cylinder(r=2, h=2*ws);
  hull() {
    translate([ws+10, innen.y, 10]) rotate([-90, 0, 0]) cylinder(r=5, h=2*ws);
    translate([innen.x+ws-10, innen.y, 10]) rotate([-90, 0, 0]) cylinder(r=5, h=2*ws);
    translate([ws+10, innen.y, innen.z+10]) rotate([-90, 0, 0]) cylinder(r=5, h=2*ws);
    translate([innen.x+ws-10, innen.y, innen.z+10]) rotate([-90, 0, 0]) cylinder(r=5, h=2*ws);
  }
  for(x=[10: (innen.x-20)/5: innen.x-10]) {
    //echo(x);
    translate([x, 0, 0]) hull() {
      translate([ws, -0.1, 10]) rotate([-90, 0, 0]) cylinder(r=3, h=2*ws);
      translate([ws, -0.1, innen.z-10]) rotate([-90, 0, 0]) cylinder(r=3, h=2*ws);
    }
  }
  if(bottom_opening) {
    translate([ws+innen.x/2-8, ws, -0.1]) cube([16, (innen.y+ws)-3, 2*ws+3]);
  }
}
