$fn = 60;

width = 15;

hook(true);

translate([0, width + 5, 0]) {
    hook(false);
}

module hook(long = false) {
    difference() {
        translate([3, width, 3])
            rotate([90, 0, 0])
                cylinder(width, 3, 3);
        translate([5, -0.5, 5])
            cube([2, width + 1, 2]);
    }
    translate([3, 0, 0])
        cube([17, width, 5]);
    difference() {
        translate([0, 0, 3])
            cube([5, width, 12]);
        translate([2.5, width + 0.5, 15.5])
            rotate([90, 0, 0])
                linear_extrude(width + 1)
                    polygon([[0, 0], [3, -3], [3, 0]]);
    }
    if (long) {
        difference() {
            translate([15, 0, 0])
                cube([5, width, 40]);
            translate([14.5, width / 2, 22.5])
                rotate([0, 90, 0])
                cylinder(6, 2.5, 2.5);
            translate([14.5, width / 2, 32.5])
                rotate([0, 90, 0])
                cylinder(6, 2.5, 2.5);
            translate([14.5, width /2 - 2.5, 22.5])
                cube([6, 5, 10]);
            translate([15, width / 2, 22.5])
                rotate([0, 90, 0])
                    rotate_extrude()
                        polygon([[5, -0.5],[2, -0.5],[2, 2]]);
            translate([15, width / 2, 32.5])
                rotate([0, 90, 0])
                    rotate_extrude()
                        polygon([[5, -0.5],[2, -0.5],[2, 2]]);
            translate([14.5, width / 2, 22.5])
                linear_extrude(10)
                    polygon([[2.5, 2], [0, 0], [0, 5]]);
            translate([14.5, width / 2, 22.5])
                linear_extrude(10)
                    polygon([[2.5, -2], [0, 0], [0, -5]]);
        }
    } else {
        difference() {
            translate([15, 0, 0])
                cube([5, width, 30]);
            translate([14.5, width / 2, 22.5])
                rotate([0, 90, 0])
                cylinder(6, 2.5, 2.5);
            translate([15, width / 2, 22.5])
                rotate([0, 90, 0])
                    rotate_extrude()
                        polygon([[5, -0.5],[2, -0.5],[2, 2]]);
            
        }
    }
    difference() {
        translate([12, 0, 0])
            cube([4, width, 8]);
        translate([12, width + 0.5, 8])
            rotate([90, 0, 0])
                cylinder(width + 1, 3, 3);
    }
}