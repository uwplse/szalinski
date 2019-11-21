// Lower Toilet Seat Hinge Bracket
// Designed by Mike Creuzer Dec 30 2012 -  thingiverse@creuzer.com

// measurements are as the part is in use using the bottom back edge of the seat as reference for all measurements
// rotated on its side for printing when done

//Bracket bit

BracketWidth = 13; 
BracketLength = 54; 
BracketHeight = 7.5;

// Hinge upright bit to center of hinge hole
HingeWidth = BracketWidth; 
HingeLength = 9; 
HingeHeight = 15;

// Hinge Hole
//Radius
HingeHoleRadius = 5;
HingeHoleWallThickness = 3;
// Smaller number is smoother circle & slower rendering
HingeHoleRoundness = 0.01; 

//Mounting Holes
// diameter
MountingHoleSize = 4.5; 
// diameter
MountingHoleScrewHeadSize = 9.5; 
MountingHoleScrewHeadthickness = 2.5; 
FirstMountingHole = 12.75;
DistanceBetweenMountingHole =  18.8;
// smaller is more round. 6 ought to give you a pentagon
ScrewHeadRoundness = 5; 
// smaller is more round. 6 ought to give you a pentagon
ScrewRoundness = 2; 




rotate(a=[0,-90,0]){ // Rotate to the -90 so the low poly count circles put the angles up for easier printing.

// Make the mounting leg
difference(){
	cube(size = [BracketWidth,BracketLength,BracketHeight], center = false);
	// first hole
	translate(v = [BracketWidth * .5, BracketLength - FirstMountingHole, 0]) cylinder(h=BracketHeight, r=MountingHoleSize/2, $fs=ScrewRoundness);
	translate(v = [BracketWidth * .5, BracketLength - FirstMountingHole, 0]) cylinder(h=MountingHoleScrewHeadthickness, r = MountingHoleScrewHeadSize/2, $fs=ScrewHeadRoundness);
	// second hole
	translate(v = [BracketWidth * .5, BracketLength - FirstMountingHole - DistanceBetweenMountingHole, 0]) cylinder(h=BracketHeight, r=MountingHoleSize/2, $fs=ScrewRoundness);
	translate(v = [BracketWidth * .5, BracketLength - FirstMountingHole - DistanceBetweenMountingHole, 0]) cylinder(h=MountingHoleScrewHeadthickness, r = MountingHoleScrewHeadSize/2, $fs=ScrewHeadRoundness);

	// pin holes for strength
	translate(v = [BracketWidth * .25, BracketLength * .5, BracketHeight * .5]) cube(size = [.1,BracketLength,.1], center = false);
	translate(v = [BracketWidth * .5, BracketLength * .5, BracketHeight * .5]) cube(size = [.1,BracketLength,.1], center = false);
	translate(v = [BracketWidth * .75, BracketLength * .5, BracketHeight * .5]) cube(size = [.1,BracketLength,.1], center = false);
}

// Make the hinge bit
difference() { // Make the hinge bracket, then minus the hole
	hull(){ // Make the hinge bracket all fancy looking
		translate(v = [0, BracketLength, 0]) cube(size = [HingeWidth,HingeLength,HingeHeight], center = false); // The support post
		translate(v = [0, BracketLength +HingeHoleRadius + HingeHoleWallThickness, HingeHeight +BracketHeight]) rotate(a=[0,90,0]) cylinder(h = BracketWidth, r=HingeHoleRadius + HingeHoleWallThickness, center = false, $fa=HingeHoleRoundness); // The round hinge bit
	}

	// The Hinge Hole
	translate(v = [-1, BracketLength +HingeHoleRadius + HingeHoleWallThickness, HingeHeight  + BracketHeight]) rotate(a=[0,90,0]) cylinder(h = BracketWidth*2, r=HingeHoleRadius, center = false, $fa=HingeHoleRoundness); 

	// pin holes for strength
	translate(v = [BracketWidth * .25, BracketLength * .5, BracketHeight * .5]) cube(size = [.1,BracketLength,.1], center = false);
	translate(v = [BracketWidth * .5, BracketLength * .5, BracketHeight * .5]) cube(size = [.1,BracketLength,.1], center = false);
	translate(v = [BracketWidth * .75, BracketLength * .5, BracketHeight * .5]) cube(size = [.1,BracketLength,.1], center = false);
}

}