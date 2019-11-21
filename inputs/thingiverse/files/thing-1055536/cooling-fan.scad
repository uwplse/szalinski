/*
 * Design for a cooling fan thingamajig.
 */

// ################## CONSTANTS ###################

/* [Fan size] */

// Length of one side of the fan, measured as if the corners were not rounded.
squareSide = 40;

// Radius of the fan's circular opening. Can be determined as (squareSide / 2) - thinnest part of fan wall
outerRadius = 18.75;

// Radius of the screw hole itself
screwHoleRadius = 1.75;

// Distance from the center of the screw hole to the side of the fan case
screwHoleDistanceFromSide = 3.75; // (2 + screwHoleRadius)

/* [Nozzle] */

// Thickness of the baseplate that attaches the nozzle to the fan
baseThickness = 5;

// Width of the nozzle. For a wide, flat airflow, 2-4x the width of the fan is ideal.
nozzleWidth = 80;

// Breadth of the nozzle. For a wide, flat airflow, 5mm works nicely.
nozzleHeight = 5;

// Distance from the fan end of the nozzle to the output end.
nozzleLength = 100;

// Thickness of the nozzle wall. Aim for 2-3 perimeters for most 3D printers.
nozzleWallThickness = 0.8;

// Length of the two strips of material that is used to mount the nozzle. Use 0 to exclude the mounting stips.
mountLength = 42;

// Thickness of the mounting stips. Will not be thicker than the base.
mountThickness = 3;

/* [Hidden] */

// Fudge factor to keep planes from intersecting perfectly.
smidge = 0.001;

// Radius of the quarter-circle used to round off the base's corners.
baseCornerRadius = screwHoleDistanceFromSide;

// Width of the mounting stips. Since they're perforated with screw holes, it needs to be greater than the screw hole width.
mountWidth = screwHoleDistanceFromSide * 2;
actualMountThickness = min(baseThickness, mountThickness);

defaultRoundedSquareSize = squareSide - (2 * screwHoleDistanceFromSide);
module roundedSquare(height=1, x=squareSide, y=squareSide, cornerRad=baseCornerRadius) {
	actualCornerRadius = min(x / 2, y / 2, cornerRad);
	minkowski() {
		cube(size=[max(smidge, x - (2 * actualCornerRadius)), max(smidge, y - (2 * actualCornerRadius)), height], center=true);
		if (cornerRad > 0.01) {
			cylinder(r1=actualCornerRadius, r2=actualCornerRadius, h=smidge, center=true, $fn=32);
		} else {
			cube([smidge, smidge, smidge]);
		}
	}
}

module nozzleSegment(size1=[squareSide, squareSide, smidge], size2=[nozzleWidth, nozzleHeight, smidge], h=nozzleLength, cornerRad1=baseCornerRadius, cornerRad2=baseCornerRadius) {
	hull() {
		roundedSquare(x=size1[0], y=size1[1], height=size1[2], cornerRad=cornerRad1);
		translate([0, 0, max(smidge, h - (size1[2] / 2) - (size2[2] / 2))])
		roundedSquare(x=size2[0], y=size2[1], height=size2[2], cornerRad=cornerRad2);
	}
}

module nozzleShape(res=20, height=nozzleLength, bottom=[squareSide, squareSide], top=[nozzleWidth, nozzleHeight], cornerRad=outerRadius) {
	numSegments = max(1, res);
	segmentHeight = height / numSegments;
	d = top - bottom;
	for(i = [0:numSegments - 1]) {
		mult=[
			(1 - cos(180 * (i / numSegments))) / 2,
			(1 - cos(180 * ((i + 1) / numSegments))) / 2
		];
		size1 = [bottom[0] + (mult[0] * d[0]),
			bottom[0] + (mult[0] * d[1]),
			smidge];
		size2 = [bottom[0] + (mult[1] * d[0]),
			bottom[0] + (mult[1] * d[1]),
			smidge];
		translate([0, 0, segmentHeight * i])
		nozzleSegment(size1=size1, size2=size2, h=segmentHeight, cornerRad1=cornerRad, cornerRad2=cornerRad);
	}
	
}

module nozzle(res=20) {
	difference() {
		nozzleShape(res=res, bottom=[squareSide, squareSide], top=[nozzleWidth, nozzleHeight], cornerRad=outerRadius, height=nozzleLength);
		translate([0, 0, -smidge])
		nozzleShape(res=res, bottom=[squareSide - (2 * nozzleWallThickness), squareSide - (2 * nozzleWallThickness)], top=[nozzleWidth - (2 * nozzleWallThickness), nozzleHeight - (2 * nozzleWallThickness)], cornerRad=outerRadius, height=(nozzleLength + (2 * smidge)));
	}
}

module base() {
	difference() {
		roundedSquare(height=baseThickness);
		for(i=[-1:2:1]) {
			for(j=[-1:2:1]) {
				translate([
					i * ((squareSide / 2) - screwHoleDistanceFromSide),
					j * ((squareSide / 2) - screwHoleDistanceFromSide),
					0
				])
				cylinder(r1=screwHoleRadius, r2=screwHoleRadius, h=(baseThickness + (2 * smidge)), center=true, $fn=16);
			}
		}
		cylinder(r1=outerRadius, r2=outerRadius, h=baseThickness + (2 * smidge), center=true);
	}
}

module mount() {
	difference() {
		translate([-mountWidth / 2, 0, 0])
		cube([mountWidth, mountLength, actualMountThickness]);
		for(i=[1:20]) {
			y = 2 * i * screwHoleDistanceFromSide;
			if (y + screwHoleDistanceFromSide <= mountLength) {
				translate([0, y, -smidge])
				cylinder(r1=screwHoleRadius, r2=screwHoleRadius, $fn=16, h=actualMountThickness + (2 * smidge));
			}
		}
	}
}

module entireShape() {
	union() {
		translate([0, 0, baseThickness / 2])
		base();
		translate([0, 0, baseThickness - smidge])
		nozzle(res=ceil(nozzleLength / 3));
		translate([-mountWidth, outerRadius, 0])
		mount();
		translate([mountWidth, outerRadius, 0])
		mount();
	}
}

entireShape();
