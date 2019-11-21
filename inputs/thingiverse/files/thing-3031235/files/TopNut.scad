/*
Awesome customizable top nut uses true fretboard radius, true string diameter grooves and true string height setting.
It is also possible to adjust each string height if necessary.

Written by Torkel Borjeson 2018-08-02 <torkelb@gmail.com>
*/
echo(version=version());
$fn = 80*1; // To hide from Customizer

// Length of nut in direction of strings
nutLength = 4.8; 

// Width of nut
nutWidth = 42.4; 

// Radius of first fret, normally 12"
nutRadius = 304.8; 

// Distance from bottom of nut to bottom of strings. Measure nut slot height to fret board, add fret thickness and add extra clearance of about 0.75mm
stringHeight = 7.8; 

numberOfStrings = 6; //[2:7]

firstStringToLastStringDistance = 35.6;



// Set width of unused strings to 0 to not confuse
// algorithm to calculate thickest string

string1Diameter = 0.35;
string2Diameter = 0.45;
string3Diameter = 0.65;
string4Diameter = 0.85;
string5Diameter = 1.10;
string6Diameter = 1.40;
string7Diameter = 0.0;

stringDiameters = [
    string1Diameter,
    string2Diameter,
    string3Diameter,
    string4Diameter,
    string5Diameter,
    string6Diameter,
    string7Diameter];

// This way we can handle both right and left handed nuts 
thickestString = max(stringDiameters);

// Adjustment for string 1, positive value heightens string
string1HeightAdjust = 0.0; 

// Adjustment for string 2, positive value heightens string
string2HeightAdjust = 0.0; 

// Adjustment for string 3, positive value heightens string
string3HeightAdjust = 0.0; 

// Adjustment for string 4, positive value heightens string
string4HeightAdjust = 0.0; 

// Adjustment for string 5, positive value heightens string
string5HeightAdjust = 0.0; 

// Adjustment for string 6, positive value heightens string
string6HeightAdjust = 0.0; 

// Adjustment for string 7, positive value heightens string
string7HeightAdjust = 0.0; 

stringHeightAdjust = [
    string1HeightAdjust,
    string2HeightAdjust,
    string3HeightAdjust,
    string4HeightAdjust,
    string5HeightAdjust,
    string6HeightAdjust,
    string7HeightAdjust];
    
nutHeight = stringHeight + thickestString;
stringSpacing = firstStringToLastStringDistance/(numberOfStrings-1);
string1XOffset = (nutWidth - firstStringToLastStringDistance)/2; 
R = nutRadius + nutHeight;

// Angle of slot horizontally
stringAngle = 10;

module vSlot(diameter) {
    rotate([stringAngle, 0, 0]) {
        minkowski() {        
            cylinder(d=diameter, h=nutLength, center=true);
            resize([10,20])
                rotate([0,0,45]) 
                    cube([10, 10, nutLength], center=false);
        }
    }
}

module slot(stringNumber) {
    xPos = -nutWidth/2+string1XOffset + stringSpacing*(stringNumber-1);
    // Compensate so all strings will get same height to fret board
    heightCompensation = thickestString - stringDiameters[stringNumber-1];
    yPos = sqrt(R*R-xPos*xPos)-stringDiameters[stringNumber-1]/2 - heightCompensation + stringHeightAdjust[stringNumber-1];
    translate([xPos, yPos, 0])
        vSlot(stringDiameters[stringNumber-1]);
}

module torus() {
color("White")
    rotate_extrude() 
        translate([nutRadius, 0, 0])
            resize([nutHeight*2,nutLength*2])
                circle(d=20);
}

module delimiterBottom() {
    // Bottom part
    cube([nutRadius*2, nutRadius*2, 40], center=true);
}

module delimiterSide() {
    // Side delimiter
    translate([nutWidth/2+nutRadius, 0, 0])
        cube([nutRadius*2, nutRadius*3, 50], center=true);    
}

module delimiterSplit() {
    // Remove lower part of ellipse
    translate([-nutRadius, 0, -30])
        cube([nutRadius*2, nutRadius*2, 30], center=false);
}

module hollowCylinder(innerRadius, outerRadius, length) {
    color("pink") {
    difference() {
        cylinder(r=innerRadius*2, h=length, center=false);
        cylinder(r=innerRadius, h=length, center=false);
    }
}
}
module chamferCorner() {
    
    innerRadius = string1XOffset;
    xCenter = -nutWidth/2+innerRadius;
    yCenter = sqrt(R*R-xCenter*xCenter)-innerRadius;    
    translate([xCenter, yCenter, 0]) {
        difference() {
            hollowCylinder(innerRadius, innerRadius*2, nutLength);
        color("gray") { 
              cube([2*innerRadius, 2*innerRadius, nutLength], center=false);
        }
        rotate([180,90,90]) {
            translate([-nutLength,-2*innerRadius,0])
            color("green") { 
                cube([nutLength, 4*innerRadius, 2*innerRadius], center=false);
            }
            }
        }
    }
}

module removeTheRest() {
    translate([0, -nutRadius, 0])
        cube([nutRadius*2, nutRadius*2, 60], center=true);
}

module Nut() {
    rotate([90,0,0]) {
        translate([0, -nutRadius, 0]) {
            difference() {
                torus();
                delimiterBottom();
                delimiterSide();
                rotate([0,0,180])
                    delimiterSide();
                delimiterSplit();
                removeTheRest();
                chamferCorner();
                rotate([0, 180, 0])
                translate([0,0,-nutLength])
                chamferCorner();
                for (i=[1:numberOfStrings])
                    slot(i);
            }
        }
    }
}

Nut();
  
