// Base measurements

// Projector-side intake grille. Measured from outer edge of outer hexagon air holes
rectWidth = 52.38;
rectHeight = 30.16;

// Pegs inserting into projector air grille
pegHeight = 4;
pegDiameter = 2;
pegHoleDiameter = 2.6; // Used to ensure peg placement remains constant as pegDiameter changes
numPegsHorizontal = 14;
numPegsVertical = 5;
// Which pegs to include:
horizontalPegs = [1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1];
verticalPegs=[0, 0, 1, 0, 0];

// External fan
circleRadius = (92 / 2);
circularFlangeScrewHoleDistance = 82.5;
screwHoleDiameter=4.5;

// Adapter
// Depth of extruded hull
extrusionHeight = 20;
// Amount of headspace available above projector intake vent (Important to avoid intersecting mounting hardware)
rearFanDistanceAboveRectTop = 11.7;
flangeHeight = 2;
hullThickness = 3.175;

// Derived measurements
pegRadius = pegDiameter / 2;
pegHoleRadius = pegHoleDiameter / 2;
halfRectWidth = rectWidth / 2;
halfRectHeight = rectHeight / 2;
 
 // Hexapegs
 
pegStartX = halfRectWidth - pegHoleRadius;
pegStopX = -halfRectWidth + pegHoleRadius;
 
pegPaddingHorizontal = ((pegStartX - pegStopX) / (numPegsHorizontal - 1)) - pegHoleDiameter;
pegIntervalX = pegHoleDiameter + pegPaddingHorizontal;

// Pegs along "horizontal" larger rectangular edge (X-axis)
for (peg = [0:1:numPegsHorizontal-1]) {
    pegX = pegStartX - (peg * pegIntervalX);
    if (horizontalPegs[peg] != 0) {
        // Top
        translate([pegX, (-halfRectHeight) + pegHoleRadius, 0 ]) taperedHexapeg(pegHeight, pegRadius);
        // Bottom
        translate([pegX, halfRectHeight - pegHoleRadius, 0 ]) taperedHexapeg(pegHeight, pegRadius);
    }
}
    
// Pegs along "vertical" smaller rectangular edge (Y-axis)
pegStartY = halfRectHeight - pegHoleRadius;
pegStopY = (-halfRectHeight) + pegHoleRadius;

pegPaddingVertical = ((pegStartY - pegStopY) / (numPegsVertical - 1)) - pegHoleDiameter;
pegIntervalY = pegHoleDiameter + pegPaddingVertical;

// Vertical pegs
for (peg = [0:1:numPegsVertical-1]) {
    pegY = pegStartY - (peg * pegIntervalY);
    if (verticalPegs[peg] != 0) {
        // Left
        translate([pegStartX, pegY, 0 ]) taperedHexapeg(pegHeight, pegRadius);
        // Right
        translate([pegStopX, pegY, 0 ]) taperedHexapeg(pegHeight, pegRadius);
    }
}

 // Rectangular-side flange
pegAllowance = pegHoleDiameter;  // Radius / Diameter are measured flat edge to edge. Corner-corner distance is slightly greater. TODO: Do the trigonometry
innerWidth = rectWidth - (2 * pegAllowance);
innerHeight = rectHeight - (2 * pegAllowance);
outerWidth = innerWidth + (hullThickness * 2);
outerHeight = innerHeight + (hullThickness * 2);


 translate([0,0,-flangeHeight]) difference() {
     rectangularbase(outerWidth, outerHeight, flangeHeight);
     rectangularbase(innerWidth, innerHeight, flangeHeight);
 }
 
 // Circular-side flange
bottomCircleOffset = circleRadius - rectHeight/2 - rearFanDistanceAboveRectTop;

circularSideFlangeDimen = (circleRadius * 2) + (2 * hullThickness);

translate([0, bottomCircleOffset, -flangeHeight * 2 - extrusionHeight]) difference() {
     
    rectangularbase(circularSideFlangeDimen, circularSideFlangeDimen, flangeHeight);
    cylinder(r=circleRadius, h=flangeHeight, $fa = 1);
     
     // Screw holes
     // Bottom Right looking through circle at rectangle
     translate([circularFlangeScrewHoleDistance/2, circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
     
     // Bottom Left
     translate([-circularFlangeScrewHoleDistance/2, circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
     
     // Top Left
     translate([-circularFlangeScrewHoleDistance/2, -circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
     
     // Top Right
     translate([circularFlangeScrewHoleDistance/2, -circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
 }

 
// Hull
 
translate([0,0,-flangeHeight * 2]) difference() {
    // Outer hull
    adapterHull(outerWidth, outerHeight, circleRadius + hullThickness, extrusionHeight, rearFanDistanceAboveRectTop, flangeHeight);

    // Inner hull
    adapterHull(innerWidth, innerHeight, circleRadius, extrusionHeight, rearFanDistanceAboveRectTop, flangeHeight);
}

module adapterHull(rectWidth, rectHeight, circleRadius, hullHeight, rectTopToCircleTopOffset, flangeHeight) {
    
    //rectToCircleOffset = -(rectHeight / 2) - circleRadius - rectTopToCircleTopOffset;
    hull() {
        rectangularbase(rectWidth, rectHeight, flangeHeight);

        translate([0, bottomCircleOffset, -hullHeight]) cylinder(r=circleRadius, height = 1, $fa = 1);
        
    }
}

module rectangularbase(rectWidth, rectHeight, depth) {
    translate([-rectWidth/2,-rectHeight/2, 0]) cube([rectWidth, rectHeight, depth]);
}

module taperedHexapeg(pegHeight, pegRadius) {
    minHeight = .1;
    extrudeHeight = pegHeight - (minHeight * 2);
    hull() {
        hexapeg(minHeight, pegRadius);
        translate([0,0, extrudeHeight]) hexapeg(minHeight, pegRadius * .8);
    }
}

module hexapeg(pegHeight, pegRadius) {
    linear_extrude(height = pegHeight) {
        hexagon(pegRadius,0,0);
    }
}

module hexagon(r,x,y){

polygon(points=[[(r+x),(r*(tan(30)))+y],
                [x,(r*(2/sqrt(3)))+y],
                [-r+x,(r*(tan(30)))+y],
                [-r+x,-(r*(tan(30)))+y],
                [x,-(r*(2/sqrt(3)))+y], 
                [r+x,-(r*(tan(30)))+y]]);
         
 }