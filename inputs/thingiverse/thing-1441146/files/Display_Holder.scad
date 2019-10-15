/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in March 2016
 *
 * Licensed under the Creative Commons - Attribution license.
 */

// -----------------------------------------------------------

$fn = 25;

height = 10;

// works properly from around 40 to 80 degrees
display_angle = 80; // in degrees

// "right", "left", "both" or "none"
hole_position = "both";
hole_diameter = 2.9;

// -----------------------------------------------------------

module holder() {
    // front part
    translate([10, 0, 0])
    difference() {
        translate([-13 + (5 * sin(display_angle - 45)),
                    -6 - (3 * sin(display_angle - 45)), 0])
            rotate([0, 0, display_angle])
            cube([13, 6, height]);
    
        // cut off top edge
        translate([-15, 5, 0])
            cube([10, 3, height]);
    }

    // upper body
    translate([0, 0, 0])
        cube([10, 5, height]);

    // lower body
    translate([5, -24, 0])
        cube([4, 24, height]);

    // upper border
    translate([10, 0, 0])
        cube([7, 5, height]);

    // upper lip
    translate([14, -5, 0])
        cube([3, 5, height]);

    // lower border
    translate([9, -24, 0])
        cube([3, 3, height]);
}

difference() {
    holder();
    
    // insert holes
    if ((hole_position == "right") || (hole_position == "both")) {
        rotate([0, 90, 90 + display_angle])
            translate([-8, -0.5 + (4 * sin(display_angle - 45)), -4])
            cylinder(d=hole_diameter, h=10);
    }
    if ((hole_position == "left") || (hole_position == "both")) {
        rotate([0, 90, 90 + display_angle])
            translate([-2, -0.5 + (4 * sin(display_angle - 45)), -4])
            cylinder(d=hole_diameter, h=10);
    }
}
