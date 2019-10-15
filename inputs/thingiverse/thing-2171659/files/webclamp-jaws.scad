// This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// https://creativecommons.org/licenses/by-sa/3.0/

// width of your strap material
strapWidth = 15;
// thickness of your strap material (but keep it a bit on the high side)
strapThickness = 2;
// overall plastic thickness
thickness = 2;
// length of the original clamp's jaw
jawLength = 35;
// width of the original clamp's jaw
jawWidth = 20;
// thickness of the faceplate of the original clamp's jaw
jawDepth = 3.5;

module dogTag(length, width, depth, oneDiameter, otherDiameter) {
	module envelope() {
		translate([0, width / -2, 0])
			cube([length, width, depth]);
	}
	union() {
		intersection() {
			envelope();
			translate([oneDiameter / 2, 0, 0])
				cylinder(d = oneDiameter, h = depth);
		}
		intersection() {
			translate([oneDiameter / 2, 0, 0])
				envelope();
			translate([length - otherDiameter / 2, 0, 0])
				cylinder(d=otherDiameter, h = depth);
		}
	}
}

module jawCover() {
	length = jawLength;
	width = jawWidth;
	outerLength = length + thickness * 2;
	outerWidth = width + thickness * 2;
	depth = jawDepth;
	oneDiameter = width * 1.2;
	otherDiameter = width * 2;
	translate([0, 0, depth + thickness]) {
		difference() {
			dogTag(outerLength, outerWidth, thickness, oneDiameter, otherDiameter);
			translate([-3, 0, 0])
				dogTag(outerLength, outerWidth, depth + thickness, oneDiameter, otherDiameter);
		}
	}
	difference() {
		dogTag(outerLength, outerWidth, depth + thickness, oneDiameter, otherDiameter);
		translate([thickness, 0, thickness])
			dogTag(length, width, depth, oneDiameter, otherDiameter);
	}
}

module jawStrapClamp() {
	baseThickness = strapThickness + thickness;
	length = jawLength;
	width = jawWidth;
	outerLength = length + thickness * 2;
	outerWidth = width + thickness * 2;
	depth = jawDepth;
	oneDiameter = width * 1.2;
	otherDiameter = width * 2;
	thickenedStrapWidth = strapWidth + thickness * 2;
	strapSlotWidth = strapThickness + 1;
	translate([0, 0, depth + baseThickness]) {
		difference() {
			dogTag(outerLength, outerWidth, thickness, oneDiameter, otherDiameter);
			translate([-3, 0, 0])
				dogTag(outerLength, outerWidth, depth + thickness, oneDiameter, otherDiameter);
		}
	}
	difference() {
		union() {
			translate([0, thickenedStrapWidth / -2, 0])
				cube([thickenedStrapWidth, thickenedStrapWidth, strapThickness + thickness]);
			dogTag(outerLength, outerWidth, depth + baseThickness, oneDiameter, otherDiameter);
		}
		translate([thickness, 0, baseThickness])
			dogTag(length, width, depth, oneDiameter, otherDiameter);
		translate([0, strapWidth / -2, 0]) {
			cube([6, strapWidth, strapThickness]);
			translate([6, 0, 0])
				cube([strapSlotWidth, strapWidth, baseThickness + 1]);
			translate([6 + strapThickness, 0, baseThickness - strapThickness])
				cube([6, strapWidth, strapThickness]);
			translate([14, 0, 0])
				cube([strapSlotWidth, strapWidth, baseThickness + 1]);
			translate([14 + strapThickness, 0, 0])
				cube([6, strapWidth, strapThickness]);
			translate([22, 0, 0])
				cube([strapSlotWidth, strapWidth, baseThickness + 1]);
			translate([22 + strapThickness, 0, baseThickness - strapThickness])
				cube([6, strapWidth, strapThickness]);
			translate([30, 0, 0])
				cube([strapSlotWidth, strapWidth, baseThickness + 1]);
			translate([30 + strapThickness, 0, 0])
				cube([20, strapWidth, strapThickness]);
		}
	}
}

jawStrapClamp();
