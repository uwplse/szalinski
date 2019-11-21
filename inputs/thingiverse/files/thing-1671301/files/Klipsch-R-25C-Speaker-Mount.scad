// model: Klipsch R-25C Center Channel Speaker Wall Mount
// author: fiveangle@gmail.com
// date: 2017feb07
// ver: 1.0.1
// notes: Uses original speaker terminal mounting screws so no alterations to the speaker are required
// history:
//     -1.0.1 - 2017feb07 - Fixed incorrect calculation that resulted in mountingTab being thinner than expected
//                        - Increased mountingTabThickness from default 3 to 4.3 to ensure adequate strength when
//                          installing with long mounting screw (to get it to angle downward) which could pull
//                          layers apart from the unexpected increased horizontal load
//     -1.0.0 - 2015jul11 - Released
//
// adjust to increase/decrease polygon count at expense of processing time
$fn = 200;

// Sets taper relative to mountingTabHeight
mountingScrewHeadThickness =10;
mountingScrewHeadDiameter = 10; // [8:15]
mountingTabHeight = 10;
mountingScrewDiameter = 4;
mountingPlateHeight = 130;
mountingPlateWidth = 112;

// Mounting plate thickness also sets mounting tab body and head retaining tabs thicknesses (don't make bigger than 3mm or you will probably need longer screws than the stock)
mountingPlateThickness = 3;
mountingTabThickness = 4.3;

// Don't change
mountingPlateCornerRadius = 15; 
mountingPlateScrewHoleDiameter = 4;
mountingTabWidth = 2 * mountingTabThickness + mountingScrewHeadDiameter;
mountingScrewWidthBottom = 94;
mountingScrewWidthTop = 34;
mountingScrewHeightSeparation = 78;
terminalHoleWidth = 65;
terminalHoleHeight = 50;
terminalHoleCornerRadius = 5;

module ScrewHole(x = 0, y = 0) {
    translate([x, y, 0]) {
        cylinder(d = mountingPlateScrewHoleDiameter, h = mountingPlateThickness);
        translate([0, 0, 3]) {
        cylinder(d = mountingScrewHeadDiameter, h = mountingPlateThickness);
        }
    }
}

// mounting tab
translate([mountingScrewWidthBottom / 2, terminalHoleHeight + terminalHoleCornerRadius + mountingTabWidth / 2, mountingPlateThickness]) {
    // cube([mountingTabWidth, mountingScrewHeightSeparation + mountingPlateCornerRadius - terminalHoleHeight - terminalHoleCornerRadius, mountingPlateThickness + mountingTabHeight]);
    difference() {
        // body of raised mounting tab
        hull() {
            cylinder(d = mountingTabWidth, h = mountingTabHeight);
            translate([0, mountingScrewHeightSeparation + mountingPlateCornerRadius - terminalHoleHeight - terminalHoleCornerRadius - mountingTabWidth, 0]) cylinder(d = mountingTabWidth, h = mountingTabHeight - (mountingTabHeight - mountingScrewHeadThickness));
        }

        // screw head hollow
        hull() {
            cylinder(d = mountingScrewHeadDiameter, h = mountingTabHeight - mountingTabThickness);
            translate([0, mountingScrewHeightSeparation + mountingPlateCornerRadius - terminalHoleHeight - terminalHoleCornerRadius - mountingTabWidth, 0]) cylinder(d = mountingScrewHeadDiameter, h = mountingTabHeight - mountingTabThickness - (mountingTabHeight - mountingScrewHeadThickness));
        }

        // screw slot recess
        cylinder(d = mountingScrewHeadDiameter, h = mountingTabHeight);
        hull() {
            cylinder(d = mountingScrewDiameter, h = mountingTabHeight);
            translate([0, mountingScrewHeightSeparation + mountingPlateCornerRadius - terminalHoleHeight - terminalHoleCornerRadius - mountingTabWidth, 0]) cylinder(d = mountingScrewDiameter, h = mountingTabHeight);
        }

    }
}

difference() {
    // plate
    linear_extrude(height = mountingPlateThickness) { // need to extrude 2D minkowski sum rather than plate and cyclinder, otherwise plate will increase in thickness by the z-axis minkowski freedom (woops !)
        minkowski() {
            square([mountingScrewWidthBottom, mountingScrewHeightSeparation, ]);
            circle(r = mountingPlateCornerRadius);
        }
    }

    // mounting holes 
    ScrewHole(0, 0);
    ScrewHole(mountingScrewWidthBottom, 0);
    ScrewHole((mountingScrewWidthBottom - mountingScrewWidthTop) / 2, mountingScrewHeightSeparation);
    ScrewHole((mountingScrewWidthBottom - mountingScrewWidthTop) / 2 + mountingScrewWidthTop, mountingScrewHeightSeparation);

    // hole for speakter terminals
    translate([(mountingScrewWidthBottom - terminalHoleWidth) / 2, 0, 0]) {
        minkowski() {
            cube([terminalHoleWidth, terminalHoleHeight, mountingPlateThickness]);
            cylinder(r = terminalHoleCornerRadius, h = mountingPlateThickness);
        }
    }
}