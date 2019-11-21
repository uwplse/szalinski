// preview[view:south west, tilt:bottom]

/* [General] */

// Base diameter (bottom part)
diameter = 51.5;

// Diameter of single hole
holeDiameter = 1.8;

// Number holes rows with central hole
holeRings = 6; // [0:20]

/* [Advanced] */

// Use -1 for auto.
rimWidth = -1;

// Total cap height
height = 16; // [1:20]

// Modifier for space around holes
holeSpace = 1;

// Set 4 to disable catch
catchSize = 10; // [4:20]

// calculated
bottomRadius = diameter/2;
topRadius = rimWidth == -1 ? bottomRadius * 1.04 : bottomRadius + rimWidth;
basePocketRadius = bottomRadius - 2;
basePartHeight = height / 2;
catchCenterX = topRadius + 2;
holeRadius = holeDiameter / 2;
catchCogCylinderRadius = topRadius - catchSize / 2.8 + 1;
catchHeight = height > 10 ? 7 : height * 0.7;
catchCogHeight = height > 10 ? 3 : height * 0.3;

module base() {
	cylinder(h=basePartHeight, r1=topRadius, r2=bottomRadius);
	translate([0, 0, basePartHeight])
	cylinder(h=basePartHeight, r=bottomRadius);
}

module basePocket() {
	if (height > 1)
	translate([0, 0, 1])
	cylinder(h=height, r=basePocketRadius);
}

module grooveCylinder() {
	translate([catchCenterX, 0, 0])
	cylinder(h=catchHeight, r=catchSize);
}

module catchPocket() {
	translate([catchCenterX, 0, -1])
	cylinder(h=catchHeight, r=catchSize-2);
}

module catchCogCylinder() {
	translate([0, 0, 0])
	cylinder(h=catchCogHeight, r1=catchCogCylinderRadius, r2=catchCogCylinderRadius-1);
}

module hole(x, y) {
	translate([x, y, -1])
	cylinder(r=holeRadius, h=height+2);
}

module holes() {
	if (holeRings > 0)
		hole(0, 0);

	if (holeRings > 1) {
		for (ring = [1:holeRings-1]) {
			for (i = [1:6*ring]) {
				assign(x=sin(i*60/ring+90)*ring*holeSpace*holeRadius*4.2)
				assign(y=cos(i*60/ring+90)*ring*holeSpace*holeRadius*4.2)
				if (pow(x - catchCenterX, 2) + pow(y, 2) > pow(catchSize+holeRadius, 2))
				if (pow(x, 2) + pow(y, 2) < pow(basePocketRadius-holeRadius, 2))
				hole(x, y);	
			}
		}
	}
}

module emptyBase() {
	difference() {
		base();
		basePocket();
	}
}

module emptyBaseWithHoles() {
	difference() {
		emptyBase();
		holes();
	}
}

module groove() {
	intersection() {
		base();
		grooveCylinder();
	}
}

module baseWithGroove() {
	union() {
		emptyBaseWithHoles();
		groove();
	}
}

module baseWithCatch() {
	difference() {
		baseWithGroove();
		catchPocket();
	}
}

module catchCog() {
	intersection() {
		catchPocket();
		catchCogCylinder();
	}
}

module fullBase() {
	union() {
		baseWithCatch();
		catchCog();
	}
}


$fa = 2;
$fs = 0.3;
fullBase();



