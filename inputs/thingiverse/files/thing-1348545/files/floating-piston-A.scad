/* [PARAMETERS] */

cylinder_radius = 120;
cylinder_height = 150;
torus_radius = 10;
rings_separation = 80;

/* [Hidden] */
$fn = 100;

difference() {
    cylinder(r = cylinder_radius, h = cylinder_height, center = true);
    translate([0, 0, 40])
        torus(); 
    translate([0, 0, -40])
        torus(); 
    }   
module torus(){
    rotate_extrude(convexity = 10)
        translate([cylinder_radius, 0, 0]) rotate([0, 0, 45])
            circle(r = torus_radius);
  }
/*
  color ("red") 
    translate([0, 0, rings_separation/2 ])
        torus(); 
color ("red") 
    translate([0, 0, -rings_separation/2])
        torus(); 
*/