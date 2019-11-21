include <defaults.scad>;

$fn = 120; 

union() {
    cylinder(26, 7.4, 7.4);
    translate([0,0,6]) cylinder(19, 0, 9.4);
    translate([0,0,26]) cylinder(12, 7.4, 0);
}