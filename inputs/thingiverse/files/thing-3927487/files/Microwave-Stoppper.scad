// Length of Stopper
length = 40;
// Width of Stopper
width = 15;
// Cavity diameter
diameter = 16;
// Thickness
thick = 4;
// Thickness of Cavity
thick_cavity = 6;

$fn=80;
// Model
difference() {
    union() {
        cube([length, width, thick], center=true);
        translate([0, diameter/2, -(thick/2)]) {
            cylinder(h=thick_cavity+0.2, r=diameter/2+2);
        };
    };
    translate([0, diameter/2, -(thick/2+0.2)]) {
        cylinder(h=thick_cavity+0.6, r=diameter/2);
    };
    translate([0, width+0.1, 0]) {
        cube([length+0.2, width+0.2, thick_cavity*2], center=true);
    };
};