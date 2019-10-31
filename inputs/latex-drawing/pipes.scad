difference() {
    cube();
    translate([0.5, 0.5, 0.5])
        sphere($fn = 50, r = 0.6);
}

translate([2, 0, 0]) {
    difference() {
        cube([1, 1, 2]);
        translate([0.5, 0.5, 0.5])
            sphere($fn = 50, r = 0.6);
        translate([0.5, 0.5, 1.5])
            sphere($fn = 50, r = 0.6);
    }
}


translate([4, 0, 0]) {
    difference() {
        cube([1, 1, 3]);
        translate([0.5, 0.5, 0.5])
            sphere($fn = 50, r = 0.6);
        translate([0.5, 0.5, 1.5])
            sphere($fn = 50, r = 0.6);
        translate([0.5, 0.5, 2.5])
            sphere($fn = 50, r = 0.6);
    }
}