/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in June 2016
 *
 * Licensed under the
 * Creative Commons - Attribution - Share Alike license.
 */

// -----------------------------------------------------------

head_height = 14.7;
head_width = 20.8;
head_intersect_angle = 225;
head_intersect_x = 19;
head_intersect_y = 21;
head_intersect_off_x = -3.5;
head_intersect_off_y = -4.9;
nub_width = 5;
nub_height = 1;
nub_depth = 1;
nub_off = 8.9;
hole = 2.7;
hole_dist_x = 3.95;
hole_dist_y = 5.85;
height = 2.5;
arm_height = 11;
arm_width = 65;
foot_height = 12;
foot_length = 20;
foot_angle = 45;
foot_off_x = -16;
foot_off_y = -1;

cutout_1_width = 8;
cutout_1_height = 4;
cutout_1_x = 25;
cutout_1_y = 5;
cutout_1_angle = 20;

cutout_2_width = 8;
cutout_2_height = 4;
cutout_2_x = 42.5;
cutout_2_y = 5;
cutout_2_angle = 20;

cutout_3_width = 8;
cutout_3_height = 4;
cutout_3_x = 60;
cutout_3_y = 5;
cutout_3_angle = 20;

$fn = 20;

// -----------------------------------------------------------

difference() {
    union() {
        intersection() {
            cube([head_width, head_height, height]);
            rotate([0, 0, head_intersect_angle])
                translate([-head_intersect_x + head_intersect_off_x, head_intersect_off_y, 0])
                cube([head_intersect_x, head_intersect_y, height]);
        }
        
        translate([head_width - nub_width, nub_off, height])
            cube([nub_width, nub_height, nub_depth]);
        
        translate([head_width, 0, 0])
            cube([arm_width, arm_height, height]);

        translate([head_width + arm_width + foot_off_x, foot_off_y, 0])
            rotate([0, 0, -foot_angle])
            cube([height, foot_length, foot_height]);
    }
    
    translate([hole_dist_x, hole_dist_y, -1])
        cylinder(d = hole, h = height + 2);
    
    translate([head_width + arm_width - 20, -10, -1])
        cube([10, 10, 10 + foot_height]);

    translate([head_width + arm_width - 8, arm_height, -1])
        cube([10, 10, 10 + foot_height]);
    
    translate([head_width + arm_width + foot_off_x, foot_off_y, -1])
            rotate([0, 0, -foot_angle])
            translate([2, 0, 0])
            cube([10, 20, 10 + foot_height]);
    
    translate([cutout_1_x, cutout_1_y, -1])
        rotate([0, 0, -cutout_1_angle])
        cube([cutout_1_width, cutout_1_height, height + 2]);
    
    translate([cutout_2_x, cutout_2_y, -1])
        rotate([0, 0, -cutout_2_angle])
        cube([cutout_2_width, cutout_2_height, height + 2]);
        
    translate([cutout_3_x, cutout_3_y, -1])
        rotate([0, 0, -cutout_3_angle])
        cube([cutout_3_width, cutout_3_height, height + 2]);
}
