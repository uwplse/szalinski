/* [Box Info] */
// width of box
boxWidth = 60;
// length of box
boxLength = 100;
// height of box
boxHeight = 30;

// number of cols
boxCols = 2;
//number of rows
boxRows = 2;

/* [Padding and Gaps] */
// thickness of box walls
wallThickness = 2.5;

/* [Box Label] */
// will be embossed into lid
title = "My Things";
//depth of the lettering
textDepth = 1.5;
// size of the font
textSize = 12;
// font to use
textFont = "Arial"; // [Arial,Times,Helvetica,Courier,Futura]

/* [hidden] */
// used to offset z collisions
fudge = 0.005;
// use 100 segments on rounded edges
$fn = 100;

boxDims = [
    boxWidth,
    boxLength,
    boxHeight
];

innerBox = [
    boxDims[0] - 2 * wallThickness,
    boxDims[1] - 2 * wallThickness,
    boxDims[2] - wallThickness + fudge
];

// bottom box
union() {
    difference() {    
        cube(boxDims);
        
        translate([wallThickness, wallThickness, wallThickness])
        cube(innerBox);
        
        translate([wallThickness, -fudge, boxHeight - 2 * wallThickness])
        cube([innerBox[0], wallThickness + 2 * fudge, 2 * wallThickness + fudge]);
        
        translate([wallThickness/2, -fudge, boxHeight - 2 * wallThickness])
        lid(innerBox[0]+wallThickness, boxLength, wallThickness, true);
    }
    
    if (boxCols > 1) {
        colOffset = (boxWidth - wallThickness) / boxCols;
        
        for (n =[1:boxCols-1]) {
            translate([n*colOffset, fudge, fudge])
            cube([wallThickness, boxLength - 2 * fudge, boxHeight - 2 * wallThickness - 2 * fudge]);
        }
    }
    
    if (boxRows > 1) {
        rowOffset = (boxLength - wallThickness) / boxRows;
        
        for (n =[1:boxRows-1]) {
            translate([fudge, n*rowOffset, fudge])
            cube([boxWidth - 2 * fudge, wallThickness, boxHeight - 2 * wallThickness - 2 * fudge]);
        }
    }
}

module lid(width, length, depth, cut) {
    rad = depth / 2;
    slideWidth = cut ? width : width - 3;
    slideDepth = length - wallThickness;
    handleGap = 1;
    
    rotate([-90])
    union() {
        translate([rad, -rad, 0])
        cylinder(r=rad, h=slideDepth);
        
        translate([rad, -depth, 0])
        cube([slideWidth - 2 * rad, depth, slideDepth]);
        
        translate([rad + handleGap, -depth - wallThickness, 0])
        cube([slideWidth - 2 * rad - 2 * handleGap, depth + wallThickness, wallThickness]);
        
        translate([slideWidth-rad, -rad, 0])
        cylinder(r=rad, h=slideDepth);
        
        rotate([90, 90, 0])
        translate([-slideDepth/2, slideWidth/2, wallThickness-fudge])
        linear_extrude(height = textDepth)
        text(title, size = textSize, font = textFont, valign="center", halign="center");
    }
}

translate([boxWidth + 10, 0, 0])
lid(boxWidth, boxLength, wallThickness, false);