width = 40;
length = 85;
height = 30;
thickness = 2.5;
extraEndThickness = 2;
endRadius = 1;
backAngle = 70;
frontAngle = 45;
middle_radius = 4;
clipThickness = 2;
clipWidth = 25;
clipEndRadius = 2;
nutHoleWidth = 9;
nutHoleInset = 3;
boltHoleDiameter = 5;

module round4CornersCube(x,y,z,r) {
	translate([r, r, 0])
        minkowski() {
			cube([x - 2 * r, y - 2 * r, z]);
			cylinder(r=r, h=0.1);
        }
}

module clip(cutout) {
	centerToCenter = clipWidth - clipEndRadius * 2;
	difference() {
		union() {
			translate([0, clipEndRadius - clipThickness, 0])
				cube([centerToCenter, clipThickness, width + cutout]);
			cylinder(r=clipEndRadius, h=width + cutout, $fn=24);
			translate([centerToCenter, 0, 0])
				cylinder(r=clipEndRadius, h=width + cutout, $fn=24);
			if (cutout) {
				nutBoreDepth = thickness + extraEndThickness + 2;
				translate([(centerToCenter - nutHoleWidth) / 2,  - nutBoreDepth, (width - nutHoleWidth) / 2])
					cube([nutHoleWidth, nutBoreDepth - nutHoleInset, nutHoleWidth]);
				translate([centerToCenter / 2, clipThickness, width / 2])
					rotate([90, 0, 0])
						cylinder(d=boltHoleDiameter, h=nutBoreDepth + nutHoleInset, $fn=12);
			}
		}
		if (!cutout) {
			translate([centerToCenter / 2, clipThickness, width / 2])
				rotate([90, 0, 0])
					cylinder(d=boltHoleDiameter, h=10, $fn=12);
		}
	}
}

module simpleBlock(inset, extraWidth) {
	backAdj = 1.5 * tan(90 - backAngle);
	frontAdj = 1.5 * tan(90 - frontAngle);
	minkLength = length - (inset ? extraEndThickness * 2 : 0) - inset * (2 + backAdj + frontAdj) - endRadius * 2;
	minkHeight = height - inset * 2 - endRadius * 2;
	translate([endRadius + inset * backAdj + (inset ? extraEndThickness : 0), endRadius, 0])
		minkowski() {
			linear_extrude(height=width + extraWidth, convexity=5) {
				polygon(paths=[[0, 1, 2, 3]],
					points=[[0, 0], [minkLength, 0], [minkLength - tan(90 - frontAngle) * minkHeight, minkHeight], [tan(90 - backAngle) * minkHeight, minkHeight]]);
			}
			cylinder(r=endRadius, h=0.1, $fn=24);
		}
}

module block() {
	difference() {
		simpleBlock(0, 0);
		translate([thickness, thickness, -1])
			simpleBlock(thickness, 2);
		translate([2 * tan(90 - backAngle) - 0.25, thickness * 2, 0])
			rotate([0, 0, backAngle])
				clip(1);
		translate([length + 0.25 - 2 * tan(90 - frontAngle), thickness * 2, 0])
			rotate([0, 0, 180 - frontAngle])
				mirror([0, 1, 0])
					clip(1);
	}
}

block();
translate([thickness + extraEndThickness + clipThickness + 10, thickness + clipThickness + 0.5, 0]) {
	clip(0);
	translate([clipWidth + 0.25, 0, 0])
		clip(0);
}
