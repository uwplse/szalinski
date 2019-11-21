showLid = true;
showBox = true;
showPCB = true;
arrangeForPrinting = false;
pcbExploded = 10;
lidExploded = 20;

// the board
pcbWidth = 26;
pcbLength = 54;
pcbThickness = 1.4;
pcbCornerRadius = 2;
pcbHolesFromCorners = 2.25;
pcbHoleDiameter = 2.5;

// board features
buttonPositions = [[10, 6]];
buttonHeight = 2.5;
screenGeometry = [14, 3, 35, 21, 4.1]; // x, y, length, width, z-height above the board of the whole screen block
screenFrameGeometry = [20, 8, 23, 14]; // x, y, length, width
usbLeftY = 7;
usbWidth = 12;
usbHeight = 7;
otherUpwardCutouts = [[7, 9, 7, 8]]; // x, y, length, width: this one is for the DIP switches

boxInnerHeight = 10;
boxRadius = 2.5;
pcbClearances = [1, 1, 1, 3]; // space between the box and the PCB: left, right, bottom, top
pcbFitClearance = 0.25; // adjust for your printer in case inner-hole sizes are too small and the PCB won't fit
pcbHolderExtraHeight = 1; // corner bosses stick up this much higher than the PCB
wallThickness = 1.7;
lipPcbOverlap = 1;	// How much of the edge of the PCB the lips should cover
lipClearance = 0.35;	// How much to inset lips for looser fit
$fn=12;

// -----------------------------------------
boxLength = pcbLength + wallThickness * 2 + pcbClearances[0] + pcbClearances[1];
boxWidth = pcbWidth + wallThickness * 2 + pcbClearances[2] + pcbClearances[3];
boxHeight = boxInnerHeight + wallThickness;
boxBottomToPcbTop = boxHeight - screenGeometry[4];
cornerStrutMinSize = pcbHolesFromCorners + pcbHoleDiameter;
lipHeight = boxHeight - boxBottomToPcbTop; // rails on the underside of the lid holding it in the box

module quad(length, width) {
	children([0:$children-1]);
	translate([length, 0, 0])
		children([0:$children-1]);
	translate([length, width, 0])
		children([0:$children-1]);
	translate([0, width, 0])
		children([0:$children-1]);
}

module roundCornersCube(dims, r=1, centerXY=false)
{
	translate(centerXY ? [dims[0] / -2, dims[1] / -2, 0] : [0,0,0])
	union() {
		translate([0, r, 0])
			cube([dims[0], dims[1] - r * 2, dims[2]]);
		translate([r, 0, 0])
			cube([dims[0] - r * 2, dims[1], dims[2]]);
		translate([r, r, 0])
			quad(dims[0] - r * 2, dims[1] - r * 2)
				cylinder(r = r, h = dims[2]);
	}
}

module dummyPCB(){
    translate([0,0,pcbExploded - pcbThickness]) difference() {
		union(){
			color ("green") roundCornersCube([pcbLength,pcbWidth,pcbThickness], pcbCornerRadius);
			color ("lightgray") translate([screenGeometry[0],screenGeometry[1],pcbThickness]) cube([screenGeometry[2],screenGeometry[3],screenGeometry[4]]);
			color ("gray") translate([screenFrameGeometry[0],screenFrameGeometry[1],pcbThickness]) cube([screenFrameGeometry[2],screenFrameGeometry[3],screenGeometry[4] + 0.01]);

			for (buttonPosition = buttonPositions) {
				translate([buttonPosition[0],buttonPosition[1],pcbThickness]) {
					translate([0, 0, buttonHeight / 4])
						color("lightgray") cube([3, 5, buttonHeight / 2], center=true);
					color("white") roundCornersCube([2,3,buttonHeight],1, centerXY=true);
				}
			}

			for (cutoutGeom = otherUpwardCutouts) {
				translate([cutoutGeom[0],cutoutGeom[1],pcbThickness])
					color("black") cube([cutoutGeom[2], cutoutGeom[3], screenGeometry[4]]);
			}
		}
		translate([pcbHolesFromCorners, pcbHolesFromCorners, 0])
			quad(pcbLength - pcbHolesFromCorners * 2, pcbWidth - pcbHolesFromCorners * 2)
				cylinder(d=pcbHoleDiameter, h=pcbThickness + 0.2);
	}
}

module buttonTabCutout(buttonPos, label) {
	z = wallThickness + 2;
	width = 7;
	length = 8;
	gap = 1;
	fontHeight = 4;
	difference() {
		union() {
			translate([buttonPos[0] - length, buttonPos[1] - width / 2, -1]) cube([length, width, z]);
			translate([buttonPos[0], buttonPos[1], -1]) cylinder(d=width, h=z);
		}
		union() {
			translate([buttonPos[0] - length, buttonPos[1] - width / 2 + gap, -1]) cube([length, width - gap * 2, z]);
			translate([buttonPos[0], buttonPos[1], -1]) cylinder(d=width - gap * 2, h=z);
		}
	}
	translate([buttonPos[0], buttonPos[1], wallThickness - 0.5])
		linear_extrude(wallThickness + 1) color("black")
			text(label, font = "Liberation Sans:style=Bold", fontHeight, halign = "center", valign="center");
}

module box() {
	difference() {
		translate([-wallThickness - pcbClearances[0], -wallThickness - pcbClearances[2], -boxBottomToPcbTop])
			union() {
				difference() {
					roundCornersCube([boxLength, boxWidth, boxHeight], boxRadius);
					translate([wallThickness, wallThickness, wallThickness])
						roundCornersCube([boxLength - wallThickness * 2,boxWidth - wallThickness * 2,boxHeight], boxRadius - wallThickness / 2);
				}
				translate([wallThickness / 2, wallThickness / 2, 0]) {
					roundCornersCube([cornerStrutMinSize + pcbClearances[0], cornerStrutMinSize + pcbClearances[2],
						boxBottomToPcbTop + pcbHolderExtraHeight], pcbHoleDiameter / 2);
					translate([boxLength - wallThickness - cornerStrutMinSize - pcbClearances[1], 0, 0])
						roundCornersCube([cornerStrutMinSize + pcbClearances[1], cornerStrutMinSize + pcbClearances[2],
							boxBottomToPcbTop + pcbHolderExtraHeight], pcbHoleDiameter / 2);
					translate([boxLength - wallThickness - cornerStrutMinSize - pcbClearances[1],
							   boxWidth - wallThickness - cornerStrutMinSize - pcbClearances[3], 0])
						roundCornersCube([cornerStrutMinSize + pcbClearances[1], cornerStrutMinSize + pcbClearances[3],
							boxBottomToPcbTop + pcbHolderExtraHeight], pcbHoleDiameter / 2);
					translate([0, boxWidth - wallThickness - cornerStrutMinSize - pcbClearances[3], 0])
						roundCornersCube([cornerStrutMinSize + pcbClearances[0], cornerStrutMinSize + pcbClearances[3],
							boxBottomToPcbTop + pcbHolderExtraHeight], pcbHoleDiameter / 2);
				}
			}
		// cut out the board footprint from the corner holders
		translate([-pcbFitClearance, -pcbFitClearance, -pcbThickness])
			roundCornersCube([pcbLength + pcbFitClearance * 2, pcbWidth + pcbFitClearance * 2, pcbThickness + pcbHolderExtraHeight + 1], pcbCornerRadius);
		// cut out around the USB jack
		translate([-1 - pcbClearances[0] - wallThickness, usbLeftY, usbHeight - (usbHeight - 3) / 2])
			rotate([0, 90, 0])
				roundCornersCube([usbHeight, usbWidth, wallThickness + 2], 1);
	}
}

module lid(exploded = lidExploded) {
	translate([0, 0, exploded + boxHeight - boxBottomToPcbTop]) {
		union() {
			difference() {
				translate([-wallThickness - pcbClearances[0], -wallThickness - pcbClearances[2], 0]) {
					union() {
						roundCornersCube([boxLength, boxWidth, wallThickness], boxRadius);
						lipX = wallThickness + cornerStrutMinSize + pcbClearances[0];
						translate([lipX, wallThickness + lipClearance, -lipHeight])
							cube([boxLength - lipX - wallThickness - cornerStrutMinSize - pcbClearances[1],
							      lipPcbOverlap + pcbClearances[2], lipHeight]);
						lipWidth = lipPcbOverlap + pcbClearances[3];
						translate([lipX, boxWidth - wallThickness - lipWidth - lipClearance, -lipHeight])
							cube([boxLength - lipX - wallThickness - cornerStrutMinSize - pcbClearances[1],
							      lipWidth, lipHeight]);
					}
				}
				translate([screenFrameGeometry[0], screenFrameGeometry[1], -1])
					cube([screenFrameGeometry[2], screenFrameGeometry[3], wallThickness + 2]);
				for (buttonPosition = buttonPositions)
					buttonTabCutout(buttonPosition, "");
				for (cutoutGeom = otherUpwardCutouts)
					translate([cutoutGeom[0],cutoutGeom[1],-1])
						cube([cutoutGeom[2], cutoutGeom[3], wallThickness + 2]);
			}
			for (buttonPosition = buttonPositions)
				translate([buttonPosition[0], buttonPosition[1], buttonHeight - screenGeometry[4]])
					cylinder(d=4, h=screenGeometry[4] - buttonHeight);
		}
	}
}

if (showLid) {
	if (arrangeForPrinting) {
		translate([0, -wallThickness * 2 - pcbClearances[3], boxHeight - boxBottomToPcbTop + wallThickness])
		rotate([180, 0, 0])
			lid(0);
	} else {
		lid();
	}
}
if (showBox) {
	if (arrangeForPrinting) {
		translate([0, 0, boxBottomToPcbTop])
			box();
	} else {
		box();
	}
}
if (showPCB && !arrangeForPrinting) {
    dummyPCB();
}
