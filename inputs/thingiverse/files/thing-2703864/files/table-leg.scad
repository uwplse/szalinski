// preview[view:south east, tilt:top diagonal]



/* [Screw holes] */

// The screw hole radius at the bottom. The top screw hole is half of this. Wiggle is applied.
screwHoleRadius = 4;



/* [Dimensions] */

// Depth of the whole thing.
depth = 50;

// Width of the slot sides.
sideWidth = 3;

// Width of the slot. This should equal to the width of your table leg. Wiggle is applied.
slotWidth = 22;

// Height of the slot.
slotHeight = 15;

// Height of the base underneath slot. This is how much your table gets taller.
baseHeight = 40;



/* [Extras] */

// Extra room/width added to the screw holes and to the slot. If you took exact measurements you want to add some extra space for easier handling.
wiggle = 0.5; // [0:None, 0.5:Little bit, 1:A lot]



/* [Hidden] */

_screwHoleRadius = screwHoleRadius + wiggle;
_slotWidth = slotWidth + wiggle;
width = _slotWidth + 2 * sideWidth;
height = slotHeight + baseHeight;



zero() Leg();

module Leg() {
    Cradle();
    Base();
}

module Base() {
    difference() {
        translate([-sideWidth, 0, -baseHeight])
            Block(width, depth, baseHeight);

        translate([_slotWidth / 2, 1/4 * depth, 0])
            ScrewHole();
    
        translate([_slotWidth / 2, 3/4 * depth, 0])
            ScrewHole();
    }
}

module Cradle() {
    translate([-sideWidth, 0, 0]) Side();
    translate([_slotWidth, 0, 0]) Side();
}

module Side() {
    Block(sideWidth, depth, slotHeight);
}

module ScrewHole() {
    topHeight = 2;
    topRadius = _screwHoleRadius / 2;

    bodyHeight = baseHeight - topHeight;
    bodyRadius = _screwHoleRadius;

    translate([0, 0, -topHeight])
        Barrel(topHeight, topRadius);
    translate([0, 0, -(topHeight + bodyHeight)])
        Barrel(bodyHeight, bodyRadius);
}



module Block(x = 1, y = 1, z = 1) {
    linear_extrude(height = z, convexity = 4)
        square(size = [x, y], center = false);
}

module Barrel(h = 1, r = 1) {
    cylinder(h, r, r, center = false, $fn = 100);
}

module zero() {
    translate([sideWidth, 0, baseHeight])
        children();
}
