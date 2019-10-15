
difference() {
translate([10, 10, 1.5]) cube([20, 20, 3], center = true);
    translate ([15, 15, 0]) cylinder(h = 3, r = 3, $fn = 6);
    translate ([15, 5, 0]) cylinder(h = 3, r = 3, $fn = 6);
    translate ([5, 15, 0]) cylinder(h = 3, r = 3, $fn = 6);
    translate ([5, 5, 0]) cylinder(h = 3, r = 3, $fn = 6);
}