// All settings are in mm

INNER_SCREW_RADIUS = 2;
OUTER_SCREW_RADIUS = 10;
OUTER_SCREW_DEPTH  = 2;

// platform settings
BASE_BOTTOM_RADIUS       = 20;
BASE_TOP_RADIUS          = 10;
BASE_MATERIAL_WIDTH      = 8;
BASE_PLATFORM_WIDTH      = 100;
BASE_PLATFORM_DEPTH      = 48;
BASE_GROOVE_SPACING      = 6;
BASE_GROOVE_DEPTH        = 2;
BASE_GROOVE_RADIUS       = 13;
BASE_INNER_CORNER_RADIUS = 10;
BASE_SCREW_Y_OFFSET      = 10;

// pedal holder settings
PEDAL_WIDTH                 = 60;
PEDAL_BACKPLATE_HEIGHT      = 74;
PEDAL_DEPTH                 = 122;
PEDAL_BACKPLATE_DEPTH       = 8;
PEDAL_SIDEWALL_WIDTH        = 6;
PEDAL_TOP_ANGLE             = 38;
PEDAL_BOTTOM_ANGLE          = 17;
PEDAL_TOP_CORNER_RADIUS     = 10;
PEDAL_TOPFACE_WIDTH         = 20;
PEDAL_SCREW_Y_OFFET_TOP     = 20;
PEDAL_SCREW_Y_OFFSET_BOTTOM = 20;

// flags to print each part
PRINT_PEDAL_HOLDER = true;
PRINT_WHEEL_MOUNT1 = true;
PRINT_WHEEL_MOUNT2 = true;

LOGO_WIDTH    = 27;
LOGO_HEIGHT   = 18;
LOGO_OFFSET_Y = 10;

// corner smoothness
$fn = 200;

// Create an inner rounded corner
module inner_corner(RADIUS, WIDTH) {
    // create a cube and cut out the inner cylinder and 3 corners
    difference() {
        cube([WIDTH, 2 * RADIUS, 2 * RADIUS]);
        rotate([0, 90, 0]) {
            translate([-RADIUS, RADIUS, -1]) {
                cylinder(r = RADIUS, h = WIDTH + 2);
            }
        }
        translate([-1, -1, RADIUS]) {
            cube([WIDTH + 2, 3 * RADIUS, 3 * RADIUS]);
        }
        translate([-1, RADIUS, -1]) {
            cube([WIDTH + 2, 3 * RADIUS, 3 * RADIUS]);
        }
    }

}

// attaches backplates to the corner
module inner_corner_with_backs(RADIUS, WIDTH, BACK_WIDTH) {
    union() {
        inner_corner(RADIUS, WIDTH);
        translate([0, -BACK_WIDTH, -BACK_WIDTH + .001]) {
            cube([RADIUS, WIDTH + BACK_WIDTH, BACK_WIDTH]);
        }
        translate([0, -BACK_WIDTH, 0]) {
            cube([WIDTH, BACK_WIDTH, RADIUS]);
        }
    }
}

module oval(WIDTH, LENGTH, HEIGHT, CORNER_RADIUS) {
    translate([CORNER_RADIUS, CORNER_RADIUS, 0]) {
        minkowski() {
            cube([WIDTH - 2*CORNER_RADIUS, LENGTH - 2*CORNER_RADIUS, HEIGHT]);
            cylinder(r = CORNER_RADIUS, h = HEIGHT);
        }
    }
}

module two_corner_box(WIDTH, LENGTH, HEIGHT, CORNER_RADIUS) {
    hull() {
        cube([1, 1, HEIGHT]);
        translate([WIDTH - 1, 0, 0]) {
            cube([1, 1, HEIGHT]);
        }
        translate([CORNER_RADIUS, LENGTH - CORNER_RADIUS, 0]) {
            cylinder(r = CORNER_RADIUS, h = HEIGHT);
        }
        translate([WIDTH - CORNER_RADIUS, LENGTH - CORNER_RADIUS, 0]) {
            cylinder(r = CORNER_RADIUS, h = HEIGHT);
        }
    }
}

module screw_hole(r1, r2, h1, h2) {
    union() {
        // outer screw hole
        cylinder(r = r2, h = h2);

        // inner screw hole
        cylinder(r = r1, h = h1);
    }
}

module base_platform() {
    module platform_edge(CORNER_RADIUS) {
        two_corner_box(BASE_PLATFORM_WIDTH, BASE_PLATFORM_DEPTH, BASE_MATERIAL_WIDTH, CORNER_RADIUS);
    }
    
    // bottom platform
    difference() {
        union() {
            platform_edge(BASE_BOTTOM_RADIUS);

            // inner corner
            translate([0, BASE_MATERIAL_WIDTH, BASE_MATERIAL_WIDTH]) {
                inner_corner(BASE_INNER_CORNER_RADIUS, BASE_PLATFORM_WIDTH);
            }
        }
 
        translate([BASE_GROOVE_SPACING, BASE_MATERIAL_WIDTH + BASE_GROOVE_SPACING, BASE_MATERIAL_WIDTH - BASE_GROOVE_DEPTH]) {
            oval(
                BASE_PLATFORM_WIDTH - 2 * (BASE_GROOVE_SPACING),
                BASE_PLATFORM_DEPTH - BASE_MATERIAL_WIDTH - 2 * (BASE_GROOVE_SPACING),
                BASE_MATERIAL_WIDTH,
                BASE_GROOVE_RADIUS
            );
        }
    }

    // back platform
    rotate([90, 0, 0]) {
        difference() {
            translate([0, 0, -BASE_MATERIAL_WIDTH]) {
                platform_edge(BASE_TOP_RADIUS);
            }

            // outer screw hole
            translate([BASE_PLATFORM_WIDTH / 2, BASE_PLATFORM_DEPTH / 2 + BASE_SCREW_Y_OFFSET, -BASE_MATERIAL_WIDTH - 1]) {
                screw_hole(INNER_SCREW_RADIUS, OUTER_SCREW_RADIUS, BASE_MATERIAL_WIDTH + 2, OUTER_SCREW_DEPTH + 1);
            }
        }
    }
}

module pedal_holder() {
    module backplate() {
        cube([PEDAL_WIDTH, PEDAL_BACKPLATE_HEIGHT, PEDAL_BACKPLATE_DEPTH]);
    }
    
    module main_holder() {
        DEPTH     = (PEDAL_DEPTH - PEDAL_BACKPLATE_DEPTH) / cos(PEDAL_TOP_ANGLE);
        HEIGHT    = PEDAL_BACKPLATE_HEIGHT; // could optimize, but maths
        CUT_ANGLE = PEDAL_BOTTOM_ANGLE - PEDAL_TOP_ANGLE;
        MOVE_X    = HEIGHT * cos(PEDAL_TOP_ANGLE);
        MOVE_Y    = HEIGHT * sin(PEDAL_TOP_ANGLE) - PEDAL_BACKPLATE_DEPTH;

        difference() {
            // primary rounded shape
            translate([0, MOVE_X, -MOVE_Y]) {
                rotate([90-PEDAL_TOP_ANGLE, 0, 0]) {
                    difference() {
                        two_corner_box(PEDAL_WIDTH, DEPTH, HEIGHT, PEDAL_WIDTH/2);
                        translate([PEDAL_SIDEWALL_WIDTH, PEDAL_TOPFACE_WIDTH, 0]) {
                            oval(PEDAL_WIDTH - 2 * PEDAL_SIDEWALL_WIDTH, DEPTH - PEDAL_SIDEWALL_WIDTH - PEDAL_TOPFACE_WIDTH, HEIGHT, (PEDAL_WIDTH - 2 * PEDAL_SIDEWALL_WIDTH) / 2 - 1);
                        }
                        translate([PEDAL_SIDEWALL_WIDTH, 0, -PEDAL_SIDEWALL_WIDTH]) {
                            cube([PEDAL_WIDTH - 2 * PEDAL_SIDEWALL_WIDTH, DEPTH / 2, HEIGHT]);
                        }
                        translate([PEDAL_WIDTH / 2, LOGO_OFFSET_Y, HEIGHT]) {
                            bike_logo();
                        }
                    }

                }
            }
            
            // cut anything off wall-side
            translate([-1, 0, -200]) {
                cube([PEDAL_WIDTH + 2, 2*HEIGHT, 200]);
            }
            
            // cut away the bottom edge
            translate([PEDAL_WIDTH + 1, PEDAL_BACKPLATE_HEIGHT, 0]) {
                rotate([180, 0, 180]) {
                    rotate([-90 + PEDAL_BOTTOM_ANGLE, 0, 0]) {
                        cube([PEDAL_WIDTH + 2, DEPTH, HEIGHT]);
                    }
                }
            }
        }
    }
    
    module top_corners() {
        // top left
        rotate([0, 90, 0]) {
            translate([-PEDAL_BACKPLATE_DEPTH - 10, 0, 0]) {
                inner_corner_with_backs(PEDAL_TOP_CORNER_RADIUS, PEDAL_BACKPLATE_DEPTH + 20, 1);
            }
        }
        
        // top right
        translate([PEDAL_WIDTH, 0, PEDAL_BACKPLATE_DEPTH]) {
            rotate([0, -90, 0]) {
                translate([-PEDAL_BACKPLATE_DEPTH - 10, 0, 0]) {
                    inner_corner_with_backs(PEDAL_TOP_CORNER_RADIUS, PEDAL_BACKPLATE_DEPTH + 20, 1);
                }
            }
        }
    }
    
    module screw_holes() {
        translate([PEDAL_WIDTH/2, PEDAL_SCREW_Y_OFFET_TOP, PEDAL_BACKPLATE_DEPTH + 1]) {
            rotate([180, 0, 0]) {
                screw_hole(INNER_SCREW_RADIUS, OUTER_SCREW_RADIUS, PEDAL_BACKPLATE_DEPTH + 2, OUTER_SCREW_DEPTH + 1);
            }
        }

        translate([PEDAL_WIDTH/2, PEDAL_BACKPLATE_HEIGHT - PEDAL_SCREW_Y_OFFSET_BOTTOM, PEDAL_BACKPLATE_DEPTH + 1]) {
            rotate([180, 0, 0]) {
                screw_hole(INNER_SCREW_RADIUS, OUTER_SCREW_RADIUS, PEDAL_BACKPLATE_DEPTH + 2, OUTER_SCREW_DEPTH + 1);
            }
        }
    }
    
    module bike_logo() {
        scale([.05, .05, .01]) {
            // surface(file = "bike.png", center = true, invert = true);
        }
    }

    difference() {
        union() {
            backplate();
            main_holder();
        }
        top_corners();
        screw_holes();
    }
}

// Not currently used, playing with rounding edges.  Note: takes FOREVER -- LOWER $fn to <= 10 to test
module round() {
    minkowski() {
        child();
        sphere(1);
    }
}

// create two wheel platforms
if (PRINT_PEDAL_HOLDER) {
translate([PEDAL_WIDTH, -10, 0]) rotate([0, 0, 180]) pedal_holder();
}

if (PRINT_WHEEL_MOUNT1) {
    translate([0, BASE_PLATFORM_DEPTH, 0]) rotate([90, 0, 0]) base_platform();
}

if (PRINT_WHEEL_MOUNT2) {
    translate([0, 2 * BASE_PLATFORM_DEPTH + 10, 0]) rotate([90, 0, 0]) base_platform();
}