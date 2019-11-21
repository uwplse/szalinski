//************************************************************************************************/
/* EnergyBarContainer - Copyright 2014 by ohecker                                                */
/* Caution: Be aware of food safety issues. Only print / use this if you know what you are doing!*/
/* This file is licensed under CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0/deed) */
/*************************************************************************************************/
use <utils/build_plate.scad>

/* [Basic] */

// Which one would you like to see? (effect on display only)
part = "assembled"; // [assembled:Assembled Container,box:Box Only,cover:Cover Only,print:Box and Cover for Printing]

// How do you measure the size of the top tube given below?
TopTubeMeasurementKind = 2.0; // [1.0:radius, 2.0:diameter, 6.283:circumference]

// What is the radius/diameter/circumference of the bikes top tube? (mm)
TopTubeMeasurement = 40.4;

// Width of the opening for the cable tie (mm)
BinderCutoutWidth = 6;

// Height of the opening for the cable tie (mm)
BinderCutoutHeight = 2;

// Offset of the cable tie position from the middle (mm); Positive is direction to the rear
BinderOffset = 0;

// Protrusion of the energy bar from the box (mm)
BoxClipping = 10;

/* [Payload] */

// Size of the energy bar (X-dimension; mm)
PayloadX = 91.2;

// Size of the energy bar (Y-dimension; mm)
PayloadY = 11.0;

// Size of the energy bar (Z-dimension; mm)
PayloadZ = 31.0;

// Number of energy bars to store in X-dimension
PayloadCountX = 1; // [0:10]

// Number of energy bars to store in Y-dimension
PayloadCountY = 3; // [0:10]

// Extra space around energy bar (mm)
PayloadExtra=1;

/* [Advanced] */

// How thick should the walls of the box be? (mm)
BoxWall = 2.5;

// The size of the chamfer. Less than the wall thickness. (mm)
BoxChamfer = 1.5;

// Thickness of the wall of the cover (mm)
CoverWall = 2.5;

// Space between box and cover (mm)
CoverSpacing = 0.5;

// Space at top between energy bar and cover (mm) 
CoverTopSpacing=2;

// Width of the chamfer of the cover (mm)
CoverChamfer = 1.5;

// Distance of both parts on print bed (mm); You might need to increase this if the box for the payload is small compared to the top tube diameter.
PartPrintingDistance = 4;

// Opening angle in assembly rendering (degrees; effect on display only)
openingAngle = 60; // [0:90]

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


/* [Hidden] */

// technical constants
$fn=100;
epsilon = 0.01;

// Width of the clip for the top tube (mm)
ClipWidth = 3;

// Length of the clips for the top tube (mm); Only applies if ClipCutoutDepths is greater than 0.
ClipLength = 20;

// Angle of the clips for the top tube (degrees)
ClipAngle = 90;

// Depth of the space between the clips (mm); negative value: no cutout
ClipCutoutDepths = 8;

// Distance of the hinge axis from the box (mm)
HingeOffset = 4;

// Radius (big one) of the hinge cone (mm)
HingeRadius1 = 3;

// Radius (small one) of the hinge cone (mm)
HingeRadius2 = 1;

// Height of the hinge cone (mm)
HingeHeight = 1.5;

// Thickness of the hinge (mm)
HingeThickness = 2;

// Size of the little nose for keeping the cover closed (mm)
NoseSize = 3;

// Thickness of the hinge in the cover (mm)
CoverHingeThickness=2.2;

// derived dimensions
TopTubeRadius = TopTubeMeasurement / TopTubeMeasurementKind;

BoxX = PayloadCountX*(PayloadX+PayloadExtra) + (1+PayloadCountX)*BoxWall;
BoxY = PayloadCountY*(PayloadY+PayloadExtra) + (1+PayloadCountY)*BoxWall;
BoxZ = PayloadZ-BoxClipping+2;

ClipCutoutLength = BoxX-2*ClipLength;

BinderCutoutRadius = TopTubeRadius+ClipWidth/2; //-BinderCutoutHeight/2;


module EnergyBar() {
	color("brown")
	translate([0,0,PayloadZ/2-BoxClipping]) cube([PayloadX, PayloadY, PayloadZ], center=true);
}


module SinglePayloadCutout() {
	translate([0,0,PayloadZ/2-BoxClipping])cube([PayloadX+PayloadExtra, PayloadY+PayloadExtra, PayloadZ], center=true);
}

module RoundedCube(height) {
	minkowski() {
		cube([/*TopTubeRadius+ClipWidth+BoxZ*/height,BoxY-2*BoxChamfer,BoxX-2*BoxChamfer], center=true);
		rotate([0,90,0])cylinder(r=BoxChamfer,h=epsilon,$fn=20);
	}
}


module CableTie(pos) {
	translate([0,0,pos-BinderCutoutWidth/2])
	difference() {
		cylinder(r=BinderCutoutRadius+BinderCutoutHeight,h=BinderCutoutWidth);
		translate([0,0,-epsilon])cylinder(r=BinderCutoutRadius,h=BinderCutoutWidth+2*epsilon);
	}
}

module TopTubeClipBase() {
	difference() {
		cylinder(r=TopTubeRadius+ClipWidth,h=BoxX);
		translate([(TopTubeRadius)*sin(ClipAngle-90),0,0])translate([TopTubeRadius,0,BoxX/2])cube([2*TopTubeRadius,4*TopTubeRadius,BoxX+2*epsilon],center=true);
	}
}

module CubeWithClip() {
	difference() {
		union() {
			translate([-(TopTubeRadius+ClipWidth)-(BoxZ)/2,0,BoxX/2])RoundedCube(BoxZ);
			hull() {
				translate([-(TopTubeRadius+ClipWidth),0,BoxX/2])RoundedCube(epsilon);
				TopTubeClipBase();
			}
		}
		translate([0,0,-epsilon]) cylinder(r=TopTubeRadius,h=BoxX+2*epsilon);
		CableTie(BoxX/2+BinderOffset);
	}
}

module ClipSmoothing(ClipAngle_r) {
	rotate([0,0,ClipAngle_r])translate([-(TopTubeRadius+ClipWidth/2),0,0])cylinder(r=ClipWidth/2,BoxX);
}

module payloadPattern() {
	IncrementX = PayloadX+PayloadExtra+BoxWall;
	IncrementY = PayloadY+PayloadExtra+BoxWall;
	StartX = -(PayloadCountX-1)/2*IncrementX;
	StartY = -(PayloadCountY-1)/2*IncrementY;
	for( x = [0:PayloadCountX-1] ) {
		assign( PayloadPosX = StartX + x*IncrementX ) {
			for( y = [0:PayloadCountY-1] ) {
				assign( PayloadPosY = StartY + y*IncrementY ) {
					translate([PayloadPosX,PayloadPosY,0]) child();
				}
			}
	
		}
	}
}
module payloadCutouts() {
	payloadPattern() SinglePayloadCutout();
}

module BoxWOHinge() {
	difference() {
		translate([BoxX/2,0,TopTubeRadius+ClipWidth+BoxZ])rotate([0,-90,0])union() {
			CubeWithClip();
			ClipSmoothing(ClipAngle);
			ClipSmoothing(-ClipAngle);
		}
		translate([0,0,3*TopTubeRadius/2+TopTubeRadius+ClipWidth+BoxZ-ClipCutoutDepths])cube([ClipCutoutLength,BoxY+2*TopTubeRadius,3*TopTubeRadius],center=true);
		payloadCutouts();
	}
}
	
module Hinge() {
translate([-HingeOffset+epsilon,0,-HingeOffset])
	union() {
		translate([-HingeOffset,0,0])cube([2*HingeOffset,HingeThickness,HingeOffset]);
		translate([0,0,-HingeOffset])cube([HingeOffset,HingeThickness,2*HingeOffset]);
		rotate([-90,0,0])cylinder(r=HingeOffset,h=HingeThickness);
		translate([0,epsilon,0])rotate([90,0,0])cylinder(r1=HingeRadius1,r2=HingeRadius2,h=HingeHeight);
	}
}

module Nose() {
	intersection() {
		rotate([0,45,0])cube(NoseSize,center=true);
		translate([-10+epsilon,0,0])cube(20,center=true);
	}
}

module BoxWithHinge() {
	union() {
		BoxWOHinge();
		translate([BoxX/2,-BoxY/2+HingeThickness,0])rotate([0,180,0])Hinge();
		mirror([0,1,0])translate([BoxX/2,-BoxY/2+HingeThickness,0])rotate([0,180,0])Hinge();
		translate([-BoxX/2,0,HingeOffset])Nose();
	}
}

module CoverCube() {
	reducedWall = CoverWall - CoverChamfer;
	minkowski() {
		cube([BoxX+2*HingeOffset+2*CoverSpacing+2*reducedWall, BoxY+2*CoverSpacing+2*reducedWall,BoxClipping+CoverTopSpacing+2*HingeOffset+reducedWall-CoverChamfer],center=true);
		union() {
			translate([0,0,CoverChamfer/2-epsilon])cylinder(r1=CoverChamfer,r2=0,h=CoverChamfer,center=true,$fn=20);
			translate([0,0,-CoverChamfer/2+epsilon])cylinder(r1=0,r2=CoverChamfer,h=CoverChamfer,center=true,$fn=20);
		}
	}
}

module Cover() {
	difference() {
		union() {
			difference() {
				translate([0,0,(BoxClipping+CoverTopSpacing+2*HingeOffset+CoverWall)/2])
					CoverCube();
				translate([0,0,(BoxClipping+CoverTopSpacing+2*HingeOffset)/2+CoverWall+epsilon])
					cube([BoxX+2*HingeOffset+2*CoverSpacing, BoxY+2*CoverSpacing,BoxClipping+CoverTopSpacing+2*HingeOffset+2*epsilon],center=true);
			}
			translate([-HingeOffset+(BoxX+2*HingeOffset+2*CoverSpacing)/2+epsilon,-CoverHingeThickness/2+(BoxY+2*CoverSpacing)/2+epsilon,(BoxClipping+CoverTopSpacing+HingeOffset+CoverWall)/2])
				cube([2*HingeOffset,CoverHingeThickness,BoxClipping+CoverTopSpacing+HingeOffset+CoverWall],center=true);
			translate([(BoxX)/2,(BoxY+2*CoverSpacing)/2+epsilon,BoxClipping+CoverTopSpacing+HingeOffset+CoverWall])rotate([90,0,0])cylinder(r=HingeOffset,h=CoverHingeThickness);
			mirror([0,1,0])translate([-HingeOffset+(BoxX+2*HingeOffset+2*CoverSpacing)/2+epsilon,-CoverHingeThickness/2+(BoxY+2*CoverSpacing)/2+epsilon,(BoxClipping+CoverTopSpacing+HingeOffset+CoverWall)/2])
				cube([2*HingeOffset,CoverHingeThickness,BoxClipping+CoverTopSpacing+HingeOffset+CoverWall],center=true);
			mirror([0,1,0])translate([(BoxX)/2,(BoxY+2*CoverSpacing)/2+epsilon,BoxClipping+CoverTopSpacing+HingeOffset+CoverWall])rotate([90,0,0])cylinder(r=HingeOffset,h=CoverHingeThickness);
		}
		translate([-HingeOffset,0,BoxClipping+CoverTopSpacing+CoverWall])BoxWithHinge();
	}
}

module assembled() {
	rotate([0,180,0])
	union() {
		BoxWithHinge();
		payloadPattern() EnergyBar();
		color("grey")translate([BoxX/2,0,TopTubeRadius+ClipWidth+BoxZ])rotate([0,-90,0])CableTie(BoxX/2+BinderOffset);
		color("lightblue")translate([0,0,TopTubeRadius+ClipWidth+BoxZ])rotate([0,90,0])cylinder(r=TopTubeRadius,h=BoxX+50,center=true);
		translate([BoxX/2+HingeOffset,0,HingeOffset])rotate([0,-openingAngle,0])translate([-(BoxX/2),0,-(BoxClipping+CoverTopSpacing+HingeOffset+CoverWall)])Cover();
	}
}

module printAll() {
	union() {
		translate([0,BoxY/2+PartPrintingDistance/2,0])BoxWithHinge();
		translate([0,-(BoxY+2*CoverSpacing+2*CoverWall)/2-PartPrintingDistance/2,0])Cover();
		translate([0,-CoverChamfer/2,1/2])cube([1,CoverChamfer+PartPrintingDistance+2*epsilon,1],center=true);
	}
	build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 

}
module printPart() {
	if (part == "assembled") {
		assembled();
	} else if (part == "box") {
		rotate([180,0,0])BoxWithHinge();
	} else if (part == "cover") {
		Cover();
	} else if (part == "print") {
		printAll();
	} else {
		printAll();
	}
}
printPart();
