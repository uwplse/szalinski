/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in May 2016
 *
 * Licensed under the
 * Creative Commons - Attribution - Share Alike license.
 */

// -----------------------------------------------------------

cam_width = 61; // 60.5
cam_depth = 22; // 21.3
cam_height = 43; // 42.1

button_size = 12;
button_dist = 14;

mic_hole = 2.5;
mic_hole_dist = 17.8;
mic_hole_2_width = 2;
mic_hole_2_height = 8;
mic_hole_2_dist = 4.5;

bottom_hole = 8.5;
bottom_hole_dist = 17.2;
light_hole = 3;
light_hole_dist_x = 9;
light_hole_dist_y = 5.5;

wifi_hole = 6.4;
wifi_hole_dist = 17.5;
wifi_hole_2 = 3;
wifi_hole_2_dist = 6;

mount_width = 3; // 3.1
mount_gap = 3.2; // 3.1
mount_depth = 16.4; // 16.4
mount_height = 16.2; // 16.1
mount_hole = 5.2; // 5
mount_hole_dist = 7.8; // 7.7
mount_offset = -7; // -7

wall_size = 1.8;
lip_height = 1;
lip_width = 1.4;

print_support_size = 10;
print_support_height = 0.4;

$fn = 20;

// -----------------------------------------------------------

module print_support() {
    difference() {
        cylinder(d = print_support_size, h = print_support_height);
        translate([0, 0, -1])
            cube([print_support_size / 2, print_support_size / 2, print_support_height + 2]);
    }
}

module half_cylinder(d, h) {
    rotate([0, 0, 180])
    difference() {
        cylinder(d = d, h = h);
        translate([-(d / 2), 0, -1])
            cube([d, d / 2, h + 2]);
    }
}

module frame() {
    // left wall
    translate([0, wall_size, 0])
        cube([wall_size, cam_height, cam_depth]);
    
    // right wall
    translate([wall_size + cam_width, wall_size, 0])
        cube([wall_size, cam_height, cam_depth]);
    
    // bottom wall
    cube([cam_width + (2 * wall_size), wall_size, cam_depth]);
    
    // top wall
    translate([0, wall_size + cam_height, 0])
        cube([cam_width + (2 * wall_size), wall_size, cam_depth]);
}

module frameWithButton() {
    difference() {
        frame();
        
        // button
        translate([wall_size + button_dist, (2 * wall_size) + cam_height + 1, cam_depth / 2])
            rotate([90, 0, 0])
            cylinder(d = button_size, h = wall_size + 2);
        
        // mic hole
        translate([wall_size + cam_width - mic_hole_dist, (2 * wall_size) + cam_height + 1, cam_depth / 2])
            rotate([90, 0, 0])
            cylinder(d = mic_hole, h = wall_size + 2);
        
        // mic slit
        translate([wall_size + cam_width - mic_hole_2_dist, -1, (cam_depth - mic_hole_2_height) / 2])
            cube([mic_hole_2_width, wall_size + 2, mic_hole_2_height]);
        
        // bottom hole
        translate([wall_size + cam_width - bottom_hole_dist, wall_size + 1, cam_depth / 2])
            rotate([90, 0, 0])
            cylinder(d = bottom_hole, h = wall_size + 2);
        
        // light hole
        translate([wall_size + light_hole_dist_x, wall_size + 1, cam_depth - light_hole_dist_y])
            rotate([90, 0, 0])
            cylinder(d = light_hole, h = wall_size + 2);
        
        // wifi hole
        translate([wall_size + cam_width - 1, wall_size + wifi_hole_dist, cam_depth / 2])
            rotate([0, 90, 0])
            cylinder(d = wifi_hole, h = wall_size + 2);
            
        // wifi light hole
        translate([wall_size + cam_width - 1, wall_size + wifi_hole_dist + wifi_hole_2_dist, cam_depth / 2])
            rotate([0, 90, 0])
            cylinder(d = wifi_hole_2, h = wall_size + 2);
    }
}

module lip() {
    // left lip
    translate([0, wall_size, 0])
        cube([wall_size + lip_width, cam_height, lip_height]);
    
    // right lip
    translate([wall_size + cam_width - lip_width, wall_size, 0])
        cube([wall_size + lip_width, cam_height, lip_height]);
    
    // bottom lip
    cube([cam_width + (2 * wall_size), wall_size + lip_width, lip_height]);
    
    // top lip
    translate([0, wall_size + cam_height - lip_width, 0])
        cube([cam_width + (2 * wall_size), wall_size + lip_width, lip_height]);
}

module frameLips() {
    translate([0, 0, lip_height])
        frameWithButton();
    
    lip();
    
    translate([0, 0, cam_depth + lip_height])
        lip();
    
    print_support();
    
    translate([cam_width + (2 * wall_size), 0, 0])
        rotate([0, 0, 90])
        print_support();
    
    translate([cam_width + (2 * wall_size), cam_height + (2 * wall_size), 0])
        rotate([0, 0, 180])
        print_support();
    
    translate([0, cam_height + (2 * wall_size), 0])
        rotate([0, 0, 270])
        print_support();
}

module mountArm() {
    difference() {
        union() {
            translate([0, mount_height - (mount_depth / 2), 0])
                rotate([0, 90, 0])
                half_cylinder(mount_depth, mount_width);
            
            translate([0, -wall_size, -(mount_depth / 2)])
                cube([mount_width, mount_height - (mount_depth / 2) + wall_size, mount_depth]);
        }
        
        translate([-1, mount_height - mount_hole_dist, 0])
            rotate([0, 90, 0])
            cylinder(d = mount_hole, h = mount_width + 2);
    }
}

module mount() {
    mountArm();
    
    translate([mount_width + mount_gap, 0, 0])
        mountArm();
}

module cover() {
    difference() {
        frameLips();
        translate([wall_size + ((cam_width - (mount_gap + (2 * mount_width))) / 2) + mount_offset + mount_width, wall_size + cam_height - lip_width - 1, -1])
            cube([mount_gap, wall_size + lip_width + 2, cam_depth + (2 * lip_height) + 2]);
    }

    translate([wall_size + ((cam_width - (mount_gap + (2 * mount_width))) / 2) + mount_offset, (2 * wall_size) + cam_height, lip_height + (cam_depth / 2)])
        mount();
    
    translate([wall_size + (cam_width / 2) + mount_offset, wall_size + cam_height, 0])
        cylinder(d = print_support_size, h = print_support_height);
}

// -----------------------------------------------------------

translate([print_support_size / 2, print_support_size / 2, 0])
    cover();
