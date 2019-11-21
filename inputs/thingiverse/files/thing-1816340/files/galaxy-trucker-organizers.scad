// Global resolution
//$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
//$fa = 5;    // Don't generate larger angles than 5 degrees

/* [Hidden] */
// fudge sizes
// this make preview happier, but the exported model will have more faces
$f = 0.0; // set to zero when exporting
$g = 0.01; // safe to leave as non-zero

/* [Parameters] */
part = "chipHolder"; //[chipHolder:Chip Holder,chipHolderLid:Chip Holder Lid,chipHolderSizedDividedBox:Chip-sized Box,chipHolderSizedLid:Chip-sized Box Lid,goodsHolderBox:Goods Box,goodsHolderBumpyBox:Goods Bumpy Box,goodsHolderLid:Goods Lid]

//play (chip holder length and width will be increased by this much)
play = [2,2];

//thickness of the walls
wallThickness = 2; //[1:0.5:4]
//flat surfaces, also the thickness of the lid
bottomThickness = 1; //[0.5:0.5:3]
//lip of lid thickness
lipThickness = 3;
//lip fudge (will be double this value)
lipFudge = 0.25;

// How much height you have in your box (the chipHolderBox will be sized to fit on top of the chipHolder, and the goodsHolderBox will be half this height)
maxClearance = 40; //[20:60]

// Chip's thickness, length, width, cornerLength/Width
chipDimensions = [1.66, 43.3, 21.3, 3];
// Widechip's thickness, lenght, width, cornerLenght/Width
wideChipDimensions = [1.66, 47.3, 23.8, 4];

// First row - How many chip holders to make, and how many they should hold (best if all the same value)
chipCountsA = [14,14,14,14,14];
// Second row - How many chip holders to make, and how many they should hold (best if all the same value)
chipCountsB = [14,14,14,14];
// Second row, wide chip counter (if any of these chip counts do not match, the lid will not be useful)
wideChipCount = 14;

// First row - Chip counter box divison sizes. (one extra box is made with the remainder)
boxDivisionsA = [0.333,0.333];
// First row - Chip counter box division sizes. (one extra box is made with the remainder)
boxDivisionsB = [0.25,0.50];

// How big should one of the four holders be
goodsHolderBoxSize = 50;//[20:75]
// How much chamfer
goodsHolderCornerSize = 20;//[0:75]

// Print bumps on bottom of chipholder
goodsHolderBumpSize = 6;

/* [Hidden] */
goodsHolderBoxHeight = 40/2 - bottomThickness;

chipHolderHeight = max(
        max(chipDimensions[0]*max(max(chipCountsA), max(chipCountsB))),
        wideChipDimensions[0]*wideChipCount);
echo("chipHolder height:", chipHolderHeight);
echo("chipHolderLid (effective) height:", bottomThickness);

remainingHeight = maxClearance - chipHolderHeight - bottomThickness;
echo("remaining height:", remainingHeight);

/* I use these values for my smaller 3D printer and box size, so I can't use the divided box. */
// First row - How many chip holders to make, and how many they should hold (best if all the same value)
//chipCountsA = [22.5,22.5,22.5,22.5];
// Second row - How many chip holders to make, and how many they should hold (best if all the same value)
//chipCountsB = [22.5,22.5,22.5];
// Second row, wide chip counter (if any of these chip counts do not match, the lid will not be useful)
//wideChipCount = 22.5;



// one wide chip is added to the end of chipCountsB

module octagon(width, length, innerWidth, innerLength) {
    width = width / 2;
    length = length / 2;
    innerWidth = innerWidth / 2;
    innerLength = innerLength / 2;
    points = [
        [-width, innerLength], [-innerWidth, length], // top-left corner
        [innerWidth, length], [width, innerLength], // top-right corner
        [width, -innerLength], [innerWidth, -length], // bottom-right corner
        [-innerWidth, -length], [-width, -innerLength]]; // bottom-left corner
    
    translate([width, length]) polygon(points, [[0,1,2,3,4,5,6,7,8]]);
}

module surface2DToBox(height, thickness, bottomThickness, chamfer) {
    linear_extrude(bottomThickness) children(0);
    translate([0,0,bottomThickness]) linear_extrude(height) difference() {
        offset(0) children(0);
        offset(delta=-thickness, chamfer=chamfer) children(0);
    }
}

module surfaceToBox(height, thickness, bottomThickness, chamfer) {
    surface2DToBox(height, thickness, bottomThickness, chamfer) projection() children(0);
}

// print the lid part, or just the lip
module surface2DToLid(thickness, lidThickness, chamfer, printLid=true) {
    rotate([180,0,0]) translate([0,0,-lidThickness]) {
        if(printLid) {
            linear_extrude(lidThickness) offset(delta=1.5, chamfer=chamfer) children(0);
        }
        translate([0,0,-thickness]) linear_extrude(thickness) difference() {
            offset(delta=1.5, chamfer=chamfer) children(0);
            offset(delta=lipFudge) children(0);
        }
    }
}

module surfaceToLid(thickness, lidThickness, chamfer) {
    surface2DToLid(thickness, lidThickness, chamfer) projection() children(0);
}

// the inside octagon's innerWidth and innerLength is defined as:
// innerWidth - tan(theta/2) * wallThickness
// *and*
// innerLength - tan((theta-90)/2) * wallThickness
// theta is the angle produced from the right triangle sitting outside the octagon:
// theta = atan((length - innerLength)/(width - innerWidth));
// sigma = 90 - theta;
// widthAdjust = tan(theta/2) * wallThickness;
// lengthAdjust = tan(sigma/2) * wallThickness;
function hollowOctagonSolidInnerVector(width, length, innerWidth, innerLength, wallThickness) = [
    tan(atan((length - innerLength)/(width - innerWidth))/2) * wallThickness*2,
    tan(atan((width - innerWidth)/(length - innerLength))/2) * wallThickness*2
];

module octagonBox(width, length, innerWidth, innerLength, wallThickness, height, bottomWallThickness) {
    surface2DToBox(height, wallThickness, bottomWallThickness, true)
        octagon(width, length, innerWidth, innerLength);
}

module chipHolder(chipDimensions, chipCount, wallThickness, bottomWallThickness) {
    outerWidth = chipDimensions[2] + wallThickness*2 + play[0];
    outerLength = chipDimensions[1] + wallThickness*2 + play[1];
    innerWidth = outerWidth - chipDimensions[3]*2 - sqrt(2)*wallThickness;
    innerLength = outerLength - chipDimensions[3]*2 - sqrt(2)*wallThickness;
    height = chipCount * chipDimensions[0];
    innerVector = hollowOctagonSolidInnerVector(width=outerWidth, length=outerLength,
            innerWidth=innerWidth, innerLength=innerLength,
            wallThickness=wallThickness);
    cutawayWidth = innerWidth - innerVector[0];
    cutawayLength = innerLength - innerVector[1];
    
    difference() {
        octagonBox(width=outerWidth, length=outerLength,
            innerWidth=innerWidth, innerLength=innerLength,
            wallThickness=wallThickness,
            height=height,
            bottomWallThickness=bottomWallThickness);
        // side wall cutout
        translate([outerWidth/2-cutawayWidth/2,outerLength-wallThickness-$g,bottomWallThickness-$f])
            cube([cutawayWidth, wallThickness+$g+$g, height + $f+$g]);
        // bottom cutout
        translate([outerWidth/2,outerLength-cutawayWidth*sqrt(2)/2*sqrt(2)/2,-$g])
            rotate(45)
            cube([cutawayWidth*sqrt(2)/2, cutawayWidth*sqrt(2)/2, bottomWallThickness + $g*2]);
    }
}

module moveChipInRow(chipDimensions, wallThickness, i) {
    translate([(chipDimensions[2]+wallThickness+play[0])*i,0,0])
        children(0);
}

module chipHolderRow(chipDimensions, chipCounts, wallThickness, bottomWallThickness) {
    for(i = [0:len(chipCounts)-1])
        moveChipInRow(chipDimensions, wallThickness, i) 
            chipHolder(chipDimensions=chipDimensions, chipCount=chipCounts[i], wallThickness=wallThickness, bottomWallThickness=1);
}

module fullChipHolder() {
    mirror([0,1,0]) translate([0,-wallThickness,0]) chipHolderRow(chipDimensions=chipDimensions, chipCounts=chipCountsA, wallThickness=wallThickness, bottomWallThickness=bottomThickness);
    chipHolderRow(chipDimensions=chipDimensions, chipCounts=chipCountsB, wallThickness=wallThickness, bottomWallThickness=1);
    moveChipInRow(chipDimensions, wallThickness, len(chipCountsB)) chipHolder(chipDimensions=wideChipDimensions, chipCount=wideChipCount, wallThickness=wallThickness, bottomWallThickness=1);
}

function _plateWidth(chipDimensions, chipHolders, wallThickness, extraHolderWidth) =
    chipHolders*(chipDimensions[2]+wallThickness+play[0]);
function plateWidth(chipDimensions, chipHolders, wallThickness, extraHolderWidth) =
    extraHolderWidth ?
        _plateWidth(chipDimensions, chipHolders, wallThickness, extraHolderWidth) + extraHolderWidth + wallThickness + play[0] :
        _plateWidth(chipDimensions, chipHolders, wallThickness, extraHolderWidth);

module chipHolderPlate(chipDimensions, chipHolders, wallThickness, plateThickness, cornerOffset, extraHolderWidth, lengthOverride, extraLength=0) {
    width = plateWidth(chipDimensions, chipHolders, wallThickness, extraHolderWidth);
    length = lengthOverride ? lengthOverride + extraLength : chipDimensions[1] + extraLength;

    outerWidth = width + wallThickness;
    outerLength = length + wallThickness*2;
    innerWidth = outerWidth - cornerOffset*2 - sqrt(2)*wallThickness;
    innerLength = outerLength - cornerOffset*2 - sqrt(2)*wallThickness;

    linear_extrude(plateThickness)
        octagon(outerWidth,outerLength,innerWidth,innerLength);
}

module fullChipHolderPlate(extraLength=0) {
    translate([0,0,-1]) {
        mirror([0,1,0]) translate([0,-wallThickness,0]) chipHolderPlate(chipDimensions, len(chipCountsA), wallThickness, 1, chipDimensions[3], extraLength=extraLength);
        chipHolderPlate(chipDimensions, len(chipCountsB), wallThickness, 1, wideChipDimensions[3], wideChipDimensions[2], wideChipDimensions[1], extraLength=extraLength);
    }
}

module chipHolderLid() {
    rotate([180,0,0])
        translate([0,0,-bottomThickness]) linear_extrude(bottomThickness) offset(delta=1.5) projection() fullChipHolderPlate(1.5);
    translate([0,0,-$g]) surface2DToLid(lipThickness+$g,bottomThickness, chamfer=true, printLid=false) 
        projection(cut=true) translate([0,0,-lipThickness+bottomThickness]) fullChipHolder();
}


module chipHolderSizedBox() {
    surfaceToBox(remainingHeight - bottomThickness, wallThickness, bottomThickness, true)
        fullChipHolderPlate();
}

function _sumArray(array, acc, start, end) = 
    start > end ? acc : _sumArray(array, acc + array[start] , start + 1, end);
function sumArray(array,end) = _sumArray(array, 0, 0, end);

module chipHolderSizedDividedBox() {
    height = remainingHeight - bottomThickness;
    
    aWidth = plateWidth(chipDimensions, len(chipCountsA), wallThickness);
    aLength = chipDimensions[1] + wallThickness + $g;

    bWidth = plateWidth(chipDimensions, len(chipCountsB), wallThickness, wideChipDimensions[2]);
    bLength = wideChipDimensions[1] + wallThickness + $g;

    surfaceToBox(height, wallThickness, bottomThickness, true)
        mirror([0,1,0]) translate([0,-wallThickness,0]) chipHolderPlate(chipDimensions, len(chipCountsA), wallThickness, 1, chipDimensions[3]);
    surfaceToBox(height, wallThickness, bottomThickness, true)
        chipHolderPlate(chipDimensions, len(chipCountsB), wallThickness, 1, wideChipDimensions[3], wideChipDimensions[2], wideChipDimensions[1]);
    
    mirror([0,1,0]) for(i = [0:len(boxDivisionsA)-1]) {
        translate([(aWidth-wallThickness*2)*sumArray(boxDivisionsA,i)+wallThickness/2,$g,bottomThickness]) cube([wallThickness, aLength, height]);
    }

    for(i = [0:len(boxDivisionsB)-1]) {
        translate([(bWidth-wallThickness*2)*sumArray(boxDivisionsB,i)+wallThickness/2,$g,bottomThickness]) cube([wallThickness, bLength, height]);
    }
}

module chipHolderSizedLid() {
    surfaceToLid(lipThickness, bottomThickness, true)
        fullChipHolderPlate();
}

module goodsHolderSurface() {
    offset = goodsHolderBoxSize-wallThickness;
    innerSize = goodsHolderBoxSize-goodsHolderCornerSize;
    translate([0,0,0]) octagon(goodsHolderBoxSize,goodsHolderBoxSize,
        innerSize,innerSize);
    translate([offset,0,0]) octagon(goodsHolderBoxSize,goodsHolderBoxSize,
        innerSize,innerSize);
    translate([0,offset,0]) octagon(goodsHolderBoxSize,goodsHolderBoxSize,
        innerSize,innerSize);
    translate([offset,offset,0]) octagon(goodsHolderBoxSize,goodsHolderBoxSize,
        innerSize,innerSize);
}

module bumps(width, length, innerWidth, innerLength, wallThickness, bottomThickness) {
    if(goodsHolderBumpSize > 0) {
        length = length - wallThickness*2;
        width = width - wallThickness*2;
        rows = floor(length/goodsHolderBumpSize/2);
        columns = floor(width/goodsHolderBumpSize/2);
        lengthOffset = (length - rows*goodsHolderBumpSize*2)/2 + wallThickness + goodsHolderBumpSize/2;
        widthOffset = (width - columns*goodsHolderBumpSize*2)/2 + wallThickness + goodsHolderBumpSize/2;
        
        // TODO: this doesn't take into account chamfer
        translate([widthOffset, lengthOffset, bottomThickness])
        for(y = [0:rows-1]) {
            translate([0,y*goodsHolderBumpSize*2,0])
            for(x = [0:columns-1]) {
                translate([x*goodsHolderBumpSize*2,0]) {
                    translate([goodsHolderBumpSize/2,goodsHolderBumpSize/2,-goodsHolderBumpSize/2000])
                    difference() {
                        translate([0,0,-goodsHolderBumpSize/sqrt(2)/2])
                        rotate([45,45,45])
                            cube([goodsHolderBumpSize,goodsHolderBumpSize,goodsHolderBumpSize], center=true);
                        translate([0,0,-goodsHolderBumpSize])
                        cube([goodsHolderBumpSize*2,goodsHolderBumpSize*2,goodsHolderBumpSize*2], center=true);
                    }
                }
            }
        }
    }
}

module goodsHolderBox(bumps=false) {
//    surface2DToBox(goodsHolderBoxHeight, wallThickness, bottomThickness, true) goodsHolderSurface();
    offset = goodsHolderBoxSize-wallThickness;
    innerSize = goodsHolderBoxSize-goodsHolderCornerSize;
    translate([0,0,0]) {
        surface2DToBox(goodsHolderBoxHeight-bottomThickness, wallThickness, bottomThickness, true)
            octagon(goodsHolderBoxSize,goodsHolderBoxSize, innerSize,innerSize);
        if(bumps) bumps(goodsHolderBoxSize,goodsHolderBoxSize,innerSize,innerSize, wallThickness, bottomThickness);
    }
    translate([offset,0,0]) {
        surface2DToBox(goodsHolderBoxHeight-bottomThickness, wallThickness, bottomThickness, true)
            octagon(goodsHolderBoxSize,goodsHolderBoxSize, innerSize,innerSize);
        if(bumps) bumps(goodsHolderBoxSize,goodsHolderBoxSize,innerSize,innerSize, wallThickness, bottomThickness);
    }
    translate([0,offset,0]) {
        surface2DToBox(goodsHolderBoxHeight-bottomThickness, wallThickness, bottomThickness, true)
            octagon(goodsHolderBoxSize,goodsHolderBoxSize, innerSize,innerSize);
        if(bumps) bumps(goodsHolderBoxSize,goodsHolderBoxSize,innerSize,innerSize, wallThickness, bottomThickness);
    }
    translate([offset,offset,0]) {
        surface2DToBox(goodsHolderBoxHeight-bottomThickness, wallThickness, bottomThickness, true)
            octagon(goodsHolderBoxSize,goodsHolderBoxSize, innerSize,innerSize);
        if(bumps) bumps(goodsHolderBoxSize,goodsHolderBoxSize,innerSize,innerSize, wallThickness, bottomThickness);
    }
}

module goodsHolderLid() {
    surface2DToLid(lipThickness, bottomThickness, true) goodsHolderSurface();
}

//octagonBox(width=40,length=20, innerWidth=40-3,innerLength=20-6, wallThickness=wallThickness, height=40, bottomWallThickness=4);
//chipHolder(chipDimensions=chipDimensions, chipCount=10, wallThickness=wallThickness, bottomWallThickness=1);

if(part=="chipHolder") {
    fullChipHolder();
} else if(part=="chipHolderLid") {
    chipHolderLid();
} else if(part=="chipHolderSizedDividedBox") {
    chipHolderSizedDividedBox();
} else if(part=="chipHolderSizedLid") {
    chipHolderSizedLid();
} else if(part=="goodsHolderBox") {
    goodsHolderBox();
} else if(part=="goodsHolderBumpyBox") {
    goodsHolderBox(true);
} else if(part=="goodsHolderLid") {
    goodsHolderLid();
}