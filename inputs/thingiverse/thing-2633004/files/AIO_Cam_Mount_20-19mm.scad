// Type of nuts used
use_locknuts = 0;  // [0:Standard, 1:Locking]

// 20mm or 19mm width
size_20_or_19 = 0;  // [0:20mm, 1:19mm]

module camera() {
    union() {
        cube([15, 7, 13.5]);
        /*
        translate([2.875, -1.99, 2.25]) cube([9.25, 2, 10]);
        translate([7.5, 0.01, 6.75]) rotate([90, 0, 0]) cylinder(d=10, h=10, $fn=100);
        */
        translate([2.25, -9.99, 1.5]) cube([10.5, 10, 10.5]);
    }
}

module side_fillet() {
    union() {
        translate([-0.5, -0.5, 1.5]) cube([2, 8, 5]);
        translate([-0.5, -0.5, 6.5]) cube([1, 8, 1]);
        translate([0.5, 7.5, 6.5]) rotate([90, 0, 0]) cylinder(d=2, h=8, $fn=100);
    }
}

module corner_fillet_large() {
    difference() {
        cube([1, 8, 1]);
        translate([1, 9, 0]) rotate([90, 0, 0]) cylinder(d=1, h=10, $fn=100);
    }
}

module corner_fillet_small() {
    difference() {
        cube([1, 2, 1]);
        translate([0, 3.5, 0]) rotate([90, 0, 0]) cylinder(d=1, h=4, $fn=100);
    }
}

union() {
    difference() {
        // Main body
        difference() {
            cube([20, 7, 20]);
            translate([2.5, 1, 3.25]) camera();
        }
        // Screw & nut holes
        {
            if (use_locknuts) {
                translate([-1, 3.5, 10]) rotate([30, 0, 0]) rotate([0, 90, 0]) cylinder(d=5, h=4.5, $fn=6);
                translate([16.5, 3.5, 10]) rotate([30, 0, 0]) rotate([0, 90, 0]) cylinder(d=5, h=4.5, $fn=6);
            } else {
                translate([-0.5, 3.5, 10]) rotate([0, 90, 0]) cylinder(d=2, h=4, $fn=100);
                translate([16.75, 3.5, 10]) rotate([0, 90, 0]) cylinder(d=2, h=4, $fn=100);
                translate([0.76, 3.5, 10]) rotate([30, 0, 0]) rotate([0, 90, 0]) cylinder(d=5, h=1.75, $fn=6);
                translate([17.49, 3.5, 10]) rotate([30, 0, 0]) rotate([0, 90, 0]) cylinder(d=5, h=1.75, $fn=6);
            }
        }
        // Top and bottom cuts
        {
            translate([-0.5, -0.5, 14.99]) cube([21, 8, 6]);
            translate([-0.5, -0.5, -0.5]) cube([21, 8, 2.5]);
        }
        // Side cuts and fillets
        {
            // Left
            {
                translate([0, 0, -0.5]) side_fillet();
                translate([0, 0, 20.5]) mirror([0, 0, 1]) side_fillet();
            }
            // Right
            {
                translate([20, 0, -0.5]) mirror([1, 0, 0]) side_fillet();
                translate([20, 0, 20.5]) mirror([0, 0, 1]) mirror([1, 0, 0]) side_fillet();
            }
        }
        // External corners fillets
        {
            // Left
            {
                translate([4.25, -0.5, 14.49]) corner_fillet_small();
                translate([1, -0.5, 14.49]) corner_fillet_large();
                translate([-0.5, -0.5, 12.5]) corner_fillet_large();
                translate([-0.5, -0.5, 7.5]) mirror([0, 0, 1]) corner_fillet_large();
                translate([1, -0.5, 2.5]) mirror([0, 0, 1]) corner_fillet_large();
            }
            // Right
            {
                translate([15.75, -0.5, 14.49]) mirror([1, 0, 0]) corner_fillet_small();
                translate([19, -0.5, 14.49]) mirror([1, 0, 0]) corner_fillet_large();
                translate([20.5, -0.5, 12.5]) mirror([1, 0, 0]) corner_fillet_large();
                translate([20.5, -0.5, 7.5]) mirror([0, 0, 1]) mirror([1, 0, 0]) corner_fillet_large();
                translate([19, -0.5, 2.5]) mirror([0, 0, 1]) mirror([1, 0, 0]) corner_fillet_large();
            }
        }
        // Side trims for 19mm
        {
            if (size_20_or_19) {
                translate([-0.5, -1, 5]) cube([1, 9, 10]);
                translate([19.5, -1, 5]) cube([1, 9, 10]);
            }                
        }
    }
    // Internal corners fillets
    {
        translate([4.25, 0, 4.25]) difference() {
            cube([1, 1, 1]);
            translate([1, 1.5, 1]) rotate([90, 0, 0]) cylinder(d=1, h=2, $fn=100);
        }
        translate([14.75, 0, 4.25]) difference() {
            cube([1, 1, 1]);
            translate([0, 1.5, 1]) rotate([90, 0, 0]) cylinder(d=1, h=2, $fn=100);
        }
    }
}