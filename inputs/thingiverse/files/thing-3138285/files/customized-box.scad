/*
 * Customizable Box - https://www.thingiverse.com/thing:3138285
 * by ASP3D - https://www.thingiverse.com/asp3d/about
 * created 2018-10-05
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0 - 2018-10-05:
 *  - [new] Initial release
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


/* [Box size and params] */

width = 120;
depth = 80;
height = 70;

// Outer walls thickness
wall = 2;
// Bottom shell thickness
bottom = 3;

// Inner modules configiration
modules_select = 4; // [0:Custom (need to download source),1:Empty box,2:2x2,3:3+1,4:3+2,5:2+3+4]
// Inner modules walls thickness
modules_wall = 1;
// Custom modules (when modules_select=0 (Custom))
// Format: modules_custom = [ [[pos_x, pos_y], [size_x, size_y]], ... ];
// All sizes are in percentage
modules_custom = [
    [[0, 0], [25, 50]], [[25, 0], [50, 34]], [[75, 0], [25, 34]],
    [[0, 34], [67, 34]], [[67, 34], [33, 34]],
    [[0, 68], [25, 32]], [[50, 68], [50, 75]]
];

// Smooth corners by this value
corners_radius = 10;

// Make near side lower, use this angle for cut
top_angle = 20; // [0:45]
// Smooth top cut by this value
top_radius = 10;


/* [Hidden] */

modules_list = [

    [],
    [
        [[0, 0], [50, 50]], [[50, 0], [50, 50]],
        [[0, 50], [50, 50]], [[50, 50], [50, 50]]
    ],
    [
        [[0, 0], [100, 50]],
        [[0, 50], [33, 50]], [[33, 50], [34, 50]], [[67, 50], [33, 50]]
    ],
    [
        [[0, 0], [50, 50]], [[50, 0], [50, 50]],
        [[0, 50], [33, 50]], [[33, 50], [34, 50]], [[67, 50], [33, 50]]
    ],
    [
        [[0, 0], [25, 34]], [[25, 0], [25, 34]], [[50, 0], [25, 34]], [[75, 0], [25, 34]],
        [[0, 34], [33, 34]], [[33, 34], [34, 34]], [[67, 34], [33, 34]],
        [[0, 68], [50, 32]], [[50, 68], [50, 32]]
    ]

// [], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], [[], []], ]

];

bottom_radius = 1;

front_height = height - sin(top_angle)*height;

$fn = 100;



intersection() {
    union() {
        box_3d();
        grig_3d();
    }
    cut_3d();
}


module cut_3d() {
    translate([-1, 0, 0])
        rotate([90, 0, 90])
            linear_extrude(width + 2)
                cut_shape();
}

module cut_shape() {
    hull() {
        translate([bottom_radius, bottom_radius - bottom_radius*2, 0])
            circle(bottom_radius);
        translate([depth - bottom_radius, bottom_radius - bottom_radius*2, 0])
            circle(bottom_radius);
        translate([depth - top_radius, height - top_radius, 0])
            circle(top_radius);
        translate([top_radius, front_height - top_radius, 0])
            circle(top_radius);

    }
}


module grig_3d() {
    linear_extrude(height, convexity = 10) {
        if (modules_select == 0) {
            grid_shape(modules_custom);
        } else {
            grid_shape(modules_list[modules_select - 1]);
        }
    }
}

module grid_shape(modules) {
    w = width - wall*2 + modules_wall;
    h = depth - wall*2 + modules_wall;
    intersection() {
        translate([wall, wall, 0])
            union() {
                for (m = [0:len(modules)-1]) {
                    mx = w * modules[m][0][0]/100;
                    my = h * modules[m][0][1]/100;
                    wx = w * modules[m][1][0]/100;
                    wy = h * modules[m][1][1]/100;
                    translate([mx, my, 0])
                        difference() {
                            square([wx, wy]);
                            square([wx - modules_wall, wy - modules_wall]);
                        }
                }
            }
        bottom_shape();
    }
}
   
module box_3d() {
    linear_extrude(height, convexity = 10)
        difference() {
            bottom_shape();
            offset(delta = -wall)
                bottom_shape();        
        }
    linear_extrude(bottom)
        bottom_shape();
}
    
module bottom_shape() {
    translate([corners_radius, corners_radius, 0])
        minkowski() {
            square([width - corners_radius*2, depth - corners_radius*2]);
            circle(corners_radius);
        }
}