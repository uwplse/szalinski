/* [Overall dimensions] */
box_width = 45;
box_length = 75;
top_height = 10;
bottom_height = 17;

/* [Walls] */
wall_thickness = 1.2;
floor_thickness = 1.2;

/* [Lock] */
lock_width = 10;
lock_thickness = 1.5;
lock_height = 3;
button_width = 1.6;
button_gap = 0.2;

/* [Lip] */
lip_height = 1.4;
lip_thickness = 1.2;
lip_gap = 0.2;

/* [Hidden] */
hinge_square = 4.3;
facet = 5;
hinge_length = 15;
hinge_gap = 0.6;

$fn = 15;

module hinge_hole(hinge_height) {
    translate([hinge_square, hinge_length/2, hinge_height-10+hinge_square]) {
        rotate(45, [0, 1, 0]) {
            cube([hinge_square, hinge_length+1, hinge_square], true);
            translate([-10, 0, (hinge_square-hinge_gap)/2]) {
                cube([20, hinge_length+1, hinge_gap], true);
            }
        }
    }
}

module box_top() {
    difference() {
        difference() {
            cube([box_width, box_length, top_height]);
            translate([hinge_square*2, wall_thickness, floor_thickness]) {
                    cube([box_width-hinge_square*2-wall_thickness, box_length-wall_thickness*2, top_height-floor_thickness+1]);
                }
            translate([0, -1, top_height-facet]) {
                rotate(-45, [0, 1, 0]) {
                    cube([20, box_length+2, 20]);
                }
            }
        }
        hinge_hole(top_height);
        translate([0, box_length, 0]) {
            mirror([0, 1, 0]) {
                hinge_hole(top_height);
            }
        }
    }
    translate([box_width, (box_length-lock_width)/2, 0]) {
        cube([lock_thickness, lock_width, top_height+lock_height]);
    }
    translate([box_width, (box_length-lock_width)/2, top_height+lock_height-button_width/2]) {
        difference() {
            rotate(-90, [1, 0, 0]) {
                cylinder(lock_width, button_width/2, button_width/2);
            }
            translate([button_width/2, lock_width/2, 0]) {
                cube([button_width, lock_width, button_width], true);
            }
        }
    }
}

module box_buttom() {
    difference() {
        union() {
            cube([box_width, box_length, bottom_height]);
            translate([hinge_square*2+lip_gap, wall_thickness+lip_gap, floor_thickness]) {
                cube([box_width-hinge_square*2-wall_thickness-lip_gap*2, box_length-wall_thickness*2-lip_gap*2, bottom_height-floor_thickness+lip_height]);
            }
        }
        translate([0, -1, bottom_height-facet]) {
            rotate(-45, [0, 1, 0]) {
                cube([20, box_length+2, 20]);
            }
        }
        translate([hinge_square*2+lip_gap+lip_thickness, wall_thickness+lip_gap+lip_thickness, floor_thickness]) {
            cube([box_width-hinge_square*2-wall_thickness-lip_gap*2-lip_thickness*2, box_length-wall_thickness*2-lip_gap*2-lip_thickness*2, bottom_height-floor_thickness+lip_height+1]);
        }
        hinge_hole(bottom_height);
        translate([0, box_length, 0]) {
            mirror([0, 1, 0]) {
                hinge_hole(bottom_height);
            }
        }
        translate([box_width-button_width/2, (box_length-lock_width)/2-button_gap, bottom_height-lock_height-button_gap]) {
            cube([button_width+1, lock_width+button_gap*2, button_width+button_gap*2]);
        }
    }
}

translate([0, 0, 0]) {
    box_top();
}
translate([box_width+lock_thickness+10, 0, 0]) {
    box_buttom();
}
