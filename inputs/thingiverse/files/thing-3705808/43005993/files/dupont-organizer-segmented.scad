include <MCAD/units.scad>

/* [Common] */

// Part to draw
part = "plate"; // [comb:Comb Only,bridge:Bridge Only,plate:Build Plate]
// Bridge segment to draw
bridgeSegment = -1; // [-1:All segments,0:First segment,1:Second segment, 2:Third segment, 3:Fourth segment]
// Length of the cables, excluding header connectors
cableLength = 156;
// Number of cable slots
numCables = 10;
// Number of bridge segment splits
numBridgeSegments = 2;
// Space between parts on the built plate
itemSpacing = 2;

/* [Comb] */

// Thickness of the comb part
combThickness = 4;
// Width of the comb part and thickness of the bridge part
combBaseWidth = 4;
// Length of a tooth
combToothLength = 14;
// Width of a tooth
combToothWidth = 1.2;
// Length of the top part of a tooth
combSharpLength = 1.1;
// Length of the bump part of a tooth
toothBumpLength = 3.4;
// Thickness of the bump part of a tooth
toothBumpThickness = 0.7;
// Space between teeth
combToothSpacing = 2.2;

/* [Bridge] */

// Width of the bridge part
bridgeWidth = 35.2;
// Margin between the outer bridge border and the center hole
bridgeHoleMargin = 4;

/* [Join] */

// Length to subtract from the total bridge length per join (to compensate for imperfect fits)
joinSubtractLength = 0.2;
// Width of the joining hole
joinHoleWidth = 10.2;
// Length (depth) of the joining hole
joinHoleLength = 8.1;
// Width of the joining peg on the comb (printed vertically)
joinCombPegWidth = 10.2;
// Width of the joining peg on the bridge (printed horizontally)
joinBridgePegWidth = 10;
// Length of the joining peg
joinPegLength = 8;

/* [Hidden] */

combLength = (numCables + 1) * combToothWidth + numCables * combToothSpacing;
combSpacing = combBaseWidth + combToothLength + combSharpLength + itemSpacing;
bridgeLength = (cableLength - combThickness * 2 - (1 + numBridgeSegments) * joinSubtractLength) / numBridgeSegments;
bridgeSpacing = bridgeWidth + itemSpacing;

$fn = 60;

module CombTooth(bumps = [0,1]) {
    linear_extrude(combThickness)
    polygon([
        [0, 0], 
        [0, combToothLength],
        [combToothWidth / 2, combToothLength + combSharpLength],
        [combToothWidth, combToothLength],
        [combToothWidth, 0],
    ]);
    
    for (x = bumps) 
        mirror([x, 0, 0])
        translate([-combToothWidth * x, combToothLength - toothBumpLength / 2, combThickness / 2])
        rotate([-90, 0, 90])
        linear_extrude(toothBumpThickness, scale = 0.6)
        square([toothBumpLength, combThickness], center = true);
}

module DupontComb() {
    translate([-combLength / 2, 0, 0]) {
        cube([combLength, combBaseWidth, combThickness]);

        translate([combLength / 2, combBaseWidth / 2, combThickness - epsilon])
        linear_extrude(joinPegLength + epsilon)
        polygon([
            [-joinCombPegWidth / 2, -combBaseWidth / 2], 
            [joinCombPegWidth / 2, -combBaseWidth / 2],
            [joinCombPegWidth / 2 + combBaseWidth / 2, 0],
            [joinCombPegWidth / 2, combBaseWidth / 2], 
            [-joinCombPegWidth / 2, combBaseWidth / 2], 
            [-joinCombPegWidth / 2 - combBaseWidth / 2, 0],
        ]);

        for (t = [0:numCables])
            translate([t * (combToothWidth + combToothSpacing), combBaseWidth, 0])
            CombTooth(t == 0 ? [1] : t == numCables ? [0] : [0, 1]);
    }
}

module DupontBridge() {
    for (i = [0:numBridgeSegments - 1])
        if (bridgeSegment == -1 || bridgeSegment == i)
            translate([-bridgeLength / 2, i * bridgeSpacing, 0]) {
                difference() {
                    cube([bridgeLength, bridgeWidth, combBaseWidth]);
                    
                    translate([bridgeHoleMargin + (i > 0 ? 0 : joinHoleLength), bridgeHoleMargin, -epsilon])
                    cube([bridgeLength - joinHoleLength * (i > 0 ? 1 : 2) - bridgeHoleMargin * 2, 
                        bridgeWidth - bridgeHoleMargin * 2, combBaseWidth + epsilon * 2]);
                    
                    l = bridgeLength - joinHoleLength;
                    for (x = i == 0 ? [-epsilon, l] : [l])
                        translate([x, bridgeWidth / 2, combBaseWidth / 2])
                        rotate([-90, 0, -90])
                        linear_extrude(joinHoleLength + epsilon)
                        polygon([
                            [-joinHoleWidth / 2, -combBaseWidth / 2 - epsilon], 
                            [joinHoleWidth / 2, -combBaseWidth / 2 - epsilon],
                            [joinHoleWidth / 2 + combBaseWidth / 2, 0],
                            [joinHoleWidth / 2, combBaseWidth / 2 + epsilon], 
                            [-joinHoleWidth / 2, combBaseWidth / 2 + epsilon], 
                            [-joinHoleWidth / 2 - combBaseWidth / 2, 0],
                        ]);
                }
            
                if (i > 0)
                    translate([-joinPegLength, bridgeWidth / 2, combBaseWidth / 2])
                    rotate([-90, 0, -90])
                    linear_extrude(joinPegLength + epsilon)
                    polygon([
                        [-joinBridgePegWidth / 2, -combBaseWidth / 2], 
                        [joinBridgePegWidth / 2, -combBaseWidth / 2],
                        [joinBridgePegWidth / 2 + combBaseWidth / 2, 0],
                        [joinBridgePegWidth / 2, combBaseWidth / 2], 
                        [-joinBridgePegWidth / 2, combBaseWidth / 2], 
                        [-joinBridgePegWidth / 2 - combBaseWidth / 2, 0],
                    ]);
            }    
}

module DupontOrganizerPlate() {
    DupontComb();

    translate([0, combSpacing, 0])
    DupontComb();
    
    translate([0, combSpacing * 2, 0])
    DupontBridge();
}

if (part == "comb")
    DupontComb();

if (part == "bridge")
    DupontBridge();

if (part == "plate")
    DupontOrganizerPlate();
