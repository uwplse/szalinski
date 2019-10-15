/*
 * Created by:
 * Thomas Buck <xythobuz@xythobuz.de> in March 2016
 *
 * Licensed under the Creative Commons - Attribution license.
 */

// -----------------------------------------------------------

$fn = 50;

/*
 * Depending on your printer and exact settings, you need to adjust
 * this parameter. I've had a tight fit with 17.8mm for a 17mm lens.
 */
diameter = 17.8; // diameter of the lens

width = 1; // wall thickness
bottom_width = 1; // bottom wall thickness
height = 6; // height of the whole lens cap

// -----------------------------------------------------------

difference() {
    // whole part
    cylinder(h = height, d = (diameter + (2 * width)));

    translate([0, 0, bottom_width])
        cylinder(h = height - bottom_width, d = diameter);
}
