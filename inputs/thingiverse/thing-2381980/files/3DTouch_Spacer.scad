/*
 * ChimeraMount.scad
 * v1.1.0 12th August 2017
 * Written by landie @ Thingiverse (Dave White)
 *
 * This script is licensed under the Creative Commons - Attribution - Non-Commercial license.
 *
 * http://www.thingiverse.com/thing:2381980
 *
 * A simple spacer to match teh X Carriage, customisable
 *
 */

// Variables you may want to adjust...
spacerThickness = 4; //[1:10]


/* [Hidden] */

touchMountBoltSpacing = 18;
touchMountLength = touchMountBoltSpacing + 12;
touchMountWidth = 16;
touchMountThickness = 4;

spacer();

module spacer() {
    translate([0,0,spacerThickness / 2])
    cube([touchMountThickness, touchMountLength, spacerThickness], center = true);
    
    difference() {
        // horizontal section
        translate([touchMountWidth / 2, 0, spacerThickness / 2])
        cube([touchMountWidth, touchMountLength, spacerThickness], center = true);
        
        translate([touchMountWidth / 2 + 2, -touchMountBoltSpacing / 2, 0])
        cylinder(d = 4.3, h = spacerThickness, $fn = 50);
        
        translate([touchMountWidth / 2 + 2, touchMountBoltSpacing / 2, 0])
        cylinder(d = 4.3, h = spacerThickness, $fn = 50);
    }
}