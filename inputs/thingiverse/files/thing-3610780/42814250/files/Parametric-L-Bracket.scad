// Copyright 2019 jackw01. 
// https://jackw01.github.io
// Released under the Creative Commons - Attribution license.

// Screw clearance hole diameter (mm)
screwHoleDiameter = 3.4;
// Screw clearance hole counterbore diameter (mm)
screwHoleCounterboreDiameter = 6.5;
// Screw clearance hole counterbore depth (mm)
screwHoleCounterboreDepth = 3;
// Number of screw holes on side 1 (length dimension)
side1Holes = 2;
// Spacing of screw holes on side 1 (mm)
side1HoleSpacing = 10;
// Spacing between corner axis and first screw hole on side 1 (mm)
side1HoleOffset = 12;
// Number of screw holes on side 2 (length dimension)
side2Holes = 2;
// Spacing of screw holes on side 2 (mm)
side2HoleSpacing = 10;
// Spacing between corner axis and first screw hole on side 2 (mm)
side2HoleOffset = 12;
// Number of screw holes in width direction (essentially extends the bracket along the corner axis)
widthHoles = 2;
// Width of bracket (per hole on width axis) (mm)
widthHoleSpacing = 10;
// Margin around holes on width and length axes (mm)
holeMargin = 6;
// Thickness of the bracket (mm)
thickness = 5;
// Fillet radius (mm)
filletRadius = 5;
// Fillet the corner axis?
filletCornerAxis = 1; // [0:no, 1:yes]
// Fillet radius for corner axis (mm)
filletCornerAxisRadius = 5;
// Gusset on left side?
gussetLeft = 1; // [0:no, 1:yes]
// Gusset on right side?
gussetRight = 1; // [0:no, 1:yes]
// Gusset size (in both dimensions) (mm)
gussetSize = 18;
// Gusset thickness (mm)
gussetThickness = 2;
// Number of segments used to make circular shapes
circleRes = 20;

length = (side1Holes - 1) * side1HoleSpacing + side1HoleOffset + holeMargin;
width = holeMargin * 2 + widthHoleSpacing * (widthHoles - 1);

module hole() {
    union() {
        linear_extrude(height=thickness + length) {
            circle(d=screwHoleDiameter, $fn=circleRes);
        }
        translate([0, 0, thickness - screwHoleCounterboreDepth]) linear_extrude(height=screwHoleCounterboreDepth + length) {
            circle(d=screwHoleCounterboreDiameter, $fn=circleRes);
        }
    }
}

module bracketSide() {
    difference() {
        union() {
            linear_extrude(height=thickness) {
                square([length, width], center=false);
            }
            if (gussetLeft == 1) {
                rotate([-90, 0, 0]) linear_extrude(height=gussetThickness) {
                    polygon(points=[[thickness - 0.2, -thickness + 0.2], [gussetSize + thickness, -thickness + 0.2], [gussetSize / 2 + thickness - 1, -gussetSize / 2 - thickness - 1]]);
                }
            }
            if (gussetRight == 1) {
                translate([0, width - gussetThickness, 0]) rotate([-90, 0, 0]) linear_extrude(height=gussetThickness) {
                    polygon(points=[[thickness - 0.2, -thickness + 0.2], [gussetSize + thickness, -thickness + 0.2], [gussetSize / 2 + thickness - 1, -gussetSize / 2 - thickness - 1]]);
                }
            }
        }
        translate([length - filletRadius, filletRadius, 0]) rotate([0, 0, -90]) linear_extrude(height=length) {
            difference() {
                square([filletRadius * 2, filletRadius * 2], center=false);
                circle(r=filletRadius, $fn=circleRes);
            }
        }
        translate([length - filletRadius, holeMargin * 2 + widthHoleSpacing * (widthHoles - 1) - filletRadius, 0]) linear_extrude(height=length) {
            difference() {
                square([filletRadius * 2, filletRadius * 2], center=false);
                circle(r=filletRadius, $fn=circleRes);
            }
        }
    }
}

module bracketSideHoles() {
    for (x=[0:widthHoles - 1]) {
        for (y=[0:side1Holes - 1]) {
            translate([side1HoleOffset + y * side1HoleSpacing, holeMargin + x * widthHoleSpacing]) hole();
        }
    }
}

difference() {
    union() {
        bracketSide();
        rotate([0, 90, 0]) mirror([1, 0, 0]) bracketSide();
        if (filletCornerAxis == 1) {
            translate([filletCornerAxisRadius * 2, 0, filletCornerAxisRadius * 2]) rotate([0, 90, 90]) linear_extrude(height=width) {
                difference() {
                    square([filletCornerAxisRadius + 0.2, filletCornerAxisRadius + 0.2], center=false);
                    circle(r=filletCornerAxisRadius, $fn=circleRes);
                }
            }
        }
    }
    union() {
        bracketSideHoles();
        rotate([0, 90, 0]) mirror([1, 0, 0]) bracketSideHoles();
    }
}
