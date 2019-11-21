/*
 * Parametric Rocket Fin Guide
 *
 * by Alex Franke (CodeCreations), Jun 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, print, smile
 *     broadly, share with friends, and send the author a few bottles of your favorite beer. 
 * 
 * v2.00, Jul 2, 2012: Added sleeve option for adding fins in middle of tube
 * v1.00, Jun 30, 2012: Initial release. 
 *
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Rocket Parameters

tubeOD              = 42;    // Outer diameter of the tube (rocket body)
tubeID              = 41;    // Inner diameter of the tube (rocket body)


// Fin Parameters
//      The fins are usually glued to the body of the rocket, near or at the bottom. Use 
//   finQty to specify one of more values indicating the number of fin supports to render.  
//   Setting finThickness is not critical, but will allow more perfect alignment. 
//      Somtimes you might want to add fins in different places (other than just the bottom).
//   In this case, set the baseThickness to a value that is sufficient for a stable fit, 
//   and set the sleeveOnly option to true. This will allow you to slide the guide onto 
//   the body of the rocket. 

finQty              = [5];   // One of more values specifying the number of fins
finThickness        = 0.5;   // Thickness of the fin material 
finHeight           = 15;    // The height of the fin supports, away from the rocket body
finLength           = 30;    // The length of the fin supports, along the rocket body
finElevation        = 2.5;   // The distance from the bottom that the fins should attach
finStandoff         = 2;     // Distance of fin supports from rocket body (room for glue)
finSupportThickness = 1;     // The thickness of the fin support material
finLedgeThickness   = 3;     // The thickness of the ledge used to vertically position the fin
finSpineLength      = 2;     // The length of the fin support rib 

tubeGuideThickness  = 2;     // The thickness of the structure that holds the tube
baseThickness       = 2;     // The thickness of the base of the jig

sleeveOnly          = false; // Set to true 

// Quality Parameters: 

$fn                 = 50;   // Default quality for most circle parts. 


/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

// Let's get some basic math out of the way first.
// ...what? No math? Well, maybe next time... 


/////////////////////////////////////////////////////////////////////////////
// Render the object...  
/////////////////////////////////////////////////////////////////////////////

rotate([0,0,-90]) // Rotate for printing with front-mounted fan
	finGuide();


/////////////////////////////////////////////////////////////////////////////
// Modules... 
/////////////////////////////////////////////////////////////////////////////

module finGuide() {

	difference() {
		union() {
			translate([0,0,(finLength+baseThickness)/2]) 
				fins();
			base(); 
		}
		
		if ( sleeveOnly ) 
			translate([0,0,-0.5]) 
				cylinder( r=tubeOD/2, h=finLength+baseThickness+1 ); 
	}
}

module base() {
	translate([0,0,baseThickness/2]) 
		tube( tubeOD+finStandoff+2, tubeID -2, baseThickness );
}

module fins() {
	for(set=finQty) {
		for(i=[0:set-1]) {
			rotate([0,0,i*360/set]) {
				innerStructure();
				fin();	
			}
		}
	}
}

module innerStructure() {
	intersection() {
		translate([tubeID/2/2,0, 0]) 
			cube([tubeID/2, tubeGuideThickness, finLength+baseThickness], center=true);
		cylinder( r=tubeID/2, h=finLength+baseThickness+1, center=true);
	}
}

module fin() {
	union() {
		// fin
		translate([	(tubeOD+finHeight+finStandoff)/2,
					(finSupportThickness+finThickness)/2, 
					0 ])
			cube([finHeight, finSupportThickness, finLength+baseThickness], center=true);

		// spine 
		translate([	(tubeOD+finHeight+finStandoff)/2,
					(finSpineLength+finThickness)/2 + finSupportThickness, 
					0 ])
			cube([finSupportThickness, finSpineLength, finLength+baseThickness], center=true);

		// elevation 
		translate([	(tubeOD+finLedgeThickness+finStandoff)/2,
					0,
					-(finLength+baseThickness)/2+(finElevation+baseThickness)/2	])
			cube([finLedgeThickness, finThickness, finElevation+baseThickness], center=true);
		
	}
}

module tube( od, id, height ) {
	difference() {
		cylinder(r=od/2, h=height, center=true);
		cylinder(r=id/2, h=height+1, center=true);
	}
}