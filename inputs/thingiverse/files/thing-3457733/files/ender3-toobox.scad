// greetings from Heinrich Schnermann, Laatzen
// ender 3 toolbox

$fn = 30;

length = 120; // 120 seems good with cables behind
width = 130; // 130 is perfect for ender 3
height = 50; // 50 is a good match

difference() {
    kaestchen(length, width, height, 2, false);
    // y rod space
    translate([-1, -1, 35])
        cube([length + 2, 21, height - 34]);
    // mount/tool holes
    translate([20, width - 3, height - 10])
        rotate([270, 0, 0])
        cylinder(4, d = 5.5, d = 5.5);
    translate([20 - 2.75, width -3, 21])
        cube([5.5, 4, 20]);
    translate([length - 20, width - 3, height - 10])
        rotate([270, 0, 0])
        cylinder(4, d = 5.5, d = 5.5);
    translate([20, width - 3, height - 30])
        rotate([270, 0, 0])
        cylinder(4, d = 5.5, d = 5.5);
    translate([length - 20 - 2.75, width -3, 21])
        cube([5.5, 4, 20]);
    translate([length -20, width - 3, height - 30])
        rotate([270, 0, 0])
        cylinder(4, d = 5.5, d = 5.5);
}


module kaestchen(x = 10, y = 10, z = 5, r = 1, center = true) {
    if (center != true) {
        a = x / 2;
        b = y / 2;
        c = (z + r) / 2;
    }
    translate([x / 2, y / 2, (z + r) / 2]) {
        kaestchen_ohne_translation(x, y, z, r);
    }
}
module kaestchen_ohne_translation(x, y, z, r) {    
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
    }
}
