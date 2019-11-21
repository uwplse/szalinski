/*
 * Based on the "Fabrikator mini Esun Spool holder" by "Rlw":
 * http://www.thingiverse.com/thing:1324831
 *
 * Recreated and parameterized by:
 * Thomas Buck <xythobuz@xythobuz.de> in March 2016
 *
 * Licensed under the Creative Commons - Attribution license.
 *
 * Settings suggested by the original author:
 *   Rafts: No
 *   Supports: No
 *   Resolution: 0.2mm
 *   Infill: 15%
 */

// Modify the overall length (moving the top part)
size_modifier = -25;

// Spool width
spool_width = 35;

// Distance of spool rollers from border
balls_distance = 7.5;

// width of outer spool border
outer_border_width = 6;

// set if the inner spool border should be rounded
// to save some more material
round_top = true;

// -----------------------------------------------------------

inner_border_width = round_top ? 10 : 5;
body_height_modifier = round_top ? -19 : 0;

// -----------------------------------------------------------

// a cylinder cut in half in the middle
module half_cylinder(h, r) {
    difference() {
        cylinder(h, r, r);
        translate([0, -r, 0]) cube([r, 2 * r, h]);
    }
}

// -----------------------------------------------------------

//import("fabrikator_mini_gsun_5kg_175mm__spool_holder.stl");

// upper body
translate([5, -19, 0])
    cube([5, 51 + size_modifier + body_height_modifier, 40]);

// lower body
translate([5, -43, 0])
    cube([4, 24, 40]);

// upper border
translate([10, -19, 0])
    cube([9, 5, 40]);

// upper lip
translate([14, -24, 0])
    cube([5, 5, 40]);

// lower border
translate([9, -43, 0])
    cube([3, 3, 40]);

// stabilization
translate([0,  size_modifier, 0]) difference() {
    rotate([0, 0, 45]) translate([2.5, -5, 0]) cube([4, 21, 40]);

    translate([5, -5, 0]) cube([10, 10, 40]);
    translate([-10, 13, 0]) cube([10, 10, 40]);
}

// inner border
translate([0,  size_modifier, 0])
    scale([1, 0.85, 1])
    translate([0, 15.5, 20])
    rotate([-90, 0, 0])
    rotate([0, 90, 0])
    half_cylinder(inner_border_width, 20);

// outer border
translate([0,  size_modifier, 0])
    scale([1, 0.85, 1])
    translate([-(spool_width + outer_border_width), 15.5, 20])
    rotate([-90, 0, 0])
    rotate([0, 90, 0])
    half_cylinder(outer_border_width, 20);

// roll plane
translate([0,  size_modifier, 0])
    translate([-(spool_width + outer_border_width), 13, 0])
    cube([spool_width + outer_border_width + inner_border_width, 1, 40]);

// roll
translate([0,  size_modifier, 0])
    scale([1, 0.4, 1])
    translate([-spool_width, 33, 20])
    rotate([-90, 0, 0])
    rotate([0, 90, 0])
    half_cylinder(spool_width, 20);

// rolling balls
translate([0,  size_modifier, 0])
    translate([-(spool_width - balls_distance), 19, 20])
    sphere(r = 3);
translate([0,  size_modifier, 0])
    translate([-balls_distance, 19, 20])
    sphere(r = 3);
