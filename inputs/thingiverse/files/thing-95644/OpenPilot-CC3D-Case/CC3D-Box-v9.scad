/*
 * OpenPilot CC3D case for 3D printing / Laser cutting
 * Copyright (C) 2013  Philippe Vanhaesendonck
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License,
 * LGPL version 2.1, or (at your option) any later version of the GPL.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 */

/*
 * This case is a combination of various designs shown on OpenPilot http://www.openpilot.org
 * 
 * It is composed of 3 parts:
 * 	- Bottom part, avilable in 2 versions:
 *		- cc3dBottom(): Standard -- the board in completely enclosed in teh box
 *		- cc3dLowBottom(): Low profile -- the USB header is cut out.
 *	- Top part (No option): cc3dTop();
 *	- Cover: laser cutted acrylic (use topPlate() and export as DXF)
 *	  Available in 3 versions:
 *		- cc3dCover(servoHeader = 0): without servo hole
 *		- cc3dCover(servoHeader = 1): servo hole without servo tabs
 *	 	- cc3dCover(servoHeader = 2): servo hole with servo tabs
 *
 */

/*
 * Parameters for Thingiverse customizer
 *
 */

// Which part would you like to print?
partSelector = 3;	// [0:Bottom,1:Top,2:Cover,3:All]

// Which bottom plate?
profile = 0;		// [0:Standard,1:Low Profile]

// Which cover plate?
coverPlate = 1;		// [0:No servo hole,1:Standard servo hole,2:Servo hole with tabs]

main();

/* End customizer stuff */
/* [Hidden] */

/*
 * Libraries
 *
 */

// From https://github.com/elmom/MCAD/blob/master/metric_fastners.scad
use <MCAD/metric_fastners.scad>

// From http://svn.clifford.at/openscad/trunk/libraries/shapes.scad
// use <shapes.scad>
// Incuded here due to Thingiverse Customize limitation
// size is a vector [w, h, d]
module roundedBox(size, radius) {
	cube(size - [2*radius,0,0], true);
	cube(size - [0,2*radius,0], true);
	for (x = [radius-size[0]/2, -radius+size[0]/2],
         y = [radius-size[1]/2, -radius+size[1]/2]) {
		translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
	}
}

// Board measures:
boardSize 		= 36.5;		// Actual size is 36.0
boardThickness	=  1.6;
holeDistance	= 30.5;
holeDiameter	=  3.0;
usbWidth		=  9.0;		// Added 1mm (was 8.0)
usbHeigth		=  4.4;
usbLength		= 11.2;
servoHeigth		=  9.0;
servoLength		= 16.0;
servoWidth		=  8.0;
servoFront		=  7.2;
servoRight		=  0.7;
servoTab		=  0.9;
servoTabWidth	=  0.7;
jstshHeigth		=  3.2;
jstsh4Width		=  7.1;
jstsh8Width		= 11.2;
jstshDelta		=  7.0;

// Data
// Note: Cura config: Nozzle: 0.4 & Wall 0.8
boxThickness	=  2.0;
nutHeigth		=  2.3;
bottomClearance	=  1.0;
topClearance	=  1.0;
poleRadius		=  3.5;
crossWidth		=  2.0;
crossHeigth		=  0.7;
coverHeigth		=  3.0;
nutDiameter		= holeDiameter + 0.5;	// avoid tight fit
bigPoleHeigth	= boardThickness + 2.0;

// Derived
boxSize			= boardSize + 2 * boxThickness;
boardRadius		= (boardSize - holeDistance) / 2;
boxRadius		= boardRadius + boxThickness;
bottomHeigth	= boxThickness + crossHeigth + bottomClearance + usbHeigth + boardThickness / 2;
bottomLowHeigth	= usbHeigth + boardThickness / 2;
topHeigth		= topClearance + servoHeigth + boardThickness / 2;
usbDepth		= usbHeigth + boardThickness / 2;
servoTabStep	= servoLength / 6;
bigPoleRadius	= (boxSize - holeDistance) / 2;

$fn=50;

// CC3D Box lower part -- variable heigth
module cc3dBottomH(bHeigth) {
	difference () {
		union() {
			difference () {
				// Outer box
				roundedBox([boxSize, boxSize, bHeigth], boxRadius);
				// Inner box
				translate([0, 0, boxThickness])
					roundedBox([boardSize, boardSize, bHeigth], boardRadius);
				// USB header hole
				translate([boardSize / 2 - 1, - usbWidth / 2, bHeigth / 2 - usbDepth])
					cube(size = [boxThickness + 2, usbWidth, usbDepth + 1], center = false);
			}
			// Screw poles
			for (x = [ -holeDistance / 2, holeDistance / 2 ],
				y = [ -holeDistance / 2, holeDistance / 2 ]) {
				translate([x, y, -boardThickness / 4])
					cylinder(r = poleRadius, h = bHeigth - boardThickness / 2, center = true, $fn = 50);
			}
			// Screw poles at the bottom (compensate for nut hole)
			for (x = [ -holeDistance / 2, holeDistance / 2 ],
				y = [ -holeDistance / 2, holeDistance / 2 ]) {
				translate([x, y, -bHeigth / 2 + bigPoleHeigth /2 ])
					cylinder(r = bigPoleRadius, h = bigPoleHeigth , center = true, $fn = 50);
			}
			// Reinforcement cross on the bottom
			translate([-boxSize / 2, -crossWidth / 2, boxThickness - bHeigth / 2 - 1])
				cube( size = [boxSize, crossWidth, crossHeigth +1], center = false);
			translate([-crossWidth / 2, -boxSize / 2, boxThickness - bHeigth / 2 - 1])
				cube( size = [crossWidth, boxSize, crossHeigth +1], center = false);
			// Upright in front of the JST-SH4
			for (y = [ -jstsh4Width - jstshDelta / 2, usbWidth / 2 ]) {
				translate([ boxSize / 2 - boxThickness, y, bHeigth / 2 - 1])
					cube( size = [boxThickness, jstsh4Width - (usbWidth - jstshDelta) / 2, 1 + boardThickness / 2], center = false);
			}
			// Upright in front of the JST-SH 8
			translate([ -jstsh8Width / 2, -boxSize / 2, bHeigth / 2 - 1])
				cube( size = [jstsh8Width, boxThickness, 1 + boardThickness / 2], center = false);

		}
		// Nuts and screw holes
		for (x = [ -holeDistance / 2, holeDistance / 2 ],
			y = [ -holeDistance / 2, holeDistance / 2 ]) {
			translate([ x, y, -bHeigth / 2 - 1 ]) 
				bolt(nutDiameter, nutHeigth + 1);
			translate([ x, y, 0 ])
				cylinder(r = holeDiameter / 2, h = bHeigth + 1, center = true, $fn = 50);
		}
	}
}

// CC3D Box lower part -- Standard heigth
module cc3dBottom(bHeight) {
	cc3dBottomH(bottomHeigth);
}

// CC3D Box lower part -- low profile version
module cc3dLowBottom(bHeight) {
	union() {
		difference () {
			// The standard box
			cc3dBottomH(bottomLowHeigth);
			// USB Hole at the bottom
			translate([boxSize / 2 - usbLength, - usbWidth / 2, -bottomLowHeigth / 2 - 1])
				cube( size = [usbLength + 1, usbWidth, usbHeigth + 2 ], center = false);
		}
		// Borders around USB holes
		translate([boxSize / 2 - usbLength -crossWidth, - usbWidth / 2 - crossWidth, boxThickness - bottomLowHeigth / 2 - 1]) {
			cube( size = [usbLength + crossWidth, crossWidth, crossHeigth +1], center = false);
			cube( size = [crossWidth, usbWidth + 2 * crossWidth, crossHeigth +1], center = false);
		}
		translate([boxSize / 2 - usbLength -crossWidth, + usbWidth / 2, boxThickness - bottomLowHeigth / 2 - 1])
			cube( size = [usbLength + crossWidth, crossWidth, crossHeigth +1], center = false);
	}
}

// CC3D Box top part
module cc3dTop() {
	difference () {
		union() {
			difference () {
				// Outer box
				roundedBox([boxSize, boxSize, topHeigth], boxRadius);
				// Inner box
				roundedBox([boardSize, boardSize, topHeigth + 2], boardRadius);
			}
			// Screw poles
			for (x = [ -holeDistance / 2, holeDistance / 2 ],
				y = [ -holeDistance / 2, holeDistance / 2 ]) {
				translate([x, y, -boardThickness / 4])
					cylinder(r = poleRadius, h = topHeigth - boardThickness / 2, center = true, $fn = 50);
			}
			// Upright for the USB header
			translate([boardSize / 2, - jstshDelta / 2, topHeigth / 2 - 1])
				cube(size = [boxThickness, jstshDelta, boardThickness / 2 + 1], center = false);
		}
		// Screw holes
		for (x = [ -holeDistance / 2, holeDistance / 2 ],
			y = [ -holeDistance / 2, holeDistance / 2 ]) {
			translate([ x, y, 0 ])
				cylinder(r = holeDiameter / 2, h = topHeigth + 1, center = true, $fn = 50);
		}
		// JST-SH 4
		for (y = [ -jstsh4Width - jstshDelta / 2, jstshDelta / 2 ]) {
			translate([ boxSize / 2 - boardThickness - 1, y, topHeigth / 2 - jstshHeigth - boardThickness / 2])
				cube( size = [boardThickness + 2, jstsh4Width, jstshHeigth + boardThickness / 2 + 1], center = false);
		}
		// JST-SH 8
		translate([ -jstsh8Width / 2, boxSize / 2 - boardThickness - 1, topHeigth / 2 - jstshHeigth - boardThickness / 2])
			cube( size = [jstsh8Width, boardThickness + 2, jstshHeigth + boardThickness / 2 + 1], center = false);
	}
}

// CC3D Box cover plate 
// 	for completeness, as it in not printed but cut in acrylic
//	It can be projected on the x-y plane and exported in DXF for laser cutting
module cc3dCover(servoHeader = 1) {
	difference () {
		// Plate
		roundedBox([boxSize, boxSize, coverHeigth], boxRadius);
		// Screw Holes
		for (x = [ -holeDistance / 2, holeDistance / 2 ],
			y = [ -holeDistance / 2, holeDistance / 2 ]) {
			translate([x, y, 0])
				cylinder(r = holeDiameter / 2, h = coverHeigth + 1, center = true, $fn = 50);
		}
		if ( servoHeader > 0 ) {
			// Servo header holes
			translate([-boardSize / 2 + servoFront, boardSize / 2 - servoRight - servoWidth , -coverHeigth / 2 - 1])
				cube( size = [servoLength, servoWidth, coverHeigth + 2], center = false);
			// Servo tabs
			if (servoHeader > 1) for ( i = [0:6-1] ) {
				translate([-boardSize / 2 + servoFront + i * servoTabStep, boardSize / 2 - servoRight - servoWidth - servoTab, -coverHeigth / 2 - 1])
					cube( size = [servoTabWidth, servoTab + 1, coverHeigth + 2], center = false);

			}
		}
	}
}

// Draw all parts
module demo() {
	translate([ 0, 0, -15 ]) cc3dLowBottom();
	cc3dBottom();
	translate([ 0, 0, (bottomHeigth + topHeigth) / 2 + 5]) rotate(a=[180,0,0]) cc3dTop();
	translate([ 0, 0, 28 ]) cc3dCover(servoHeader = 1);
}

// Projection on x-y plane to extract DXF file for the top plate
module topPlate(pServoHeader = 0) {
	projection(cut=true)
		cc3dCover(servoHeader = pServoHeader);
}

// Projection on x-y plane to check alignment
module testCut() {
	projection(cut=true) {
		translate([ -25, 0, -2 ]) cc3dBottom();
		translate([ 25, 0, -4 ]) cc3dTop();
	}
}

/*
 * Rendering
 *
 */

/*
 * For testing / Demo purpose:
 *
 */
// testCut();
// demo(false);

/*
 * Laser cut
 * Render & Export as DXF (With or without servo tabs)
 *
 */
// topPlate(pServoHeader = 1);

/*
 * 3D Print
 * Render & Export as STL
 *
 */
// cc3dBottom();
// cc3dLowBottom();
// cc3dTop();


/*
 * Customizer
 *
 */
module main() {
	if (partSelector == 0 || partSelector > 2) {
		if (profile == 0) {
			cc3dBottom();
		} else {
			cc3dLowBottom();
		}
	}
	if (partSelector == 1 ) {
		cc3dTop();
	} else if (partSelector == 2) {
		cc3dCover(servoHeader = coverPlate);
	} else if (partSelector > 2) {
		translate([ 0, 0, (bottomHeigth + topHeigth) / 2 + 5]) rotate(a=[180,0,0]) cc3dTop();
		translate([ 0, 0, 28 ]) cc3dCover(servoHeader = coverPlate);
	}
}
