// Greetings from Heinrich Schnermann, Laatzen, Germany
//
// this is a replacement for the Ikea Hjälpa clothes rail holder
// 
// for right holder set leftpart to false

$fn =180;

leftpart = true;

difference() {
    union() {
        cylinder(5,  21, 21);
        translate([0, -21, 0]) cube([35, 42, 5]);
        translate([35, 0, 0]) cylinder(5, 21, 21);
        translate([31, 0, 0]) cylinder(22, 16.25, 16.25);
        if (leftpart) {
            translate([31 - 16.25, 0, 0]) cube([32.5, 10, 22]);
        } else {
            translate([31 - 16.25, - 10, 0]) cube([32.5, 10, 22]);
        }
    }
    translate([1, 13, 2]) cylinder(3.1, 4.5, 4.5);
    translate([1, -13, 2]) cylinder(3.1, 4.5, 4.5);
    translate([1, 13, -0.1]) cylinder(3, 5.2 / 2, 5.2 / 2);
    translate([1, -13, -0.1]) cylinder(3, 5.2 / 2, 5.2 / 2);
    translate([31, 0, 3.5]) cylinder(25, 12.75, 12.75);
    if (leftpart) {
        translate([31 - 12.75, 0, 3.5]) cube([25.5, 25, 22]);
    } else {
        translate([31 - 12.75, -25, 3.5]) cube([25.5, 25, 22]);
    }
}