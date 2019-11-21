// preview[view:south east, tilt:top diagonal]



/* [Dimensions] */

// Width of the ring.
margin = 3;

// Width of the inner space. Wiggle is applied.
widthInner = 13.33;

// Height of the inner space. Wiggle is applied.
heightInner = 5.72;

// Depth of the whole thing.
depth = 2;



/* [Extras] */

// Extra room on inner side. If you took exact measurements you want to add some extra space for easier handling.
wiggle = 0.65; // [0:None, 0.55:Tight, 0.65:Little bit, 0.75:More, 0.85:A lot]



/* [Hidden] */

_widthInner = widthInner + wiggle;
_heightInner = heightInner + wiggle;

width = _widthInner + 2*margin;
height = _heightInner + 2*margin;



PanelMount();

module PanelMount() {
    difference() {
        Panel();
        translate([margin, 0, margin]) Hole();
    }
}

module Panel() {
    Block(width, depth, height);
}

module Hole() {
    Block(_widthInner, depth, _heightInner);
}



module Block(x = 1, y = 1, z = 1) {
    linear_extrude(height = z, convexity = 4)
        square(size = [x, y], center = false);
}
