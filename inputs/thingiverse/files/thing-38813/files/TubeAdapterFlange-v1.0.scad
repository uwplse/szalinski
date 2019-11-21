/*
 * Tube Adapter Flange with Grating (Parametric), v1.00
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This allows you to cover a hole with a specific diameter (with optional 
 *   grating) and then attach a hose of a different diameter. For example, if you're creating
 *   an exhaust vent for a 40mm fan to push air out through a 1.25-inch tube, then you can 
 *   render this file with a 40mm input diameter and a 1.25-inch output diameter. The angle
 *   of the transition is configurable to ensure good prints. 
 * 
 * INSTRUCTIONS:  Choose some values in the "User-defined values" section, render,
 *   and print. See the comments in that section for details on how to measure. 
 * 
 * v1.00, Mar 1, 2014: Added pinch angles, flange thickness, end rounding.
 * v0.42, Dec 20, 2012: Initial Release.
 * 
 * TODO: 
 *   * None at this time
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

roundRadius       = 5;    // The radius of the rounding on the corners
thickness         = 1.7;  // The thickness of the material (tube) 
flangeThickness   = 2.0;  // The thickness of the flange
holeDistance      = 32;   // The distance on center between the mounting holes on each side  
holeDiameter      = 3.5;  // The diameter of the mounting holes 

boltHeadDiameter  = 6;    // The diameter of the bolt head (so it doesn't interfere with the tube) 

angle             = 60;   // The angle of the transition between diameters

inputTubeLength   = 3;    // The length the input diameter will extend straight before the transition.  
inputDiameter     = 38.5; // The inner diameter (ID) of the input hole
outputLength      = 25;   // The length of the output diameter after the transition. 
outputDiameter    = 29.1; // The inner diameter (ID) of the output flange. 

meshLines         = 0;    // The number of mesh lines (grates) to render (zero for none) 
meshWidth         = 0;    // The width of the mesh material (grates) 
meshHeight        = 0;    // The thickness of the mesh material (grates)

optimizeThickness = true; // true to optimize transition thickness for FDM printing (a bit thinner), 
                          //   or false for consistent thickness 

pinchAngle1       = 90;   // The angle to pinch the output tube from one side
pinchAngle2       = 90;   // ...and from the other side 
tipCutRadius      = 0;    // The radius to round in the tip
tipCutInset       = 0;    // The distance to cut into the tip 

$fn               = 35;   // general curve quality

silliness         = 0.05; // Allows OpenSCAD to create good models 


/////////////////////////////////////////////////////////////////////////////
// Some calculated values and helpful output... 
/////////////////////////////////////////////////////////////////////////////

dx = (inputDiameter - outputDiameter)/2; 
height = dx*tan(angle);
yOffset = (thickness*tan(angle/2));
xOffset = yOffset*tan(angle);
totalHeight = inputTubeLength + outputLength + height; 

echo( str( "Outer diameter of output flange is ", outputDiameter+thickness*2, " mm or ",
	(outputDiameter+thickness*2)/25.4, " in.") ); 
echo( str( "Inner diameter of output flange is ", outputDiameter, " mm or ",
	outputDiameter/25.4, " in.") ); 
echo( str( "Total height is ", totalHeight, " mm or ",
	totalHeight/25.4, " in.") ); 


/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////

difference() {
	union() {
		translate([0,0,thickness/2]) 
			base(); 
		translate([0,0,inputTubeLength/2+thickness]) 
			lowerTube(); 
		translate([0,0,thickness+inputTubeLength]) 
			cone(); 
	}

	// Carve some space for the mounting bolts. 
	translate([0,0,totalHeight/2+flangeThickness+0.5]) 
	for(x=[-1,1], y=[-1,1]) {
		translate([holeDistance/2*x,holeDistance/2*y,0]) 
			cylinder(h=totalHeight+1,r=boltHeadDiameter/2, center=true);
	}
}


/////////////////////////////////////////////////////////////////////////////
// The modules...
/////////////////////////////////////////////////////////////////////////////

// Comment out the "module" line and the "}" at the end to use these settings. 
// This is likely suitable for connecting a 40mm fan to a 1.25" tube.
module example1() {
	roundRadius       = 5;
	thickness         = 1.7;
	holeDistance      = 32;
	holeDiameter      = 3.5;
	
	boltHeadDiameter  = 6;
	
	angle             = 60;
	
	inputTubeLength   = 3;
	inputDiameter     = 38.5;
	outputLength      = 15;
	outputDiameter    = (1.28*25.4)-thickness*2;
	
	meshLines         = 0;
	meshWidth         = 0;
	meshHeight        = 0;
	
	optimizeThickness = true;
}

// Comment out the "module" line and the "}" at the end to use these settings. 
// This is likely suitable for connecting a 1.25" tube to cover a 1 1/8" - 1 1/4" hole.
module example2() {
	roundRadius       = 3;
	thickness         = 1.7;
	holeDistance      = 27;
	holeDiameter      = 3.5;
	
	boltHeadDiameter  = 6;
	
	angle             = 60;
	
	inputTubeLength   = 3;
	inputDiameter     = 30;
	outputLength      = 15;
	outputDiameter    = (1.28*25.4)-thickness*2;
	
	meshLines         = 7;
	meshWidth         = 0.8;
	meshHeight        = 1;
	
	optimizeThickness = true;
}

// Comment out the "module" line and the "}" at the end to use these settings. 
// This is likely suitable for connecting a 80mm fan to a 1 1/4" tube.
module example3() {
	roundRadius       = 3;
	thickness         = 1.7;
	holeDistance      = 71.6;
	holeDiameter      = 3.5;
	
	boltHeadDiameter  = 6;
	
	angle             = 60;
	
	inputTubeLength   = 3;
	inputDiameter     = 76;
	outputLength      = 15;
	outputDiameter    = (1.28*25.4)-thickness*2;
	
	meshLines         = 0;
	meshWidth         = 0;
	meshHeight        = 0;
	
	optimizeThickness = true;
}

// Comment out the "module" line and the "}" at the end to use these settings. 
// This makes a nice 40mm fan shroud.
module example4() {
	roundRadius       = 3;
	thickness         = 0.5;
 	flangeThickness   = 1; 
	holeDistance      = 32;
	holeDiameter      = 3.5;
	
	boltHeadDiameter  = 6;
	
	angle             = 68;
	
	inputTubeLength   = 1;
	inputDiameter     = 37;
	outputLength      = 12;
	outputDiameter    = 14;
	
	meshLines         = 0;
	meshWidth         = 0;
	meshHeight        = 0;
	
	optimizeThickness = true;

	pinchAngle1       = 60; 
	pinchAngle2       = 70;
	tipCutRadius      = 12; 
	tipCutInset       = 1.5; 
}


module cone() {
	
	y = optimizeThickness ? 0 : yOffset; 

	difference() { 

		union() {
			rotate([0,0,180]) // line up the edges 
			rotate_extrude(convexity=5)
			polygon(points=[
				[inputDiameter/2+thickness,0],
				[outputDiameter/2+thickness,height],
				[outputDiameter/2+thickness,height+outputLength],
				[outputDiameter/2,height+outputLength],
				[outputDiameter/2,height-y],
				[inputDiameter/2,0-y]
			]);
		
			translate([0,0,silliness]) 
			intersection() {
				union() {
					translate([outputDiameter/2,-(outputDiameter+1)/2,height]) 
						rotate([0,-90+pinchAngle1,0]) 
							cube([thickness,outputDiameter+1,outputLength*2]); 
					translate([-outputDiameter/2-thickness,-(outputDiameter+1)/2,height]) 
						rotate([0,90-pinchAngle2,0]) 
							cube([thickness,outputDiameter+1,outputLength*2]); 
				}
				translate([0,0,height+silliness]) 
					cylinder(h=outputLength, r=outputDiameter/2+silliness); 
			}
		}

		// clean up the pinches 
		translate([outputDiameter/2+thickness,-(outputDiameter+thickness*2+1)/2,height+silliness]) 
			rotate([0,-90+pinchAngle1,0]) 
				cube([outputDiameter,outputDiameter+thickness*2+1,outputLength*2]); 
		translate([-outputDiameter/2-thickness,-(outputDiameter+thickness*2+1)/2,height+silliness]) 
			rotate([0,90-pinchAngle2,0]) 
				translate([-outputDiameter,0,0]) 
				cube([outputDiameter,outputDiameter+thickness*2+1,outputLength*2]);

		// Cut a radius into the tip
		translate([0,0,height+outputLength+tipCutRadius-tipCutInset]) 
			rotate([0,90,0])  	
				cylinder(r=tipCutRadius, h=outputDiameter+thickness*2+1, center=true); 	

	}
}

module lowerTube() {
	difference() {
		cylinder(h=inputTubeLength, r=inputDiameter/2+thickness, center=true);
		cylinder(h=inputTubeLength+1, r=inputDiameter/2, center=true);
	}
}

module base() {
	wid = max( inputDiameter + thickness*2, holeDistance + boltHeadDiameter); 
	dist = wid/2-roundRadius; 
	// meshLines = ( inputDiameter + thickness*2 - meshSize ) / ( meshWidth + meshSize );
	meshDistance = ( wid-meshWidth*meshLines ) / (meshLines+1); 


	echo( str( "Mesh hole size ", meshWidth + meshDistance, " mm" ) ); 

	union() {

		difference() {
			union() {
				for(x=[-1,1], y=[-1,1]) {
					translate([dist*x,dist*y,0]) 
						cylinder(h=flangeThickness, r=roundRadius, center=true); 
				}
				for(r=[0,90]) {
					rotate([0,0,r]) 
						cube([wid,wid-roundRadius*2,flangeThickness], 
							center=true);
				}
			}
	
			// Mounting holes 
			for(x=[-1,1], y=[-1,1]) {
				translate([holeDistance/2*x,holeDistance/2*y,0]) 
					cylinder(h=flangeThickness+1,r=holeDiameter/2, center=true);
			}
	
			// Input hole 
			cylinder(h=thickness+1,r=inputDiameter/2, center=true);
		}

		// mesh
		if ( meshLines > 0 ) {
			intersection() {
				cylinder(h=thickness+1,r=inputDiameter/2, center=true);

				translate([-wid/2,-wid/2,-thickness/2]) {
					for(x=[0:meshLines-1]) 
						translate([meshDistance+x*(meshWidth + meshDistance),0,0]) {
							cube([meshWidth,wid,meshHeight]); 
						}
		
					for(y=[0:meshLines-1]) 
						translate([0,meshDistance+y*(meshWidth + meshDistance),0]) {
							cube([wid,meshWidth,meshHeight]); 
						}
				}
			}
		}
	}
}