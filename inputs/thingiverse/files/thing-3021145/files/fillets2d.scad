/*
Modified by Kevin Gravier
https://www.thingiverse.com/mrkmg/about

Originally from: https://github.com/OskarLinde/scad-utils/blob/master/morphology.scad



Modules:

rounding2d(r)
r = radius of rounding

fillet2d(r)
r = radius of rounding

*/

$fa = 0.1;
$fs = 0.1;

// Example
linear_extrude(1)
rounding2d(1)
fillet2d(1)
difference() {
    union() {
        square([10, 10], center = true);
        translate([5, 5])
        square([10, 10], center = true);
    }
    
    translate([-5, -5])
    square([10, 10], center = true);
    
    translate([8, 8])
    circle(3);
}

// Example, text
translate([-20, -15])
rotate([0, 0, 0])
linear_extrude(1)
rounding2d(.25)
fillet2d(.25)
text("Fillets!");

module fillet2d(r) {
    offset(r = -r) offset(delta = r) children(0);
}

module rounding2d(r) {
    offset(r = r) offset(delta = -r) children(0);
}