/*
 * Convertible Pencil Rocket / Pencil Stand
 *
 * by Alex Franke (CodeCreations), Nov 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, and print. 
 * 
 * v1.00, Nov 28, 2012: Initial Release.
 *
 * TODO: 
 *   * Nothing at this time. 
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

finThickness     = 1;    // Thickness of fins
finCount         = 3;    // Number of fins
finInset         = 0.5;  // Distance fins are inset from surface
finScale         = 0.75; // Scale the fins larger (>1) or smaller (<1)
pencilInDiameter = 7.6;  // Diameter of pencil (flat to flat for hex) 6.85 == Ticonderoga #2
bandThickness    = 2;    // The maximum thickness of the band the fins are attached to 
bandHeight       = 10;   // The height of the band
bandTranslation  = 8;    // The distance the band is translated toward the top of the fins

$fn              = 40;   // Overall curve quality


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

rotate([180,0,0]) 
union() {
	translate([0,0,bandTranslation]) 
	difference() {
		cylinder(h=bandHeight, r=pencilInDiameter/2+bandThickness);
	
		translate([0,0,(bandHeight)/2]) 
			rotate([0,0,30]) 
			nut([pencilInDiameter, bandHeight+1]);
	
	}
	
	for( i=[0:finCount-1] ) {
	
		rotate([0,0,(360/finCount)*i]) 
		translate([pencilInDiameter/2+bandThickness-finInset, 0, 0]) 
		rotate([90,0,0]) 
		scale([finScale,finScale,1]) 
		fin(); 
	
	}
}

/////////////////////////////////////////////////////////////////////////////
// Modules... 
/////////////////////////////////////////////////////////////////////////////

module fin() {
	translate([-20,-11.8,0]) 
	union() {
		difference() { 
			cylinder(h=finThickness, r=40, center=true);
			
			translate([0,-18,0]) 
				cylinder(h=finThickness+1, r=36, center=true);
	
			translate([-25,0,0]) 
				cube([90,90,finThickness+1], center=true);

			translate([36,-16,0]) 
				cube([10,10,finThickness+1], center=true);
		}

		translate([36.75,-12,0]) 
			cylinder(h=finThickness, r=2.5, center=true);
	}
}


// Same nutty code I use in my other designs...
// nutSize = [inDiameter,thickness]
module nut( nutSize ) { 
	side = nutSize[0] * tan( 180/6 );
	if ( nutSize[0] * nutSize[1] != 0 ) {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, nutSize[0], nutSize[1]], center=true );
		}
	}
}