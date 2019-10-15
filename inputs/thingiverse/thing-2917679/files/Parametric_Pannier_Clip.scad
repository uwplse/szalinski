// How wide should the clip be?
clipWidth = 25;

// How high should the clip be?
clipHeight = 50;

// How thick should the walls be?
plateThickness = 4;

// What diameter bar is the clip clipping onto?
barSize = 12.5;

// How big of a "nub"? (for snapping on/off)
nubSize = 2;

difference() {
    union() {
        // plate
        cube([clipHeight, plateThickness, clipWidth]);

        // top of clip
        cube([(plateThickness + (barSize/2)), (plateThickness * 2 + barSize), clipWidth]);

        // inside of clip
        translate([0, barSize + plateThickness, 0])
            cube([clipHeight, plateThickness, clipWidth]);
        translate([plateThickness + barSize, barSize + plateThickness, 0])
            cylinder($fn=32, h=clipWidth, r=nubSize);
    }

    translate([plateThickness + (barSize/2), plateThickness + (barSize/2), -1])
        cylinder($fn=32, h=(clipWidth + 2), d=barSize);
    translate([clipHeight, 0, -1])
        rotate(a=[0, 0, 45])
        cube([clipHeight, clipHeight, clipWidth+2]);
}
