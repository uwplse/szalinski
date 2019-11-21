// All measurements are in mm.

// The thickness of the phone. This should be the only value you need to change.
phone = 9.3;

// The thickness of the holder walls.
wall_thickness = 10;

// The height of the holder walls.
wall_height = 20;

// The width of the locking block.
width = 43.5;

// The depth of the locking block.
depth = 38.25;

// The height of the locking block.
height = 8.0;

union() {
    difference() {
        cube([width, depth, height], true);
        translate([0, depth / 2 + height / 2 - 1.2, 0])
            rotate([110, 0, 0])
            cube([width + 1, depth, height], true);
        translate([0, - depth / 2 - height / 2 + 1.2, 0])
            rotate([70, 0, 0])
            cube([width + 1, depth, height], true);
    }
    translate([-width / 2, phone / 2 , height / 2])
        cube([width, wall_thickness, wall_height]);
    translate([-width / 2, -wall_thickness - phone / 2, height / 2])
        cube([width, wall_thickness, wall_height]);
}