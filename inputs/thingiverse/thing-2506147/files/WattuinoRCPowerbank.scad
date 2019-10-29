include <defaults.scad>;

$fn = 50; 

difference() {
    union() {
        difference() {
            cube(   size=[26.4, 50.0, 70.0 ] );
            translate([1.2, 8.0, 0]) cube(   size=[24.0, 34.0, 72.0 ] ); 
        }
        difference() {
            translate([1.2, 8.0, 0]) cube(   size=[4.0, 4.0, 70.0 ] );
            translate([5.2, 12.0, 0]) cylinder(72, 4.0, 4.0); 
        }
        difference() {
            translate([21.2, 8.0, 0]) cube(   size=[4.0, 4.0, 70.0 ] );
            translate([21.2, 12.0, 0]) cylinder(72, 4.0, 4.0); 
        }
        difference() {
            translate([1.2, 38.0, 0]) cube(   size=[4.0, 4.0, 70.0 ] );
            translate([5.2, 38.0, 0]) cylinder(72, 4.0, 4.0); 
        }
        difference() {
            translate([21.2, 38.0, 0]) cube(   size=[4.0, 4.0, 70.0 ] );
            translate([21.2, 38.0, 0]) cylinder(72, 4.0, 4.0); 
        }
    }
    translate([0,5,5]) rotate(a=[0, 90,0]) cylinder(50, 2.0, 2.0); 
    translate([0,45,5]) rotate(a=[0, 90,0]) cylinder(50, 2.0, 2.0); 
    translate([0,45,65]) rotate(a=[0, 90,0]) cylinder(50, 2.0, 2.0); 
    translate([0,5,65]) rotate(a=[0, 90,0]) cylinder(50, 2.0, 2.0); 
}