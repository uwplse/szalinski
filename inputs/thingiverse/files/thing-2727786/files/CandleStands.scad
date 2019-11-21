// ****************************************************************************
// Customizable Candle Stands
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

/* ********************************************* */
// Tea light, 5:
/* ********************************************* */

/* [Candle] */
// Candle diameter
dCandle= 39.5;
// Thickness of bottom below candle
hCandle= 2;
// Height of ring around candle
hCandleStand= 5;

/* [Star] */
// Outer diameter of star
dOuter= 80;
// Outer height
hOuter= 2;
// Inner diameter of star
dInner= 39.5;
// Inner height
hInner= 5;
// Number of segments
n= 5;
// Rounding radius
rr= 2;
// Smoothness
$fn=100;


StarStand(dCandle/2, hCandle, hCandleStand, dOuter/2, hOuter, dInner/2, hInner, n, rr);

module StarStand(rCandle, hCandle, hCandleStand, rOuter, hOuter, rInner, hInner, n, rr) {
    difference() {
        union() {
            Star(rOuter, hOuter, rInner, hInner, n, rr);
            cylinder(r= rCandle+2, h= hCandleStand);
        }
        // space for candle
        translate([0,0,hCandle]) cylinder(r= rCandle, h= hCandleStand);
        // flat bottom
        translate([0,0,-rr-1]) cylinder(r=rOuter+rr+0.01,h= rr+1);
    }
}

// a star without space for the candle
module Star(rOuter, hOuter, rInner, hInner, n, rr) {
    for (a= [0:360/n:360]) {
        rotate([0,0,a]) 
            triangle(rOuter, hOuter, rInner, hInner, n, rr);
    }
}

module triangle(rOuter, hOuter, rInner, hInner, n, rr) {
    alpha= 360/n/2;
    b= cos(alpha) *rInner;
    a= sin(alpha) *rInner;
    tPoints= [
        [b, -a, 0],
        [b, -a, hInner],
        [b, a, 0],
        [b, a, hInner],
        [rOuter, 0, 0],
        [rOuter, 0, hOuter],
    ];
    tFaces= [
        [0, 2, 4], // bottom
        [0, 1, 3, 2], // left
        [0, 1, 5, 4], // lower
        [2, 3, 5, 4], // upper
        [1, 3, 5] // top
    ];
    minkowski() {
        hull() {
            polyhedron(tPoints, tFaces);
            intersection() {
                cylinder(r= rInner, h= hInner);
                translate([0, -a, 0]) cube([rOuter, 2*a, rInner]);
            }
        }
        sphere(r= rr);
    }
}

