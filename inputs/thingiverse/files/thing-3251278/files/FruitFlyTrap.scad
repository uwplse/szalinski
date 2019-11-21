/********************************************************
** FRUIT FLY TRAP GENERATOR version 1.0.0 (2018-12-01) **
** Copyright (c) Michal A. Valasek, 2018, CC-BY-NC-SA  **
**               www.rider.cz | www.altair.blog        **
********************************************************/

/* [Basic parameters] */
// (inner diameter of lid - outer diameter of the jar)
lid_inner_diameter = 50.5;
// (inner height of lid)
lid_inner_height = 10;

/* [Advanced] */
// (number of bumps/knurls along the perimerer, 0 to smooth edge)
lid_bump_count = 64;
wall_thickness = 1.6;
cone_height = 20;
cone_hole_diameter = 1.5;
cone_wide_diameter = 30;

/* [Hidden] */
lid_outer_diameter = lid_inner_diameter + 2 * wall_thickness;
lid_outer_height = lid_inner_height + wall_thickness;
fudge = .1;
$fn = 64;

difference() {
    union() {
        // Knurled lid
        difference() {
            union() {
                cylinder(d = lid_outer_diameter, h = lid_outer_height);
                if(lid_bump_count > 0) {
                    for(i = [0:lid_bump_count]) {
                        rotate(360 / lid_bump_count * i) translate([lid_outer_diameter / 2 - wall_thickness / 2, 0, 0]) 
                            cylinder(d = 3.14 * lid_outer_diameter / lid_bump_count, h = lid_outer_height, $fn = 32);
                    }
                }
            }
            translate([0, 0, wall_thickness]) cylinder(d = lid_inner_diameter, h = lid_outer_height);
        }
        // Cone
        translate([0, 0, wall_thickness]) cylinder(d1 = cone_wide_diameter, d2 = cone_hole_diameter, h = cone_height);
    }
    // Cone hole
    translate([0, 0, -fudge]) cylinder(d = cone_hole_diameter, h = cone_height + wall_thickness + 2 * fudge);
    translate([0, 0, -wall_thickness]) cylinder(d1 = cone_wide_diameter, d2 = cone_hole_diameter, h = cone_height);
}