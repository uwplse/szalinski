// This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// https://creativecommons.org/licenses/by-sa/3.0/

// DIN rail clamp thickness: at least 11 to have enough space for the PowerPoles; if thicker, provides a good place for labels
clampThickness = 11.5;
// the top of the row of PowerPoles will be this far above the DIN rail
heightAboveRail = 25;
// provides a good place for a label
spacingOutwardsFromRail = 8;
// how many pairs of PowerPoles?
pairCount = 2;
// spacing between PowerPole pairs
pairSpacing = 1.5;
// an endcap is a good place for a label
endcapWidth = 8;
// width of a single PowerPole; should be 8mm, but probably larger to compensate for your printer
powerPoleSquareSide = 8.5;
// diameter of roll pins to hold the PowerPoles in place; compensate for your printer
rollPinDiameter = 2.25;
// how deep the bolt should go into the solid part, past the spring clip
boltHoleDepth = 10;
// diameter where the bolt passes through the spring clip
looseBoltDiameter = 3.2;
// diameter where the bolt should screw into the DIN holder body
tightBoltDiameter = 2.9;

// DIN rail clamp
// adapted from Thingiverse 101024 by Robert Hunt
// made with 1mm wider opening: my rail is bigger or my printer prints too small
// Dimensions: 19.74 x 51 x clampThickness
module din_clamp() {
	$fn = 24;
	translate([10.1, -13.1, 0])
	difference() {
		linear_extrude(height=clampThickness, convexity=5) {
			// imported Robert's DXF to Inkscape, adjusted, then exported via https://github.com/martymcguire/inkscape-openscad-poly
			polygon(points=
				[[-9.731, 25.355], [5.910, 25.355], [6.675, 25.203], [7.324, 24.770], [7.758, 24.121], [7.910, 23.355], [7.910, 10.855],
				[7.764, 10.502], [7.410, 10.355], [6.854, 10.355], [6.320, 10.510], [5.951, 10.925], [4.910, 13.105], [3.910, 13.106],
				[3.910, -21.394], [3.832, -21.783], [3.617, -22.101], [3.299, -22.315], [2.910, -22.394], [-5.372, -22.394], [-5.736, -22.550],
				[-5.852, -22.894], [-5.729, -23.238], [-5.372, -23.394], [5.160, -23.394], [5.160, -21.464], [5.302, -21.239], [5.566, -21.269],
				[9.561, -24.465], [9.730, -24.717], [9.721, -25.021], [9.538, -25.263], [9.249, -25.355], [-9.731, -25.355]]
				, paths=
				[[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 0]]
			);
		}
		translate([0, -22.5, clampThickness / 2]) {
			rotate([90, 90, 0]) {
				cylinder(h= boltHoleDepth, r = looseBoltDiameter / 2);
			}
		}
		translate([0, -22.5, clampThickness / 2]) {
			rotate([-90, 90, 0]) {
				cylinder(h= boltHoleDepth, r = tightBoltDiameter / 2);
			}
		}
	}
}
// End of DIN clamp by Robert Hunt

// PowerPole code is inspired by thing:1424702 (which in turn was based on something from by J. Dunmire)
// but this version is way simplified and has little in common now
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
	halfSide = powerPoleSquareSide / 2;
	module key(){
		translate([0,-1.75,-0.5]) cube([25,3.5,1]);
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

module powerPoleLinearArray(pairs){
	for (i = [0:pairs - 1]) {
		translate([i * 16,0,0]) rotate([0, 0, -90]) powerPoleSingleCutout();
		translate([i * 16 + 8,0,0]) rotate([0, 0, -90]) powerPoleSingleCutout();
		translate([i * 16 + 8,-10,0]) cylinder(d=rollPinDiameter,h=30, center=true, $fn=12);
	}
}

module clampWithWing(heightAboveRailTop, height, stickOut) {
	radius = 8;
	wingBottom = heightAboveRailTop - height;
	wallThickness = 1.5; // or max(1, (clampThickness - 8.5) / 2) to center it
	difference() {
		union() {
			translate([0, wingBottom - radius, 0])
				cube([stickOut, height + radius, clampThickness]);
			translate([14, 0, 0])
				mirror([1, 0, 0])
					din_clamp();
		}
		// hollow out most of the clamp:
		//~ translate([6, 6, wallThickness])
			//~ cube([20, wingBottom - 6, 8.5]);

		translate([8, 32, wallThickness])
			cube([20, 8, 8.5]);

		translate([21.65, wingBottom - radius, -1])
			cylinder(r=radius, h=20);
		translate([22, wingBottom - radius - 1, -1])
			cube([200, radius + 1, 20]);
	}
}

// not practical to print because of trouble bridging that far
module powerpolesAllTogether() {
	perPairOffset = 16.5;
	wallThickness = 1.5;
	difference() {
		clampWithWing(heightAboveRail, 18, spacingOutwardsFromRail + perPairOffset * pairCount + endcapWidth - pairSpacing);
		translate([spacingOutwardsFromRail, heightAboveRail, wallThickness])
			powerPoleLinearArray(pairCount);
	}
}

module powerpoles2and4Together() {
	perPairOffset = pairSpacing + 16.5;
	wallThickness = 1.5;
	difference() {
		clampWithWing(heightAboveRail, 18, spacingOutwardsFromRail + 48 + pairSpacing + endcapWidth);
		// first pair of PowerPoles must insert from top
		translate([spacingOutwardsFromRail, heightAboveRail, wallThickness]) {
			translate([0,0,0]) rotate([0, 0, -90]) powerPoleWithExtendedKeys();
			translate([8,0,0]) rotate([0, 0, -90]) powerPoleWithExtendedKeys();
			translate([8,-10,0]) cylinder(d=rollPinDiameter,h=30, center=true, $fn=12);
		}
		translate([spacingOutwardsFromRail + perPairOffset, heightAboveRail, wallThickness])
			powerPoleLinearArray(2);
	}
}

module clampWithNPowerPoles() {
	perPairOffset = pairSpacing + 16.5;
	wallThickness = 1.5;
	difference() {
		clampWithWing(heightAboveRail, 20, spacingOutwardsFromRail + perPairOffset * pairCount + endcapWidth - pairSpacing);
		// first pair of PowerPoles must insert from top
		translate([spacingOutwardsFromRail, heightAboveRail, wallThickness]) {
			translate([0,0,0]) rotate([0, 0, -90]) powerPoleWithExtendedKeys();
			translate([8,0,0]) rotate([0, 0, -90]) powerPoleWithExtendedKeys();
			translate([8,-10,0]) cylinder(d=rollPinDiameter,h=30, center=true, $fn=12);
		}
		for (i = [0:pairCount - 1])
			translate([spacingOutwardsFromRail + i * perPairOffset, heightAboveRail, wallThickness])
				powerPoleLinearArray(1);
	}
}

clampWithNPowerPoles();
