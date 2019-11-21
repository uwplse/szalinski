$fn=180;
difference() {
    union() {
        sphere(5);
        cube([12, 3.5, 8], true);
    }
    cube([2, 12, 10], true);
    translate([0, 0, -10]) {
        cube ([20, 20, 20], true);
    }
    translate([0, 0, 0]) {
        difference() {
            cylinder(d=13, h=2.2);
            cylinder(d=10, h=2.2);
        }
    }
}
translate([0, 0, -2]) {
    cylinder(2, d=13, true);
}

translate([0, 0, -12]) {
    intersection() {
        cylinder (h=10, d1=12, d2=10);
        cube([5, 20, 20], true);
    }
}