$fn = 100;

// Length of the tool box.
l = 130;

// Width of the tool box (mm)
w = 35;

// Height of the tool box (mm)
h = 20;

// Outer wall thickness
owall = 3;

// Inner wall thickness
iwall = 1.5;

// Number of compartments in x direction
ncx = 6;

// Number of compartments in y direction
ncy = 0;

// Outer edge radius.
rounding = 2;

delta = 0.1;

module box() {
    difference() {
        hull() {
            translate([rounding, rounding, 0])
                cylinder(h=h, r=rounding);
            translate([l-rounding, rounding, 0])
                cylinder(h=h, r=rounding);
            translate([l-2*rounding, w-2*rounding, 0])
                cube([2*rounding, 2*rounding, h]);
            translate([0, w-2*rounding, 0])
                cube([2*rounding, 2*rounding, h]);
        }
        translate([owall, owall, owall])
            cube([l-2*owall, w-2*owall, h]);
    }
    translate([0, w, h-4]) cube([l, 10, 4]);
    translate([0, w+6.5, h-4-3.5]) cube([l, 3.5, 3.5]);
    for (i = [1 : ncx-1])
        translate([l*i/ncx-iwall/2, delta, 0])
            cube([iwall, w-2*delta, h]);
    for (i = [1 : ncy-1])
        translate([delta, w*i/ncy-iwall/2, 0])
            cube([l-2*delta, iwall, h]);
}

difference() {
    box();
    // There's a screw in the way on the ultimaker. Make space for it.
    translate([l/2-2.5,w-2,h-4-6-15]) cube([6,2+delta,15]);
}
