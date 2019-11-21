/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   24 November 2017
 * =====================================
 *
 * Mini-stand, OpenSCAD version from muzz64:
 *   https://www.thingiverse.com/thing:1977933
 *
 * Re-modeled with muzz64 permission.
 *
 * Units are in millimetres.
 */

/* [Basic] */

// The original model have a clearance of 0.5mm. A clearance of 0.2mm works very well with precise printers like the Prusa i3.
clearance = 0.5; // [0.0:0.1:1]

// First line of text
string1 = "DO";

// Second line of text
string2 = "NOT";

// Third line of text
string3 = "TURN";

// Forth line of text
string4 = "OFF";

// Scale of the text, adjust to make it fit
textScale = 0.7; // [0.1:0.05:1]

// Move the text down
textOffset = -19; // [-40:1:40]

// Move the text down
textLineHeight = 16; // [1:1:50]


/* [Advanced] */

// Precision
$fn = 40;

// Font used for the text. For a list of available fonts, use: Help > Font List
font = "DejaVu Sans:style=Condensed Bold";

standWidth = 40;
standHeight = 62;
standDepth = 5;
standCornerRadius = 2.5;

standHandleWidth = 20;
standHandleHeight = 3.5;
standHandleOffset = 3.5;

frameWidth = 36;
frameHeight = 51;
frameBorder = 0.8;
frameDepth = 1.2;
frameOffset = 3.6;

legLength = 7.5;
legWidth = 10;
legCutAngle = 23; // TODO Calculate from "arm" length

hingeSideWidth = 7.6;
hingeMiddleWidth = 11;
hingeLength = 7.5;

// The arm underneath, used to lock the mini-stand
armLength = 40;
armWidth = 4;
armThickness = 3;

minimumThickness = 0.4;
hingeConeAngle = 60;

// Extra padding to help when evaluating 3D difference.
diffExtra = 0.1;

// Variables calculated to simplify the code
// Hinge angle
hingeTheta = 90 - hingeConeAngle;
// hingeOffset is the distance between the tip of the cone and the tip of the conic hole
hingeOffset = clearance / sin(hingeTheta);

hingeConeHoleRadius = standDepth/2 - minimumThickness;
hingeConeHoleLength = hingeConeHoleRadius / tan(hingeTheta);

hingeConeLength = hingeConeHoleLength + clearance - hingeOffset;
hingeConeRadius = hingeConeLength * hingeConeHoleRadius / hingeConeHoleLength;


// Clearance on both side
armHoleWidth = armWidth + 2*clearance;
armHoleLength = armLength + 2*clearance;
// Increase clearance on top of the arm (we don't want it to get stuck inside)
armHoleDepth = armThickness + 2*clearance;

armHingeConeHoleRadius = armThickness/2 - minimumThickness;
armHingeConeHoleLength = armHingeConeHoleRadius / tan(hingeTheta);

armHingeConeLength = armHingeConeHoleLength + clearance - hingeOffset;
armHingeConeRadius = armHingeConeLength * armHingeConeHoleRadius / armHingeConeHoleLength;


legInnerLength = legLength - (standDepth / tan(90-legCutAngle));
armEndRadius = armThickness / 2;

// Debuging
*color([0, 0, 1, 0.2]) {
	//import("../orig/blank.stl");
	import("../orig/do_not_turn_off.stl");
}

// Debuging
*difference() {
	miniStand();
	translate([0, 50, 0]) {
		cube([200, 100, 100], center=true);
	}
}


miniStand();

module miniStand() {
	translate([hingeLength, standWidth/2, 0]) {
		rotate([0, 0, -90]) {
			difference() {
				panel();
				armHole();
			}

			arm();
		}
	}

	translate([-hingeLength, -standWidth/2, 0]) {
		rotate([0, 0, 90]) {
			difference() {
				panel();
				armLockHole();
			}
		}
	}

	color([1, 0, 0]) {
		hinge();
	}
}

// One of the 2 side of the stand, without the hinge, without hole at the back.
module panel() {
	color([1, 0, 0]) {
		linear_extrude(standDepth) {
			difference() {
				union() {
					// Panel with holes for the rounded corner
					translate([0, standCornerRadius]) {
						square([standWidth, standHeight - standCornerRadius]);
					}
					translate([standCornerRadius, 0]) {
						square([standWidth - (standCornerRadius * 2), standCornerRadius]);
					}

					// Rounded corner
					translate([standCornerRadius, standCornerRadius]) {
						circle(r = standCornerRadius);
					}
					translate([standWidth - standCornerRadius, standCornerRadius]) {
						circle(r = standCornerRadius);
					}
				}

				// Handle (hole)
				translate([(standWidth - standHandleWidth) / 2, standHandleOffset]) {
					square([standHandleWidth, standHandleHeight]);
				}
			}
		}

		// Legs
		translate([0, standHeight, 0]) {
			leg();
		}
		translate([standWidth - legWidth, standHeight, 0]) {
			leg();
		}
	}

	// Frame
	color([1, 1, 1]) {
		translate([
			standWidth / 2,
			standHeight / 2 + frameOffset,
			standDepth
		]) {
			rotate([0, 0, 180]) {
				frame();
			}
		}
	}
}

// The frame around the text
module frame() {
	linear_extrude(frameDepth) {
		difference() {
			square([frameWidth, frameHeight], center = true);
			square([
				frameWidth - (frameBorder * 2),
				frameHeight - (frameBorder * 2)
			], center = true);
		}

		scale([textScale, textScale]) {
			translate([0, -textOffset]) {
				text(string1, font = font, halign = "center");
			}
			translate([0, -textOffset - textLineHeight]) {
				text(string2, font = font, halign = "center");
			}
			translate([0, -textOffset - textLineHeight*2]) {
				text(string3, font = font, halign = "center");
			}
			translate([0, -textOffset - textLineHeight*3]) {
				text(string4, font = font, halign = "center");
			}
		}
	}
}

// The legs at the bottom, cut in an angle
module leg() {
	rotate([90, 0, 90]) {
		linear_extrude(legWidth) {
			polygon([
				[0, 0],
				[legInnerLength, 0],
				[legLength, standDepth],
				[0, standDepth]
			]);
		}
	}
}

module hinge() {
	// Middle part
	difference() {
		translate([0, hingeMiddleWidth/2, standDepth/2]) {
			rotate([90, 0, 0]) {
				linear_extrude(hingeMiddleWidth) {
					hinge2DProfile();
				}
			}
		}
		// Conic holes
		translate([0, hingeMiddleWidth/2, standDepth/2]) {
			rotate([90, 0, 0]) {
				cylinder(r1 = hingeConeHoleRadius, r2 = 0, h = hingeConeHoleLength);
			}
		}
		translate([0, -hingeMiddleWidth/2, standDepth/2]) {
			rotate([-90, 0, 0]) {
				cylinder(r1 = hingeConeHoleRadius, r2 = 0, h = hingeConeHoleLength);
			}
		}
	}

	// Side parts
	translate([0, hingeMiddleWidth/2 + hingeSideWidth + clearance, standDepth/2]) {
		rotate([90, 180, 0]) {
			linear_extrude(hingeSideWidth) {
				hinge2DProfile();
			}
		}
	}
	translate([0, hingeMiddleWidth/2 + clearance, standDepth/2]) {
		rotate([90, 0, 0]) {
			cylinder(r1 = hingeConeRadius, r2 = 0, h = hingeConeLength);
		}
	}

	translate([0, -hingeMiddleWidth/2 - clearance, standDepth/2]) {
		rotate([90, 180, 0]) {
			linear_extrude(hingeSideWidth) {
				hinge2DProfile();
			}
		}
	}
	translate([0, -hingeMiddleWidth/2 - clearance, standDepth/2]) {
		rotate([-90, 0, 0]) {
			cylinder(r1 = hingeConeRadius, r2 = 0, h = hingeConeLength);
		}
	}
}

module hinge2DProfile() {
	// NOTE: Parameter "d" (diameter) is only available from OpenSCAD 2014.03
	circle(r = standDepth/2);
	translate([0, -standDepth/2]) {
		square([hingeLength, standDepth]);
	}
}

module arm() {
	translate([
		(standWidth - armWidth) / 2,
		(standHeight - armLength) / 2,
		0
	]) {
		difference() {
			cube([armWidth, armLength - armEndRadius, armThickness]);
			// Hole in the arm, to lock it in place
			translate([-diffExtra, armThickness/2, armThickness/2]) {
				cube([
					armWidth + 2*diffExtra,
					armThickness/2 + 2*clearance,
					armThickness/2 + diffExtra
				]);
			}
		}
		translate([0, armLength - armEndRadius, armEndRadius]) {
			rotate([0, 90, 0]) {
				cylinder(r = armEndRadius, h = armWidth);
			}
		}
	}

	// Arm hinges
	translate([
		(standWidth - armWidth) / 2 + armWidth,
		(standHeight - armLength) / 2 + armLength - armEndRadius,
		armEndRadius
	]) {
		rotate([0, 90, 0]) {
			cylinder(r1 = armHingeConeRadius, r2 = 0, h = armHingeConeLength);
		}
	}

	translate([
		(standWidth - armWidth) / 2,
		(standHeight - armLength) / 2 + armLength - armEndRadius,
		armEndRadius
	]) {
		rotate([0, -90, 0]) {
			cylinder(r1 = armHingeConeRadius, r2 = 0, h = armHingeConeLength);
		}
	}
}

// Hole under the panel to store the arm when not in use.
module armHole() {
	// Extra space to allow the arm to get out of its hole
	armRadius = armLength - armEndRadius;
	armHalfDepth = armThickness / 2;
	armHoleGap = sqrt(armRadius*armRadius + armHalfDepth*armHalfDepth) - armRadius;

	translate([
		(standWidth - armHoleWidth) / 2,
		(standHeight - armHoleLength) / 2 - armHoleGap,
		-diffExtra
	]) {
		cube([armHoleWidth, armHoleLength + armHoleGap, armHoleDepth + diffExtra]);
	}

	// Holes for the arm hinges
	translate([
		(standWidth - armHoleWidth) / 2 + armHoleWidth,
		(standHeight - armLength) / 2 + armLength - armEndRadius,
		armEndRadius
	]) {
		rotate([0, 90, 0]) {
			cylinder(r1 = armHingeConeHoleRadius, r2 = 0, h = armHingeConeHoleLength);
		}
	}

	translate([
		(standWidth - armHoleWidth) / 2,
		(standHeight - armLength) / 2 + armLength - armEndRadius,
		armEndRadius
	]) {
		rotate([0, -90, 0]) {
			cylinder(r1 = armHingeConeHoleRadius, r2 = 0, h = armHingeConeHoleLength);
		}
	}
}

// Hole under the other panel, use to lock the arm in place.
module armLockHole() {
	armLockHoleWidth = armHoleWidth;
	armLockHoleHeight = armThickness + 4*clearance;

	// Deep hole to allow the arm to slide in place
	armLockHoleDepth = 1.2 * armThickness + diffExtra;

	armLockHeight = armThickness/2;
	armLockThickness = armThickness/2 - clearance;

	translate([
		(standWidth - armLockHoleWidth) / 2,
		(standHeight - armLength) / 2 + armLength - armLockHoleHeight,
		-diffExtra
	]) {
		difference() {
			cube([armLockHoleWidth, armLockHoleHeight, armLockHoleDepth]);
			translate([0, -diffExtra, -diffExtra]) {
				cube([
					armLockHoleWidth + diffExtra,
					armLockHeight + diffExtra,
					armLockThickness + 2*diffExtra
				]);
			}
		}
		translate([-armLockHoleWidth, 0, 0]) {
			cube([
				armLockHoleWidth,
				armLockHoleHeight,
				armLockHoleDepth
			]);
		}
	}
}
