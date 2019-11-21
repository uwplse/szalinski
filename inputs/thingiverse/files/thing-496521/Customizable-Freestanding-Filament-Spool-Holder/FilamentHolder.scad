/**
 * Parametric Spool Holder
 * By Chris London
 * 
 * based on: http://www.thingiverse.com/thing:293623
 */

/* [Standard] */
/* [Global] */

// Which part would you like to see?
part = "all"; // [axle:Axle Only,stands:Stands Only,base:Base Only,all:All]

// The diameter of the hole in the center of the spool in millimeters.
axle_diameter = 32;

// The diameter of the entire spool in millimeters
spool_diameter = 100;

// The width of the spool in millimeters
spool_width = 60;


/* [Advanced] */

// Extra space between the axle and the spool opening in millimeters
axle_tolerance = 2;

// Extra space from the spool to the ground in millimeters
spool_tolerance = 25;

// Extra space between the stands and the spool in millimeters
spool_padding = 20;

// Thickness of the design in millimeters
stand_thickness = 8;

// Extra base width for stability in millimeters
stand_balance = 68;

/* [Hidden] */

axleRadius =  (axle_diameter - axle_tolerance) / 2;
spoolRadius = spool_diameter / 2 + spool_tolerance;
standWidth = spool_width + (2 * spool_padding);
pegDistance = (axleRadius / 1.3) > 8 ? axleRadius / 1.3 : 8;

print_part();

module print_part() {
	if (part == "axle") {
		axle();
	} else if (part == "stands") {
		flatStands();
	} else if (part == "base") {
		base();
	} else if (part == "all") {
		all();
	} else {
		all();
	}
}

// Draw the base
module base() {
	difference() {
		translate([-(stand_balance + axle_diameter) / 2, -standWidth / 2, 0]) 
		cube([stand_balance + axle_diameter, standWidth, stand_thickness]);

		translate([2.25, -standWidth / 2 + stand_thickness, -stand_thickness / 2])
		cube([(stand_balance + axle_diameter) / 2 - stand_thickness - 2.25, standWidth - stand_thickness * 2, stand_thickness * 2]);

		translate([-(stand_balance + axle_diameter) / 2 + stand_thickness, -standWidth / 2 + stand_thickness, -stand_thickness / 2])
		cube([(stand_balance + axle_diameter) / 2 - stand_thickness - 2.25, standWidth - stand_thickness * 2, stand_thickness * 2]);

		translate([-pegDistance, -41, 2])
		equiTriangle([10, stand_thickness * 2]);

		translate([pegDistance, -41, 2])
		equiTriangle([10, stand_thickness * 2]);

		translate([-pegDistance, 51, 2])
		equiTriangle([10, stand_thickness * 2]);

		translate([pegDistance, 51, 2])
		equiTriangle([10, stand_thickness * 2]);
	}
}

// Draw two stands in their upright position
module stands() {
	translate([0, standWidth / 2 - stand_thickness / 2, 0])
	stand();

	translate([0, -standWidth / 2 + stand_thickness / 2, 0])
	stand();
}

// Draw two stands in their flat printing position
module flatStands() {
	translate([-(axleRadius + stand_thickness) - 10, 0, 0])
	rotate(90, v=[1,0,0])
	stand();

	translate([(axleRadius + stand_thickness) + 10, 0, 0])
	rotate(90, v=[1,0,0])
	stand();
}

// Draw a single stand in an upright position
module stand() {
	pegOffset = -5.8;

	difference() {
		translate([0, 0, stand_thickness]) union() {
			translate([-(axleRadius + stand_thickness), -stand_thickness / 2, 0]) 
			cube([(axleRadius + stand_thickness) * 2, stand_thickness, spoolRadius]);

			translate([-(axleRadius + stand_thickness), 0, 0]) 
			cylinder(spoolRadius, stand_thickness / 2, stand_thickness / 2);

			translate([(axleRadius + stand_thickness), 0, 0])
			cylinder(spoolRadius, stand_thickness / 2, stand_thickness / 2);

			translate([-pegDistance, stand_thickness / 2, pegOffset])
			equiTriangle([9.5, stand_thickness]);

			translate([pegDistance, stand_thickness / 2, pegOffset])
			equiTriangle([9.5, stand_thickness]);
		}

		translate([-axleRadius - stand_thickness / 2, -stand_thickness, stand_thickness * 2]) 
		cube([axleRadius * 2 + stand_thickness, stand_thickness * 2, spoolRadius - axleRadius - (stand_thickness * 2)]);

		rotate(90, v=[1,0,0])
		translate([0, spoolRadius + stand_thickness - 2, -stand_thickness])
		cylinder(stand_thickness * 2, axleRadius, axleRadius);

		translate([-axleRadius, -stand_thickness, spoolRadius + stand_thickness - 2])	
		cube([axleRadius * 2, stand_thickness * 2, axleRadius * 2]);
	}
}

// Draw an axle in the upright position
module axle() {
	cylinder(standWidth, axleRadius, axleRadius);
}

module all() {
	base();
	stands();

	rotate(90, v=[1,0,0])
	translate([0, spoolRadius + stand_thickness - 1.5, -standWidth / 2])
	axle();
}

module equiTriangle(coords) {
	height = coords[0] / 2 * sqrt(3);
	rotate(90, v=[1,0,0]) 
	linear_extrude(coords[1], true, coords[1], 0)
	polygon(points=[[0,height], [-coords[0]/2, 0], [coords[0]/2, 0]]);
}
