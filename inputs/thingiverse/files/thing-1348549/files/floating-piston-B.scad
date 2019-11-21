/* [PARAMETERS] */

cylinder_radius = 120;
cylinder_height = 150;
torus_thickness = 14;

/* [Hidden] */
$fn = 100;

difference() {
    cylinder(r = cylinder_radius, h = cylinder_height, center = true);
    translate([0, 0, 45])
        cubic_torus();
    translate([0, 0, -45])
        cubic_torus();
    translate([0, 0, 15])
        cubic_torus();
    translate([0, 0, -15])
        cubic_torus();
}   

function ngon(num, r) = [for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a) ]];
module torus(){
    rotate_extrude(convexity = 10)
        translate([cylinder_radius, 0, 0]) rotate([0, 0, 45])
            circle(r = 10);
  }
  module cubic_torus(){
    rotate_extrude(convexity = 10)
        translate([cylinder_radius, 0, 0]) rotate([0, 0, 45])
            polygon(ngon(4, torus_thickness));
  }