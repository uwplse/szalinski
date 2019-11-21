/*
 * Cable Plug (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: Covers a larger hole in an enclosure while still providing space for a 
 *   cable to fit. This is useful when you need to drill a larger hole in order to fit 
 *   the cable ends through the enclosure wall but want to limit the overall size of the 
 *   opening.  
 * 
 * INSTRUCTIONS:  Choose some values in the "User-defined values" section, render,
 *   and print. Change the numberOfCatches and sliceAngle together to control the size 
 *   of the catches. See the comments for more details. 
 * 
 * v0.42, Dec 20, 2012: Initial Release.
 * 
 * TODO: 
 *   * None at this time. 
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

caseHoleDiameter    = 19.05;     // Diameter of the hole to plug
cableHoleDiameter   = 5.4;       // Diameter of the cable(s) taht go through the plug

caseThickness       = 3.5;       // Thickness of the material being plugged
caseOverlap         = 3;         // Distance the plug will overlap the hole opening

thickness           = 1.2;       // Thickness of the flat round portion of the plug

catchPostThickness  = 1.5;       // Thickness of the plug posts that go through the hole
catchHeight         = 1;         // Height of the "catch" portion that holds the plug in place
catchAngle          = 55;        // Angle of the "catch" material that holes the plug in place 

numberOfCatches     = 3;         // Number of catches/posts
sliceAngle          = 80;        // The angle of the empty space between catches/posts

$fn                 = 35;        // General curve quality


/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////

catchYOffset = catchHeight/tan(90-catchAngle); 
stemHeight = caseThickness+catchYOffset*2;

difference() {
	union () {
		cylinder(h=thickness, r=caseHoleDiameter/2+caseOverlap);
	
		translate([0,0,thickness]) 
		rotate_extrude(convexity=5) 
		translate([caseHoleDiameter/2,0,0]) 
		polygon( points=[	
			[-catchPostThickness,0],
			[-catchPostThickness,stemHeight],
			[0,stemHeight],
			[catchHeight,stemHeight-catchYOffset],
			[0,caseThickness],
			[0,0]
			] ); 
	}

	// Cable hole 
	translate([(caseHoleDiameter-cableHoleDiameter)/2,0,-0.5]) 
		cylinder(h=thickness+stemHeight+1, r=cableHoleDiameter/2);

	// Cable channel
	translate([(caseHoleDiameter-cableHoleDiameter)/2,-cableHoleDiameter/2,-0.5]) 
		cube([cableHoleDiameter/2+caseOverlap+1,cableHoleDiameter,thickness+stemHeight+1]);

	// Cut catch posts 
	translate([0,0,thickness+0.001]) 
	for( i=[0:numberOfCatches-1] )
		rotate([0,0,i*(360/numberOfCatches)]) 
			wedge(caseHoleDiameter/2+catchHeight+1,stemHeight+1, sliceAngle);
	
}

module wedge(length, height, angle) {

	x = length; 
	y = 2*x*tan(angle/2); 
	z = height;
	x2 = (y/2)/sin(angle/2);

	difference() {
		translate([0,-y/2,0]) 
			cube([x,y,z]);

		for(i=[-1,1])
			rotate([0,0,angle/2*i]) 
				translate([0,-y/2 +y/2*i,-0.5]) 
					cube([x2,y,z+1]);

	}
}