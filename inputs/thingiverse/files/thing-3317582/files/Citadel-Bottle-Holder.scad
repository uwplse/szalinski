//#
// Original Author:  Jean Philippe Neumann
// Ported to OpenSCAD: Joseph Lenox
// License: Creative Commons Attribution-ShareAlike 3.0 Unported License
//         see http://creativecommons.org/licenses/by-sa/3.0/
// URL:     http://www.thingiverse.com/thing:65028
//

rows = 3; // [20]
columns = 3; // [20]

// Generate stacking pillars? 
extraPillars = "False"; // [True, False]

/* [Details] */

// Wall thickness
bottleCasingStrength = 2;

// Floor thickness
bottleCavityStrength = 4.5;
capHoleBottleCavityDiff = 0;

/* [Bottle Parameters] */
bottleBodyDiameter = 33.5;
bottleCapDiameter = 18.5;
// Amount cap protrudes into upper layer
capHoleHeight = 2;


/* [Pillars] */
// Length of the optional pillars
pillarHeight = 39.0;
pegSizeReduction = 1;


/* [Hidden] */
// derived parameters

_pillarHeight = pillarHeight - bottleCavityStrength;
_extraPillars = extraPillars == "True";

planeStrengthBottom = capHoleHeight + bottleCavityStrength + capHoleBottleCavityDiff;

pegHeight = planeStrengthBottom;

maxColumn = columns-1;
maxColumnInEvenRows = maxColumn-1;
maxRow = rows-1;

bottleBodyRadius = bottleBodyDiameter / 2;

holeDiffX = bottleCasingStrength+bottleBodyRadius*2;

// calculating the distance between rows using the pythagorean theorem

// c = hypotenuse between the centers of holes in adjacent rows
c = holeDiffX;
// b = cathetus between (the center between two holes on the same row) and (the center of one of the holes)
b = bottleCasingStrength/2 + bottleBodyRadius;
// a = cathetus between (the center between two holes on the same row) and (the center of the hole directly above it)
a = sqrt(c*c - b*b);
holeDiffY = a;

//# helper functions ###

function isEven(num) = (num % 2) == 0;
function isNotEven(num) = !isEven(num);
function triangleHeightFromWidth(width) = sqrt(width*width-(width/2)*(width/2));

module createTriangle(xSize, ySize, zExtrusion) {
    translate([0, -ySize/3,0])
        linear_extrude(height=zExtrusion)
            polygon(points = [[-xSize/2,0], [xSize/2,0], [0,ySize]]);
}

function placePillarTopRight(column,row) = [holeDiffX*column+pillarPosX, holeDiffY*row+pillarPosY, 0];

function placePillarBottomRight(column, row) = [holeDiffX*column+pillarPosX, holeDiffY*row-pillarPosY, 0];
//# calculate objects ###
  
// calculate holes ##

module bottleCasing() {
    color([0,0,1])
        cylinder(h=planeStrengthBottom, r=bottleBodyRadius + bottleCasingStrength, $fn=128);
}

module bottleBody() {
    translate([0,0,capHoleHeight])
    color([0,1,1])
    cylinder(h=bottleCavityStrength+0.1, r=bottleBodyRadius);
}

module bottleCap() {
    cylinder(h=capHoleHeight+0.2, r=bottleCapDiameter/2);
}

module bottleHolder() {
    difference() {
        difference() {
            bottleCasing();
            bottleBody();
        }
        translate([0,0,-0.1])
        bottleCap();
    }
}

// calculate pillars ##

// calculate pillar coordinates

x = (0+(bottleBodyDiameter+bottleCasingStrength)*1.5)/3;
y = (0+0+holeDiffY)/3;

pillarPosX = x;
pillarPosY = y;

// calculate pillar dimensions

// distance from center of a hole to center of the pillars coordinates
distanceToCenter = sqrt(x*x + y*y);

pillarTriangleWidth = (2/sqrt(3))*(3*(distanceToCenter-bottleBodyDiameter/2));
pegTriangleWidth = (2/sqrt(3))*(3*(distanceToCenter-bottleBodyDiameter/2-bottleCasingStrength/2)) - pegSizeReduction;

pillarTriangleHeight = triangleHeightFromWidth(pillarTriangleWidth);
pegTriangleHeight = triangleHeightFromWidth(pegTriangleWidth);

module pillar() {
    color([0.7,0.7,0])
        createTriangle(pillarTriangleWidth, pillarTriangleHeight, _pillarHeight);
}

module peg() {
    color([0.3,0,0.7])
    createTriangle(pegTriangleWidth, pegTriangleHeight, _pillarHeight+pegHeight);
}

module pillarPointingUp() {
    union() {
        peg();
        pillar();
    }
}

module pillarPointingDown() {
    rotate([0,0,180]);
    pillarPointingUp();
}

// build the object ###

for (column = [0:maxColumn]) {
    for (row = [0:maxRow]) {
        // red / uneven rows
        if (isNotEven(row)) {
            if (column != maxColumn) {
                translate([holeDiffX*column + holeDiffX/2, (holeDiffY)*row, 0])
                    color([1,0,0])
                    bottleHolder();
                    // green / even rows
            }
        } else {
            translate([holeDiffX*column, holeDiffY*row, 0])
                color([0,1,0]) bottleHolder();

            // place pillars
            if (_extraPillars && maxColumn > 0 && maxRow > 0) {
                // bottom left pillar
                if (row == 0 && column == 0) {
                    translate(placePillarTopRight(column,row)) pillarPointingDown();
                } else if (row == 0 && column == maxColumn-1) {
                    translate(placePillarTopRight(column,row)) pillarPointingDown();
                    // top left pillar
                } else if (row == maxRow && column == 0) {
                    translate(placePillarBottomRight(column,row)) pillarPointingUp();
                    // top right pillar
                } else if (row == maxRow && column == maxColumn-1) {
                    translate(placePillarBottomRight(column,row)) pillarPointingUp();
                }
            }
        }
    }
}
