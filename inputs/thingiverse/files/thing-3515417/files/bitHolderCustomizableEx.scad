/**
 * Remix of "Hex Shank Bit Holder - Parametric" by Fitzterra on Thingiverse:
 * https://www.thingiverse.com/thing:1686330
 *
 * This remix mimics the original as close as possible but has the following
 * features:
 *  - Any number of rows and columns, still keeping the edge rows open on the
 *    sides. This is nice if the hex shank has the bit size stamped on it.
 *  - Footer height can be adjusted
 *  - Height can be adjusted
 *  - Allows easy scaling in the X and Y directions if your printer causes
 *    the hex holes to be too tight, like mine does.
 *  - Added more shapes (triangle, square, pentagon, heptagon, octagon) [New]
 *  - Allow custom size and shapes per row and cols [New]
 *  - Allow label holes [New]
 *  - Allow allen key slots (Need two or more rows for that) [New]
 *  - Allow set global tolerance for holes [New]
 *  - Allow use magnets at bottom [New]
 *
 * Author: Fitzterra <fitz_subs@icave.net>  - July 2016
 * Author: Tiago Conceição - March 2019
 *
 * License:
 * This work is licensed under the Creative Commons Attribution-ShareAlike 3.0
 * Unported License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 **/

/**
 * This version is specifically for upload to Thingiverse and includes the
 * filleting function from jfhbrook's fillets (see below) library inline in
 * this file.
 * This is because on Thingiverse you can not use custom external scad files
 * when using the customizer.
 * 
 * The original source for this can be fount at:
 * https://github.com/fitzterra/3DP/tree/master/Things/Tools/Hex_Shank_Drill_Bit_Holder
 **/

// Fillets library from:
// https://github.com/jfhbrook/openscad-fillets/blob/master/fillets.scad
// Thanks jfhbrook!
//use <fillets.scad>;

/*
*   SETUP
*   Must edit stuff, configure your holder
*/
/* [SETUP] */
// Number of rows
rows = 2;
// Number of columns
columns = 8;
// Height of the footer in mm
foot = 1.2;
// Height above footer in mm
height = 30;
// Type of hole, edges?
holeShape = "hexagon"; //[triangle, square, pentagon, hexagon, heptagon, octagon, round]
// When using hex holes, specify if the diameter given is from long diagonal (1) or short diagonal (0). Tip: Short diagonals are easier to measure.
hexHoleDiameterIsLongDiagonal = 1; //[0:No, 1:Yes]
// Hole diameter in mm
holeDiameter = 7.2;
// Hole tolerance in mm, this value will be add with holeDiameter and custom holes. Use 0 for manual set tolerance individual. A good value can be your nozzle size + 0.1mm
holeTolerance = 0.5;
/* END SETUP */


/*
*   CUSTOM HOLES
*   Create custom holes sizes and shapes, if X Y not found defaults will be used.
*   ["shape", size]
*/
/* [CUSTOM HOLES] */
// Use custom holes feature
useCustomHoles = 1; //[0:No,1:Yes]
// Custom holes array
customHoles = [ [], [ ["round", 2.9], ["round", 3.9], ["round", 4.9], ["round", 5.9], ["round", 6.9], ["round", 7.9], ["round", 8.9], ["round", 9.9] ] ];
/* END CUSTOM HOLES */


/*
*   ALLEN KEY HOLES
*   Create a slot for hold a allen key at middle of rows, it require two or more rows to work.
*/
/* [ALLEN KEY HOLES] */
// Use allen key slow feature
useAllenSlotAtRowMiddle = 0; //[0:No,1:Yes]
// Allen key slot long diagonal diameter, holeTolerance will be added
allenDiameter = 2.8;
/* END ALLEN KEY HOLES /*


/*
*   LABELS
*   Use labels for each hole to identify the tool.
*/
/* [LABELS] */
// Use Front Labels feature
useFrontLabels = 1; //[0:No, 1:Yes]
// Use Back Labels feature
useBackLabels = 1; //[0:No, 1:Yes]
// The font for labels
labelsFont="Verdana:style=Bold";
// Labels font size in mm
labelsSize = 4.5;
// The labels depth in mm
labelsDepth = 1.2;
// Front labels array
frontLabels = ["H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "H11", "H12"];
// Back labels array
backLabels  = ["3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];

useLeftLabel = 0; //[0:No, 1:Yes]
labelLeftFont="Verdana:style=Bold";
labelLeftSize = 10;
labelLeftDepth = 1.2;
labelLeftText = "+";

useRightLabel = 0; //[0:No, 1:Yes]
labelRightFont="Verdana:style=Bold";
labelRightSize = 10;
labelRightDepth = 1.2;
labelRightText = "+";
/* END LABELS */


/*
*   SPLIT LINE
*   Draw a split line per row at center (aesthetic only), need two or more rows to work.
*/
/* [SPLIT LINE] */
// Use split line feature
useRowSplitLine = 1; //[0:No, 1:Yes]
// Line width in mm
rowSplitLineWidth = 1;
// Line depth in mm
rowSplitLineDepth = 1;
/* END SPLIT LINE */


/*
*   MAGNETIC BASE
*   Create a slot for hold a allen key at middle of rows, it require two or more rows to work.
*/
/* [MAGNETIC BASE] */
// Create holes from base to insert and glue magnets, they will valign to center.
useBaseMagnets = 0; //[0:No, 1:Yes]
// Magnet shape
baseMagnetShape = "rounds"; //[round, rectangular]
// Magnet Length, this will also be used for round magnet diameter. holeTolerance will be added
baseMagnetLength = 20;
// Magnet width for rectangular magnets. holeTolerance will be added
baseMagnetWidth = 8;
// Magnet height, make sure foot is higher than this height! Tolerance must given by user, 1 layer height is OK.
baseMagnetHeight = 1;
// Magnet count to place, 1 = center, 2 = left and right | 3 = left, center and right.
baseMagnetCount = 3; //[1,2,3]
// Margin from left and right wall when using 2 or more magnets
baseMagnetMargin = 5;
/* END MAGNETIC BASE */



/*
*   Advanced
*   Fun stuff, can dramatic change how it looks!
*/
/* [ADVANCED] */
// Gap between hole edges for rows
rowsGap = 10;
// Gap between hole edges for columns
colsGap = 7;
// How much space to leave on the columns edges - can be negative to open the hex hole edge.
colsEdge = 6;
// How much space on the row top and bottom.
rowsEdge = 6;
// Fillet coners
filletCorners = 1; //[0:No,1:Yes]
// The corner fillet radius
fRad = 2.0;
/* END Advanced */

/* [Hidden] */
//---------------------------
/*
*   SCRIPT START
*   !DO NOT MODIFY!
*
*----------------------------*/
function shapeNameToEdges(name) =   name == "triangle"  ? 3 :
                                    name == "square"    ? 4 :
                                    name == "pentagon"  ? 5 :
                                    name == "hexagon"   ? 6 :
                                    name == "heptagon"  ? 7 :
                                    name == "octagon"   ? 8 :
                                    name == "round"     ? 100 :
                                                        6;
                             
function shortDiagonalToLongDiagonal(short) = (short / sqrt(3)) * 2;
function longDiagonalToShortDiagonal(long) = (long / 2) * sqrt(3);

// Constants
holeShapeEdges = shapeNameToEdges(holeShape);
holeDiameterTol = !hexHoleDiameterIsLongDiagonal && holeShapeEdges == 6 ?
                        shortDiagonalToLongDiagonal(holeDiameter) + holeTolerance : 
                        holeDiameter + holeTolerance;
allenDiameterTol = allenDiameter + holeTolerance;

baseMagnetLengthTol = baseMagnetLength+holeTolerance;
baseMagnetWidthTol = baseMagnetWidth+holeTolerance;
/** Direct inclusion from fillets.scad **/
// 2d primitive for inside fillets.
module fil_2d_i(r, angle=90) {
  translate([r, r, 0])
  difference() {
    polygon([
      [0, 0],
      [0, -r],
      [-r * tan(angle/2), -r],
      [-r * sin(angle), -r * cos(angle)]
    ]);
    circle(r=r);
  }
}

/** Direct inclusion from fillets.scad **/
// 3d linear inside fillet.
module fil_linear_i(l, r, angle=90) {
  rotate([0, -90, 180]) {
    linear_extrude(height=l, center=false) {
      fil_2d_i(r, angle);
    }
  }
}

/**
 * Module to generate the bit holder
 *
 **/
module BitHolder() {
    // Nicely rounded fillets
    $fn=64;

    // Calculate the total width and depth
    w = columns*holeDiameterTol + (columns-1)*colsGap + colsEdge*2;
    d = rows*holeDiameterTol + (rows-1)*rowsGap + rowsEdge*2;
    totalHeight = height+foot;

    // Apply a scaling if needed
    difference() {
        // The main block
        cube([w, d, totalHeight]);
        // Sink the hex holes
        translate([colsEdge, rowsEdge, foot]) {
            for(x=[0:columns-1]) {
                for(y=[0:rows-1]) {
                    // Check for custom holes
                    if(useCustomHoles && customHoles[y][x] != undef && customHoles[y][x][0] != undef && customHoles[y][x][1] != undef){
                        customShapeName=customHoles[y][x][0];
                        customShapeEdges=shapeNameToEdges(customShapeName);
                        customShapeDiameter=customHoles[y][x][1];
                                              
                        customShapeDiameterTol = !hexHoleDiameterIsLongDiagonal && customShapeEdges == 6 ?
                        shortDiagonalToLongDiagonal(customShapeDiameter) + holeTolerance : 
                        customShapeDiameter + holeTolerance;
                        
                        if(customShapeName && customShapeDiameter) {
                           translate([x*(holeDiameterTol+colsGap)+holeDiameterTol/2, y*(holeDiameterTol+rowsGap)+holeDiameterTol/2, 0])
                            cylinder(d=customShapeDiameterTol, h=height+0.1, $fn=customShapeEdges);
                        }
                    }
                    else{ // Render normal holes
                        translate([x*(holeDiameterTol+colsGap)+holeDiameterTol/2, y*(holeDiameterTol+rowsGap)+holeDiameterTol/2, 0])
                            cylinder(d=holeDiameterTol, h=height+0.1, $fn=holeShapeEdges);
                    }
                }
            }
        }
        
        // Generate labels
        if(useFrontLabels || useBackLabels) {
            for(x=[0:columns-1]) {
                // Front labels
                if(useFrontLabels)
                    translate([x*(holeDiameterTol+colsGap)+holeDiameterTol/2+colsEdge, labelsDepth, height/2])
                            rotate([90, 0, 0])
                                linear_extrude(labelsDepth+0.1)
                                    text(frontLabels[x], labelsSize, font=labelsFont, halign="center", valign="center");
                
                // Back Labels
                if(useBackLabels)
                    translate([x*(holeDiameterTol+colsGap)+holeDiameterTol/2+colsEdge, d-labelsDepth, height/2])
                            rotate([90, 0, 180])
                                linear_extrude(labelsDepth+0.1)
                                    text(backLabels[x], labelsSize, font=labelsFont, halign="center", valign="center");
            }
        }

        if(useLeftLabel)
            translate([labelRightDepth, d/2, totalHeight/2])
                rotate([90, 0, -90])
                    linear_extrude(labelLeftDepth+0.1)
                        text(labelLeftText, labelLeftSize, font=labelLeftFont, halign="center", valign="center");
        
        
        if(useRightLabel)
            translate([w-labelRightDepth, d/2, totalHeight/2])
                rotate([90, 0, 90])
                    linear_extrude(labelRightDepth+0.1)
                        text(labelRightText, labelRightSize, font=labelRightFont, halign="center", valign="center");
        
        baseMagnetShape="round";
        // Create magnets
        if(useBaseMagnets && baseMagnetCount > 0) {
            if(baseMagnetCount == 1 || baseMagnetCount >= 3)
            {
                if(baseMagnetShape == "round")
                    translate([w/2, d/2, -0.1])
                        cylinder(d=baseMagnetLengthTol, h=baseMagnetHeight+0.1, $fn=100);
                else
                    translate([w/2-baseMagnetLengthTol/2, d/2-baseMagnetWidthTol/2, -0.1])
                        cube([baseMagnetLengthTol, baseMagnetWidthTol, baseMagnetHeight+0.1]);

            }
            
            if(baseMagnetCount == 2 || baseMagnetCount >= 3) {
                if(baseMagnetShape == "round")
                {
                    translate([baseMagnetMargin+baseMagnetLengthTol/2, d/2, -0.1])
                        cylinder(d=baseMagnetLengthTol, h=baseMagnetHeight+0.1, $fn=100);
                    
                    translate([w-baseMagnetMargin-baseMagnetLengthTol/2, d/2, -0.1])
                        cylinder(d=baseMagnetLengthTol, h=baseMagnetHeight+0.1, $fn=100);
                }
                else
                {
                    translate([baseMagnetMargin, d/2-baseMagnetWidthTol/2, -0.1])
                        cube([baseMagnetLengthTol, baseMagnetWidthTol, baseMagnetHeight+0.1]);
                    
                    translate([w-baseMagnetMargin-baseMagnetLengthTol, d/2-baseMagnetWidthTol/2, -0.1])
                        cube([baseMagnetLengthTol, baseMagnetWidthTol, baseMagnetHeight+0.1]);
                }
            }
        }
        
        // Generate allen key slots
        if(useAllenSlotAtRowMiddle && rows > 1){
            for(y=[1:rows-1]) {
                translate([-0.1, y*(holeDiameterTol+rowsGap)+rowsEdge-rowsGap/2, totalHeight-allenDiameterTol-(useRowSplitLine? rowSplitLineDepth/2:0.5 )])
                    rotate([0, 90, 0])
                        cylinder(d=allenDiameterTol, h=w+0.2, $fn=6);
            }
        }
        
        // Generate split lines
        if(useRowSplitLine && rows > 1) {
            for(y=[1:rows-1]) {
                translate([-0.1, y*(holeDiameterTol+rowsGap)+rowsEdge-rowsGap/2-rowSplitLineWidth/2, totalHeight-rowSplitLineDepth])
                    cube([w+0.2, rowSplitLineWidth, rowSplitLineDepth+0.1]);
            }
        }
               
        // Fillet the 4 corners
        if(filletCorners) {
            // Front Left
            translate([-0.1, -0.1, -0.1])
                rotate([0, -90, 180])
                    fil_linear_i(totalHeight+0.2, fRad);
            translate([-0.1, d+0.1, -0.1])
                rotate([0, -90, 90])
                    fil_linear_i(totalHeight+0.2, fRad);
            translate([w+0.1, -0.1, -0.1])
                rotate([0, -90, -90])
                    fil_linear_i(totalHeight+0.2, fRad);
            translate([w+0.1, d+0.1, -0.1])
                rotate([0, -90, 0])
                    fil_linear_i(totalHeight+0.2, fRad);
                    
            // Fillet the 4 top edges
            // Front
            translate([-0.1, -0.1, totalHeight+0.1])
                rotate([-180, 0, 0])
                    fil_linear_i(w+0.2, fRad);
            
            // Back
            translate([-0.1, d+0.1, totalHeight+0.1])
                rotate([90, 0, 0])
                    fil_linear_i(w+0.2, fRad);
                    
            // Left
            translate([-0.1, -0.1, totalHeight+0.1])
                rotate([90, 0, 90])
                    fil_linear_i(d+0.2, fRad);
                    
            // Right
            translate([w+0.1, -0.1, totalHeight+0.2])
                rotate([180, 0, 90])
                    fil_linear_i(d+0.2, fRad);
        }
    }
}

BitHolder();
