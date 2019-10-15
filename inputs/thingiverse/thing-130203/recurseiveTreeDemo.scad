// (c) Ben Britton 2013
// 
// This is designed to be the simplest possible recursive tree. It should be a good demonstration of recursion for people learning to use OpenSCAD.
// Learn to use recursion. It's great!

// Number of branches
depth = 5; // [0:7]
// trunk length
length = 20;
branch_angle = 20;
// trunk width
width = 3;
// number of branches
branches = 3; // [0:5
// How much to shorten each new branch
reduction = 0.75;


cylinder (r=length*.6,h=2); 					// Create the stand

branch(length, width, depth); 					// Create the trunk

module branch(length, width, num){
	if(num > 0){
		cylinder (r=width/2, h=length); 		// Create this branch
		translate([0,0,length])					// Move to the end of this branch
		for (r = [0:branches]){ 						// Create the new branches
			rotate([0,0,r*360/branches]) 				// Rotate each about the Z axis to be spaced equally
			rotate ([branch_angle,0,0]) 		// tilt the new branch
												// Next is the RECURSIVE bit!
			branch(length*reduction,width, num-1); 	// create the new branch, shorter than the old one
		}
	}
}

