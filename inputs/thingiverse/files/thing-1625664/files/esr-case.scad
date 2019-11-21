/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in June 2016
 *
 * Licensed under the Creative Commons - Attribution license.
 */

// -----------------------------------------------------------

width = 67;
height = 67.5;
hole_nub = 5;
hole = 2;
hole_width = 60;
hole_height = 40;
hole_offset_top = 3;
wall_size = 1.4;

depth_top = 3.6;
depth_pcb = 1.6;
depth_bottom = 4.1;
depth_gap = 1.8;
depth = depth_top + depth_pcb + depth_bottom + depth_gap;
screw_nub_depth = depth_bottom + depth_gap;

switch_width = 11.8;
switch_height = 5.8;
switch_hole = 2.2;
switch_hole_dist = 15;
switch_x = 2.5;
switch_y = 0;

cutout_width = 12;
cutout_height = 2;
cutout_x = 25.6;

helper_disc = 5;
helper_disc_height = 0.4;

$fn = 20;

// -----------------------------------------------------------

module nub() {
    difference() {
        cylinder(d = hole_nub, h = screw_nub_depth);
        translate([0, 0, -1])
            cylinder(d = hole, h = screw_nub_depth + 2);
    }
}

module nubs() {
    nub();
    
    translate([hole_width, 0, 0])
        nub();
    
    translate([0, hole_height, 0])
        nub();
    
    translate([hole_width, hole_height, 0])
        nub();
}

module switch() {
    translate([0, 0, switch_height / 2])
        rotate([0, 90, 0])
        cylinder(d = switch_hole, h = wall_size + 2);
    translate([0, (switch_hole_dist - switch_width) / 2, 0])
        cube([wall_size + 2, switch_width, switch_height]);
    translate([0, switch_hole_dist, switch_height / 2])
        rotate([0, 90, 0])
        cylinder(d = switch_hole, h = wall_size + 2);
}

// -----------------------------------------------------------

// base
cube([width + (2 * wall_size), height + (2 * wall_size), wall_size]);

// left wall
difference() {
    translate([0, 0, wall_size])
        cube([wall_size, height + (2 * wall_size), depth]);
    
    translate([-1, wall_size + height - hole_offset_top - hole_height + hole_nub, wall_size])
        cube([wall_size + 2, hole_nub, hole]);
    
    translate([-1, (switch_hole / 2) + wall_size + switch_x, wall_size + switch_y])
        switch();
}

// bottom wall
translate([0, 0, wall_size])
    cube([width + (2 * wall_size), wall_size, depth]);

// right wall
translate([width + wall_size, 0, wall_size])
    cube([wall_size, height + (2 * wall_size), depth]);

// top wall
difference() {
    translate([0, height + wall_size, wall_size])
        cube([width + (2 * wall_size), wall_size, depth]);
    translate([wall_size + cutout_x, height + wall_size - 1, wall_size + depth - cutout_height])
        cube([cutout_width, wall_size + 2, cutout_height + 1]);
}

translate([wall_size + (width - hole_width) / 2, wall_size + height - hole_height - hole_offset_top, wall_size])
    nubs();

cylinder(d = helper_disc, h = helper_disc_height);
translate([width + (2 * wall_size), height + (2 * wall_size), 0])
    cylinder(d = helper_disc, h = helper_disc_height);
translate([0, height + (2 * wall_size), 0])
    cylinder(d = helper_disc, h = helper_disc_height);
translate([width + (2 * wall_size), 0, 0])
    cylinder(d = helper_disc, h = helper_disc_height);
