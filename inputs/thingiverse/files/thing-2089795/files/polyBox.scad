// Box diameter
boxDiameter = 50;

// Box height
boxHeight = 50;

// Lid height
lidHeight = 15;

// Number of sides 
numberSides = 6; // [2:20]

// Wall thickness
wallThickness = 1.4;

// Text on the base
textBase="Text";

// Size of the base text
textBaseSize=10; // [3:50]

// Text on the lid
textLid="Your"; 

// Size of the lid text
textLidSize=10; // [3:50]

// Parts to show
showParts = 0; // [0:All, 1:Base, 2:Lid]

// Just for presentation purposes
showClosed = 1; // [0:Open, 1:Closed]

/* [Hidden] */
corner=1;
tolerance=0.8;
$fn=60;

if( showParts != 2 || showClosed ==1) {
    boxBase();
    separators(numSeparatorsX, numSeparatorsY, boxWidth, boxDepth, boxHeight);
}
if (showClosed == 1 ) {
    translate([0, 0, boxHeight]) rotate(a=[0, 180, 0]) boxLid();
}
else {
    if (showParts != 1) translate([boxDiameter+10, 0, ]) boxLid();
}


module boxBase() {
difference() {
    
    roundedPol(boxDiameter/2, boxHeight, numberSides, corner);
    translate([0, 0, wallThickness]) roundedPol(boxDiameter/2-wallThickness, boxHeight, numberSides, corner);
    
    a = 360 / numberSides;
    ri = cos(a/2)*boxDiameter/2 + corner - 1 ;
    
    translate ([0, -ri, boxHeight/2]) rotate(a=[90, 0, 0]) linear_extrude(height=2) text(textBase, size=textBaseSize, valign="center", halign="center");
}

}

module boxLid() {
difference() {
    roundedPol(boxDiameter/2+tolerance+wallThickness, lidHeight, numberSides, corner);
translate([0, 0, wallThickness]) roundedPol(boxDiameter/2+tolerance, boxHeight, numberSides, corner);
    
    a = 360 / numberSides;
    ri = cos(a/2)*boxDiameter/2 + corner - 1 ;
    
    translate ([0, 0, 1]) rotate(a=[180, 0, 180]) linear_extrude(height=2) text(textLid, size=textLidSize, valign="center", halign="center");    
}

}


module roundedPol(r, h, sides, corner)
{
    a = 360 / sides;
    rotate([0, 0, a/2-90])
    linear_extrude(height=h) offset(corner)
    circle(r=r-corner, $fn=sides);
    
}
    