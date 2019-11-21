/*
 * Squeeze Bottle Cap
 *
 * by Alex Franke (CodeCreations), Nov 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, and print. 
 * 
 * v1.00, Nov 21, 2012: Initial Release.
 *
 * TODO: 
 *   * Nothing at this time. 
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

lowerInnerDiameter   = 8;    // Larger diameter of cone-shaped nozzle (farthest from the tip)
lowerDiameterHeight  = 10;   // Distance from tip of previous measurement  (also insertion depth)

upperInnerDiameter   = 5;    // Smaller diameter of cone-shaped nozzle (near the tip)
upperDiameterHeight  = 2.5;  // Distance from tip of previous measurement 

capDiameter          = 12;   // Diameter of ridge at top of cap
capHeight            = 2.5;  // Height of ridge at top of cap
materialThickness    = 0.9;  // Minimum thickness of printed material

$fn                  = 30;   // Curve quality 


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

squeezeBottleCap(); 

/////////////////////////////////////////////////////////////////////////////
// Modules... 
/////////////////////////////////////////////////////////////////////////////

module squeezeBottleCap() {

	difference() {
		union() {
			cylinder(h=capHeight, r=capDiameter/2);
			translate([0,0,materialThickness]) 
				cylinder(h=lowerDiameterHeight, r=lowerInnerDiameter/2+materialThickness);
		}
	
		translate([0,0,materialThickness+0.05]) 
		union() {
			cylinder(r=upperInnerDiameter/2, h=upperDiameterHeight);
			translate([0,0,upperDiameterHeight]) 
				cylinder(r1=upperInnerDiameter/2, r2=lowerInnerDiameter/2, h=lowerDiameterHeight-upperDiameterHeight);
		}
	}
}