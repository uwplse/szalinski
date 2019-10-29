include <MCAD/units.scad>

/* [Stand] */

// Leg center angles in degrees
legCenterAngles = [0, 120, 240];
// Width of the legs (the chord length)
legWidth = 10;
// Leg segment lengths (innermost segment first, value 0 = placeholder)
legSegmentLengths = [10.75, 2, 0, 0, 0];
// Leg segment heights (innermost segment first, same vector size as legSegmentLengths)
legSegmentHeights = [5, 30, 0, 0, 0];

/* [Hidden] */

$fn = 50;

function add(v, i = 0, imax = 1e200) = i < len(v) - 1 && i < imax ? v[i] + add(v, i + 1, imax) : v[i];

module Stand() {
    intersection() {
        for (i = [0:len(legSegmentLengths) - 1])
            if (legSegmentLengths[i] > 0)
                difference() {
                    cylinder(legSegmentHeights[i], r = add(legSegmentLengths, 0, i));
                    if (i > 0)
                        translate([0, 0, -epsilon])
                        cylinder(legSegmentHeights[i] + epsilon * 3, r = add(legSegmentLengths, 0, i - 1));
                }
        for (a = legCenterAngles)
            rotate([0, 0, a])
            translate([-legWidth / 2, 0, -epsilon])
            cube([legWidth, add(legSegmentLengths) + epsilon, max(legSegmentHeights) + epsilon * 2]);
    }
}

Stand();
