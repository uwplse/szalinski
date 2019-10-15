/* [Button] */
// How thick should the button be in the center? (mm)
buttonThickness = 2; // [2:2.0 millimetres,2.5:2.5 millimetres,3:3.0 millimetres,5:5.0 millimetres,10:10 millimetres]

// What is the distance from one side of the button to the other? (mm)
buttonDiameter = 14; // [7:40]

// How wide should the trim around the button be? (mm)
buttonTrimThickness = 2; // [0:39]

// How far off of the top of the button should the trim stand? (mm)
buttonTrimHeight = 1.5; // [1.5:1.5 millimetres,2:2.0 millimetres,2.5:2.5 millimetres,3:3.0 millimetres]

/* [Threadholes] */
// How many threadholes should the button have?
holeCount = 4; // [0:8]

// How far from the centre should the threadholes be (fraction out of 10)?
holeDistanceToCentre = 5; // [0:10]

// How big should each threadhole be? (mm)
holeSize = 2; // [1:6]

// END OF CUSTOMIZER VARIABLES

innerDiameter = buttonDiameter - (buttonTrimThickness-0.001 * 2);	// Used to line things up so they won't collide with the trim

// Lays out the  cylinders that will be used to form the threadholes
module holes() {	
	if ( (holeCount > 0) && (holeCount != 1) ) {	// Avoid a divide-by-zero error
		rotationDegrees = 360 / holeCount;	// This places the holes equally around the centre
		
		for(currentRotation = [0 : rotationDegrees : 359]) {	// Stop at 359 degrees, because 360 degrees is coterminal to 0 degrees
			singleHole( ((holeDistanceToCentre * .05) * innerDiameter * cos(currentRotation)),
				((holeDistanceToCentre * .05) * innerDiameter * sin(currentRotation)) );
			
			/*	Multiplying by .05 makes the distance to centre a fraction of 1, and then divides it by two (diameter to radius)
				The x coordinate is found by multiplying the sine of the current angle by the distance from the centre
				The y coordinate is found the same way, except using the cosine instead of the sine. */
		}
	} else if ( (holeCount > 0) && (holeCount == 1) ) {
		singleHole(0, 0);	// If there's only one hole, just put it in the middle
	}
}

// Defines a single threadhole cylinder; used in holes()
module singleHole(x, y) {
	translate([x,y,0]) cylinder(h=(buttonThickness + buttonTrimHeight) * 3, d=holeSize, center=true, $fn=12);
}

// The button, minus the trim
module buttonInnerDisc() {
	difference() {
		cylinder(h=buttonThickness, d=innerDiameter);
		holes();
	}
}

// Just the trim for the button
module buttonTrim() {
	difference() {
		cylinder(h=buttonThickness + buttonTrimHeight, d=buttonDiameter);
		cylinder(h=buttonThickness * 4, d=innerDiameter, center=true);
	}
}

// Compile everything together and make the final button
module makeButton() {
	buttonTrim();
	buttonInnerDisc();
}

makeButton();