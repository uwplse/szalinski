clipWidth = 35;
clipLength = 35;
clipDepth = 5;
clipThickness = 1;
spineThickness = 1.5;
bedThickness = 6.6;
cornerRadius = 0.5;
actualSpaceHeight = bedThickness + 2 * cornerRadius;
totalHeight = 2 * clipThickness + actualSpaceHeight;

translate([0, totalHeight, 0]) {
    rotate([90, 0, 0]) {
        minkowski() {
            color("purple")
                    sphere($fn = 0, $fa = 12, $fs = 2, r = cornerRadius);

            difference() {
                difference() {
                    cube([clipWidth, clipLength, totalHeight]);
                    color("red")
                        translate([spineThickness, spineThickness, clipThickness]) {
                            cube([clipWidth - spineThickness, clipLength - spineThickness, actualSpaceHeight]);
                        }
                }
                offset = spineThickness + clipDepth;
                color("green")
                    translate([offset, offset, 0]) {
                        cube([clipWidth - offset, clipLength - offset, totalHeight]);
                    }
            }
        }
    }
}