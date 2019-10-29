$fn = 50;

// Part to render [top, bottom, test, speaker]
part = "bottom";
// Radius of speaker corners
cornerRadius = 12;
// Leave this as is
speakerSide = 34.5;
// Speaker height, 150 is standart
speakerHeight = 150;
// Bottom and top rubber parts width, adjust it if needed
borderSide = 81;
// Bottom and top rubber parts height, 25 is standart
borderHeight = 25;
// Width of vertical plate connecting bottom and top rubber parts
plateWidth = 18;
// Leave it as is
plateDepth = (borderSide - speakerSide - radiusSide(cornerRadius)) / 3;
// Thickness of walls around speaker, 5 is fine
wallThickness = 5;
// Bike frame diameter at attaching place
frameWidth = 32;
// Distance between bike frame holes, 65 is standart
holesDistance = 65;
// Bike frame screws diameter, 5 is standart
holesDiameter = 5;

function radiusSide(r) = 6 * r / sqrt(3);

module speaker(full = false) {
	if (full) {
		hull() {
			cylinder(r = cornerRadius, h = speakerHeight);
			translate([borderSide - radiusSide(cornerRadius), 0, 0]) cylinder(r = cornerRadius, h = speakerHeight);
			rotate(a = 60, v = [0, 0, 1]) translate([borderSide - radiusSide(cornerRadius), 0, 0]) cylinder(r = cornerRadius, h = speakerHeight);
		}
	} else {
		hull() {
			cylinder(r = cornerRadius, h = borderHeight);
			translate([borderSide - radiusSide(cornerRadius), 0, 0]) cylinder(r = cornerRadius, h = borderHeight);
			rotate(a = 60, v = [0, 0, 1]) translate([borderSide - radiusSide(cornerRadius), 0, 0]) cylinder(r = cornerRadius, h = borderHeight);
		}
		translate([(borderSide - speakerSide - radiusSide(cornerRadius)) / 2, plateDepth, borderHeight]) hull() {
			cylinder(r = cornerRadius, h = speakerHeight - borderHeight * 2);
			translate([speakerSide, 0, 0]) cylinder(r = cornerRadius, h = speakerHeight - borderHeight * 2);
			rotate(a = 60, v = [0, 0, 1]) translate([speakerSide, 0, 0]) cylinder(r = cornerRadius, h = speakerHeight - borderHeight * 2);
		}
		translate([0, 0, speakerHeight - borderHeight]) hull() {
			cylinder(r = cornerRadius, h = borderHeight);
			translate([borderSide - radiusSide(cornerRadius), 0, 0]) cylinder(r = cornerRadius, h = borderHeight);
			rotate(a = 60, v = [0, 0, 1]) translate([borderSide - radiusSide(cornerRadius), 0, 0]) cylinder(r = cornerRadius, h = borderHeight);
		}
		rotate(a = 60, v = [0, 0, 1]) translate([(borderSide - plateWidth - radiusSide(cornerRadius)) / 2, cornerRadius - plateDepth, borderHeight]) cube([plateWidth, plateDepth, speakerHeight - borderHeight * 2]);
	}
}

module holderBottom() {
	difference() {
		union() {
			hull() {
				cylinder(r = cornerRadius, h = speakerHeight + wallThickness * 2);
				translate([borderSide - radiusSide(cornerRadius) / 2, 0, 0]) cylinder(r = cornerRadius, h = speakerHeight + wallThickness * 2);
				translate([-cornerRadius + borderSide / 2 - radiusSide(cornerRadius) / 2, borderSide, 0]) cube([frameWidth + wallThickness * 2, 0.1, speakerHeight + wallThickness * 2]);
			}
			translate([(frameWidth + borderSide - radiusSide(cornerRadius)) / 2 + wallThickness - cornerRadius, borderSide, 0]) cylinder(r = frameWidth / 2 + 5, h = speakerHeight + wallThickness * 2);
		}
		translate([wallThickness / cos(60), wallThickness, wallThickness]) speaker(true);
		translate([(frameWidth + borderSide - radiusSide(cornerRadius)) / 2 + wallThickness - cornerRadius, borderSide, 0]) cylinder(r = frameWidth / 2, h = speakerHeight + wallThickness * 2);
		translate([(borderSide - radiusSide(cornerRadius)) / 2 - cornerRadius, borderSide, 0]) cube([frameWidth + wallThickness * 2, frameWidth / 2 + wallThickness, speakerHeight + wallThickness * 2]);
		translate([-cornerRadius, -cornerRadius, wallThickness + borderHeight]) cube([borderSide + wallThickness, wallThickness + cornerRadius, speakerHeight - borderHeight * 2]);
		translate([(frameWidth + borderSide - radiusSide(cornerRadius)) / 2 + wallThickness - cornerRadius, borderSide, (speakerHeight - holesDistance) / 2 + wallThickness]) rotate(a = 90, v = [1, 0, 0]) cylinder(r = holesDiameter / 2, h = frameWidth);
		translate([(frameWidth + borderSide - radiusSide(cornerRadius)) / 2 + wallThickness - cornerRadius, borderSide - frameWidth / 2 - wallThickness, (speakerHeight - holesDistance) / 2 + wallThickness]) rotate(a = 90, v = [1, 0, 0]) cylinder(r = 6, h = 12);
		translate([(frameWidth + borderSide - radiusSide(cornerRadius)) / 2 + wallThickness - cornerRadius, borderSide, (speakerHeight + holesDistance) / 2 + wallThickness]) rotate(a = 90, v = [1, 0, 0]) cylinder(r = holesDiameter / 2, h = frameWidth);
		translate([(frameWidth + borderSide - radiusSide(cornerRadius)) / 2 + wallThickness - cornerRadius, borderSide - frameWidth / 2 - wallThickness, (speakerHeight + holesDistance) / 2 + wallThickness]) rotate(a = 90, v = [1, 0, 0]) cylinder(r = 6, h = 12);
		translate([0, speakerSide / 2, speakerHeight - borderHeight]) rotate(a = 60, v = [0, 0, 1]) cube([speakerSide, wallThickness / 2, wallThickness]);
		translate([borderSide - radiusSide(cornerRadius) / 2, 0, 0]) mirror([1, 0, 0]) translate([0, speakerSide / 2, speakerHeight - borderHeight]) rotate(a = 60, v = [0, 0, 1]) cube([speakerSide, wallThickness / 2, wallThickness]);
		translate([-50, -frameWidth / 2 - wallThickness, speakerHeight - borderHeight + wallThickness]) cube([borderSide * 2, borderSide, borderHeight + wallThickness]);
	}
}

module holderTop() {
	difference() {
		intersection() {
			translate([0, 0, speakerHeight - borderHeight]) hull() {
				cylinder(r = cornerRadius, h = borderHeight + wallThickness * 2);
				translate([borderSide - radiusSide(cornerRadius) / 2, 0, 0]) cylinder(r = cornerRadius, h = borderHeight + wallThickness * 2);
				translate([-cornerRadius + borderSide / 2 - radiusSide(cornerRadius) / 2, borderSide, 0]) cube([frameWidth + wallThickness * 2, 0.1, borderHeight + wallThickness * 2]);
			}
			translate([-50, -frameWidth / 2 - wallThickness, speakerHeight - borderHeight]) cube([borderSide * 2, borderSide, borderHeight + wallThickness * 2]);
		}
		holderBottom();
		translate([wallThickness / cos(60), wallThickness, wallThickness]) speaker(true);
		translate([(frameWidth + borderSide - radiusSide(cornerRadius)) / 2 + wallThickness - cornerRadius, borderSide, 0]) cylinder(r = frameWidth / 2, h = speakerHeight + wallThickness * 2);
		translate([(borderSide - radiusSide(cornerRadius)) / 2 - cornerRadius, borderSide, 0]) cube([frameWidth + wallThickness * 2, frameWidth / 2 + wallThickness, speakerHeight + wallThickness * 2]);
		translate([-cornerRadius, -cornerRadius, wallThickness + borderHeight]) cube([borderSide + wallThickness, wallThickness + cornerRadius, speakerHeight - borderHeight * 2]);
		translate([wallThickness / cos(60) / 0.73, wallThickness / 0.73, wallThickness * 3]) scale([0.8, 0.8, 1]) speaker(true);
	}
}

module testPlate() {
	difference() {
		scale([1.1, 1.1, 0.01]) speaker(true);
		translate([borderSide * 0.025, borderSide * 0.015, 0]) speaker(true);
	}
}

if (part == "top") translate([0, 0, speakerHeight + wallThickness * 2]) rotate(a = 180, v = [1, 0, 0]) holderTop();
else if (part == "bottom") holderBottom();
else if (part == "test") testPlate();
else if (part == "speaker") speaker();