/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in May 2016
 *
 * Licensed under the Creative Commons - Attribution license.
 */

// -----------------------------------------------------------

hole_distance = 70;
hole_size = 5;

hook_width = 5;
hook_length = 5;
hook_height = 6.5;
hook_strength = 2;
hook_outer_distance = 71;
hook_angle = 18;

base_width = 78;
base_depth = 10;
base_height = 1;

$fn = 15;

// -----------------------------------------------------------

module hook() {
    cube([hook_width, hook_strength, hook_height]);
    translate([0, 0, hook_height])
        cube([hook_width, hook_length, hook_strength]);
}

module hooks() {
    translate([(hook_outer_distance / 2) - hook_width, 0, 0])
        hook();

    translate([-(hook_outer_distance / 2) + hook_width, 0, 0])
        rotate([0, 0, 180])
        hook();
}

module base() {
    difference() {
        union() {
            cube([base_width, base_depth, base_height]);
        
            translate([0, base_depth, 0])
                cube([13, 8, base_height]);
        
            translate([base_width - 13, -base_depth + 2, 0])
                cube([13, 8, base_height]);
        }
        
        translate([(base_width - hole_distance) / 2, base_depth / 2, -1])
            cylinder(d = hole_size, h = base_height + 2);
        
        translate([(base_width + hole_distance) / 2, base_depth / 2, -1])
            cylinder(d = hole_size, h = base_height + 2);
    }
}

// -----------------------------------------------------------

translate([-base_width / 2, -base_depth / 2, 0])
    base();

translate([0, 0, base_height])
    rotate([0, 0, -hook_angle])
    hooks();
