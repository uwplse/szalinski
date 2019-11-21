/*
 * Candle Adapter, v0.42
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This will allow you to put a fat candle into a smaller hole. 
 * 
 * INSTRUCTIONS:  Choose some values in the "User-defined values" section, render,
 *   and print. See the comments in that section for details on how to measure. 
 * 
 * v0.42, Dec 15, 2012: Initial Release.
 * 
 * TODO: 
 *   * Make shorter for smaller candles placed in larger holes 
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// At the base of the candle, measure the distance the candle will be inserted into the 
// holder (fLength), the diameter of the candle at that distance form the end (fTopID), 
// and the diameter of the candle at the end (fBottomID). (This assumes a consistent 
// taper.) Finally, set the minimum thickness (thickness) of the printed material 
// surrounding the candle. 
fLength     = 20; 
fTopID      = 25; 
fBottomID   = 20; 
thickness   = 1; 

// Measure the depth of the hole (mLength), the diameter of the opening at the top 
// (mTopOD), and the diamater of the hole at the bottom (mBottomOD). (This also 
// assumes a consistent taper.)
mLength     = 15; 
mTopOD      = 12; 
mBottomOD   = 10.5; 

$fn         = 20; // general curve quality


/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////
translate([0,0,thickness/2+fLength]) 
rotate([180,0,0]) 
union() {

	// Female
	translate([0,0,(fLength+thickness)/2]) 
	difference(){ 
		cylinder(h=fLength, r=fTopID/2+thickness, center=true);
		cylinder(h=fLength+1, r2=fTopID/2, r1=fBottomID/2, center=true);
	}

	cylinder(h=thickness, r=fTopID/2+thickness, center=true);

	// Male
	translate([0,0,-(mLength+thickness)/2]) 
	cylinder(h=mLength, r2=mTopOD/2, r1=mBottomOD/2, center=true);
}