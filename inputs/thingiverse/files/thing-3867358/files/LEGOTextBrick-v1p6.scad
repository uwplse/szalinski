/* LEGO Text Bricks
   by Lyl3

Create LEGO compatible bricks with text engraved on the sides

This code is published at:
https://www.thingiverse.com/thing:3867358
licensed under the Creative Commons - Attribution - Share Alike license (CC BY-SA 3.0)

V0.1 - working code
V0.2 - corrected brick dimensions to have 0.1 mm play on each side
       corrected stud height to be 1.8 mm instead of 1.6 mm
       corrected roof thickness to be 1.0 mm instead of 1.6 mm
V0.3 - cleaned the code
V0.4 - adjusted wall thickness from 1.6 mm to 1.4 mm
       fixed math for stud positions
       fixed math for play so that it's split between sides instead of on just one side
V0.5 - added tolerance parameter
V0.6 - corrected position of text to account for play and tolerance
V0.7 - set sane ranges for all parameters
V1.0 - adjusted diameter of under-stud from 6.51 to 6.41
       adjusted width of walls from 1.4 mm to 1.5 mm
       ready for release
V1.1 - changed boolean parameters to yes/no parameters to make them Thingiverse Customizer-friendly
V1.2 - allowed $fn to be adjusted from previous hard-coded value of 100
V1.3 - allow text Z shift to be negative 
V1.4 - added parameter for spacing between letters
V1.5 - moved studs down 0.00001 mm so that the brick and studs are a single mesh
V1.6 - bug fix: parameter for spacing between letters now applied to text on back,left and right sides
     - allowed LEGO dimensions to be overridden
*/

/*
   Set default brick to be #2456 6x2 
*/
/* [Brick Parameters] */

// Brick length (specified in number of studs).
brickLength = 6; // [1:1:48]

// Brick width (specified in number of studs).
brickWidth = 2;  // [1:1:48]

// Brick height (specified in LEGO height units: 3 is normal brick height, 1 is plate height).
brickHeight = 3; // [1:1:18]

// Studs on top of the brick?
withStuds = "yes"; // [yes,no]
createStuds = (withStuds=="yes") ? true : false;

// Under-studs on underneath of skinny bricks? Skinny bricks that are only one unit wide have smaller solid cylinders (under-studs) underneath instead of the usual hollow cylinders. These have a tiny footprint and may not stick to the build-plate, so you may want to avoid printing them.
withUnderStuds = "no"; // [yes,no]
createUnderStuds = (withUnderStuds=="yes") ? true : false;


/* [Text Parameters] */

frontText = "Text Bricks";
frontTextScale = 1.0; // [0:0.01:1]

backText = "";
backTextScale = 1.0; // [0:0.01:1]

leftText = ""; 
leftTextScale = 1.0; // [0:0.01:1]

rightText = ""; 
rightTextScale = 1.0; // [0:0.01:1]

/* [Advanced parameters] */

// Tolerance to account for 3D printing inaccuracies (mm). This decreases the sizes of all vertical surfaces (brick walls, studs, under-tubes, and under-studs) to provide a better fit. It is equivalent to a negative horizontal expansion setting in the Cura slicer. You might want to decrease this for bricks that are only 1 unit wide without under-studs as they will be naturally looser fitting than other bricks. The best setting is printer/filament dependent so I've set the default for my printer on the assumption that it's average. 
tolerance = 0.05; // [0:0.01:0.1]

// Some suitable fonts
//fontName = "Arial Black:style=Regular";    // Not available on Thingiverse customizer
//fontName = "Biryani:style=Black";          // Has short numbers
//fontName = "Heebo:style=Black";            // Has tight kerning
//fontName = "Maven Pro:style=Black";        // Has tight spacing on "g"
//fontName = "Nunito Sans:style=Black";      // Has tight kerning
//fontName = "Orbitron:style=Black";         // Has blocky letters
//fontName = "Palanquin Dark:style=Bold";    // Has descended numbers
//fontName = "Raleway:style=Black";          // Has descended numbers
//fontName = "Roboto:style=Black";           // No issues
//fontName = "Yantramanav:style=Black";      // No issues

// Choose from a small selection of similar fonts that should work well in this application.
fontName = "Roboto:style=Black"; // ["Arial Black:style=Regular", "Biryani:style=Black", "Heebo:style=Black", "Maven Pro:style=Black", "Nunito Sans:style=Black", "Orbitron:style=Black", "Palanquin Dark:style=Bold", "Raleway:style=Black", "Roboto:style=Black", "Yantramanav:style=Black"]

// The base size of the text on all sides (can be scaled down in the text parameters section).
textSize = 5.5; // [1:0.1:10]

// Spacing between letters. (ratio: 1 is normal spacing of the font) It's better to have this a little higher for this application.
letterSpacing = 1.05;  // [0.9:0.01:2.0]

// How much to shift the text in the Z dimension (mm).
textZShift = 2.0;         // [-5:0.1:8]

// The depth of the text (mm). You should probably decrease this from the default of 0.8 if you plan on scaling the model up in your slicer.
textDepth = 0.8;  // [0.2:0.01:1.0]

// Resolution of circles. 50 fragments is more than enough for such a small cylinders unless the model will be later scaled up
numberFragments = 50;                 // [6:1:100] 
$fn = numberFragments;

/* [Advanced parameters: Override LEGO dimensions] */

// X and Y dimension of one brick unit (mm)
UNIT_LENGTH = 8; // [0.8:0.01:80]

// plate height (a standard brick is 3 times this height) (mm)
PLATE_HEIGHT = 3.2; // [0.32:0.01:32]

// thickness of brick roof (mm)
ROOF_THICKNESS = 1; // [0.1:0.01:10]

// thickness of brick outer wall as in the original 1.5 mm wall without nubs (mm)
WALL_THICKNESS = 1.5; // [0.15:0.01:15]

// diameter of the studs (solid cylinders) on top of a brick (mm)
STUD_DIAMETER = 4.8; // [0.48:0.01:48]

// height of the studs (solid cylinders) on top of a brick (mm)
STUD_HEIGHT = 1.8; // [0.18:0.01:18]

// outer diameter of the under-tubes (hollow cylinders) on the underside of bricks with length > 1 and width > 1 (mm)
UNDERTUBE_OUTER_DIAMETER = 6.41; // [0.64:0.01:64.1]

// inner diameter of the under-tubes (hollow cylinders) on the underside of bricks with length > 1 and width > 1 (mm)
UNDERTUBE_INNER_DIAMETER = 4.8; // [0.48:0.01:48]

// diameter of the under-studs (solid cylinders) on the underside of bricks with length = 1 or width = 1 (mm)
UNDERSTUD_DIAMETER = 1.6; // [0.16:0.01:16]

// the necessary play between bricks so that they fit together
PLAY = 0.2; // [0.02:0.01:2]

/* [Hidden] */
fudge = 0.01;               // Amount to expand some dimensions to ensure manifold model

difference() {
  translate([-brickLength/2*UNIT_LENGTH, -brickWidth/2*UNIT_LENGTH, 0])
    brick (brickLength, brickWidth, brickHeight);
  translate([0, -brickWidth/2*UNIT_LENGTH+textDepth+PLAY/2+tolerance, textZShift]) rotate([90, 0, 0])
    linear_extrude(textDepth+fudge) text(frontText, font=fontName, size=textSize*frontTextScale, halign="center", spacing=letterSpacing);
  translate([0, brickWidth/2*UNIT_LENGTH-textDepth-PLAY/2-tolerance, textZShift]) rotate([90, 0, 180])
    linear_extrude(textDepth+fudge) text(backText, font=fontName, size=textSize*backTextScale, halign="center", spacing=letterSpacing);
  translate([-brickLength/2*UNIT_LENGTH+textDepth+PLAY/2+tolerance, 0, textZShift]) rotate([90, 0, 270])
    linear_extrude(textDepth+fudge) text(leftText, font=fontName, size=textSize*leftTextScale, halign="center", spacing=letterSpacing);
  translate([brickLength/2*UNIT_LENGTH-textDepth-PLAY/2-tolerance, 0, textZShift]) rotate([90, 0, 90])
    linear_extrude(textDepth+fudge) text(rightText, font=fontName, size=textSize*rightTextScale, halign="center", spacing=letterSpacing);
}

/*
   Module to make a simple rectangular LEGO compatible brick
   Makes a #3001 4x2 brick by default
*/
module brick(length=4, width=2, height=3) {

  // The brick
  translate([PLAY/2+tolerance, PLAY/2+tolerance, 0])
    difference() {
      cube([length*UNIT_LENGTH-PLAY-2*tolerance, width*UNIT_LENGTH-PLAY-2*tolerance, height*PLATE_HEIGHT]);
      translate([WALL_THICKNESS-2*tolerance, WALL_THICKNESS-2*tolerance, -ROOF_THICKNESS])
        cube([length*UNIT_LENGTH-2*WALL_THICKNESS-PLAY+2*tolerance, width*UNIT_LENGTH-2*WALL_THICKNESS-PLAY+2*tolerance, height*PLATE_HEIGHT]);
    }

  // The studs
  if(createStuds) {
    translate([0,0, height*PLATE_HEIGHT-0.00001])
      for (y = [0:width-1]) {
        for (x = [0:length-1]) {
          translate([(x+0.5)*UNIT_LENGTH, (y+0.5)*UNIT_LENGTH, 0])
            cylinder(h=STUD_HEIGHT, d=STUD_DIAMETER-2*tolerance);
        }
      }
  }

  // The under-tubes (hollow cylinders)
  if (width > 1 && length > 1) {
    for (y = [1:width-1]) {
      for (x = [1:length-1]) {
        difference() {
		  translate([x*UNIT_LENGTH, y*UNIT_LENGTH, 0])
			cylinder(h=height*PLATE_HEIGHT-ROOF_THICKNESS+fudge, d = UNDERTUBE_OUTER_DIAMETER-2*tolerance);
		  translate([x*UNIT_LENGTH, y*UNIT_LENGTH, -fudge])
			cylinder(h=height*PLATE_HEIGHT-ROOF_THICKNESS+fudge, d = UNDERTUBE_INNER_DIAMETER+2*tolerance);				
		}
	  }
	}
  }

  // The under-studs (smaller solid cylinders) along the length
  if (width == 1 && length > 1 && createUnderStuds) {	
	for (x = [1:length-1]) {
	  translate([x*UNIT_LENGTH, 0.5*UNIT_LENGTH, 0])
	    cylinder(h=height*PLATE_HEIGHT-WALL_THICKNESS, d=UNDERSTUD_DIAMETER-2*tolerance);
	}
  }

  // The under-studs (smaller solid cylinders) along the width
  if (length == 1 && width > 1 && createUnderStuds) {	
	for (y = [1:width-1]) {
	  translate([0.5*UNIT_LENGTH, y*UNIT_LENGTH, 0])
		cylinder(h=height*PLATE_HEIGHT-WALL_THICKNESS, d=UNDERSTUD_DIAMETER-2*tolerance);
	}
  }

}
	