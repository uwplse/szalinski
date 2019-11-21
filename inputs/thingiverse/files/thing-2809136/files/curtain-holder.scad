// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 1;    // Don't generate larger angles than 5 degrees

// diameter of the screws for the holders
diamScrew = 5;
// diameter of the rod
diamRod = 16.7;
// thickness of the walls surrounding the rod
rodWalls = 2.5;
// clearance between the rod and the walls surrounding it
rodClearance = 0.5;
// distance of the rod from the wall (for the hook)
wallDist = 27;

// helper variable for total wall width
wallTotal = rodWalls + rodClearance;

translate([-15,0,0]) {
    wallHolder();
}

translate([15,0,0]) {
    hook();
}

module wallHolder() {
    difference() {
        cylinder(h=10+wallTotal, r=diamRod/2+wallTotal);// baseplate
        translate([0,0,wallTotal]) {
            cylinder(h=10, r=diamRod/2+rodClearance);
        }// screw hole
        cylinder(h=wallTotal, r=diamScrew/2);//cutout
    }
}

module hook() {
    difference() {
        union() {
            cube([10+wallTotal,diamRod+2*wallTotal,wallDist+diamRod/2+rodClearance]);//hook
            translate([0,-5, 0]) {//baseplate
                cube([15+wallTotal,10+diamRod+2*wallTotal,5]);
            }
            translate([(10+wallTotal)/2,-5,0]) {//rounded edge baseplate
                cylinder(h=5, r=(10+wallTotal)/2);
            }
            translate([(10+wallTotal)/2,5+diamRod+2*wallTotal,0]) {//rounded edge baseplate
                cylinder(h=5, r=(10+wallTotal)/2);
            }
            translate([15+wallTotal,(diamRod+2*wallTotal)/2,0]) {//rounded edge baseplate
                resize(newsize=[10,diamRod+2*wallTotal,5]) {
                cylinder(h=5, r=(diamRod+2*wallTotal)/2);
                }
            }
            translate([0,(diamRod+2*wallTotal)/2, wallDist+diamRod/2+rodClearance]) {//rounded edge top
                rotate([0,90,0]) {
                    cylinder(h=10+wallTotal, r=(diamRod+2*wallTotal)/2);
                }
            }
        }
        translate([10+wallTotal,-10,0]) {//edge baseplate
            cube([10,10,5]);
        }
        translate([10+wallTotal,diamRod+2*wallTotal,0]) {//edge baseplate
            cube([10,10,5]);
        }
        translate([0,(diamRod+2*wallTotal)/2, wallDist+diamRod/2+rodClearance]) {//cutout
            rotate([0,90,0]) {
                cylinder(h=10, r=diamRod/2+rodClearance);
            }
        }
        translate([(10+wallTotal)/2,-5,0]) {// screw hole
            cylinder(h=5, r=diamScrew/2);
        }
        translate([(10+wallTotal)/2,5+diamRod+2*wallTotal,0]) {// screw hole
            cylinder(h=5, r=diamScrew/2);
        }
        translate([15+wallTotal,(diamRod+2*wallTotal)/2,0]) {// screw hole
            cylinder(h=5, r=diamScrew/2);
        }
    }
}