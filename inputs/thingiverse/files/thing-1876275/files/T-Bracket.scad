// T-Track definition: how wide is it?
trackWidth = 20.0;

// Mounting hardware definition: how long are the inserts you are using?
hardwareLength = 15.2;

// Extra space between T-track mounting brackets
extraSpace = 1.0;

// Screw hole size (make it a bit bigger than your screws)
holeSize = 5.3;

// Upper bar of the T: number of holes
upperBarNumHoles = 2;

// Vertical bar of the T: number of holes
verticalBarNumHoles = 2;

// The width of the part
mainWidth = 15.0;

// Corner radius:
cornerRadius = 2;

// Main thickness:
thickness = 2.0;

// Rim thickness 
rimThickness = 0.8;

// Rim width
rimWidth = 1.8;

/* [Hidden] */
// Hole resolution
$fn = 30;


// Code imported from scad-utils:
// Copyright (c) 2013 Oskar Linde. All rights reserved.
// License: BSD
//
// This library contains basic 2D morphology operations
//
// outset(d=1)            - creates a polygon at an offset d outside a 2D shape
// inset(d=1)             - creates a polygon at an offset d inside a 2D shape
// fillet(r=1)            - adds fillets of radius r to all concave corners of a 2D shape
// rounding(r=1)          - adds rounding to all convex corners of a 2D shape
// shell(d,center=false)  - makes a shell of width d along the edge of a 2D shape
//                        - positive values of d places the shell on the outside
//                        - negative values of d places the shell on the inside
//                        - center=true and positive d places the shell centered on the edge

module outset(d=1) {
	// Bug workaround for older OpenSCAD versions
	minkowski() {
		circle(r=d);
		children();
	}
}

module outset_extruded(d=1) {
   projection(cut=true) minkowski() {
        cylinder(r=d);
        linear_extrude(center=true) children();
   }
}

module inset(d=1) {
	 render() inverse() outset(d=d) inverse() children();
}

module fillet(r=1) {
	inset(d=r) render() outset(d=r) children();
}

module rounding(r=1) {
	outset(d=r) inset(d=r) children();
}

module shell(d,center=false) {
	if (center && d > 0) {
		difference() {
			outset(d=d/2) children();
			inset(d=d/2) children();
		}
	}
	if (!center && d > 0) {
		difference() {
			outset(d=d) children();
			children();
		}
	}
	if (!center && d < 0) {
		difference() {
			children();
			inset(d=-d) children();
		}
	}
	if (d == 0) children();
}


// Below are for internal use only

module inverse() {
	difference() {
		square(1e5,center=true);
		children();
	}
}




// End import from scad-utils











extraHardwareSpace = (trackWidth - mainWidth) / 2;
upperBarWidth = upperBarNumHoles * (hardwareLength+extraSpace);
verticalBarHeight = verticalBarNumHoles * (hardwareLength+extraSpace) + extraHardwareSpace;


module bracket2DSquare () {
    square ([upperBarWidth,mainWidth]);
    translate ([(upperBarWidth-mainWidth)/2,mainWidth,0]) {
        square ([mainWidth, verticalBarHeight]);
    }
}

module bracket2DRounded () {
    rounding(r=cornerRadius) fillet(r=cornerRadius) bracket2DSquare();
}

module rim2D () {
    shell(d=rimWidth) bracket2DRounded ();
}

module bracket3D () {
    linear_extrude (height=thickness) bracket2DRounded ();
    linear_extrude (height=thickness+rimThickness) rim2D();
}

module holePuncher (thisHole, numHoles) {
    if (thisHole < numHoles) {
        cylinder (d = holeSize, h = 4* thickness, center = true);
        translate ([hardwareLength+extraSpace,0,0]) {
            holePuncher (thisHole + 1, numHoles);
        }
    }
}

module punchUpperBarHoles () {
    translate ([(hardwareLength+extraSpace)/2,mainWidth/2,0]) {
        holePuncher(0,upperBarNumHoles);
    }
}

module punchVerticalBarHoles () {
    translate ([upperBarWidth/2,mainWidth+extraHardwareSpace+hardwareLength/2,0]) {
        rotate (90) {
            holePuncher(0,verticalBarNumHoles);
        }
    }
}

difference () {
    bracket3D();
    punchUpperBarHoles();
    punchVerticalBarHoles();
}