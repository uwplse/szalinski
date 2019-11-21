/*
 * Configurable French Cleat Tool Holder
 *
 * by 4iqvmk, 2018-07-05
 * https://www.thingiverse.com/4iqvmk/about
 * 
 * Licenced under Creative Commons Attribution - Share Alike 4.0 
 *
 * version 1.00 - initial version
*/

// Note: default parameters will make a holder for three 1 oz bottles of Zap CA

/* [Hidden] */

inch2mm = 0.3048/12*1000;
mm2inch = 12/0.3048/1000;
$fn=60;

// preview[view:south west, tilt:top diagonal]

/* [Parameters] */

// mm
cleatHeight = 75; // [0:1:200]

// mm
cleatDepth = 15; // [0:1:30]

// mm
cleatThickness = 6; // [0:1:20]

// mm, used if > 0
fixedShelfDepth = 60; // [0:1:200]

// mm
topShelfHeight = 56; // [0:1:200]

// mm
backThickness = 6; // [1:1:20]

// mm
shelfThickness = 6; // [1:1:20]

// Is top shelf included?
topShelf = 1; // [0:no, 1:yes]

// Is bottom shelf included?
bottomShelf = 1; // [0:no, 1:yes]

// Are holes included in bottom shelf?
bottomHole = 2; // [0:no, 1:yes, 2:half]

// mm
holeDepthAxis = 48; // [1:1:100]

// mm
holeWidthAxis = 28; // [1:1:100]

// deg
holeAngle = 45; // [-45:1:45]

numCols = 3; // [1:10]

numRows = 1; // [1:10]

// mm, used if > 0
fixedHoleWidthSpacing = 0; // [0:100]

// mm, used if > 0
fixedHoleDepthSpacing = 0; // [0:100]

// mm
labelTextSize = 7; // [0:1:50]

// Centered at the top
centerLabelText = "CA";

// Centered over each column
colLabelText = ["Thin", "Med", "Thick"];

/////////////////////////////////////////////////////////////////////////////
// Calculated values
/////////////////////////////////////////////////////////////////////////////

makeToolHolder(cleatHeight, cleatDepth, cleatThickness, fixedShelfDepth,
    topShelfHeight, backThickness, shelfThickness, topShelf, bottomShelf,
    bottomHole, holeDepthAxis, holeWidthAxis, holeAngle, numCols, 
    numRows, fixedHoleWidthSpacing, fixedHoleDepthSpacing, labelTextSize,
    centerLabelText, colLabelText);
    
module makeToolHolder(cleatHeight, cleatDepth, cleatThickness, fixedShelfDepth,
    topShelfHeight, backThickness, shelfThickness, topShelf, bottomShelf,
    bottomHole, holeDepthAxis, holeWidthAxis, holeAngle, numCols, 
    numRows, fixedHoleWidthSpacing, fixedHoleDepthSpacing, labelTextSize,
    centerLabelText, colLabelText) {

    // height

    maxHeight = cleatHeight + topShelf*topShelfHeight;


    // thickness and roundovers

    maxThickness = max(shelfThickness, backThickness);
    filletRadius = min(maxThickness, 5);

    shelfRoundOverRadius = shelfThickness/4;
    backRoundOverRadius = backThickness/4;
    cleatRoundOverRadius = cleatThickness/8;


    // hole dimensions

    holeWidth = sqrt(pow(holeWidthAxis,2) * pow(cos(holeAngle),2) + pow(holeDepthAxis,2) * pow(sin(holeAngle),2));
    holeDepth = sqrt(pow(holeWidthAxis,2) * pow(sin(holeAngle),2) + pow(holeDepthAxis,2) * pow(cos(holeAngle),2));

    holeNarrowWidth = holeDepthAxis * holeWidthAxis / holeDepth;
    holeNarrowDepth = holeDepthAxis * holeWidthAxis / holeWidth;


    // width spacing

    holeSpacing = (fixedHoleWidthSpacing > 0) ? fixedHoleWidthSpacing : shelfThickness/2/cos(holeAngle);

    width = holeSpacing + holeWidth + (numCols-1)*(holeNarrowWidth + holeSpacing);


    // depth spacing

    // if fixed depth is specified, use that
    // if fixed spacing is specified, use that

    if (fixedShelfDepth > 0) {

        shelfDepth = fixedShelfDepth;

        depthSpace = (fixedHoleDepthSpacing > 0) ? fixedHoleDepthSpacing : (shelfDepth - holeDepth - holeNarrowDepth*(numRows-1))/(numRows+1);

        makeSolid(shelfDepth, depthSpace);

    } else {

        depthSpace = (fixedHoleDepthSpacing > 0) ? fixedHoleDepthSpacing : (shelfDepth - holeDepth - holeNarrowDepth*(numRows-1))/(numRows+1);

        shelfDepth = holeDepth + depthSpace + (holeNarrowDepth + depthSpace)*(numRows -1);

        makeSolid(shelfDepth, depthSpace);
        
    }

    module makeSolid(shelfDepth, depthSpace) {
        
        maxDepth = shelfDepth + backThickness;
        
        rotate(a=180, v=[0,0,1]) {
            translate([-maxDepth/2, -maxHeight/2, 0]) {
                difference() {
                    
                    linear_extrude(width) {
                        makeProfile(shelfDepth);
                    }

                    for (k = [0:numCols-1]) {

                        zcenter = holeWidth/2 + holeSpacing/2 + k*(holeSpacing + holeNarrowWidth);

                        for (j = [0:numRows-1]) {

                            // tool hole
                            
                            xcenter = maxDepth - holeDepth/2 - depthSpace/2 - (depthSpace + holeNarrowDepth)*j;
                            
                            if (topShelf) {
                                translate([xcenter, topShelfHeight-1.5*shelfThickness, zcenter]) {
                                    rotate(a=-90, v=[1,0,0]) {
                                        linear_extrude(2*shelfThickness) {
                                            ellipse(holeDepthAxis, holeWidthAxis, -holeAngle);
                                        }
                                    }
                                }
                            }
                            
                            if (bottomShelf) {
                                if (bottomHole==1) {
                                    translate([xcenter, -0.5*shelfThickness, zcenter]) {
                                        rotate(a=-90, v=[1,0,0]) {
                                            linear_extrude(2*shelfThickness) {
                                                ellipse(holeDepthAxis, holeWidthAxis, -holeAngle);
                                            }
                                        }
                                    }
                                }

                                if (bottomHole==2) {
                                    translate([xcenter, shelfThickness/2, zcenter]) {
                                        rotate(a=-90, v=[1,0,0]) {
                                            linear_extrude(1*shelfThickness) {
                                                ellipse(holeDepthAxis, holeWidthAxis, -holeAngle);
                                            }
                                        }
                                    }
                                }
                            }
                        
                        }
                        
                        if (len(centerLabelText) > 0) {
                            if (len(colLabelText) > 0) {
                                addText(labelTextSize, colLabelText[numCols - 1 - k], maxHeight-backThickness - labelTextSize*2, zcenter);
                                
                                translate([backThickness - 1, maxHeight-backThickness - labelTextSize*1.5, width*0.05]) {
                                    linear_extrude(width*0.9) {
                                        square([2, 1]);
                                    }
                                }
                                
                            }
                            
                        } else {
                            addText(labelTextSize, colLabelText[numCols - 1 - k], maxHeight-backThickness, zcenter);
                        }
                    
                    }
                    
                    addText(labelTextSize, centerLabelText, maxHeight-backThickness, width/2);
                  
                }
            }
        }
    }

    module makeProfile(shelfDepth) {
        
        union() {
        
            // offsets for fillets
            offset(-filletRadius) {
                offset(filletRadius) {
            
                    union() {
                        
                        // back profile
                        hull() {
                            
                            translate([backRoundOverRadius, backRoundOverRadius, 0]) {
                                circle(r=backRoundOverRadius);
                            }
                            translate([backThickness - backRoundOverRadius, backRoundOverRadius, 0]) {
                                circle(r=backRoundOverRadius);
                            }
                            translate([backRoundOverRadius, maxHeight-backRoundOverRadius, 0]) {
                                circle(r=backRoundOverRadius);
                            }
                            translate([backThickness - backRoundOverRadius, maxHeight-backRoundOverRadius, 0]) {
                                circle(r=backRoundOverRadius);
                            }
                            
                        }
                        
                        // holder profile
                        if (topShelf) {
                            hull() {
                                
                                translate([0, topShelfHeight - shelfThickness, 0]) {
                                    square([0.01*backThickness,shelfThickness]);
                                }
                                translate([shelfDepth + backThickness - shelfRoundOverRadius, topShelfHeight - shelfThickness + shelfRoundOverRadius, 0]) {
                                    circle(r=shelfRoundOverRadius);
                                }
                                translate([shelfDepth + backThickness - shelfRoundOverRadius, topShelfHeight - shelfRoundOverRadius, 0]) {
                                    circle(r=shelfRoundOverRadius);
                                }
                                
                            }
                        }
                        
                        // bottom shelf profile
                        if (bottomShelf) {
                            hull() {
                                
                                translate([shelfRoundOverRadius, shelfRoundOverRadius, 0]) {
                                    circle(r=shelfRoundOverRadius);
                                }
                                translate([shelfRoundOverRadius, shelfThickness - shelfRoundOverRadius, 0]) {
                                    circle(r=shelfRoundOverRadius);
                                }
                                translate([shelfDepth + backThickness - shelfRoundOverRadius, shelfRoundOverRadius, 0]) {
                                    circle(r=shelfRoundOverRadius);
                                }
                                translate([shelfDepth + backThickness - shelfRoundOverRadius, shelfThickness - shelfRoundOverRadius, 0]) {
                                    circle(r=shelfRoundOverRadius);
                                }
                                
                            }
                        }
                    }
                }
            }

            // cleat profile
            hull() {
                
                translate([0, maxHeight-backThickness-cleatThickness*sqrt(2), 0]) {
                    square([0.01*backThickness,cleatThickness*sqrt(2)]);
                }
                translate([-cleatDepth + cleatRoundOverRadius, maxHeight-backThickness-cleatDepth-cleatRoundOverRadius*tan(22.5), 0]) {
                    circle(r=cleatRoundOverRadius);
                }
                translate([-cleatDepth + cleatRoundOverRadius, maxHeight-backThickness-cleatDepth-cleatThickness*sqrt(2)+cleatRoundOverRadius/tan(22.5), 0]) {
                    circle(r=cleatRoundOverRadius);
                }
            }
        }
    }

    module ellipse(a, b, rotation) {
        rotate(a = rotation) {
            scale([a/2, b/2]) {
                circle(r=1);
            }
        }
    }

    module addText(textSize, textStr, x, z) {
        textDepth = min(0.25*backThickness, 2);
        
        translate ( [backThickness-textDepth, x, z] ) {
            rotate( a = 90, v=[0, 1, 0]) {
                linear_extrude(height = backThickness) {
                    text(text = textStr, size = textSize, halign="center", valign="top", $fn=20);
                }
            }
        }
    }
}