/*
 * Parametric Encoder Wheel, v0.9
 *
 * by Alex Franke (CodeCreations), Mar 2012 - Apr 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, and render. 
 * 
 * The bearing.scad file from the MCAD library has a number of different bearing sizes 
 * in it if you're not using a 608. 
 * 
 * VERSION HISTORY: 
 * 
 * v0.9, Apr 2, 2012: Added support for bearing constraints, captive nuts, bolting holes, 
 * 		and pins for joining the wheel and cap. Both parts are now rendered side by side. 
 * 		Added a bunch of new parameters, and some more math output for users. 
 * 
 * v0.0, Mar 31, 2012: Initial Release.
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////
bearingSize = [8, 22, 7]; 		 	// The dimensions of the bearing, if you're using that to define the hole 
encoderCircumference = 100;		 	// The circumference at the *surface* of the wheel (subtract tire thickness, e.g.)
internalWidth = bearingSize[2];	 	// The internal width (e.g. tire width) of the wheel. This is the width of a pinch 608 by default
collarPlay = 0.5; 				 	// The amount of play to build into the internal width. 
collarHeight = 6; 				 	// How high the shoulders/encoder extend out from the wheel 
collarWidth = 1.5; 				 	// How thick the shoulders are 
holeDiameter = bearingSize[1]; 	 	// The diameter of the mounting hole. This is the diameter of a 608 bearing by default. 
holePlay = 0.5; 					 	// The amount of play built into the mounting hole. 
timingHoles = 40;					 	// The number of timing holes to render. (e.g. 100mm circumference / 5mm per hole = 20 holes)
timingHoleInset = 1; 				 	// How far the timing holes are inset from the edge of the shoulder

// Calculated values -- don't change them. 
encoderDiameter = encoderCircumference / PI; 

// Captive Nut traps allow you to tighten the wheel onto a shaft or bearing. 
nutCount = 3; 
nutDiameter = 5.4; 				 	// The distance across the nut, from flat to flat, default M3
nutThickness = 2.3; 				 	// The thickness of the nut, default M3
setScrewDiameter = 3;			 	 	// The diameter of the set screw clearance hole, default M3

// The constraint values can be used to add material to the bottom of the mounting hole that partially 
// blocks the hole. This can be useful, for example, if you want to constrain a bearing in the hole. 
constraintInset = 1.5; 			 	// How far the constraint estends toward the center of the mounting hole
constraintThickness = collarWidth;	 	// The thickness of the contstraining wall
capConstraintInset = 1.5; 			// How far the constraint estends toward the center of the mounting hole on the cap
capConstraintThickness = collarWidth;	// The thickness of the contstraining wall on the cap

// Pins or holes allow the cap to be snapped, glued, or bolted to the encoder wheel. 
pinCount = 3; 					 	// The total number of pins / pin holes to render evenly-spaced
pinLength = internalWidth / 2;	 	// The length of the pins/holes 
pinDiameter = ((encoderDiameter 	 
	-holeDiameter)/2) * 0.6;		 	// The diameter of the pins/holes
useHolesInstead = false; 				// If true, render bolt through-holes rather than pins and pin holes 
mateHoleDiameter = setScrewDiameter; 	// Bolt holes are sized to match hardware, not physical properties. 

// These values define the cap
capDiameter = encoderDiameter 
	+ (collarHeight*2);			 	// The diameter of the shoulder cap, defaulting to the outer diameter of the encoder
capWidth = collarWidth; 			 	// The thickness of the shoulder cap, defaulting to the thickness of the slotted encoder shoulder
capStandoff = 0;				 	 	// A surface rendered on the inside of the cap around the mounting hole
capStandoffWidth = 1;				 	// The width of the stand-off surface
capHoleRotation = 360/(pinCount*2); 	// Rotation of cap holes (in order to avoid the nut traps)

// Other misc
distanceApart = 10;				 	// How far apart the object will be rendered. 



/////////////////////////////////////////////////////////////////////////////
// Don't change the code below unless you know what your'e doing... 
/////////////////////////////////////////////////////////////////////////////


// Do some math for the user... 
echo ( str("Circumference is ", encoderCircumference, "mm, with ", timingHoles, " timing holes." ) );
echo ( str("Each timing mark is ", encoderCircumference/timingHoles, "mm." ) );
echo ( str("...or ", (encoderCircumference/timingHoles) / 25.4, "in." ) );

echo ( str("For various product + tire thicknesses, where center of product is at this height: " ) );
echo ( str("  1.0mm: ", dist(1), "mm" ) );
echo ( str("  1.5mm: ", dist(1.5), "mm" ) );
echo ( str("  2.0mm: ", dist(2), "mm" ) );
echo ( str("  2.5mm: ", dist(2.5), "mm" ) );
echo ( str("  3.0mm: ", dist(3), "mm" ) );
echo ( str("  3.5mm: ", dist(3.5), "mm" ) );
echo ( str("  4.0mm: ", dist(4), "mm" ) );
echo ( str("  4.5mm: ", dist(4.5), "mm" ) );
echo ( str("  5.0mm: ", dist(5), "mm" ) );


// Render the encoder wheel 
translate([0,-(encoderDiameter/2)-collarHeight-(distanceApart/2),0]) {
	renderEncoder();
}

// Render the cap
translate([0,(capDiameter/2)+(distanceApart/2),0]) {
	renderCap();
}


/////////////////////////////////////////////////////////////////////////////
// These are just a couple of helpers / shortcuts
/////////////////////////////////////////////////////////////////////////////

function dist(h) = ( (encoderDiameter+(2*h)) * PI ) / timingHoles;

// Shortcuts that include all the parameters
module renderCap() {
	cap( capDiameter, 
		capWidth, 
		encoderDiameter,
		holeDiameter + holePlay, 
		capStandoff,
		capStandoffWidth,
		pinCount,
		pinLength, 
		pinDiameter,
		useHolesInstead,
		mateHoleDiameter,
		capConstraintInset, 
		capConstraintThickness
		);
}
module renderEncoder() {
	encoder(  encoderCircumference, 
		internalWidth + collarPlay,
		holeDiameter + holePlay,
		collarHeight,
		collarWidth,
		timingHoles,
		timingHoleInset, 
		constraintInset, 
		constraintThickness,
		pinCount,
		pinLength, 
		pinDiameter,
		useHolesInstead,
		mateHoleDiameter,
		capHoleRotation,
		nutCount,
		nutDiameter,
		nutThickness,
		setScrewDiameter
		); 
}


/////////////////////////////////////////////////////////////////////////////
// These modules were designed to be a bit more generic. They don't rely on
// any of the variables above. 
/////////////////////////////////////////////////////////////////////////////

module encoder( circumference, internalWidth, holeDiameter=8, collarHeight=5, collarWidth=1.5, 
	timingHoles=8, timingHoleInset=1, constraintInset=0, constraintThickness=0, 
	pinCount=0, pinLength=0, pinDiameter=0, useHolesInstead=false, mateHoleDiameter=0, pinHoleRotation=0,
	nutCount=3, nutDiameter=5.4, nutThickness=2.3, setScrewDiameter=3 ) {

	encoderDiameter = circumference / PI; 
	newR = ((encoderDiameter-holeDiameter)/4 - 2)/2.7;
	wallThickness = (encoderDiameter-holeDiameter)/2;
	wallCenterRadius = holeDiameter/2+(wallThickness/2); 

	union() {
		difference () {

			// The body of the wheel/shoulder
			union() {
				cylinder( r=encoderDiameter/2 + collarHeight, h=collarWidth );
				translate([0,0,collarWidth])
					cylinder( r=encoderDiameter/2, h=internalWidth);
			}

			// Punch out the mounting hole
			translate([0,0,-0.5])
				cylinder( r=holeDiameter/2, h=internalWidth + collarWidth + 1);

			// Punch out timing holes	
			translate([0,0,-0.5]) {
				for ( i = [0 : timingHoles-1] ) {
				   	 rotate( i*(360/timingHoles), [0, 0, 1])
				   	 arc( collarHeight-timingHoleInset, 
						collarWidth+1, 
						(encoderDiameter/2)+collarHeight-timingHoleInset, 
						degrees =180/timingHoles 
				    	);
				}
			}

			// Punch out bolting holes if necessary 
			if ( pinCount>0 ) {
				rotate([0,0,pinHoleRotation]) {
					if( useHolesInstead ) {
						translate([0,0,-0.5]) {
							pins( pinCount, mateHoleDiameter, internalWidth + collarWidth + 1, wallCenterRadius ); 
						}
					}
					else {
						translate([0,0,internalWidth + collarWidth + collarPlay - pinLength - 0.5]) {
							pins( pinCount, pinDiameter, pinLength + 0.5, wallCenterRadius ); 
						}
					}
				}
			}

			// Punch out the nut traps if necessary 
			if ( nutCount > 0 ) {
				for ( i = [0 : nutCount-1] ) {
					rotate( i*(360/nutCount), [0, 0, 1]) {
						translate([wallCenterRadius,0,collarWidth+(internalWidth/2)]) {
							rotate([0,-90,180]) {
								nutTrap(
									nutDiameter, 
									nutThickness, 
									setScrewDiameter, 
									depth=(internalWidth/2)+0.5, //0.5 extra so it renders well
									holeLengthTop=wallThickness/2, 
									holeLengthBottom=wallThickness/2
								);
							}
						}
					}
				}
			}
	 
			/*
			// Experimental... 
			// Holes in idler to conserve filament
			for ( i = [0 : 4] ) {
			   	 rotate( i * 360/5, [0, 0, 1])
			   	 translate([holeDiameter/2 + (encoderDiameter-holeDiameter)/4, 0, -0.5])
			   	 cylinder(h=internalWidth+(2*collarWidth)+1, r=(encoderDiameter-holeDiameter)/4 - 1);
			}
	
			// Smaller holes in idler to conserve filament
		   	rotate( 360/5/2, [0, 0, 1])
			for ( i = [0 : 4] ) {
			   	 rotate( i*(360/5), [0, 0, 1])
			   	 translate([encoderDiameter/2-newR -1.5, 0, -0.5])
			   	 cylinder(h=internalWidth+(2*collarWidth)+1, r=newR, $fn=10);
			}
			*/
		}

		// Render the constraint surface if necessary 
		if ( ( constraintInset > 0 ) && ( constraintThickness > 0 ) ) {
			difference() {
				cylinder( r=holeDiameter/2, h=constraintThickness);
				translate([0,0,-0.5])
					cylinder( r=(holeDiameter/2)-constraintInset, h=constraintThickness+1);
			}
		}
	}
}

module cap( diameter, thickness, hubDiameter, holeDiameter, standoffHeight=0, standoffWidth=0, numPins=0, 
	pinHeight=0, pinDiameter=0, useHolesInstead=false, mateHoleDiameter=0, constraintInset=0, constraintThickness=0 ) {

	wallThickness = (hubDiameter-holeDiameter)/2;
	wallCenterRadius = holeDiameter/2+(wallThickness/2); 

	render()
	union() {
		difference() {
			// cap body 
			union() {
				cylinder( r=diameter/2, h=thickness );
				cylinder( r=(holeDiameter/2)+standoffWidth, h=collarWidth+standoffHeight );
			}
	
			// Poke out the mounting hole 
			translate([0,0,-0.5]) 
				cylinder( r=holeDiameter/2, h=collarWidth+standoffHeight+1 );

			// Poke out the bolting holes if necessary  
			if ( useHolesInstead ) {
				translate([0,0,-0.5]) {
					pins( numPins, mateHoleDiameter, thickness+1, wallCenterRadius ); 
				}
			}
		}

		// Add the pins, if necessary 
		if ( ( !useHolesInstead ) && ( numPins > 0 ) && ( pinHeight > 0 ) && ( pinDiameter > 0 ) ) {
			translate([0,0,thickness]) {
				pins( numPins, pinDiameter, pinHeight, wallCenterRadius ); 
			}
		}

		// Render the constraint surface if necessary 
		if ( ( constraintInset > 0 ) && ( constraintThickness > 0 ) ) {
			difference() {
				cylinder( r=holeDiameter/2, h=constraintThickness);
				translate([0,0,-0.5])
					cylinder( r=(holeDiameter/2)-constraintInset, h=constraintThickness+1);
			}
		}
	}
}

module pins( numPins=3, pinDiameter=3, pinHeight=10, distanceFromCenter=10) {
	for ( i = [1 : numPins] ) {
		rotate( i*(360/numPins), [0, 0, 1]) {
			translate([distanceFromCenter,0,0]) {
				cylinder( r=pinDiameter/2, h=pinHeight, $fn=15);
			}
		}
	}
}

module nutTrap( inDiameter=5.4, thickness=2.3, setScrewHoleDiameter=3, depth=10, holeLengthTop=5, holeLengthBottom=5 )
{
	side = inDiameter * tan( 180/6 );

	render()
	union() {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, inDiameter, thickness], center=true );
		}
	
		translate([depth/2,0,0]) 
			cube( [depth, inDiameter, thickness], center=true );
	
		translate([0,0,-(thickness/2)-holeLengthBottom]) 
			cylinder(r=setScrewHoleDiameter/2, h=thickness+holeLengthTop+holeLengthBottom, $fn=15);
	}
}

// Why is this not easy in openSCAD? :/ 
module arc( height, depth, radius, degrees ) {
	// This dies a horible death if it's not rendered here 
	// -- sucks up all memory and spins out of control 
	render() {
		difference() {
			// Outer ring
			rotate_extrude($fn = 100)
				translate([radius - height, 0, 0])
					square([height,depth]);
		
			// Cut half off
			translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);
		
			// Cover the other half as necessary
			rotate([0,0,180-degrees])
			translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);
		
		}
	}
}
