import("front.stl");
use <connector.scad>;

$fn=60;
//import("hinge.stl");
union() {
    import("raspberri_pi_camera_case_front_v0.4.2.STL");
    translate([29.2, 0, 0]) 
        rotate([0,0,90]) 
            translate([28, 8]) {
                cube([2,12.5,10]);
                translate([2,0]) {
                    connectors();
                }
            }
}


