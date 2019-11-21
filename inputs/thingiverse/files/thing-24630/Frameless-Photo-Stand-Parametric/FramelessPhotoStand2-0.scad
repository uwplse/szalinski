/*
 * Frameless Photo Stand, v2.0
 *
 * by Alex Franke (CodeCreations), Jun 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This is a simple parametric frameless photo stand that uses (with its 
 *   default values) only about 50mm of filament (about a penny) and holds up a photo
 *   for display without the use of a frame. 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render,
 *   and print. If you want to render the object with a slot to hold a coin, use 
 *   the name of that coin from the list in "Some constant coin sizes," or define 
 *   your own size as [diameter,thickness]. For example, if you want to stack two 
 *   1-euro coins, use [23.25, 4.66] as the value. Be sure the base is sized to fit
 *   the coins. 
 * 
 * v1.0, Jun 9, 2012: Initial Release.
 * v2.0, Jun 19, 2012: Adds coin clip for added weight.
 * 
 * TODO: 
 *   * nothing yet...  
 */

/////////////////////////////////////////////////////////////////////////////
// Some constant coin sizes... 
/////////////////////////////////////////////////////////////////////////////

NONE   = [0,0];          EU_2E  = [25.75,2.2];    CA_2D  = [28,1.8];
                         EU_1E  = [23.25,2.33];   CA_1D  = [26.5,1.75];
US_1D  = [26.49,2];      EU_50C = [24.25,2.38];   CA_50C = [23.87,1.95];
US_50C = [30.61,2.15];   EU_20C = [22.25,2.14];   CA_25C = [23.88,1.58];
US_25C = [24.26,1.75];   EU_10C = [19.75,1.93];   CA_10C = [18.03,1.22];
US_10C = [17.91,1.35];   EU_5C  = [21.25,1.67];   CA_5C  = [21.2,1.76];
US_5C  = [21.21,1.95];   EU_2C  = [18.75,1.67];   CA_1C  = [19.05,1.45];
US_1C  = [19.05,1.55];   EU_1C  = [16.3,1.67];

AU_2D  = [20.5,3.2];
AU_1D  = [25,3];
AU_50C = [31.51,2];
AU_20C = [28.52,2.5];
AU_10C = [23.6,2];
AU_5C  = [19.41,1.3];


/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

baseThickness     = 1;          // The thickness of the base
baseWidth         = 25;         // The width of the base 
baseLength        = 30;         // The length of the base
coinSize          = US_25C;     // The coin to use, or [diameter,thickness]
coinClipPadding   = 0.5;        // The extra space built into to the coin clip
coinClipThickness = 1.2;        // The thickness of the coin slot 
coinSupportWidth  = 5;          // The width of the coin support surface
coinStopHeight    = 0.5;        // The width of the coin support surface
coinStopOverhang  = 0.5;        // The width of the coin support surface

baseSupportWidth  = 2;          // The minimal width of the support structure 

tabThickness      = 1.0;        // The thickness of each vertical "tab"
tabHeight         = 3.5;        // The height of the vertical tabs
tabRadius         = 1;          // The radius of the top corners of the tabs
tabSeparation     = 4;          // How far apart the tabs are 
tabAngle          = 75;         // The angle of the tabs (90 is vertical) 

$fn               = 25;         // Quality of circles 


/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

tabWidth = (baseWidth-(tabSeparation*2))/3;
sideCutoutWidth = (baseWidth-baseSupportWidth)/2;
sideCutoutLength = (baseLength-tabThickness-baseSupportWidth);


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

union() {

	// Base
	Base(baseLength, baseWidth, baseThickness, tabThickness, sideCutoutLength, sideCutoutWidth );
	
	// Coin clip 
	if ( coinSize[0] * coinSize[1] > 0 ) {
		translate([0,0,baseThickness])
		intersection() {
			translate([0,baseLength/2 + tabThickness,0])
			difference() {
				union() {
					difference() {
						// outer circle 
						cylinder(r=coinSize[0]/2 + coinClipPadding/2 + coinClipThickness, 
							h=coinSize[1] + coinClipPadding); 
						// inner circle cutout
						translate([0,0,-0.5]) 
							cylinder(r=coinSize[0]/2 + coinClipPadding/2, 
								h=coinSize[1] + coinClipPadding + 1); 
					}

					// coin stop 
					translate([0,0,coinSize[1]+coinClipPadding])
					difference() {
						// outer circle
						cylinder(r=coinSize[0]/2 + coinClipPadding/2 + coinClipThickness, h=coinStopHeight); 
						// inner circle cutout
						translate([0,0,-0.5]) 
							cylinder(r=coinSize[0]/2 + coinClipPadding/2 - coinStopOverhang, h=coinStopHeight+1); 
					}
				}

			}
			translate([0,0,-0.5]) 
				Base(baseLength, baseWidth, coinSize[1]+coinStopHeight+coinClipPadding+1, tabThickness, 
					sideCutoutLength, sideCutoutWidth );
		}

		// Coin support
		translate([0,baseLength/2 + tabThickness,baseThickness/2])
		intersection() {
			cube([coinSize[0],coinSupportWidth,baseThickness], center=true);
			cylinder(r=coinSize[0]/2, h=coinSize[1], center=true); 
		}
	}

	// Tabs
	translate([0,0,baseThickness]) 
		rotate([tabAngle-90,0,0]) 
			for( i=[-1,0,1] )
				translate([i*(baseWidth-tabWidth)/2,tabThickness/2,tabHeight/2]) 
					RoundedTab([tabWidth,tabThickness, tabHeight], tabRadius);
}


/////////////////////////////////////////////////////////////////////////////
// Modules... 
/////////////////////////////////////////////////////////////////////////////

module Base(length, width, thickness, tabThickness, cutoutLength, cutoutWidth ) {
	difference() {
		translate([0,length/2,thickness/2]) 
			cube([width, length, thickness], center = true);

		// Curved cutouts 
		for( i=[-1,1] ) {
			translate([i*width/2,tabThickness+((length-tabThickness)/2),-0.5]) 
				scale([1,cutoutLength/cutoutWidth/2,1]) 
					cylinder(h=thickness+1, r=cutoutWidth);
		}
	}
}

module RoundedTab( size, radius ) {
	union() {
		for( i=[-1,1] ){
			translate([i*((size[0]/2)-radius), 0, (size[2]/2)-radius]) 
				rotate([90,0,0]) 
					cylinder( h=size[1], r=radius, center=true ) ;
		}
		translate([0,0,-radius/2]) 
			cube([size[0], size[1], size[2]-radius], center=true);
		translate([0,0,0]) 
			cube([size[0]-radius*2, size[1], size[2]], center=true);
	}
}

