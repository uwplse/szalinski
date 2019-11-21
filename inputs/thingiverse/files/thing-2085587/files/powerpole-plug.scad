// This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// https://creativecommons.org/licenses/by-sa/3.0/

// how many pairs of PowerPoles?
pairCount = 1;
// how many cords? choose either 1, or the same as pairCount
cordCount = 1;
// diameter of hole where cord goes into plug
cordDiameter = 4;
// select 1 or 2 cords per pair (2 is good for "zip cord")
strandCount = 2;
// width of a single PowerPole; should be 8mm, but probably larger to compensate for your printer
powerPoleSquareSide = 8.5;
// diameter of roll pins to hold the PowerPoles in place; compensate for your printer
rollPinDiameter = 2.25;

module round4CornersCube(x,y,z,r) {
	translate([r, r, 0])
	minkowski() {
					cube([x - 2 * r, y - 2 * r, z]);
					cylinder(r=r, h=0.1);
	}
}

module powerPoleSingleCutout(){
	halfSide = powerPoleSquareSide / 2;
	module key(){
		translate([12.5,-1.75,-0.5]) cube([12.5,3.5,1]);
	}
	difference() {
		union() {
			cube([25,powerPoleSquareSide,powerPoleSquareSide + 0.5]);
			// proud keys
			translate([0,halfSide,0]) key();
			translate([0,powerPoleSquareSide,4]) rotate([90,0,0]) key();
		}
	}
}

module powerPoleWithExtendedKeys(){
	powerPoleHeight = 25;
	halfSide = powerPoleSquareSide / 2;
	module key(){
		translate([0,-1.75,-0.5]) cube([25,3.5,1]);
	}
	difference() {
		union() {
			cube([powerPoleHeight,powerPoleSquareSide,powerPoleSquareSide + 0.5]);
			// proud keys
			translate([0,halfSide,0]) key();
			translate([0,powerPoleSquareSide,4]) rotate([90,0,0]) key();
		}
	}
}

module fingerGripCutout(outerThickness) {
	$fn = 32;
	diameter = 14;
	rotate([-90, 0, 0])
		union() {
			cylinder(d=diameter, h=outerThickness);
			translate([0, 0, -0.01])
			cylinder(d2=diameter, d1=diameter + 4, h=2);
			translate([0, 0, outerThickness - 1.99])
				cylinder(d1=diameter, d2=diameter + 4, h=2);
		}
}

module cordCutout(plugWidth, offset, z) {
	translate([plugWidth / 2, offset, z])
		cylinder(d2=cordDiameter, d1=powerPoleSquareSide, h=6);
	if (strandCount == 2) {
		translate([plugWidth / 2 - cordDiameter * 0.4, offset, 0])
			cylinder(d=cordDiameter, h=100);
		translate([plugWidth / 2 + cordDiameter * 0.4, offset, 0])
			cylinder(d=cordDiameter, h=100);
	} else {
		translate([plugWidth / 2, offset, 0])
			cylinder(d=cordDiameter, h=100);
	}
}

module plugBody() {
	// outer dimensions
	width = 20;
	endThickness = 1.75; // 1.75 * 2 + 8.5 = 12mm total thickness for one PowerPole pair
	cornerRadius = 1;
	$fn = 12;
	// depth dimensions
	flangeDepth = 5;
	keyDepth = 12;
	powerPoleHeight = 25;
	powerPoleCenterOffset = endThickness - powerPoleSquareSide / 2;

	outerThickness = endThickness * 2 + powerPoleSquareSide * pairCount;
	difference() {
		round4CornersCube(width, outerThickness, keyDepth + flangeDepth + 11, cornerRadius);
		for (i = [1:pairCount]) {
			translate([endThickness + powerPoleSquareSide, endThickness + powerPoleSquareSide * i, flangeDepth + keyDepth - powerPoleHeight])
				rotate([0, -90, 90])
					powerPoleWithExtendedKeys();
			translate([endThickness + powerPoleSquareSide * 2, endThickness + powerPoleSquareSide * i, flangeDepth + keyDepth - powerPoleHeight])
				rotate([0, -90, 90])
					powerPoleWithExtendedKeys();
			if (pairCount == cordCount)
				cordCutout(width, powerPoleCenterOffset + powerPoleSquareSide * i, keyDepth + flangeDepth);
		}
		if (cordCount == 1) {
			cordCutout(width, outerThickness / 2, keyDepth + flangeDepth);
			if (pairCount > 1)
				translate([(width - 8) / 2, endThickness, keyDepth + flangeDepth])
					round4CornersCube(8, pairCount * powerPoleSquareSide, 8, 3.9);
		}
		translate([-2, 0, keyDepth + flangeDepth + 8])
			fingerGripCutout(outerThickness);
		translate([width + 2, 0, keyDepth + flangeDepth + 8])
			fingerGripCutout(outerThickness);
		translate([width / 2, 0, flangeDepth / 2])
			rotate([-90, 0, 0])
				cylinder(d=rollPinDiameter, h=100);
	}
}

plugBody();
