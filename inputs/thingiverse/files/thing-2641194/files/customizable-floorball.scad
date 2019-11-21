// Customizable floorball key fob
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// licensed under the Creative Commons - Attribution license. 
//
// First revision: November 12, 2017
// Second revision: November 13, 2017 Fixes in upper_half(), didn't look right for big radius

radius = 12;     // [10:36]
thickness = 1.2; // [1.0:0.1:2.0]
r_hole= 11/72*radius;

translate([radius+1,0])
  upper_half();
translate([-radius-1,0])
  lower_half();

module upper_half() {
  r_outer = r_hole+thickness;
  eps = 0.01;
  
  half_a_floorball();
  translate([0,0,radius-thickness]) {
    difference() {
      union() {
        translate([-r_outer, -r_hole])
          cube([2*r_outer, 2*r_hole, r_outer]);
        translate([0, 0, r_outer])
          rotate([90, 0])
            cylinder(r=r_outer, h=2*r_hole, center=true, $fn=24);
      }
      translate([0,-eps,r_outer])
        rotate([90,0])
          cylinder(r=r_hole, h=2*r_hole+2*eps, center=true, $fn=24);
    }
  }
}

module lower_half() {
  difference() {
    half_a_floorball();
    cylinder(r=r_hole, h=radius, $fn=24);
  }
}

module half_a_floorball() {
  difference() {
    half_sphere();
    
    for (a=[45:90:315])
      rotate([0, 0, a]) rotate([0, 33, 0])
        cylinder(r=r_hole, h=radius, $fn=24);
    for (a=[0:90:270])
      rotate([0, 0, a]) rotate([0, 57, 0])
        cylinder(r=r_hole, h=radius, $fn=24);
    for (a=[45:90:315])
      rotate([0, 0, a]) rotate([0, 76, 0])
        cylinder(r=r_hole, h=radius, $fn=24);
  }
}

module half_sphere() {
  difference() {
    sphere(r=radius, $fn=60);
    
    translate([-radius, -radius, -radius])
      cube([2*radius, 2*radius, radius]);
    
    sphere(r=radius-thickness);
  }
  
  difference() {
    cylinder(r=radius, h=0.8);
    cylinder(r=radius-2*thickness, h=0.8);
  }
}