/******************************************************************************
 * PARAMETRIC CUSTOMIZABLE SHOWER BOTTLE HOLDER version 1.0 (2019-09-28)
 * Copyright (c) Michal A. Valasek, 2019, licensed under CC BY-NC-SA
 *               www.rider.cz | www.altair.blog
 *****************************************************************************/

/* [Dimensions] */
// Internal width
inner_diameter_x = 70;
// Internal depth
inner_diameter_y = 34;
// Internal height
inner_height = 90;

/* [Suction Cup Option] */
// Narrow part slot diameter
slot_diameter_narrow = 8;
// Wide part slot diameter
slot_diameter_wide = 12;
// Slot position from top
slot_position_from_top = 5;
// Lip depth
lip_depth = 3;

/* [Construction] */
// Wall thickness
wall_thickness = 1.67;
// Bottom thickness
bottom_thickness = 1.6;
// Relative diameter of bottom hole
bottom_hole_size = .75;

/* [Hidden] */
$fn = 64;

// Computed variables
total_height = inner_height + bottom_thickness;
slot_position = total_height - slot_position_from_top - slot_diameter_wide / 2 - slot_diameter_narrow;

// Bottom with lip
linear_extrude(bottom_thickness) difference() {
    union() {
        base();
        if(lip_depth > 0) translate([0, -lip_depth]) offset(wall_thickness) base();
    }
    if(bottom_hole_size > 0) circle(d = bottom_hole_size * min(inner_diameter_x, inner_diameter_y));
}

// Walls
difference() {
    // Walls proper
    linear_extrude(total_height) difference() {
        offset(wall_thickness) base();
        base();
    }

    // Keyhole slot
    translate([0, 0, slot_position]) rotate([90, 0, 0]) linear_extrude(inner_diameter_y) {
        circle(d = slot_diameter_wide, $fn = 32);
        hull() {
            circle(d = slot_diameter_narrow, $fn = 32);
            translate([0, (slot_diameter_wide + slot_diameter_narrow) / 2]) circle(d = slot_diameter_narrow, $fn = 32);
        }
    }
}

// Basic shape
module base(include_lip = false) {
    resize([inner_diameter_x, inner_diameter_y]) circle(d = max(inner_diameter_x, inner_diameter_y));
    translate([-inner_diameter_x / 2, -inner_diameter_y / 2]) square([inner_diameter_x, inner_diameter_y / 2]);
}