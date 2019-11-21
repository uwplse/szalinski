/*
 * This version use my helix_extrude library to create the threads of the cap.
 * It's much better than linear_extrude, and more predictable then Thread_Library.
 */

include <../bezier.scad>
include <../helix_extrude.scad>

// The shape precision.
//   Change it to a high value (100) for rendering.
//   Change it to a low value (40) while developing.
//     This will create a rough shape, fast render.
$fn = 100;

shakerRadius = 23;
shakerHeight = 105;

holesDiameter = 3;

holeRadius = shakerRadius*0.5;
bottomThickness = 4;
topThickness = 2.5;

// Threads
threadHeight = 8;
threadClearance = 0.2;
threadInnerHeight = 3;
threadOuterHeight = 1;
threadWidth = 2;


*shaker();
*shakerCap();

debug();

module debug() {
	difference() {
		union() {
			shaker();
			shakerCap();
		}

		// Cut shaker in half, to see inside
		translate([-shakerRadius, 0, 0]) cube([shakerRadius*2, shakerRadius, shakerHeight]);
	}
}


// The shaker polygon, starting from the bottom, to the top
module shakerPolygon() {
	BezPolygon([
		[
			[0, 0], [0, 0],
			[shakerRadius, 0], [shakerRadius, 0]
		],
		[
			[shakerRadius, 0], [shakerRadius, 0],
			[shakerRadius, shakerHeight*0.17], [shakerRadius, shakerHeight*0.17]
		],
		[
			[shakerRadius, shakerHeight*0.17], [shakerRadius, shakerHeight*0.195],
			[shakerRadius*0.89, shakerHeight*0.2], [shakerRadius*0.89, shakerHeight*0.2]
		],
		[
			[shakerRadius*0.89, shakerHeight*0.2], [shakerRadius*0.89, shakerHeight*0.2],
			[shakerRadius, shakerHeight*0.215], [shakerRadius, shakerHeight*0.26]
		],
		[
			[shakerRadius, shakerHeight*0.26], [shakerRadius, shakerHeight*0.305],
			[shakerRadius*0.89, shakerHeight*0.32], [shakerRadius*0.89, shakerHeight*0.32]
		],
		[
			[shakerRadius*0.89, shakerHeight*0.32], [shakerRadius*0.89, shakerHeight*0.32],
			[shakerRadius*0.89, shakerHeight*0.35], [shakerRadius*0.89, shakerHeight*0.35]
		],
		[
			[shakerRadius*0.89, shakerHeight*0.35], [shakerRadius*0.89, shakerHeight*0.35],
			[shakerRadius*0.62, shakerHeight*0.43], [shakerRadius*0.62, shakerHeight*0.56]
		],
		[
			[shakerRadius*0.62, shakerHeight*0.56], [shakerRadius*0.62, shakerHeight*0.69],
			[shakerRadius*0.85, shakerHeight*0.74], [shakerRadius*0.85, shakerHeight*0.77]
		],
		[
			[shakerRadius*0.85, shakerHeight*0.77], [shakerRadius*0.85, shakerHeight*0.79],
			[shakerRadius*0.78, shakerHeight*0.81], [shakerRadius*0.78, shakerHeight*0.81]
		],
		[
			[shakerRadius*0.78, shakerHeight*0.81], [shakerRadius*0.78, shakerHeight*0.81],
			[0, shakerHeight*0.81], [0, shakerHeight*0.81]
		]
	], $fn);

	// Cylinder at the top for threads
	translate([0, shakerHeight*0.81]) {
		square([holeRadius + 2, threadHeight]);
	}
}

module shakerCapPolygon() {
	difference() {
		BezPolygon([
			[
				[0, shakerHeight*0.81], [0, shakerHeight*0.81],
				[shakerRadius*0.78, shakerHeight*0.81], [shakerRadius*0.78, shakerHeight*0.81]
			],
			[
				[shakerRadius*0.78, shakerHeight*0.81], [shakerRadius*0.78, shakerHeight*0.81],
				[shakerRadius, shakerHeight*0.83], [shakerRadius, shakerHeight*0.89]
			],
			[
				[shakerRadius, shakerHeight*0.89], [shakerRadius, shakerHeight],
				[0, shakerHeight], [0, shakerHeight]
			]
		], $fn);

		// Cylinder at the top for threads
		holeWidth = holeRadius + 2 + threadWidth + threadClearance;
		translate([0, shakerHeight*0.81]) {
			square([holeWidth, threadHeight]);
		}

		// Conical (or spherical) hole inside the cap
		yOffset = shakerHeight*0.81 + threadHeight;
		yRadius = shakerHeight - yOffset - topThickness;
		sphericalHole = false;
		translate([0, yOffset]) {
			// X radius = holeWidth;
			// Y radius = yRadius;
			if (sphericalHole) {
				// Spherical hole. Pretty, but hard to print
				scaleXRatio = holeWidth / yRadius;
				scale([scaleXRatio, 1]) {
					circle(r = yRadius);
				}
			} else {
				// Conical hole. Can be printed without support
				polygon([
					[0, 0],
					[holeWidth, 0],
					[0, yRadius]
				]);
			}
		}
	}
}

// The polygon of the hole inside the shaker.
module shakerHolePolygon() {
	bottomSphereYOffset = holeRadius + bottomThickness;

	translate([0, bottomSphereYOffset]) {
		circle(r = holeRadius);
		square([holeRadius, shakerHeight - bottomSphereYOffset]);
	}
}

module shaker() {
	rotate_extrude() {
		difference() {
			shakerPolygon();
			shakerHolePolygon();
		}
	}

	// Threads
	translate([0, 0, shakerHeight*0.81]) {
		helix_extrude(height=threadHeight - threadInnerHeight, angle = 360*1.2) {
			threadPolygon(holeRadius + 2);
		}
	}
}

module shakerCap() {
	difference() {
		rotate_extrude() {
			shakerCapPolygon();
		}

		// Holes on top
		holeHeight = shakerHeight - holeRadius - bottomThickness;
		translate([0, 0, holeRadius + bottomThickness]) {
			cylinder(d=holesDiameter, h=holeHeight);
			translate([holeRadius*0.6, 0, 0]) {
				cylinder(d=holesDiameter, h=holeHeight);
			}
			translate([-holeRadius*0.6, 0, 0]) {
				cylinder(d=holesDiameter, h=holeHeight);
			}
			translate([0, holeRadius*0.6, 0]) {
				cylinder(d=holesDiameter, h=holeHeight);
			}
			translate([0, -holeRadius*0.6, 0]) {
				cylinder(d=holesDiameter, h=holeHeight);
			}
		}
	}

	// Threads
	translate([0, 0, shakerHeight*0.81]) {
		helix_extrude(height=threadHeight - threadInnerHeight, angle = 360*1.2) {
			threadPolygon(-(holeRadius + 2 + threadWidth + threadClearance));
		}
	}
}

module threadPolygon(radius) {
	threadDelta = (threadInnerHeight - threadOuterHeight) / 2;

	// Move the trapezoid away from the center
	translate([radius, 0, 0]) {
		// Simple trapezoid
		polygon([
			[0, 0],
			[threadWidth, threadDelta],
			[threadWidth, threadInnerHeight - threadDelta],
			[0, threadInnerHeight]
		]);
	}
}
