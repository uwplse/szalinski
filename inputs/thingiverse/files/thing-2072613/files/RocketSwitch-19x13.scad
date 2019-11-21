// Configuration
$fn = 360;

rocketSwitchLength  = 19;
rocketSwitchWidth   = 13;
wallThickness       = 5;
boxHeight           = 25;
groundPlateHeight   = 3;
cornerRadius        = 5;
numberOfFragments   = 360;
drillingRadius      = 1.5;

// Usefull modules
module Drilling(height, radius, position = [0, 0, 0]) {
    translate(position) cylinder(h = height, r = radius);
}

module MirrorCopy(vector = [0, 1, 0]) {
    mirror (vector) children();
}

// This module creates the shape that needs to be substracted from a cube to make its corners rounded.
//This shape is basicly the difference between a quarter of cylinder and a cube
// All that 0.x numbers are to avoid "ghost boundaries" when substracting
module createMeniscus(h,radius) {
    difference() {
        translate([radius/2+0.1,radius/2+0.1,0]) {
            cube([radius+0.2,radius+0.1,h+0.2],center=true);
        }
        cylinder(h=h+0.2,r=radius,$fn = numberOfFragments,center=true);
    }
}

// Now we just substract the shape we have created in the four corners
module roundCornersCube(x,y,z,r) {
    difference() {
        cube([x,y,z], center=true);
        
        translate([x/2-r,y/2-r]) {  // We move to the first corner (x,y)
            rotate(0) {
                createMeniscus(z,r); // And substract the meniscus
            }
        }
        translate([-x/2+r,y/2-r]) { // To the second corner (-x,y)
            rotate(90) {
                createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
            }
        }
        translate([-x/2+r,-y/2+r]) { // ... 
            rotate(180) {
                createMeniscus(z,r);
            }
        }
        translate([x/2-r,-y/2+r]) {
            rotate(270) {
                createMeniscus(z,r);
            }
        }
    }
}

module RocketSwitchBox() {
    x = rocketSwitchLength + (2 * wallThickness);
    y = rocketSwitchWidth + (2 * wallThickness);
    
    roundCornersCube(x, y, boxHeight, cornerRadius);
}

module RocketSwitchCutOut() {
    cube([rocketSwitchLength, rocketSwitchWidth, boxHeight], center=true);
}

module GroundPlate() {
    x = rocketSwitchLength + (2 * wallThickness) + 15;
    y = rocketSwitchWidth + (2 * wallThickness) + 15;
    
    difference() {
        roundCornersCube(x, y, groundPlateHeight, cornerRadius);
        
    }
}

module CableCutOut() {
    x = rocketSwitchLength + (2 * wallThickness) + 15;
    y = 10;
    
    cube([x, y, groundPlateHeight], center=true);
}

module Box() {
    x1 = 0;
    y1 = 0;
    z1 = -boxHeight/2 + groundPlateHeight/2;
    
    x2 = -10;
    y2 = -(rocketSwitchWidth + (2 * wallThickness) + 15)/2 + 3.75;
    z2 = -boxHeight/2;
    drillingPosition1 = [x2, y2, z2];
    
    x3 = 10;
    y3 = -(rocketSwitchWidth + (2 * wallThickness) + 15)/2 + 3.75;
    z3 = -boxHeight/2;
    drillingPosition2 = [x3, y3, z3];
    
    x4 = -10;
    y4 = (rocketSwitchWidth + (2 * wallThickness) + 15)/2 - 3.75;
    z4 = -boxHeight/2;
    drillingPosition3 = [x4, y4, z4];
    
    x5 = 10;
    y5 = (rocketSwitchWidth + (2 * wallThickness) + 15)/2 - 3.75;
    z5 = -boxHeight/2;
    drillingPosition4 = [x5, y5, z5];
    
    difference() {
        union() {
            RocketSwitchBox();
            translate([x1, y1, z1]) GroundPlate();
        }
        RocketSwitchCutOut();
        translate([x1, y1, z1]) CableCutOut();
        
        Drilling(groundPlateHeight, drillingRadius, drillingPosition1);
        Drilling(groundPlateHeight, drillingRadius, drillingPosition2);
        Drilling(groundPlateHeight, drillingRadius, drillingPosition3);
        Drilling(groundPlateHeight, drillingRadius, drillingPosition4);
    }
}

Box();
