width = 10;
length = 10;
thickness = 1;

clipLength = 8;

translate([0, 0, -thickness / 2]) cube([length, width, thickness], center = true);

difference() {
    union() {
        translate([0, 0, 1.5/2]) cube([clipLength, 3.2, 1.5], center = true);
        translate([0, 0, 2]) hull() {
            cube([clipLength, 3.2, 2], center = true);
            cube([clipLength, 4, 1], center = true);
        }
    }
    translate([0, 0, 5/2]) cube([length, 1, 5], center = true);
}
