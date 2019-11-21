/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in May 2016
 *
 * Licensed under the
 * Creative Commons - Attribution - Share Alike license.
 */

// -----------------------------------------------------------

width_outer = 47.8;
height_outer = 31.5;
hole = 7;
depth = 1.8;
wall = 1.4;
inner_y_offset = -1;
diameter_big = 58;
offset_big = 23;
diameter_mid = 60;
offset_mid = 24.5;
diameter_small = 22;
offset_small = 8;

fpv_width = 36.5;
fpv_depth = 11;
fpv_offset = 5;
fpv_hole = 2.5;
fpv_holder_width = 8;
fpv_holder_top = 2.5;
fpv_wall = 2;

cam_depth = 15.5;
cam_base_height = 9;
cam_arm_height = 17;
cam_arm_hole_dist = 9.5;
cam_arm_hole = 5;
cam_arm_width = 3.1;
cam_arm_dist = 3.1;
cam_nut_outer = 12;
cam_nut_inner = 9.2;
cam_nut_height = 4;
cam_holder_offset = 13.8;

$fn = 30;

// -----------------------------------------------------------

module half_cylinder(d, h) {
    rotate([0, 0, 180])
    difference() {
        cylinder(d = d, h = h);
        translate([-(d / 2), 0, -1])
            cube([d, d / 2, h + 2]);
    }
}

module cam_arm() {
    difference() {
        union() {
            cube([cam_arm_width, cam_depth, cam_arm_hole_dist]);
            translate([0, cam_depth / 2, cam_arm_hole_dist])
                rotate([90, 0, 90])
                half_cylinder(cam_depth, cam_arm_width);
        }
        
        translate([-1, cam_depth / 2, cam_arm_hole_dist])
            rotate([0, 90, 0])
            cylinder(d = cam_arm_hole, h = cam_arm_width + 2);
    }
}

module cam_arm_nut() {
    translate([-cam_nut_height, 0, 0])
    rotate([0, 90, 0])
    difference() {
        cylinder(d = cam_nut_outer, h = cam_nut_height);
        translate([0, 0, -1])
            cylinder(d = cam_nut_inner, h = cam_nut_height + 2, $fn = 6);
    }
}

module cam_holder() {
    cube([(3 * cam_arm_width) + (2 * cam_arm_dist), cam_depth, cam_base_height]);
    
    translate([0, 0, cam_base_height])
        cam_arm();
    
    translate([0, cam_depth / 2, cam_base_height + cam_arm_hole_dist])
        cam_arm_nut();
    
    translate([cam_arm_width + cam_arm_dist, 0, cam_base_height])
        cam_arm();
    
    translate([2 * (cam_arm_width + cam_arm_dist), 0, cam_base_height])
        cam_arm();
}

module base() {
    difference() {
        cube([width_outer, height_outer, depth]);
        
        translate([wall + (hole / 2), wall + (hole / 2), -1])
            cylinder(d = hole, h = depth + 2);
        
        translate([width_outer - wall - (hole / 2), wall + (hole / 2), -1])
            cylinder(d = hole, h = depth + 2);
        
        translate([wall + (hole / 2), height_outer - wall - (hole / 2), -1])
            cylinder(d = hole, h = depth + 2);
        
        translate([width_outer - wall - (hole / 2), height_outer - wall - (hole / 2), -1])
            cylinder(d = hole, h = depth + 2);
        
        translate([width_outer / 2, -offset_mid, -1])
            cylinder(d = diameter_mid, h = depth + 2);
        
        translate([width_outer / 2, height_outer + offset_big, -1])
            cylinder(d = diameter_big, h = depth + 2);
        
        translate([-offset_small, height_outer / 2, -1])
            cylinder(d = diameter_small, h = depth + 2);
            
        translate([width_outer + offset_small, height_outer / 2, -1])
            cylinder(d = diameter_small, h = depth + 2);
            
        translate([0, 0, -1])
            rotate([0, 0, 45])
            translate([-2.8, -2.8, 0])
            cube([5, 5, depth + 2]);
            
        translate([width_outer, 0, -1])
            rotate([0, 0, 45])
            translate([-2.8, -2.8, 0])
            cube([5, 5, depth + 2]);
            
        translate([0, height_outer, -1])
            rotate([0, 0, 45])
            translate([-2.8, -2.2, 0])
            cube([5, 5, depth + 2]);
        
        translate([width_outer, height_outer, -1])
            rotate([0, 0, 45])
            translate([-2.2, -2.2, 0])
            cube([5, 5, depth + 2]);
    }
}

module arm() {
    difference() {
        cube([fpv_wall, fpv_holder_width, fpv_offset + (fpv_width / 2) + (fpv_hole / 2) + fpv_holder_top]);
        
        translate([-1, fpv_holder_width / 2, fpv_offset + (fpv_width / 2)])
            rotate([0, 90, 0])
            cylinder(d = fpv_hole, h = fpv_wall + 2);
    }
}

module fpv_holder() {
    arm();
    
    translate([fpv_width + fpv_wall, 0, 0])
        arm();
}

// -----------------------------------------------------------

base();

translate([(width_outer - fpv_width) / 2 - fpv_wall, (height_outer - fpv_holder_width) / 2, depth])
    fpv_holder();

translate([cam_holder_offset, (height_outer + cam_depth) / 2, 0])
    rotate([180, 0, 0])
    cam_holder();

// -----------------------------------------------------------
/*
%translate([(width_outer - fpv_width) / 2, (height_outer - fpv_depth) / 2, depth + fpv_offset])
    cube([fpv_width, fpv_depth, fpv_width]);

%translate([width_outer / 2, (height_outer - fpv_depth) / 2 + 1, depth + fpv_offset + (fpv_width / 2)])
    rotate([90, 0, 0])
    cylinder(d = fpv_width / 3, h = 8);
*/
