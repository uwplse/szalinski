use <Thread_Library.scad>
//use </Users/james/Documents/Projects/Thingiverse-Projects/Threaded Library/Thread_Library.scad>


difference (){
  cylinder([0,0,0], r=19, h=8, $fn=60);
  translate ([0,0,-1]) cylinder([0,0,0], r=25/2, h=8, $fn=60);
  translate([0,0,4])trapezoidThreadNegativeSpace(
	length=7, 				// axial length of the threaded rod 
	radius=22, 				// outer radius of the nut	
	pitch=1.8, 				// axial distance from crest to crest
	pitchRadius=16.6, 			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5, 			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=35, 			// angle between the two faces of the thread 
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0.0, 		// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1, 			// radial clearance, normalized to thread height
	backlash=0.1, 			// axial clearance, normalized to pitch
	stepsPerTurn=45 			// number of slices to create per turn
	);
}



