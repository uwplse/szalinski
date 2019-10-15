/**
 * Print designed to check that you bed is level
 *
 * print four small squares in each corner to ensure even print quality and good adhesion.
 */

// Define your printers printable area
// If you are using Sprinter firmware then these come directly from configuration.h

/* [Dimensions] */

//Length of X axis [mm]
X_MAX_LENGTH = 230; // [1:1:500]

//Length of Y axis [mm]
Y_MAX_LENGTH = 230; // [1:500]

//Thickness (height) of square [mm]
THICKNESS = 0.2; // [0:0.05:1]

/* [Customize grid] */

//Choose preconfigured grid or choose custom and change parameters below
PRESET = "all"; // [custom:Custom (use parameters below),corners_only:Corners only,3x3:3x3 grid,all:Full 5x5 grid]

//Do you want to see square X1 Y1?
GRID_1_1 = 1; // [0:No, 1:Yes]
//Do you want to see square X2 Y1?
GRID_2_1 = 1; // [0:No, 1:Yes]
//Do you want to see square X3 Y1?
GRID_3_1 = 1; // [0:No, 1:Yes]
//Do you want to see square X4 Y1?
GRID_4_1 = 1; // [0:No, 1:Yes]
//Do you want to see square X5 Y1?
GRID_5_1 = 1; // [0:No, 1:Yes]
//Do you want to see square X1 Y2?
GRID_1_2 = 1; // [0:No, 1:Yes]
//Do you want to see square X2 Y2?
GRID_2_2 = 1; // [0:No, 1:Yes]
//Do you want to see square X3 Y2?
GRID_3_2 = 1; // [0:No, 1:Yes]
//Do you want to see square X4 Y2?
GRID_4_2 = 1; // [0:No, 1:Yes]
//Do you want to see square X5 Y2?
GRID_5_2 = 1; // [0:No, 1:Yes]
//Do you want to see square X1 Y3?
GRID_1_3 = 1; // [0:No, 1:Yes]
//Do you want to see square X2 Y3?
GRID_2_3 = 1; // [0:No, 1:Yes]
//Do you want to see square X3 Y3?
GRID_3_3 = 1; // [0:No, 1:Yes]
//Do you want to see square X4 Y3?
GRID_4_3 = 1; // [0:No, 1:Yes]
//Do you want to see square X5 Y3?
GRID_5_3 = 1; // [0:No, 1:Yes]
//Do you want to see square X1 Y4?
GRID_1_4 = 1; // [0:No, 1:Yes]
//Do you want to see square X2 Y4?
GRID_2_4 = 1; // [0:No, 1:Yes]
//Do you want to see square X3 Y4?
GRID_3_4 = 1; // [0:No, 1:Yes]
//Do you want to see square X4 Y4?
GRID_4_4 = 1; // [0:No, 1:Yes]
//Do you want to see square X5 Y4?
GRID_5_4 = 1; // [0:No, 1:Yes]
//Do you want to see square X1 Y5?
GRID_1_5 = 1; // [0:No, 1:Yes]
//Do you want to see square X2 Y5?
GRID_2_5 = 1; // [0:No, 1:Yes]
//Do you want to see square X3 Y5?
GRID_3_5 = 1; // [0:No, 1:Yes]
//Do you want to see square X4 Y5?
GRID_4_5 = 1; // [0:No, 1:Yes]
//Do you want to see square X5 Y5?
GRID_5_5 = 1; // [0:No, 1:Yes]

/* [For experts] */

//Square size [mm]
SIZE = 20; // [1:1:100]

//Width of margin between square and parameter
GAP = 0.5; // [0:0.1:2]

//Width of outline
OUTLINE_WIDTH = 1; //[0:0.1:2]

//Offset from limits in each axis
OFFSET = 5; // [1:1:500]

if (PRESET == "custom") {
    /* Grid X1 */
    if (GRID_1_1) {
        translate([OFFSET, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Left
    }
    if (GRID_2_1) {
        translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Left-Middle
    }
    if (GRID_3_1) {
        translate([(X_MAX_LENGTH / 2) - (SIZE / 2), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Middle
    }
    if (GRID_4_1) {
        translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Right-Middle
    }
    if (GRID_5_1) {
        translate([X_MAX_LENGTH - OFFSET - SIZE, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Right
    }

    /* Grid X2 */
    if (GRID_1_2) {
        translate([OFFSET, (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Left
    }
    if (GRID_2_2) {
        translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Left-Middle
    }
    if (GRID_3_2) {
        translate([(X_MAX_LENGTH / 2) - (SIZE / 2), (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Middle
    }
    if (GRID_4_2) {
        translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Right-Middle
    }
    if (GRID_5_2) {
        translate([X_MAX_LENGTH - OFFSET - SIZE, (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Right
    }

    /* Grid X3 */
    if (GRID_1_3) {
        translate([OFFSET, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Left
    }
    if (GRID_2_3) {
        translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Left-Middle
    }
    if (GRID_3_3) {
        translate([(X_MAX_LENGTH / 2) - (SIZE / 2), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Middle
    }
    if (GRID_4_3) {
        translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Right-Middle
    }
    if (GRID_5_3) {
        translate([X_MAX_LENGTH - OFFSET - SIZE, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Right
    }

    /* Grid X4 */
    if (GRID_1_4) {
        translate([OFFSET, OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Left
    }
    if (GRID_2_4) {
        translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Left-Middle
    }
    if (GRID_3_4) {
        translate([(X_MAX_LENGTH / 2) - (SIZE / 2), OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Middle
    }
    if (GRID_4_4) {
        translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Right-Middle
    }
    if (GRID_5_4) {
        translate([X_MAX_LENGTH - OFFSET - SIZE, OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Right
    }

    if (GRID_1_5) {
        translate([OFFSET, OFFSET, 0]) square(); //Bottom Left
    }
    if (GRID_2_5) {
        translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), OFFSET, 0]) square(); //Bottom Left-Middle
    }
    if (GRID_3_5) {
        translate([(X_MAX_LENGTH / 2) - (SIZE / 2), OFFSET, 0]) square(); //Bottom Middle
    }
    if (GRID_4_5) {
        translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), OFFSET, 0]) square(); //Bottom Right-Middle
    }
    if (GRID_5_5) {
        translate([X_MAX_LENGTH - OFFSET - SIZE, OFFSET, 0]) square(); //Bottom Right
    }
} else if (PRESET == "all") {
    translate([OFFSET, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Left
    translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Left-Middle
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Middle
    translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Right-Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Right

    translate([OFFSET, (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Left
    translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Left-Middle
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Middle
    translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Right-Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, (Y_MAX_LENGTH / 2) + (SIZE / 2) + (  ((Y_MAX_LENGTH - OFFSET - SIZE) - (Y_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), 0]) square(); //Top-Middle Right

    translate([OFFSET, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Left
    translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Left-Middle
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Middle
    translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Right-Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Right

    translate([OFFSET, OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Left
    translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Left-Middle
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Middle
    translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Right-Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, OFFSET + SIZE + (  ((Y_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), 0]) square(); //Bottom-Middle Right

    translate([OFFSET, OFFSET, 0]) square(); //Bottom Left
    translate([OFFSET + SIZE + (  ((X_MAX_LENGTH / 2) - (SIZE / 2) - (OFFSET + SIZE)) / 2 - (SIZE / 2)  ), OFFSET, 0]) square(); //Bottom Left-Middle
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), OFFSET, 0]) square(); //Bottom Middle
    translate([(X_MAX_LENGTH / 2) + (SIZE / 2) + (  ((X_MAX_LENGTH - OFFSET - SIZE) - (X_MAX_LENGTH / 2) - (SIZE / 2)) / 2 - (SIZE / 2)  ), OFFSET, 0]) square(); //Bottom Right-Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, OFFSET, 0]) square(); //Bottom Right
} else if (PRESET == "corners_only") {
    translate([OFFSET, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Left
    translate([X_MAX_LENGTH - OFFSET - SIZE, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Right
    translate([OFFSET, OFFSET, 0]) square(); //Bottom Left
    translate([X_MAX_LENGTH - OFFSET - SIZE, OFFSET, 0]) square(); //Bottom Right
} else if (PRESET == "3x3") {
    translate([OFFSET, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Left
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Top Right

    translate([OFFSET, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Left
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Right

    translate([OFFSET, OFFSET, 0]) square(); //Bottom Left
    translate([(X_MAX_LENGTH / 2) - (SIZE / 2), OFFSET, 0]) square(); //Bottom Middle
    translate([X_MAX_LENGTH - OFFSET - SIZE, OFFSET, 0]) square(); //Bottom Right
}

module square() {
	//Center square
	translate([
				OUTLINE_WIDTH + GAP,
				OUTLINE_WIDTH + GAP,
				0
			])
		cube([SIZE, SIZE, THICKNESS]);

	//Parameter
	difference() {
		//Outer square
		cube([
				SIZE + (2 * (GAP + OUTLINE_WIDTH)),
				SIZE + (2 * (GAP + OUTLINE_WIDTH)),
				THICKNESS
			]);

		//Inner square
		translate([OUTLINE_WIDTH, OUTLINE_WIDTH, -5])
			cube([SIZE + (2 * GAP), SIZE + (2 * GAP), 10]);
	}
}