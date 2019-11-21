// Derived from http://www.sergepayen.fr/en/parametric-u-hook by Serge Payen, January 2016
// Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
// http://creativecommons.org/licenses/by-nc-sa/4.0/

/* [General] */
// (millimeters, object width/print height)
thickness = 25; // [0.1:250]
// (millimeters, thinnest point2)
stiffness = 8; // [0.1:250]

/* [Main Hook] */
// (millimeters, internal diameter of U shape)
hook_size = 35; // [0.1:250]
// (hole in center of hook for material reduction)
hook_hole = 1; // [0:No, 1:Yes]
hook_tip = 1; // [0:Flat, 1:Triangle]

/* [Second hook] */
second_hook = 1; // [0:No, 1:Yes]
// (millimeters)
second_hook_length = 30; // [0.1:200]
// (degrees from vertical, best between 45° and 65°)
second_hook_angle = 55; // [0:90]
second_hook_tip = 1; // [0:Flat, 1:Triangle]

/* [Spacers] */
// (millimeters, between main hook and bottom screw)
spacer_1 = 20; // [0:200]
// (millimeters, between bottom screw and secondary hook)
spacer_2 = 10; // [0:200]
// (millimeters, between second hook and top screw)
spacer_3 = 10; // [0:200]
// (millimeters, between top screw and hook top)
spacer_4 = 10; // [0:200]

/* [Screw holes] */
screw_holes = 0; // [0:No, 1:Yes]
// (millimeters)
screw_diameter = 3; // [0:0.5:20]
// (millimeters)
countersink_diameter = 8; // [0:0.5:40]
// (millimeters)
countersink_depth = 3; // [0:0.5:20]
// (millimeters)
screw_tolerance = 0.5; // [0:0.1:10]

/* [Bracket] */
bracket_type = 1; // [0:None, 1:Square, 2:Round]
// (millimeters)
bracket_size = 40; // [0:250]
// (millimeters, back length, for Bracket Type: Square)
bracket_stop_length = 15; // [0:250]
// (millimeters, for Bracket Type: Square)
bracket_stiffness = 8; // [0:100]
// (for Bracket Type: Square)
bracket_safety_screw = 0; // [0:No, 1:Yes]
// (for Bracket Type: Square)
bracket_rounded_corners = 1; // [0:No, 1:Yes]


/* [Hidden] */
bottom_width = hook_size + (stiffness * 2);
bottom_height = bottom_width - (hook_size / 2);
screw_house = countersink_diameter + (screw_tolerance * 2);

$fn = 150;
epsilon = 0.1;


bottom(bottom_width, bottom_height, thickness, stiffness, hook_hole)
belly(bottom_width, hook_size / 2, thickness) {
    translate([bottom_width - stiffness, 0, 0]) {
        tip(stiffness, 0, thickness, hook_tip);
    }

    spacer(stiffness, spacer_1, thickness)
    screw(stiffness, screw_house, thickness)
    spacer(stiffness, spacer_2, thickness)
    arm(stiffness, second_hook_length, thickness, second_hook_angle, second_hook_tip)
    spacer(stiffness, spacer_3, thickness)
    screw(stiffness, screw_house, thickness)
    spacer(stiffness, spacer_4, thickness)
    
    if (bracket_type == 1) {
        head(stiffness, stiffness, thickness, bracket_rounded_corners)

        translate([-bracket_stiffness, 0, 0]) {
            top(bracket_stiffness, bracket_size, thickness)
            head(bracket_stiffness, bracket_stiffness, thickness, bracket_rounded_corners)
        
            translate([-bracket_stiffness, 0, 0]) {
                stop(bracket_stiffness, bracket_stop_length, thickness);
            }
        }
    } else if (bracket_type == 2) {
        pipeHook(stiffness, bracket_size, thickness);
    }
}

module bottom(width, height, depth, stiffness, hole) {    
    color("Cyan")

    difference() {
        intersection() {
            cube([width, height, depth]);

            translate([(width / 2) - stiffness, height, 0]) {
                cylinder(r=height, h=depth);
            }
        }

        if (hole) {
            translate([width / 2, height / 2, -epsilon]) {
                hull() {
                    big_r = height / 5;
                    small_r = height / 10;
                    translate([-big_r / 2 - stiffness / 4, 0, 0]) {
                        cylinder(r=big_r, h=depth + (epsilon * 2));
                    }

                    translate([big_r, stiffness / 2, 0]) {
                        cylinder(r=small_r, h=depth + (epsilon * 2));
                    }
                }
            }
        }
        
    }
    
    translate([0, height, 0]) children();
}

module belly(width, height, depth) {
    color("Crimson")
    
    difference() {
        // base cube
        cube([width, height, depth]);

        // half-cylindric hole
        translate([width / 2, height, -epsilon]) {
            cylinder(r=height, h=depth + (epsilon * 2));
        }
    }
    
    translate([0, height, 0]) children();
}


module tip(width, height, depth, type) {
    color("SpringGreen")
    
    translate([0, 0, depth / 2]) {
        rotate([0, 90, 0]) {
            difference() {
                hull() {
                    translate([depth/2 - depth/10, 0, 0]) {
                        cylinder(d=depth/5, h=width);
                    }
                    translate([-depth/2 + depth/10, 0, 0]) {
                        cylinder(d=depth/5, h=width);
                    }

                    if (type == 1) {
                        translate([depth/7, depth/5, 0]) {
                            cylinder(d=depth/5, h=width);
                        }
                        translate([-depth/7, depth/5, 0]) {
                            cylinder(d=depth/5, h=width);
                        }
                    }
                }

                translate([-depth / 2, -depth / 5, -epsilon]) {
                    cube([depth, depth / 5, width + epsilon * 2]);
                }
            }
        }
    }
}

module spacer(width, height, depth) {
    color("DeepSkyBlue")
    
    cube([width, height, depth]);
    
    translate([0, height, 0]) children();
}

module screw(width, height, depth) {
    if (screw_holes) {
        color("Silver")
        
        difference() {
            cube([width, height, depth]);

            translate([0, height / 2, depth / 2]) {
                rotate([0, 90, 0]) {
                    screwHole(width);
                }
            }
        }
        
        translate([0, height, 0]) children();
    } else {
        children();
    }
}

module screwHole(depth) {
    screw_hole = screw_diameter + (screw_tolerance * 2);

    translate([0, 0, -epsilon]) {
        cylinder(d=screw_hole, h=depth + (epsilon * 2));

        translate([0, 0, depth - countersink_depth + (epsilon * 2)]) {
            cylinder(d=screw_house, h=countersink_depth + epsilon);
        }
    }
}



module arm(width, height, depth, angle, tip) {
    if (second_hook) {
        color("Orange")
        
        union() {
            cube([width, height, depth]);
        
            hull() {
                cube([width, width, depth]);
                translate([0, width, 0]) {
                    rotate([0, 0, -angle]) {
                        cube([width, height, depth]);
                    }
                }
            }
        }
        
        translate([0, width, 0]) {
            rotate([0, 0, -angle]) {
                translate([0, height, 0]) {
                    tip(width, 0, depth, tip);
                }
            }
        }

        translate([0, height, 0]) children();
    } else {
        children();
    }
}

module head(width, height, depth, rounded) {
    color("Gold")
    
    intersection() {
        cube([width, height, depth]);
        if (rounded) {
            translate([0, 0, -epsilon]) {
                cylinder(r=width, h=depth + (epsilon * 2));
            }
        }
    }
    
    translate([0, height, 0]) rotate([0, 0, 90]) children();
}

module top(width, height, depth) {
    color("Crimson")
    
    difference() {
        cube([width, height, depth]);
            
        if (bracket_safety_screw) {
            translate([0, height / 2, depth / 2]) {
                rotate([0, 90, 0]) {
                    screwHole(width);
                }
            }
        }
    }
    
    translate([0, height, 0]) children();
}

module stop(width, height, depth) {
    color("DeepSkyBlue")

    union() {
        cube([width, height, depth]);

        translate([0, height, 0]) {
            intersection() {
                cube([width, width, depth]);
                cylinder(r=bracket_stiffness, h=thickness+0.2);
            }
        }
    }
}

module pipeHook(width, height, depth) {
    outside_diam = height + (width * 2);
    
    color("Crimson")
    
    union() {
        translate([-height / 2, 0, 0]) {
            difference() {
                cylinder(d=outside_diam, h=depth);
                translate([0, 0, -epsilon]) {
                    cylinder(d=height, h=depth + (epsilon * 2));
                }
                translate([-outside_diam / 2, -outside_diam / 2, -epsilon]) {
                    cube([outside_diam, outside_diam / 2, depth + (epsilon * 2)]);
                }
            }
        }
        
        translate([-(height + (width / 2)), 0, 0]) {
            difference() {
                cylinder(d=width, h=depth);
                translate([-width / 2, 0, -epsilon]) {
                    cube([width, width, depth + (epsilon * 2)]);
                }
            }
        }
    }
}

/*
// TODO: Enable when OpenSCAD turns on assert support in builds

assert(hook_hole == 0 || hook_hole == 1);
assert(hook_tip == 0 || hook_tip == 1);
assert(second_hook == 0 || second_hook == 1);
assert(second_hook_tip == 0 || second_hook_tip == 1);
assert(screw_holes == 0 || screw_holes == 1);
assert(bracket_type == 0 || bracket_type == 1 || bracket_type == 2);
assert(bracket_safety_screw == 0 || bracket_safety_screw == 1);
assert(bracket_rounded_corners == 0 || bracket_rounded_corners == 1);

if ((bracket_type == 1 && safety_screw) || screw_holes) {
    if (countersink_depth > 0) {
        assert(countersink_diameter >= screw_diameter);
    }
}

if (screw_holes) {
    assert(screw_house < thickness);
    assert(countersink_depth < stiffness);
}

if (bracket_type == 1 && safety_screw) {
    assert(screw_house < bracket_thickness);
    assert(countersink_depth < bracket_stiffness);
}
*/