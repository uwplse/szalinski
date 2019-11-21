// All measurements in mm.

// The model is built with the top upwards so
// that you can more easily position holes and
// such. Make sure to flip it over for printing.

// The width of the lid.
width = 132;

// The height of the lid.
height = 81;

// The distance to place screw holes from the left/right edge.
x_hole_distance = 6;

// The distance to place screw holes from the top/bottom edge.
y_hole_distance = 6;

$fn = 50 * 1;

difference() {
    
    union() {
        cube([width, height, 1]);
        translate([1, 1, -4]) {
            cube([width - 2, height - 2, 4]);
        }
    }

    translate([x_hole_distance, y_hole_distance, 0]) {
        cylinder(100, 2, 2, true);
    }
    translate([x_hole_distance, y_hole_distance, -51]) {
        cylinder(100, 8, 8, true);
    }
    
    translate([x_hole_distance, height - y_hole_distance, 0]) {
        cylinder(100, 2, 2, true);
    }
    translate([x_hole_distance, height - y_hole_distance, -51]) {
        cylinder(100, 8, 8, true);
    }
    
    translate([width - x_hole_distance, y_hole_distance, 0]) {
        cylinder(100, 2, 2, true);
    }
    translate([width - x_hole_distance, y_hole_distance, -51]) {
        cylinder(100, 8, 8, true);
    }

    translate([width - x_hole_distance, height - y_hole_distance, 0]) {
        cylinder(100, 2, 2, true);
    }
    translate([width - x_hole_distance, height - y_hole_distance, -51]) {
        cylinder(100, 8, 8, true);
    }

 }
