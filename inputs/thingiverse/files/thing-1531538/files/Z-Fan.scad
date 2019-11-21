/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in April 2016
 *
 * Licensed under the Creative Commons - Attribution license.
 */

// -----------------------------------------------------------

base_width = 33;
base_height = 33;
base_depth = 2;

cutout_width = 16;
cutout_height = 25;

hole_dist_left = 3.6;
hole_dist_right = 3.6;
hole_dist_top = 7;
hole_dist_bottom = 10;
hole_size = 3;

fan_width = 26;
fan_diameter = 24;
fan_hole = 2.8;
fan_hole_dist = 2.5;

fan_angle = 10;
fan_x = -2;
fan_y = 0;
fan_z = 6;
first_wall = 3;
wall_size = 1.4;

angled_wall_size = 0.8;
rotation_add_x = -0.4;
rotation_add_z = 4.55;
mirror_dist_y = 6.6;

$fn = 25;

// -----------------------------------------------------------

module base() {
    difference() {
        cube([base_width, base_height, base_depth]);
    
        translate([(base_width - cutout_width) / 2, (base_height - cutout_height) / 2, -1])
            cube([cutout_width, cutout_height, base_depth + 2]);
        
        translate([hole_dist_left, hole_dist_bottom, -1])
            cylinder(d = hole_size, h = base_depth + 2);
        
        translate([hole_dist_left, base_height - hole_dist_top, -1])
            cylinder(d = hole_size, h = base_depth + 2);
        
        translate([base_width - hole_dist_right, hole_dist_bottom, -1])
            cylinder(d = hole_size, h = base_depth + 2);
        
        translate([base_width - hole_dist_right, base_height - hole_dist_top, -1])
            cylinder(d = hole_size, h = base_depth + 2);
    }
}

module rim() {
    translate([-wall_size, 0, 0])
        cube([wall_size, cutout_height, first_wall]);
    
    translate([-wall_size, -wall_size, 0])
        cube([cutout_width + (2 * wall_size), wall_size, first_wall]);
    
    translate([cutout_width, 0, 0])
        cube([wall_size, cutout_height, first_wall]);
    
    translate([-wall_size, cutout_height, 0])
        cube([cutout_width + (2 * wall_size), wall_size, first_wall]);
}

module angled() {
    polyhedron(points = [
        // 0: down, top left
        [(base_width - cutout_width) / 2 - wall_size, (base_height - cutout_height) / 2, base_depth + first_wall],
    
        // 1: down, top right
        [(base_width - cutout_width) / 2 + cutout_width + wall_size, (base_height - cutout_height) / 2, base_depth + first_wall],
    
        // 2: down, bottom right
        [(base_width - cutout_width) / 2 + cutout_width + wall_size, (base_height - cutout_height) / 2 - wall_size, base_depth + first_wall],
    
        // 3: down, bottom left
        [(base_width - cutout_width) / 2 - wall_size, (base_height - cutout_height) / 2 - wall_size, base_depth + first_wall],
    
        // 4: up, top left
        [(base_width - fan_width) / 2 + fan_x, (base_height - fan_width) / 2 + fan_y + angled_wall_size, base_depth + fan_z],
    
        // 5: up, top right
        [(base_width - fan_width) / 2 + fan_x + fan_width + rotation_add_x, (base_height - fan_width) / 2 + fan_y + angled_wall_size, base_depth + fan_z + rotation_add_z],
    
        // 6: up, bottom right
        [(base_width - fan_width) / 2 + fan_x + fan_width + rotation_add_x, (base_height - fan_width) / 2 + fan_y, base_depth + fan_z + rotation_add_z],
        
        // 7: up, bottom left
        [(base_width - fan_width) / 2 + fan_x, (base_height - fan_width) / 2 + fan_y, base_depth + fan_z]
    ], faces = [
        [0, 1, 2, 3], // bottom
        [4, 5, 1, 0], // back
        [7, 6, 5, 4], // top
        [5, 6, 2, 1], // right
        [6, 7, 3, 2], // front
        [7, 4, 0, 3]  // left
    ]);
}

module fan_mount() {
    difference() {
        cube([fan_width, fan_width, base_depth]);
        
        translate([fan_width / 2, fan_width / 2, -1])
            cylinder(d = fan_diameter, h = base_depth + 2);
        
        translate([fan_hole_dist, fan_hole_dist, -1])
            cylinder(d = fan_hole, h = base_depth + 2);
        
        translate([fan_width - fan_hole_dist, fan_hole_dist, -1])
            cylinder(d = fan_hole, h = base_depth + 2);
        
        translate([fan_hole_dist, fan_width - fan_hole_dist, -1])
            cylinder(d = fan_hole, h = base_depth + 2);
        
        translate([fan_width - fan_hole_dist, fan_width - fan_hole_dist, -1])
            cylinder(d = fan_hole, h = base_depth + 2);
    }
}

base();

translate([(base_width - cutout_width) / 2, (base_height - cutout_height) / 2, base_depth])
    rim();

angled();

translate([0, cutout_height + wall_size + mirror_dist_y, 0])
    mirror([0, 1, 0])
    angled();

polyhedron(points = [
    // 0: down, top left
    [(base_width - cutout_width) / 2, (base_height - cutout_height) / 2 + cutout_height, base_depth + first_wall],

    // 1: down, top right
    [(base_width - cutout_width) / 2, (base_height - cutout_height) / 2 - wall_size, base_depth + first_wall],

    // 2: down, bottom right
    [(base_width - cutout_width) / 2 - wall_size, (base_height - cutout_height) / 2 - wall_size, base_depth + first_wall],

    // 3: down, bottom left
    [(base_width - cutout_width) / 2 - wall_size, (base_height - cutout_height) / 2 + cutout_height, base_depth + first_wall],

    // 4: up, top left
    [(base_width - fan_width) / 2 + fan_x + angled_wall_size, (base_height - fan_width) / 2 + fan_y + fan_width, base_depth + fan_z],

    // 5: up, top right
    [(base_width - fan_width) / 2 + fan_x + angled_wall_size, (base_height - fan_width) / 2 + fan_y, base_depth + fan_z],

    // 6: up, bottom right
    [(base_width - fan_width) / 2 + fan_x, (base_height - fan_width) / 2 + fan_y, base_depth + fan_z],
    
    // 7: up, bottom left
    [(base_width - fan_width) / 2 + fan_x, (base_height - fan_width) / 2 + fan_y + fan_width, base_depth + fan_z]
], faces = [
    [0, 1, 2, 3], // bottom
    [4, 5, 1, 0], // back
    [7, 6, 5, 4], // top
    [5, 6, 2, 1], // right
    [6, 7, 3, 2], // front
    [7, 4, 0, 3]  // left
]);

polyhedron(points = [
    // 0: down, top left
    [(base_width - cutout_width) / 2 + cutout_width, (base_height - cutout_height) / 2 - wall_size, base_depth + first_wall],

    // 1: down, top right
    [(base_width - cutout_width) / 2 + cutout_width, (base_height - cutout_height) / 2 + cutout_height, base_depth + first_wall],

    // 2: down, bottom right
    [(base_width - cutout_width) / 2 + cutout_width + wall_size, (base_height - cutout_height) / 2 + cutout_height, base_depth + first_wall],

    // 3: down, bottom left
    [(base_width - cutout_width) / 2 + cutout_width + wall_size, (base_height - cutout_height) / 2 - wall_size, base_depth + first_wall],

    // 4: up, top left
    [(base_width - fan_width) / 2 + fan_x + fan_width + rotation_add_x - angled_wall_size, (base_height - fan_width) / 2 + fan_y, base_depth + fan_z + rotation_add_z],

    // 5: up, top right
    [(base_width - fan_width) / 2 + fan_x + fan_width + rotation_add_x - angled_wall_size, (base_height - fan_width + wall_size) / 2 + fan_y + cutout_height, base_depth + fan_z + rotation_add_z],

    // 6: up, bottom right
    [(base_width - fan_width) / 2 + fan_x + fan_width + rotation_add_x, (base_height - fan_width + wall_size) / 2 + fan_y + cutout_height, base_depth + fan_z + rotation_add_z],
    
    // 7: up, bottom left
    [(base_width - fan_width) / 2 + fan_x + fan_width + rotation_add_x, (base_height - fan_width) / 2 + fan_y, base_depth + fan_z + rotation_add_z]
], faces = [
    [0, 1, 2, 3], // bottom
    [4, 5, 1, 0], // back
    [7, 6, 5, 4], // top
    [5, 6, 2, 1], // right
    [6, 7, 3, 2], // front
    [7, 4, 0, 3]  // left
]);

translate([(base_width - fan_width) / 2 + fan_x, (base_height - fan_width) / 2 + fan_y, base_depth + fan_z])
    rotate([0, -fan_angle, 0])
    fan_mount();
