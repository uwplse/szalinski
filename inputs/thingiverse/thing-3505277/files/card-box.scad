// The part to print
part = "all"; // [tray,lid,all]

// The width of the card (or width of sleeve)
cardWidth = 72;

// The length of the card (or length of sleeve)
cardLength = 112;

// The height of the card
cardHeight = 0.55;

// The amount of cards
cardCount = 59;

// Extra size for the cards
cardSpacing = 2;

// Extra box height, to ensure cards do not fall out
extraHeight = 4;

// The height of the base and lid
baseHeight = 2;

// The thickness of the walls. The thinnest wall will be half this size.
wallThickness = 5;

// The height of the lid intersection with the base.
lidLegHeight = 5;

contentWidth = cardWidth + cardSpacing;
contentLength = cardLength + cardSpacing;
boxWidth = contentWidth + wallThickness * 2;
boxLength = contentLength + wallThickness * 2;
boxHeight = cardHeight * cardCount + extraHeight;
lidLegThickness = wallThickness / 2;
cardAccessCutoutWidth = contentWidth / 2;
cardAccessCutoutLength = contentLength / 2;
lookingGlassWidth = contentWidth * 0.8;
lookingGlassLength = contentLength * 0.8;

module base() {
	cube([contentWidth + wallThickness * 2, contentLength + wallThickness * 2, baseHeight]);
}

module walls() {
	union() {
		// Top
		cube([contentWidth + wallThickness * 2, wallThickness, boxHeight]);

		// Bottom
		translate([0, contentLength + wallThickness, 0]){
			cube([contentWidth + wallThickness * 2, wallThickness, boxHeight]);
		}

		// Left
		cube([wallThickness, contentLength + wallThickness * 2, boxHeight]);

		// Right
		translate([contentWidth + wallThickness, 0, 0]){
			cube([wallThickness, contentLength + wallThickness * 2, boxHeight]);
		}
	}
}

module lid() {
	translate([0, 0, boxHeight]) {
		difference() {
			union() {
				cube([contentWidth + wallThickness * 2, contentLength + wallThickness * 2, baseHeight]);

				translate([0, 0, -lidLegHeight]) {
					union() {
						// Top
						cube([contentWidth + wallThickness * 2, lidLegThickness, lidLegHeight]);

						// Bottom
						translate([0, contentLength + wallThickness * 2 - lidLegThickness, 0]){
							cube([contentWidth + wallThickness * 2, lidLegThickness, lidLegHeight]);
						}

						// Left
						cube([lidLegThickness, contentLength + wallThickness * 2, lidLegHeight]);

						// Right
						translate([contentWidth + wallThickness * 2 - lidLegThickness, 0, 0]){
							cube([lidLegThickness, contentLength + wallThickness * 2, lidLegHeight]);
						}
					}
				}
			}

			//Looking glass cutout
			translate([boxWidth / 2 - lookingGlassWidth / 2, boxLength / 2 - lookingGlassLength / 2, 0]) {
				cube([lookingGlassWidth, lookingGlassLength, baseHeight]);
			}
		}
	}
}

module cardAccessCutout() {
	cardAccessCutoutCutoutWidth = wallThickness * 2;

	union() {
		//Center on the x axis
		translate([boxWidth / 2 - cardAccessCutoutWidth / 2, 0, 0]) {
			// Top
			cube([cardAccessCutoutWidth, cardAccessCutoutCutoutWidth, boxHeight]);

			// Bottom
			translate([0, boxLength - cardAccessCutoutCutoutWidth, 0]) {
				cube([cardAccessCutoutWidth, cardAccessCutoutCutoutWidth, boxHeight]);
			}
		}

		//Center on the y axis
		translate([0, boxLength / 2 - cardAccessCutoutLength / 2, 0]) {
			// Left
			cube([cardAccessCutoutCutoutWidth, cardAccessCutoutLength, boxHeight]);

			// Right
			translate([boxWidth - cardAccessCutoutCutoutWidth, 0, 0]) {
				cube([cardAccessCutoutCutoutWidth, cardAccessCutoutLength, boxHeight]);
			}
		}
	}
}

if(part == "tray" || part == "all") {
	difference() {
		union() {
			base();
			walls();
		}
		lid();
		cardAccessCutout();
	}
}

if(part == "lid" || part == "all") {
	translate([boxWidth + 10, boxLength, boxHeight + baseHeight]) {
		rotate([180, 0, 0]) {
			difference() {
				lid();
				cardAccessCutout();
			}
		}
	}
}
