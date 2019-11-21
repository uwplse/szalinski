
/* [Basic] */

// The cutting height in mm
height = 12;

/* [Advanced] */

// The number of tines or teeth in the comb
tines = 8;

// the width of the tines
tine_width = 1.15;

// angle between the clipper and the base of the tines
base_angle = 15;

/* [Attachment] */

trimmer_width = 32;
trimmer_length = 37;
trimmer_height = 3;
attach_wall = 2;
attach_front_clip = 4;
attach_rear_clip = 5;
clip_depth = 1.3;

/* [Hidden] */

tol = 0.01;
tol2 = 0.02;
full_width = trimmer_width + attach_wall * 2;
full_length = trimmer_length + attach_wall * 2;
front_overlap = attach_front_clip - attach_wall;
tine_spacing = (full_width - tine_width) / (tines - 1);
spring_gap = tine_spacing - attach_wall;

module trimmer() {
    difference() {
        cube([trimmer_width, trimmer_length, trimmer_height+tol]);
        rotate([30,0,0])
        cube([trimmer_width, trimmer_length, trimmer_height]);
    }
}

//trimmer();

module trimmer_attach_diff() {
    trimmer();
    translate([0, trimmer_length/2, -attach_wall-tol])
        cube([spring_gap, trimmer_length/2, attach_wall+tol2]);
    translate([trimmer_width - spring_gap, trimmer_length/2, -attach_wall-tol])
        cube([spring_gap, trimmer_length/2, attach_wall+tol2]);
    translate([0, trimmer_length - spring_gap,-attach_wall-tol])
        cube([trimmer_width, spring_gap, attach_wall+tol2]);
    translate([-attach_wall-tol, trimmer_length/2, 0])
        cube([(full_width - attach_rear_clip)/2+tol, trimmer_length, trimmer_height+tol]);
    translate([(trimmer_width + attach_rear_clip)/2, trimmer_length/2, 0])
        cube([(full_width - attach_rear_clip)/2+tol, trimmer_length, trimmer_height+tol]);
    translate([-attach_wall-tol, trimmer_length/2, 0])
        cube([full_width+tol2, trimmer_length/2 - attach_wall, trimmer_height+tol]);
}

module trimmer_attach() {
    difference() {
        union() {
            translate([-attach_wall, -attach_wall, -attach_wall])
                cube([full_width, full_length, trimmer_height + attach_wall]);
            translate([(trimmer_width-attach_rear_clip)/2, trimmer_length, 0]) {
                cube([attach_rear_clip, attach_wall, attach_rear_clip]);
            translate([0, 0, trimmer_height]) rotate([45,0,0])
                cube([attach_rear_clip, clip_depth, clip_depth]);
            }
        }
        translate([front_overlap, -attach_wall, -attach_wall-tol])
            cube([trimmer_width - front_overlap * 2, trimmer_length/4, trimmer_height+attach_wall+tol2]);
        trimmer_attach_diff();
    }
}

//trimmer_attach();

module tine() {
    max_h = height + trimmer_length * sin(base_angle);
    len = height + (trimmer_length+attach_wall) * cos(base_angle);
    difference() {
        translate([0, -height, -height]) {
            difference() {
                cube([tine_width, len, max_h]);
                translate([-tol,0,0]) {
                    rotate([45,0,0])
                        cube([tine_width+tol2, len, max_h]);
                    translate([0,1,-tol]) rotate([90,0,0])
                        cube([tine_width+tol2, len, max_h]);
                }
            }
        }
        translate([-tol,0,0]) {
        rotate([base_angle,0,0])
            cube([tine_width+tol2, len, max_h]);
        }
    }
}

//tine();

module assembly() {
    difference() {
        union() {
            rotate([base_angle,0,0]) trimmer_attach();
            translate([-attach_wall,0,0]) {
                for (x=[0:tines-1])
                    translate([x * tine_spacing, 0, 0])
                        tine();
            }
        }
        rotate([base_angle,0,0]) trimmer_attach_diff();        
    }
}

assembly();
