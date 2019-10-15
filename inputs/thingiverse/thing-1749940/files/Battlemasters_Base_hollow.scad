// Horizontal size of the base
baseWidth = 90; // [10:500]
// Vertical size of the base
baseHeight = 79; // [10:500]
// Thickness of the base
baseThickness = 5; // [1:50]

// How wide the gap of the grooves is
grooveWidth = 2.5; // [0.1:0.1:5]
// How deep into the base the grooves are cut
grooveDepth = 3; // [0.1:0.1:5]

// How many grooves to cut across the horizontal dimension
horizontalGrooveCount = 5; // [0:10]
// How many gooves to cut across the vertical dimension
verticalGrooveCount = 3; // [0:10]
// How far before the edge of the base should the grooves stop?
marginSize = 2; // [-1:0.1:10]

union() {
    difference() {
        translate([0,0,baseThickness-grooveDepth-1]) Grooves(grooveWidth+3, grooveDepth+1, 0);
        translate([0,0,baseThickness-grooveDepth]) Grooves(grooveWidth, baseThickness+2, marginSize);
    }
    difference() {
        cube([baseWidth, baseHeight, baseThickness]);
        translate([0, 0, baseThickness-grooveDepth]) Grooves(grooveWidth, baseThickness+2, marginSize);
        translate([1.5, 1.5, -1]) cube([baseWidth-3, baseHeight-3, baseThickness-0.5]);
    }
}


module Grooves(grooveWidth, grooveDepth, marginSize) {
    translate([baseWidth/horizontalGrooveCount/2-grooveWidth/2, 0, 0]) {
        for (a = [0 : horizontalGrooveCount-1]) {
            translate([(baseWidth/horizontalGrooveCount)*a, marginSize, 0]) cube([grooveWidth, baseHeight-marginSize*2, grooveDepth]);
        }
    }
    translate([0, baseHeight/verticalGrooveCount/2-grooveWidth/2, 0]) {
        for (a = [0 : verticalGrooveCount-1]) {
            translate([marginSize, (baseHeight/verticalGrooveCount)*a, 0]) cube([baseWidth-marginSize*2, grooveWidth, grooveDepth]);
        }
    }
}