$fn = 50 / 1;

// basic label dimensions

// the width of the label
label_width = 60; // [40:5:120]

// the size of the label
label_height = 13; // [13:1/2 inch, 16: 5/8 inch, 19.2: 3/4 inch, 26.6: 1 inch]
label_thickness = 1 / 1; // 1mm thickness

// the angle of the label
label_angle = 60; // [45, 60, 75]


module panel() {
    rotate([label_angle, 0, 0]) {
        translate([0, label_height / 2, -(label_thickness / 2)]) {
            difference() {
                minkowski() {
                    sphere(1);
                    cube([label_width, label_height, label_thickness], true);
                }
                translate([0, 0, label_thickness + .5]) cube([label_width, label_height, label_thickness], true);
            }
        }
    }
}

module base() {
    difference() {
        minkowski() {
            sphere(1);
            cylinder(1, label_height, label_height);
        }
        translate([0, -49, 0]) cube([100, 100, label_height], true);
    }
}

// flatten everything
difference() {
    union() {
        translate([0, 0, .5]) panel();
        base();
    }
    translate([0, 0, -5]) cube([200, 200, 10], true);
}
