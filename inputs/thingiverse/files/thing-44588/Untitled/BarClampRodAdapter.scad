/*
 * Bar Clamp Rod Adapter (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Jan 2013
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This adapter makes it eacy to clamp rods down to a flat surface with 
 *   a bar clamp.  
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section if 
 *   necessary, render, and print. Print with several walls and higher infill for 
 *   added strength.  
 * 
 * v0.42, Jan 23, 2013: Initial Release.
 * 
 * TODO: 
 *   * None at this time
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// The length of the clamp jaw
jawLength = 40; 

// The width of the clamp jaw 
jawWidth = 25; 

// The thickness of the lip surrounding the clamp jaw
lipThickness = 2; 

// The height of the lip surrounding the clamp jaw
lipHeight = 2; 

// The depth of the groove 
grooveDepth = 4; 

// The minimum thickness of the adapter (at the top of the groove) 
minimumThickness = 2;


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////
totalSize = [jawWidth+lipThickness*2,jawLength+lipThickness*2,grooveDepth+minimumThickness+lipHeight];

difference() {
	translate([0,0,totalSize[2]/2]) 
		cube(totalSize, center=true);

	translate([-(totalSize[0]+1)/2,0,grooveDepth]) 
		rotate([-135,0,0]) 
			cube([totalSize[0]+1,grooveDepth*2,grooveDepth*2]);

	translate([0,0,(lipHeight+1)/2+grooveDepth+minimumThickness]) 
		cube([jawWidth,jawLength,lipHeight+1], center=true);

}
	

