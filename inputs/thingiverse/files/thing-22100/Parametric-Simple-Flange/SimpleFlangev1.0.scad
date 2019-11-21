/*
 * Simple Flange 
 *
 * by Alex Franke (CodeCreations), Apr 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, print, smile
 *     broadly, share with friends, and send the author a few bottles of your favorite beer. 
 *
 * v1.00, Apr 26, 2012: Initial release. This was inspired by my broken towel hoop... so might 
 *     as well make it an official "thing!" :) 
 */

totalHeight = 6.5; 		// Total height of object
bodyDiameter = 11; 		// Diameter of body
flangeHeight = 1.5; 		// Diameter of the bottom part that juts out
flangeWidth = 1.5; 		// Distance that the bottom part juts out
internalDiameter = 10; 	// Diameter of the hole in the middle 
holeDepth = 7; 			// Depth of the hole in the middle, from the bottom

$fn=30;

flange( totalHeight, bodyDiameter, flangeHeight, flangeWidth, internalDiameter, holeDepth ); 

module flange(
	totalHeight = 6.5,
	bodyDiameter = 11,
	flangeHeight = 1.5,
	flangeWidth = 1.5,
	internalDiameter = 10,
	holeDepth = 5.5
) {
	difference() {
		union() {
	
			// Flange
			cylinder(h=flangeHeight, r=bodyDiameter/2+flangeWidth);
	
			// Body 
			translate([0,0,flangeHeight])
				cylinder(h=totalHeight-flangeHeight, r=bodyDiameter/2);
		}
	
		// Hole 
		cylinder(h=holeDepth, r=internalDiameter/2);
	}
}
	
