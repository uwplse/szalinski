include <MCAD/units.scad>

/* [Stand] */

// Length of the stand (along gap)
standLength = 20;
// Width of the stand (perpendicular to gap)
standWidth = 40;
// Height of the stand (base included)
standTotalHeight = 25;
// Width of the center gap
standGapWidth = 2.1;
// Thickness of the stand base
standBaseThickness = 5;
// Thickness of the vertical walls
standWallThickness = 3;

module Stand() {
    translate([0, standLength / 2, 0])
    difference() {
        rotate([90, 0, 0])
        linear_extrude(standLength, convexity = 2)
        polygon([
            [-standWidth / 2, 0],
            [-standWidth / 2, standBaseThickness],
            [-standGapWidth / 2 - standWallThickness, standTotalHeight],
            [-standGapWidth / 2, standTotalHeight],
            [-standGapWidth / 2, standBaseThickness],
            [standGapWidth / 2, standBaseThickness],
            [standGapWidth / 2, standTotalHeight],
            [standGapWidth / 2 + standWallThickness, standTotalHeight],
            [standWidth / 2, standBaseThickness],
            [standWidth / 2, 0],
        ]);
        for (x = [0, 1])
            mirror([x, 0, 0])
            translate([-standWidth / 2 - epsilon, -standLength + standWallThickness, standBaseThickness])
            cube([standWidth / 2 - standGapWidth / 2 - standWallThickness, standLength - standWallThickness * 2, standTotalHeight - standBaseThickness + epsilon]);
    }
}

Stand();
