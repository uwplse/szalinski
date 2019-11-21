// relaishousing
// greetings from Heinrich Schnermann, Laatzen
// this is my "hello world"

$fn = 30;

buildBox = true; // box
buildTop = true; // top

length = 100; // 100 relais + connector + some extra room
width = 40; // 40
height = 35; // 35

if(buildBox) {
    difference() {
        kaestchen(length, width, height, 3, 5, false);
        // 1. 220 V slot
        translate([-1, 13.5, 20])
            rotate([0,90,0])
                cylinder(10, 3.5, 3.5);
        translate([-1, 10, 20])
            cube([10, 7, height - 15]);
        // 2. 220 V slot
        translate([-1, 40 -13.5, 20])
            rotate([0,90,0])
                cylinder(10, 3.5, 3.5);
        translate([-1, 23, 20])
           cube([10, 7, height - 15]);
        // raspi pin 3 slot
        translate([100, 20, 33])
            cube([10, 6, 10], center = true);
        // mount/tool holes
        translate([20, -1, height - 10])
            rotate([270, 0, 0])
            cylinder(width + 2, d = 5.1, d = 5.1);
        translate([length -20, -1, height - 10])
            rotate([270, 0, 0])
            cylinder(width + 2, d = 5.1, d = 5.1);
    }
}

if (buildTop) {
    deckel(length, width, 10, 3, 5);
}

module kaestchen(x = 10, y = 10, z = 5, r = 1, rille = 1, center = true) {
    if (center != true) {
        a = x / 2;
        b = y / 2;
        c = (z + r) / 2;
    }
    translate([x / 2, y / 2, (z + r) / 2]) {
        kaestchen_ohne_translation(x, y, z, r, rille);
    }
}
module kaestchen_ohne_translation(x, y, z, r, rille) {    
     difference() {
// Aussen
       minkowski() {
            cube([x - 2 * r, y - 2 * r, z - r], center = true);
            sphere(r);
        }
// oberer Rand    
        translate([0, 0, (z + 1) / 2 ]) {
            cube([x + 1, y + 1, r  + 1], center = true);
        }
// Ausschnitt   
        translate([0, 0, r]) {
            minkowski() {
                cube([x - 4 * r, y - 4 * r, z], center = true);
                sphere(r);
            }
        }
// Rille
       translate([0, 0, (z - r) / 2 - rille]) {
            linear_extrude(rille + 1) {
                minkowski() {
                    square([x - 3 * r, y - 3 * r], center = true);
                    circle(r);
                }
            }
        }
    }
}

module deckel(x = 10, y = 10, z = 3, r = 1, rille = 1) {
    echo (r);
    translate([x / 2, y * 2, (z + r) / 2]) rotate([180, 0, 0]) {
    difference() {
        minkowski() {
            cube([x -2 * r, y - 2 * r, z - r], center = true);
            sphere(r);
        }
        translate([0, 0, -r]) {
            minkowski() {
                cube([x - 4 * r, y - 4 * r, z], center = true);
                sphere(r);
            }
        }
        translate([0, 0, -(z + 1) / 2]) {
            cube([x + 1, y + 1, r + 1], center = true);
        }
        translate([0, 0, -(z -r) / 2 - (z -r) / 2 + rille]) {
            kaestchen_ohne_translation(x, y, z, r, rille);
        }
    }
}
}
