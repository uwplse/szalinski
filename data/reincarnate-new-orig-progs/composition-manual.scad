difference() {
    cube([110, 110, 5]);
    translate([10, 10, 0]) cube([90, 90, 6]);
}

union() {
    translate([40, 0, 0]) cube([1, 100, 1]);
    translate([70, 0, 0]) cube([1, 100, 1]);
    translate([0, 40, 0]) cube([100, 1, 1]);
    translate([0, 70, 0]) cube([100, 1, 1]);
}
