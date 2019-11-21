/* 
   Parametric Lego Brick
   Andrew Sweet, 2014
   Feel free to use my design,
	credit is appreciated where appropriate

   If you choose to alter this code, please keep this
	top comment in all further iterations :)

   Modified to be able to print birthday cards (or other
   similar objects) by Andreas Ehliar.
*/

/* Parameters */


// This is the number of studs in one column of the birthday card
numCols = 18; // [10:30]

// This is the number of studs in one row of the birthday card
numRows = 10; // [6:30]

// This is the number of studs on the left and right side of the birthday card. 2 to 4 are typically good values.
studsOnSide = 2; // [0:8] 

// This is the number of studs on the top and bottom side of the birthday card. 1 or 2 are typically good values.
studsOnTop = 1; // [0:8] 

// 1/3 and 1 are the two standard heights. You should probably leave this at 1/3.
height = 1/3; // [0.33333333, 1]

// Multiples of 2 of each other can fit into each other. You should probably leave this at 1.
brickScale = 1; // [1, 2, 4, 0.5, 0.25]

// Number of text lines
numberOfTextLines = 2; // [1, 2, 3]

// Text on first line
textLine1 = "HAPPY";

// Text on second line
textLine2 = "BIRTHDAY";

// Text on third line
textLine3 = "";

// Fontsize
fontSize = 17; // [5:40]

// Font selection from Google Fonts which works well with the Customizer. For other fonts, you'll need to download the file yourself.
fontName = "Luckiest Guy"; // [Oswald, Bitter, Indie Flower, Lobster, Abril Fatface, Bree Serif, Righteous, Teko, Courgette, Satisfy, Caveat, Luckiest Guy, Tangerine, Bangers, Notable, Fugaz One, Knewave]
  
// The higher the number, the smoother the curves.
curveFidelity = 40; // [10:100]

/* End Parameters */

// See comments below if you want to modify the font!


/* Lego Dimensions courtesy of:

http://www.robertcailliau.eu/Lego/Dimensions/zMeasurements-en.xhtml

and

http://static2.wikia.nocookie.net/__cb20130331204917/legomessageboards/images/3/3c/Lego_brick_2x4.png

*/

/* [Hidden] */

// Brick Dimensions
brickHeightDim = 9.6; // toBeScaled

brickUnit = 8.0;

dWidth = 0.2;
brickWidth = ((brickUnit * numCols) - dWidth) * brickScale;
brickDepth = ((brickUnit * numRows)  - dWidth) * brickScale;

brickHeight = (height * brickHeightDim) * brickScale;

shellThicknessTop = 1.0 * brickScale;
shellThicknessSides = 1.2 * brickScale;

// UnderPeg
uPegMaxRadius = 6.51 * brickScale/2;
uPegMinRadius = 4.8 * brickScale/2;
uPegOffset    = (brickUnit - 0.1) * brickScale;
uPegHeight    = brickHeight - shellThicknessTop;

// Pegs
tempDistance = 2.4 + 1.6; // To be scaled
pegOffset    = (tempDistance - 0.1) * brickScale;
tempRadius   = 4.8 / 2.0;
pegDistance  = brickUnit * brickScale;

pegRadius   = tempRadius * brickScale;
pegHeight   = 1.8 * brickScale;

// KnobHolders (small rectangular protrusions underneath)
khWidth  = 0.6 * brickScale;
khDepth  = 0.3 * brickScale;
khOffset = shellThicknessSides + khDepth + pegRadius+ (0.1 * brickScale);



// Create the Brick

difference()
{
  cube([brickWidth, brickDepth, brickHeight]);

  translate([shellThicknessSides, 
	     shellThicknessSides,
	     -1])
    cube([brickWidth - (shellThicknessSides * 2), 
	  brickDepth - (shellThicknessSides * 2), 
	  brickHeight - shellThicknessTop + 1]);
}

if (numCols > 1 && numRows > 1){
  /* Add Interior */
  for (row = [1:(numCols - 1)]){
    for (col = [1:(numRows - 1)]){

      // Cylinders
      translate([uPegOffset + (pegDistance * (row - 1)),
		 uPegOffset + (pegDistance * (col-1)),
		 0])	
	render()
	difference()
	{
	  cylinder(h=uPegHeight, 
		   r1=uPegMaxRadius, 
		   r2=uPegMaxRadius, $fn=curveFidelity);
	  translate([0,0,-1])	
	    cylinder(h=uPegHeight+0.999, 
		     r1=uPegMinRadius, 
		     r2=uPegMinRadius, $fn=curveFidelity);
	}
    }
  }
 } else {
  assign (rad = (pegDistance - (pegRadius * 2))/2 - (0.1 * brickScale))
    {
      if (numCols > 1){

	for (row = [1:(numCols - 1)]){
	  translate(
		    [uPegOffset + (pegDistance * (row - 1)),
		     (brickUnit * brickScale)/2,
		     0])	
	    render()
	    cylinder(h=uPegHeight, 
		     r1=rad, 
		     r2=rad, $fn=curveFidelity);
	}

      } else if (numRows > 1){
	for (col = [1:(numRows - 1)]){
	  translate(
		    [(brickUnit * brickScale)/2,
		     uPegOffset + (pegDistance * (col - 1)),
		     0])	
	    render()
	    cylinder(h=uPegHeight, 
		     r1=rad, 
		     r2=rad, $fn=curveFidelity);
	}
      }
    }
 }

// KnobHolders (underneath)
if (numCols > 1 && numRows > 1){
  for (row = [0:(numCols - 1)]){
    translate([khOffset + (pegDistance * row),
	       shellThicknessSides,
	       0])
      cube([khWidth, khDepth, uPegHeight]);

    translate([khOffset + (pegDistance * row),
	       (numRows * (brickUnit * brickScale)) - shellThicknessSides - khDepth - (0.2 * brickScale),
	       0])	
      cube([khWidth, khDepth, uPegHeight]);
  }

  for (col = [0:(numRows - 1)]){
    translate([shellThicknessSides,
	       khOffset + (pegDistance * col),
	       0])	
      cube([khDepth, khWidth, uPegHeight]);

    translate([(numCols * (brickUnit * brickScale)) - shellThicknessSides - khDepth - (0.2 * brickScale),
	       khOffset + (pegDistance * col),
	       0])	
      cube([khDepth, khWidth, uPegHeight]);
  }
 }



// Create the Pegs
for (row = [0:(numCols - 1)]){
  for (col = [0:(numRows - 1)]){
    if((row < studsOnSide) || (row > numCols - studsOnSide - 1) ||
       (col < studsOnTop) || (col > numRows - studsOnTop - 1))
      translate([pegOffset + (pegDistance * row),
		 pegOffset + (pegDistance * col),
		 brickHeight])	
	render()
	cylinder(h=pegHeight, 
		 r1=pegRadius, 
		 r2=pegRadius, $fn=curveFidelity);
  }
 }

brickDepthNoStuds = brickDepth * (numRows - studsOnTop * 2) / numRows;

lineOneOffset = numberOfTextLines == 1 ? brickDepth / 2 :
  (numberOfTextLines == 2 ? brickDepth / 2 + brickDepthNoStuds / 4 :
   brickDepth / 2 + brickDepthNoStuds / 6 * 2);

   
lineTwoOffset = (numberOfTextLines == 2) ? brickDepth / 2 - brickDepthNoStuds / 4:
   brickDepth / 2;
  
lineThreeOffset = brickDepth / 2 - brickDepthNoStuds / 6 * 2;


translate([brickWidth/2, lineOneOffset ,brickHeight-0.2]){
  linear_extrude(1+0.2){
    text(textLine1, font=fontName, size=fontSize, halign="center", valign="center", $fn=curveFidelity);
  }
}

if (numberOfTextLines >= 2) {
  translate([brickWidth/2, lineTwoOffset, brickHeight-0.2]){
    linear_extrude(1+0.2){
      text(textLine2, font=fontName, size=fontSize, halign="center", valign="center", $fn=curveFidelity);
    }
  }
}

if (numberOfTextLines >= 3) {
  translate([brickWidth/2, lineThreeOffset, brickHeight-0.2]){
    linear_extrude(1+0.2){
      text(textLine3, font=fontName, size=fontSize, halign="center", valign="center", $fn=curveFidelity);
    }
  }
}
