screwHeadDiameter = 8;
screwHeadHeight = 5;
screwHoleDiameter = 5;

wireDiameter = 6.5;
ninetyDegreeBendLength = 15;
wallWidth = 3;


// Curve Quality/Face Generation (lower value is more faces)
$fa = 1; // 12
$fs = 1; // 2

baseWidth = ninetyDegreeBendLength * 2 + wireDiameter + 2 * screwHeadDiameter;
baseHeight = wireDiameter * 1.75 + wallWidth;

stemWidth = wireDiameter + (2 * wallWidth);
stemHeight = ninetyDegreeBendLength + 2 * wireDiameter;

difference() {
	union() {
	    cylinder(baseHeight, baseWidth, baseWidth - baseHeight);
	    cylinder(stemHeight, stemWidth, stemWidth);
	}
	translate([0,0,-1]) {
    	cylinder(stemHeight + 2, ninetyDegreeBendLength, wireDiameter);
	}

	translate([0,-baseWidth / 2, baseHeight  + 1 - screwHeadHeight]) {
    	cylinder(screwHeadHeight, screwHoleDiameter, screwHeadDiameter);
	}
	translate([0,-baseWidth / 2, -1]) {
    	cylinder(baseHeight, screwHoleDiameter, screwHoleDiameter);
	}
	translate([0,baseWidth / 2, baseHeight  + 1 - screwHeadHeight]) {
    	cylinder(screwHeadHeight, screwHoleDiameter, screwHeadDiameter);
	}
	translate([0,baseWidth / 2, -1]) {
    	cylinder(baseHeight, screwHoleDiameter, screwHoleDiameter);
	}

	translate([-baseWidth, 0, wireDiameter / 2]) {
		rotate([0,90,0]) {
    		cylinder(baseWidth, wireDiameter + 1, wireDiameter + 1);
		}
	}
	*translate([-baseWidth,0,-1]) {
    	cube(baseWidth * 2, stemHeight + 2);
	}
}
