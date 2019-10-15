/* [Main] */
// What's the height of the gantry the holder needs to grip around? (add ~1mm to compensate shrinkage)
gantryHeight = 101.1;

// What's the thickness of the gantry the holder needs to grip aroud?
gantryThickness = 3.3;

// What is the minimum internal radius of the roll of filament?
rollRadius = 15; // [10:50]

// How much bigger spool radius do you also want to accomodate?
spoolRadiusMargin = 20; // [0:50]

// What's the width of the fillament spool?
spoolWidth = 87; //[50:200]

/* [Extra] */
// Height of the notch at the end of the holder
spoolNotch = 3; //[1:10]

// Angle of the bottom arm of the spoolholder (set this so that the end aligns)
spoolAngle = 16.5; //[5:50]

// Thickness of the spoolholder arms
spoolHolderThickness = 3.5;//[1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10]

// Thickness of the top vertical part of the holder
baseThickness = 5; //[2:10]

// Thickness of the bottom vertical part of the holder
baseThicknessBottom = 2; //[1:10]

// How much should the top wrap around?
baseNotchTop = 3; //[1:10]

// How much should the bottom wrap around? (don't make this to high, otherwise it'll be hard to snap the holder on)
baseNotchBottom = 1; //[1:5]

// How round should the corners be?
cornerRadius = 4; //[0:10]


$fn =50;


module hook() {
	translate([0,0,rollRadius/2])	rotate([90,0,0]) intersection() {
		translate([-rollRadius,-rollRadius/2,0]) rotate([0,spoolAngle,0]) cube([spoolWidth/2,rollRadius, spoolWidth*1.2]);
		union() {
			difference() {
				translate([0,0,-1]) cylinder(spoolWidth+2,rollRadius, rollRadius);
				intersection() {    // make the holder hollow, for less printing
					rotate([0,spoolAngle,0]) translate([-rollRadius+spoolHolderThickness*1.2,-rollRadius/2-1,-10]) 
						cube([spoolWidth/2,rollRadius*2, spoolWidth*1.2]);
					translate([0,0,-2]) cylinder(spoolWidth + 2, rollRadius-spoolHolderThickness, rollRadius-spoolHolderThickness);
				}
			}
			translate([spoolNotch,0,spoolWidth]) cylinder(spoolNotch, rollRadius, rollRadius);
		}
	}
}

module rounding(height, radius = 3) {
	height = height + 0.04;
	translate([0,0,-0.02]) difference() {
		cube([radius+0.02, radius+0.02, height]);
		cylinder(height, radius, radius);
	}
}



module base() {
	cubeX = gantryHeight + baseThickness + baseThicknessBottom;
	cubeY = gantryThickness + baseThickness * 2;
	cubeZ = rollRadius;

	translate([-cubeX+rollRadius+spoolNotch,0,0]) {
		difference() {
			cube([cubeX, cubeY, cubeZ]);
			union() {
				// rounded corners
				translate([cubeX-cornerRadius, cubeY-cornerRadius,0]) rounding(cubeZ, cornerRadius);
				translate([cornerRadius/2, cubeY-cornerRadius/2-baseThickness+baseThicknessBottom, 0]) rotate([0,0,90]) 
					rounding(cubeZ, cornerRadius/2);
				translate([cubeX-cornerRadius, cornerRadius, 0]) rotate([0,0,-90]) rounding(cubeZ, cornerRadius);
				translate([cornerRadius/2, cornerRadius/2+baseThickness-baseThicknessBottom, 0]) rotate([0,0,180]) 
					rounding(cubeZ, cornerRadius/2);

				// space for the gantry
				translate([baseThicknessBottom, baseThickness, -0.1]) cube([gantryHeight, gantryThickness, cubeZ+0.2]);
				translate([baseThicknessBottom+baseNotchBottom, baseThickness+gantryThickness-0.1, -0.1])
					cube([gantryHeight-baseNotchTop-baseNotchBottom, baseThickness+0.2, cubeZ+0.2]);

				// making the bottom part skinnier
				difference() {
					translate([-0.1,-0.1,-0.1]) 
						cube([cubeX-spoolNotch-rollRadius-spoolRadiusMargin*2+0.1, baseThickness-baseThicknessBottom+0.1, cubeZ+0.2]);
					translate([cubeX-spoolNotch-rollRadius-spoolRadiusMargin*2-cornerRadius*2+0.1,
								 baseThickness-baseThicknessBottom-cornerRadius*2+0.1, -0.1]) 
						rounding(cubeZ+0.2, cornerRadius*2);
				}
				translate([-0.1, baseThickness+baseThicknessBottom+gantryThickness,-0.1]) 
					cube([baseThickness+baseNotchBottom+0.2, baseThickness, cubeZ+0.2]);
			}
		}
	}
}

hook();
base();



