/*
 * This version use my helix_extrude library to create the threads of the cap.
 * It's much better than linear_extrude, and more predictable then Thread_Library.
 */

include <bezier.scad>
include <helix_extrude.scad>

// The shape precision.
//   Change it to a high value (180) for rendering.
//   Change it to a low value (45) while developing.
//     This will create a rough shape, easy to manage.
precision = 40;

shakerRadius = 23;
shakerHeight = 105;

holesDiameter = 3;

holeRadius = shakerRadius*0.5;

capRadius = shakerRadius*0.75;
capHeight = shakerHeight*0.1;
capGapRadius = 0.2; // Extra space between the cap and the hole
capRecess = 2;

// Cap threads
threadInnerHeight = 3;
threadOuterHeight = 1;
threadWidth = 2;

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
			[shakerRadius, shakerHeight*0.83], [shakerRadius, shakerHeight*0.89]
		],
		[
			[shakerRadius, shakerHeight*0.89], [shakerRadius, shakerHeight],
			[0, shakerHeight], [0, shakerHeight]
		]
	], precision);
}

// The polygon of the hole inside the shaker.
module shakerHolePolygon() {
	BezPolygon([
		[
			[0, 0], [0, 0],
			[holeRadius, 0], [holeRadius, 0]
		],
		[
			[holeRadius, 0], [holeRadius, 0],
			[holeRadius, shakerHeight*0.9], [holeRadius, shakerHeight*0.9]
		],
		[
			[holeRadius, shakerHeight*0.9], [holeRadius, shakerHeight*0.9],
			[holeRadius*0.6, shakerHeight*0.98], [0, shakerHeight*0.98]
		]
	], precision);
}

module shaker() {
	rotate_extrude($fn = precision) {
		difference() {
			shakerPolygon();
			shakerHolePolygon();
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

module screwCap() {
	difference() {
		union() {
			cylinder(r=capRadius, h=capHeight, $fn=precision);
			helix_extrude(height=capHeight-threadInnerHeight, angle = 360*2, $fn=precision) {
				threadPolygon(capRadius);
			}
		}

		// Hole in cap to facilitate screwing / unscrewing
		translate([0, 0, capHeight * 0.9]) {
			cube([capRadius*1.6, capHeight*0.3, capHeight*0.3], center=true);
		}
	}
}

module screwHole() {
	union() {
		cylinder(r=capRadius+capGapRadius, h=capHeight+capRecess, $fn=precision);
		translate([0, 0, capRecess]) {
			translate([0, 0, -(capHeight-threadInnerHeight)]) {
				helix_extrude(height=(capHeight-threadInnerHeight)*2, angle = 360*4, $fn=precision) {
					threadPolygon(capRadius+capGapRadius);
				}
			}
		}
		// Conic top (to facilitate printing)
		translate([0, 0, capHeight + capRecess]) {
			cylinder(r1=capRadius+capGapRadius, r2=0, h=capHeight*0.75, $fn=precision);
		}
	}
}

difference() {
	shaker();

	translate([0, 0, -0.01]) {
		screwHole();
	}

	// Holes on top
	translate([0, 0, shakerHeight-10]) {
		cylinder(d=holesDiameter, h=10, $fn = precision);
	}
	translate([holeRadius*0.6, 0, shakerHeight-10]) {
		cylinder(d=holesDiameter, h=10, $fn = precision);
	}
	translate([-holeRadius*0.6, 0, shakerHeight-10]) {
		cylinder(d=holesDiameter, h=10, $fn = precision);
	}
	translate([0, holeRadius*0.6, shakerHeight-10]) {
		cylinder(d=holesDiameter, h=10, $fn = precision);
	}
	translate([0, -holeRadius*0.6, shakerHeight-10]) {
		cylinder(d=holesDiameter, h=10, $fn = precision);
	}

	// Cut shaker in half, to see inside
	*translate([-shakerRadius, 0, 0]) cube([shakerRadius*2, shakerRadius, shakerHeight]);
}

translate([capRadius + shakerRadius + 10, 0, 0]) {
	screwCap();
}



// Show cap hole on the side, for debugging
*translate([(capRadius + shakerRadius + 10)*2, 0, 0]) {
	screwHole();
}

// Put the cap in place, for debugging
*translate([0, 0, capHeight + capRecess]) {
	rotate([180, 0, 0])
		screwCap();
}


