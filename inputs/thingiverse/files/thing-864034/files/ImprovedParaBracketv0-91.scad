// Improved Parametric Mounting Bracket
// Original by Steve and Jacob Graber (grabercars)
// Modified by Bill Gertz (billgertz) on 4 June 2015
// Version 0.91
//
// Fixed:
// 0.91 - slotConfigOvr mod to virtualize pegboard option into modes
//
// Improved Parametric Mounting Bracket by billgertz is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
// Based on a work at http://www.thingiverse.com/thing:29110.
//
// Code needs refactoring and generally has several hacks, if you wish to fix - enjoy!

slotConfig = 2;        // Configuration settings, integer value from 0-3. See Thingiverse page at http://www.thingiverse.com/thing:864034 for more info.

baseDepth = 2.5;       // Thickness of the base portion of the bracket
baseDiameter = 3.2;    // Diameter of base holes
baseAllowance = 4;     // Minimum distance between the base mounting holes and the edge. (Includes triangulation braces) May be glitchy for slotConfig = 0.
baseDistance = 3;      // Space between inner surface of bracket platform and side of mounting platform. 
                       // Set to zero if your slot height is high enough that the base will not interfere with the mounting bolts' heads.

slotDepth = 2.5;       // Thickness of the slot portion of the bracket.
vSlotLength = 32;      // Length/height of the vertical slot. Only applies to slotConfig = 2,3. 0 is a circular hole.
hSlotLength = 15;      // Length of the horizontal slot. Only applies to slotConfig = 1,3. 0 is a circular hole.
slotDiameter = 3.2;    // Diameter of slot holes
slotAllowance = 4;     // Minimum distance between slot side and any edge/obstruction (See baseDistance)
slotHeight = 4;        // The height off of the bottom of the bracket that the hole starts. Measured from bottom of hole.

supportWidth = 2.5;    // Width of triangular prisms that hold the base to the bracket

//////// Options for base holes, vertical slot supports, pegboard mounting and 1U height ////////

pegBoard = true;       // When true, the base mounting will be fixed for standard (even EU!) pegboard
baseSlot = false;      // If true, the base mounting point will be a slot rather than a double hole
bracketMirror = false; // Change to true if you would like the vertical slot on the other side (Only for slotConfig = 3, 6 and 7)
slotSupport = true;    // Change to true if you would like support to top of vertical slot
rack1U = true;         // Change to true if want a 1U bracket height

//////// Do not edit any of these variables below ////////

inchMetric = 25.4;   // Length of inch in mm
rack1uHeight = 44.4; // height of 1 rack unit equipment in mm

slotConfigOvr = pegBoard ? slotConfig + 4 : slotConfig;  // turn on internal pegboard modes for pegboard
baseSlotOvr = (slotConfigOvr == 0) || (slotConfigOvr == 2) || baseSlot; // override mode 0 and 2 for a base slot. For a perfect hole in mode 0 set:
                                                                        // baseAllowance = slotAllowance

pegBoardBaseLength = inchMetric+2*baseAllowance+2*supportWidth+baseDiameter; // calcualted length for pegboard

slotSupportLength = (slotConfigOvr % 4 > 1) && slotSupport ? vSlotLength : 0;   // set slot support length to full support if option 2,3,6 & 7 and support requested
adjSlotAllowance = rack1U && (slotConfigOvr % 4 > 1) &&
                   (slotHeight+slotDiameter+slotAllowance+slotSupportLength < rack1uHeight) ? 
                       rack1uHeight - (slotHeight+slotDiameter+slotSupportLength) : slotAllowance; // tweak top slot allowance to work out to 1U height if not already bigger than 1U
supportLength = slotHeight+slotDiameter+adjSlotAllowance+slotSupportLength;

baseLength = [2*supportWidth+2*slotAllowance+slotDiameter,               // slotConfig = 0
              2*supportWidth+2*slotAllowance+slotDiameter+hSlotLength,   // slotConfig = 1
              2*supportWidth+2*slotAllowance+slotDiameter,               // slotConfig = 2
              2*supportWidth+3*slotAllowance+2*slotDiameter+hSlotLength, // slotConfig = 3
              pegBoardBaseLength,                                        // slotConfig = 0 and pegBoard
              pegBoardBaseLength,                                        // slotConfig = 1 and pegBoard
              pegBoardBaseLength,                                        // slotConfig = 2 and pegBoard
              pegBoardBaseLength                                         // slotConfig = 3 and pegBoard
             ];

//////// Option checking, add new validation here ////////
// This is an ugly hack, working on a better error reporting mechanism,
//    unfortunately the OpenSCAD laguage itself seems to be a barrier.
//    Somebody prove me wrong, please.
//

optionWarningMode0 = (slotConfig == 0 || slotConfig == 2) && (baseAllowance != slotAllowance); //warn unless perfect hole configured
optionWarningTextMode0 = "Mode 0 or 2 selected - slot option turned on";

optionWarning1u = slotHeight+slotDiameter+slotAllowance+slotSupportLength > rack1uHeight;
optionWarningText1u = "Bracket height greater than 1U - not adjusted downward";

optionWarning1uHeight = rack1U && (slotConfig == 0 || slotConfig == 1);
optionWarningText1uHeight = "Mode 0 and 1 do support 1U height - not adjusted upward";

optionErrorBadMode = (slotConfig < 0) || (slotConfig > 3);
optionErrorTextBadMode = "Bad slot configuration mode, use 0 to 3 only";

optionErrorBaseHole = (baseLength[slotConfigOvr] - 2*(supportWidth+baseDiameter+baseAllowance) < 0) && !baseSlotOvr;
optionErrorTextBaseHole = "Base holes overlap or not enough clearance";

//////////////////

transVal = [
    supportWidth+slotAllowance+slotDiameter/2,
    0,
    supportWidth, 
    baseLength[slotConfigOvr]-(2*slotAllowance+slotDiameter)-supportWidth,
    supportWidth+slotAllowance+slotDiameter+hSlotLength,
    0,
    supportWidth, 
    supportWidth+slotAllowance+slotDiameter+hSlotLength,
    supportWidth+slotAllowance+slotDiameter+hSlotLength
]; // grabercars: Why can't I assign variable values in IF statements? (billgertz: because OpenSCAD is a macro expansion language with limitations)

polyPoi = [
    [0, 0, supportLength], 
    [supportWidth, 0, supportLength], 
    [supportWidth, 0, 0], 
    [0, 0, 0], 
    [0, -(baseDistance+2*baseAllowance+baseDiameter), 0], 
    [supportWidth, -(baseDistance+2*baseAllowance+baseDiameter), 0]
];

polyTri = [[0,3,2], [0,2,1],  [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]; // Thank you OpenSCAD User Manual! <3

//////////////////

module bracketMount(){
	module hSlotPositive(){
		if (slotConfigOvr % 4 == 0){
			cube([baseLength[slotConfigOvr],slotDepth,slotHeight+slotDiameter+slotAllowance]);
		}
		if (slotConfig % 4 != 0 && slotConfig % 4 != 2){
			cube([baseLength[slotConfigOvr],slotDepth,slotHeight+slotDiameter+slotAllowance]);
		} // Well that was boring
		if (slotConfigOvr % 4!= 0 && slotConfigOvr % 4 != 1){
			translate([transVal[slotConfigOvr], 0, 0]) union(){
				cube([2*slotAllowance+slotDiameter, slotDepth, slotHeight+slotDiameter/2+vSlotLength]);
				translate([slotAllowance+slotDiameter/2,slotDepth,slotHeight+slotDiameter/2+vSlotLength])
					rotate([90,0,0])
						cylinder(r=(slotAllowance+slotDiameter/2), h=slotDepth, $fn=20);
			}
			cube([baseLength[slotConfigOvr],slotDepth,supportLength]);
		} // If I said this unit wasn't partially guessing stuff I would be lying
	}
	module hSlotNegative(){
		if (slotConfigOvr % 4 == 0){
			translate([transVal[slotConfigOvr],slotDepth+1,slotHeight+slotDiameter/2])
			rotate([90,0,0]) 
				cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
		}
		if (slotConfigOvr % 4 != 0 && slotConfigOvr % 4 != 2){
			translate([slotAllowance+supportWidth+slotDiameter/2,slotDepth+1,slotHeight+slotDiameter/2])
			rotate([90,0,0]) 
				hull(){
					cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
					translate([hSlotLength,0,0])
						cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
				} // Hooray hulls! Making my life that much easier.
		}
		if (slotConfigOvr % 4 != 0 && slotConfigOvr % 4 != 1){
			translate([transVal[slotConfigOvr]+slotAllowance+slotDiameter/2,slotDepth+1,slotHeight+slotDiameter/2])
			rotate([90,0,0]) 
				hull(){
					cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
					translate([0,vSlotLength,0])
						cylinder(r=slotDiameter/2, h=slotDepth+2, $fn=10);
				}
		}
	}
	difference(){
		hSlotPositive();
		hSlotNegative();
	}
}

module triangularSupport(){
    polyhedron (points = polyPoi, triangles = polyTri);
    translate([baseLength[slotConfigOvr]-supportWidth,0,0])
        polyhedron (points = polyPoi, triangles = polyTri);
}

module baseMount(){
	module positiveBase(){
		translate([0,-baseDistance,0]) mirror([0,1,0])
			cube([baseLength[slotConfigOvr], 2*baseAllowance+baseDiameter, baseDepth]);
	}
	module negativeBase(){
		if (baseSlotOvr){
			translate([baseAllowance+supportWidth+baseDiameter/2,-baseDistance-baseAllowance-baseDiameter/2,-1]) hull(){
				cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
				translate([baseLength[slotConfigOvr]-2*baseAllowance-2*supportWidth-baseDiameter,0,0])
					cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
			}
		} else {
			translate([baseAllowance+supportWidth+baseDiameter/2,-baseDistance-baseAllowance-baseDiameter/2,-1]) union(){
				cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
				translate([baseLength[slotConfigOvr]-2*baseAllowance-2*supportWidth-baseDiameter,0,0])
					cylinder(r=baseDiameter/2, h=baseDepth+2, $fn=10);
			}
		}
	}
	difference(){
		positiveBase();
		negativeBase();
	}
}

if (optionErrorBadMode){
    echo(str("ERROR - ", optionErrorTextBadMode, " NO OBJECT GENERATED"));
} else {
    if (optionErrorBaseHole){
       echo(str("ERROR - ", optionErrorTextBaseHole, " NO OBJECT GENERATED"));
    } else { 
        if (optionWarning1u){ echo(str("WARNING - ", optionWarningText1u)); };
        if (optionWarning1uHeight){ echo(str("WARNING - ", optionWarningText1uHeight)); };
        if (optionWarningMode0){ echo(str("WARNING - ", optionWarningTextMode0)); };
    
        if (bracketMirror){
            mirror([1,0,0]){
                bracketMount();
                triangularSupport();
                baseMount();
            }
        } else {
            bracketMount();
            triangularSupport();
            baseMount();
        }
        
    }
    
}