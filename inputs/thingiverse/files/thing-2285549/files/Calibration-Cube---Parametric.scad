// Calibration Cube - Parametric v1.0
//	 Author:	KatTrue (Thingiverse)
//	 Date:		4/30/2017
//
//	This OpenSCAD program creates a user definable sized
//	calibration cube.
//
//	- The X, Y, and Z axis are user definably labeled.
//
//	- Size is printed on one side.  The calibration cube 
//	supports both metric and imperial/SAE units of measure.
//
//	- Infill Percentage is printed on one side.  The Infill 
//	Percentage is only included on the calibration cube for 
//	reference.  The infill percentage is set in the slicer.
//
//	- Due to OpenSCAD font limitations the font will get smaller 
//	in relation to the overall size once 380" is exceeded.

/* [Hidden] */
inchConv = 0.79375; // 1/32" in mm
textSizeMult = 4; // Text Size Multiplier
textSizeThreshold = 1544; // Text size to stop scaling text

/* [Configuration ] */
// Dimension Length in Unit of Measure
size = 20; // [1:1000]
// Infill Percentage (Label Only)
infillPct = 10;
// Unit of Measure
unitOfMeasure = 0; // [0:mm,1:1/32in.,2:1/16in.,3:1/8in.,4:1/4in.,5:1/2in.,6:in.]

/* [Text] */
// X Axis Label
xText = "<- X ->";
// Y Axis Label
yText = "<- Y ->";
// Z Axis Label
zText = "<- Z ->";
// Text Font
textFont = "Tahoma";

sizeXYZ = unitOfMeasure ? size * (inchConv * pow(2,unitOfMeasure-1)) : size;
SAEText = unitOfMeasure == 6 ? "\"" : str("/",32/pow(2,unitOfMeasure-1),"\"");
sizeText = unitOfMeasure ? str(round(size),SAEText) : str(sizeXYZ, "mm");
infillText = str(infillPct, "%");
textHeight = sizeXYZ / 25;
textSize = textSizeMult * textHeight > textSizeThreshold ? textSizeThreshold : textSizeMult * textHeight;

translate([0,0,sizeXYZ/2])
	difference()
	{
		cube (size = sizeXYZ, center=true);
		union()
		{
			translate([0,0,(sizeXYZ-textHeight)/2])
				linear_extrude(textHeight)
					text(xText, size=textSize, font=textFont, valign="center", halign="center");
			translate([(sizeXYZ-textHeight)/2,0,0])
				rotate([90,0,90])
					linear_extrude(textHeight)
						text(yText, size=textSize, font=textFont, valign="center", halign="center");
			translate([-(sizeXYZ-textHeight)/2,0,0])
				rotate([90,0,-90])
					linear_extrude(textHeight)
						text(sizeText, size=textSize, font=textFont, valign="center", halign="center");
			translate([0,-(sizeXYZ-textHeight)/2,0])
				rotate([90,-90,0])
					linear_extrude(textHeight)
						text(zText, size=textSize, font=textFont, valign="center", halign="center");
			translate([0,(sizeXYZ-textHeight)/2,0])
				rotate([90,0,180])
					linear_extrude(textHeight)
						text(infillText, size=textSize, font=textFont, valign="center", halign="center");
		} // End union()
	} //End difference()