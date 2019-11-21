/*
 * Inspired by the "TinyBoy / Fabrikator mini Cam holder"
 * by "andy_a":
 * http://www.thingiverse.com/thing:1434698
 *
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in April 2016
 *
 * Licensed under the Creative Commons - Attribution - Share alike license.
 */

// -----------------------------------------------------------

bodyHeight = 7;
wallSize = 3;
lipSize = 3;
fullSize = 28;
gap = 5;
length = 35;
bottomOff = 5;
holeDist = 23;
holeSize = 3.3;

$fn = 15;

// -----------------------------------------------------------

module holder() {
    // lower body
    cube([wallSize, fullSize - wallSize, bodyHeight]);

    // upper border
    translate([0, fullSize - wallSize, 0])
        cube([(2 * wallSize) + gap, wallSize, bodyHeight]);

    // upper lip
    translate([wallSize + gap, fullSize - (2 * wallSize), 0])
        cube([wallSize, wallSize, bodyHeight]);

    // lower border
    translate([wallSize, 0, 0])
        cube([lipSize, lipSize, bodyHeight]);
}

module mount() {
    difference() {
        cube([bodyHeight, length, wallSize]);
        
        translate([bodyHeight / 2, bottomOff + (holeSize / 2), -1])
            cylinder(d = holeSize, h = wallSize + 2);
        
        translate([bodyHeight / 2, bottomOff + (holeSize / 2) + holeDist, -1])
            cylinder(d = holeSize, h = wallSize + 2);
    }
}

module whole() {
    translate([0, 0, wallSize])
        rotate([0, 90, 0])
        #holder();

    translate([0, -length, 0])
        mount();
}

// -----------------------------------------------------------

translate([0, 0, bodyHeight])
    rotate([0, 90, 0])
    whole();
