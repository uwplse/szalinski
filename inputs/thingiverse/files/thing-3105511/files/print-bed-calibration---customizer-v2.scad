// preview[view:south west, tilt:top diagonal]

// Configuration

// Printbed X-Size
sizeX = 300; // [10:10:500]

// Printbed Y-Size
sizeY = 300; // [10:10:500]

// Number of mesh bed leveling points on the x-axis
meshPointsX = 5; // [2:1:7]

// Number of mesh bed leveling points on the y-axis
meshPointsY = 5; // [2:1:7]

// Calibration plate offset from the left side of the printbed
offsetX = 30; // [0:5:50]

// Calibration plate offset from the bottom side of the printbed
offsetY = 30; // [0:5:50]

// Size of the generated calibration plate
calibrationPlateWidth = 10; // [1:1:50]
calibrationPlateLength = 10; // [1:1:50]
calibrationPlateHeight = 0.4; // [0.1:0.1:5]
roundedEdgesRadius = 2; // [0:0.5:10]

// Size of the generated text
textSize = 5; // [1:1:10]
textHeight = 0.4; // [0.1:0.1:5]





// Generate calibration plates according to settings
for(_x = [1:1:meshPointsX]) {
	for(_y = [1:1:meshPointsY]) {
		calibrationPlate(x=_x, y=_y);
	}

}

module calibrationPlate(x=1, y=1) {

	$fn = 32;

	if(x >= 1 && x <= meshPointsX && y >= 1 && y <= meshPointsY) {

		// Move to position defined by x and y
		translate([
			offsetX+(((sizeX-(offsetX*2))/(meshPointsX-1))*(x-1)),
			offsetY+(((sizeY-(offsetY*2))/(meshPointsY-1))*(y-1)),
			0
		]) {

			// Center calibration plate
			translate([calibrationPlateWidth/-2 + roundedEdgesRadius, calibrationPlateLength/-2 + roundedEdgesRadius, 0]) {
				
				// round the edges
				minkowski() {
					cube([calibrationPlateWidth-(roundedEdgesRadius*2), calibrationPlateLength-(roundedEdgesRadius*2), calibrationPlateHeight/2]);
					cylinder(h=calibrationPlateHeight/4, r=roundedEdgesRadius);
				}

				// move text to middle of calibration plate
				translate([calibrationPlateWidth/2 - roundedEdgesRadius, calibrationPlateLength/2 - roundedEdgesRadius, calibrationPlateHeight])
					linear_extrude(height=textHeight)
						text(str(x, "/", y), size=textSize, halign="center", valign="center");
			}
		}
		
	}
	
}
