// Parametric Round Clip Holder
// Generates an adjustable set of round clips with mounting ears
// Garrett Mace April 7th 2011
// moded for makerbot custiomizer by jhack 25/3/2013


// Parameters
// Number of clips on the bracket
clipNumber = 1;		//[1:50]		
// Distance between clip centers
clipSpacing = 30;	//[1:100]	
// Diameter of the clip inside face		
clipInnerDiameter = 20;//[5:100]
// Width (height) of clip
clipWidth = 20;		//[5:100]		
// Thickness of clip walls
clipWallThickness = 2;	//[2:10]
// Amount of clip ring to remove from top (valid between 0 and 180)
clipOpeningAngle = 100;//[0:180]	
	
// Thickness of mounting bracket
bracketThickness = 3;	//[2:10]	
// Length of mounting ears from center of first and last clips
mountEarsLength = 20;	//[5:100]		
// Position of mounting holes from edge of mounting ears
mountHoleOffset = 5;	//[2:10]		
// Diameter of the mounting holes
mountHoleDiameter = 3;	 //[1:10]	

/* [hidden] */
$fs = 0.25;

// Round clip
module roundClip() {
difference() {
	cylinder(r = (clipInnerDiameter/2 + clipWallThickness), h = clipWidth);
	translate([0,0,-1]) cylinder(r = clipInnerDiameter/2, h = clipWidth + 2);
	translate([0,0,-1]) union () {
		rotate([0,0,clipOpeningAngle/4-0.05]) intersection() {
			rotate([0,0,clipOpeningAngle/4]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			rotate ([0,0,-clipOpeningAngle/4]) translate([-(clipInnerDiameter+clipWallThickness+1),0,0]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			cylinder(r=clipInnerDiameter+clipWallThickness+1,h=clipWidth+2);
		}

		rotate([0,0,-clipOpeningAngle/4+0.05]) intersection() {
			rotate([0,0,clipOpeningAngle/4]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			rotate ([0,0,-clipOpeningAngle/4]) translate([-(clipInnerDiameter+clipWallThickness+1),0,0]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			cylinder(r=clipInnerDiameter+clipWallThickness+1,h=clipWidth+2);
		}
	}
}

rotate([0,0,clipOpeningAngle/2]) translate([0,clipInnerDiameter/2+clipWallThickness,0]) cylinder(r = clipWallThickness, h = clipWidth);
//#rotate([0,0,clipOpeningAngle/2]) translate([0,clipInnerDiameter/2+clipWallThickness*2,0]) cylinder(r = clipWallThickness, h = clipWidth);

rotate([0,0,-clipOpeningAngle/2]) translate([0,clipInnerDiameter/2+clipWallThickness,0]) cylinder(r = clipWallThickness, h = clipWidth);
}

// Create clips
translate([-(clipSpacing*(clipNumber-1))/2,0,0]) for (clipPos = [0:clipNumber-1]) {
	translate([clipPos*clipSpacing,0,0]) roundClip();
}

// Calculations
calcs_bracketLength = clipSpacing*(clipNumber-1)+mountEarsLength*2;

// Mounting bracket and holes
difference() {
	translate([-calcs_bracketLength/2,-clipInnerDiameter/2-bracketThickness,0]) cube([calcs_bracketLength,bracketThickness,clipWidth]);
	translate([calcs_bracketLength/2-mountHoleOffset,-clipInnerDiameter/2-bracketThickness-1,clipWidth/2]) rotate([-90,0,0]) cylinder(r = mountHoleDiameter/2, h = bracketThickness+2);
	translate([-calcs_bracketLength/2+mountHoleOffset,-clipInnerDiameter/2-bracketThickness-1,clipWidth/2]) rotate([-90,0,0]) cylinder(r = mountHoleDiameter/2, h = bracketThickness+2);

}