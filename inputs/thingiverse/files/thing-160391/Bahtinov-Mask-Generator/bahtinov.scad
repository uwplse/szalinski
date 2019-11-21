/*                                                 -*- c++ -*-
 * A Bahtinov mask generator.
 * Units in mm, default values are for
 * a Celestron NexStar GPS 8.
 *
 * Copyright 2013-2014, Brent Burton
 * License: CC-BY-SA
 *
 * Updated: 2014-06-23
 */

// This is the diameter of the mask.
outerDiameter = 215; // [80:400]

// The telescope light's path diameter.
aperture = 203; // [80:400]

// Diameter of secondary mirror holder. If no secondary, set to 0.
centerHoleDiameter = 71; // [0:90]

// Width of the gaps and the bars.
gap = 6; // [4:10]

/* create a series of bars covering roughly one half of the
 * scope aperture. Located in the +X side.
 */
module bars(gap, width, num=5) {
    num = round(num);
    for (i=[-num:num]) {
        translate([width/2,i*2*gap]) square([width,gap], center=true);
    }
}

module bahtinovBars(gap,width) {
    numBars = aperture/2 / gap / 2 -1;
    // +X +Y bars
    intersection() {
        rotate([0,0,30]) bars(gap, width, numBars);
        square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // +X -Y bars
    intersection() {
        rotate([0,0,-30]) bars(gap, width, numBars);
        translate([0,-outerDiameter/2]) square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // -X bars
    rotate([0,0,180]) bars(gap, width, numBars);
}

$fn=72;
module bahtinov2D() {
    width = aperture/2;
    difference() {                          // overall plate minus center hole
        union() {
            difference() {                  // trims the mask to aperture size
                circle(r=aperture/2+1);
                bahtinovBars(gap,width);
            }
            difference() {                  // makes the outer margin
                circle(r=outerDiameter/2-1);
                circle(r=aperture/2);
            }
            // Add horizontal and vertical structural bars:
            square([gap,2*(aperture/2+1)], center=true);
            translate([aperture/4,0]) square([aperture/2+1,gap], center=true);
            // Add center hole margin if needed:
            if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
                circle(r=(centerHoleDiameter+gap)/2);
            }
        }
        // subtract center hole if needed
        if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
            circle(r=centerHoleDiameter/2+1);
        }
    }
}

union() {
    linear_extrude(height=2) bahtinov2D();
    // add a little handle
    translate([outerDiameter/2-gap,0,0]) cylinder(r=gap/2, h=12);
}
