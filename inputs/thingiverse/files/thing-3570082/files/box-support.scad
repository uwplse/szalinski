// Make a hollow conical support to keep boxes off the damp floor.
// Copyright 2019 Ben Kelley
// This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/

$fn = 64*1;

topDiameter = 50; //[5:50]
bottomDiameter = 30; //[5:50]
thickness = 5; //[1:10]
height = 30; //[5:80]
bottomCutouts = 6; //[1:10]
cutoutDiameter = 8; //[2:20]

main();

module main() {
    if (bottomCutouts > 0) {
        difference() {
            mainCylinders();
            bottomCutouts();
        }
    } else {
        mainCylinders();
    }
}

module mainCylinders() {
    difference() {
        // Outer Cylinder
        cylinder(h=height, r1=(bottomDiameter / 2), r2=(topDiameter / 2));
        // Inner Cylinder
        translate([0,0,-0.005]) {
            cylinder(h=height+0.01, r1=(bottomDiameter / 2) - thickness, r2=(topDiameter / 2) - thickness);
        }
    }
}

module bottomCutouts() {
    union() {
        for(cutout = [0 : (bottomCutouts - 1)]) {
            rotate ([0,0, ((360 / bottomCutouts) * cutout)]) {
                translate ([0, (bottomDiameter / 2) + 2, 0]) {
                    rotate ([90,0,0]) {
                        cylinder(h=thickness + 5, r1=cutoutDiameter / 2, r2=cutoutDiameter / 2);
                    }
                }
            }
        }        
    }    
}

