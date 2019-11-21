/*
 * Configurable Standoff
 *
 * by 4iqvmk, 2018-02-03
 * https://www.thingiverse.com/4iqvmk/about
 * 
 * Licenced under Creative Commons Attribution - Share Alike 4.0 
 *
 * version 1.00 - initial version
 * version 1.01 - added screw clearance cutaway
*/

/* [Hidden] */

inch2mm = 0.3048/12*1000;
mm2inch = 12/0.3048/1000;
$fs = 0.2;  // Don't generate smaller facets than 0.2 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

/* [Parameters] */

// mm
baseDiam = 25; // [6:2:60]

// mm
baseHeight = 3; // [0:1:30]

// mm
standOffDiam = 8; // [0:1:60]

// mm
standOffHeight = 10; // [0:1:100]

// mm
centerDrillDiam = 2.7; // [0:0.5:10]

// mm
baseDrillDiam = 3.1; // [0:0.5:10]

// mm
filletRad = 6; // [0:0.25:10]

/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

maxHeight = max(baseHeight, standOffHeight);

holeRadius = (baseDiam+standOffDiam)/4;

// inner circle template
difference() {
    // flange and surround
    union() {
        ring(centerDrillDiam/2, baseDiam/2, baseHeight);
        ring(centerDrillDiam/2, standOffDiam/2, standOffHeight);
        fillet(baseHeight, standOffDiam/2);
    }

    union() {
        mountingHoles(4, baseDrillDiam, holeRadius);
    }
}


module ring(inner, outer, height) {
    difference() {
        
        cylinder(h=height, r=outer);
        cylinder(h=4*height, r=inner, center=true);
        
    }
}

module mountingHoles(num, screwDiam, offsetRadius) {
    
    // add registration marks
    for (step = [0:num-1]) {
        rotate( a = step*(360/num), v=[0, 0, 1]) {
            translate ( [offsetRadius, 0, 0] ) {
                cylinder(h=maxHeight*4, r=screwDiam/2, center=true);
                translate ([0,0,baseHeight]) {
                    cylinder(h=maxHeight*4, r=2.5*screwDiam/2);
                }
            }
        }
    }
}

module fillet(height, radius) {
    difference() {
        ring((centerDrillDiam/2+radius)/2, radius + filletRad, filletRad+height);
        
        translate([0, 0, filletRad+height]) {
            torus(filletRad, radius + filletRad);
        }
    }
}

// draw a torus about Z centered on the XY plane
module torus(radius, sweepRad) {
    rotate_extrude(convexity = 10) {
        translate([sweepRad, 0, 0]) {
            circle(radius);
        }
    }
}
