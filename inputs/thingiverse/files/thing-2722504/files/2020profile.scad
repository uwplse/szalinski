/*
 * 2020profile.scad
 * v1.0.2 21st December 2017
 * Written by landie @ Thingiverse (Dave White)
 *
 * This script is licensed under the Creative Commons - Attribution license.
 * https://www.thingiverse.com/thing:2722504
 *
 * A parametised and customizable profile generator for 2020 and 2040 profiles
 * v1.0 2020 and 2040 profiles
 * v1.0.1 added 2080 profile
 * v1.0.2 made slot width customizable
 */
 
// The type of extrusion, 2020 or 2040
extrusionSize = "2020"; // [2020, 2040, 2080]

// The length of the extrusion
extrusionLength = 50;  // [1:300]

// The slot gap width
slotWidth = 6; //[4,5,6,7,8]

// The radius of the extrusion outer 4 corners
cornerRadius = 1.5;

// The diameter of the hole in the center(s) of the profile
centerDia = 4.19;

// The gap at the outside edge of each slot
slotGap = slotWidth + 0.26;

// The width at the largest point of each slot
slotMax = 11.99;

// The width and height of the square in the center of each profile
centerSquare = 7.31;

// The thickness of the walls that make up most of the profile
wallThickness = 1.5;

// The width of the profile(s)
extrusionWidth = 20;

// The height of the profile(s)
extrusionHeight = 20;

/* [Hidden] */

if (extrusionSize == "2020") {
    linear_extrude(extrusionLength)
    profile2020();
}

if (extrusionSize == "2040") {
    linear_extrude(extrusionLength)
    profile2040();
}

if (extrusionSize == "2080") {
    linear_extrude(extrusionLength)
    profile2080();
}

module profile2020() {
    difference() {
        hull() {
            translate([-extrusionWidth / 2 + cornerRadius, extrusionHeight / 2 - cornerRadius])
            circle(r=cornerRadius, $fn = 60);
            translate([extrusionWidth / 2 - cornerRadius, extrusionHeight / 2 - cornerRadius])
            circle(r=cornerRadius, $fn = 60);
            translate([-extrusionWidth / 2 + cornerRadius, -extrusionHeight / 2 + cornerRadius])
            circle(r=cornerRadius, $fn = 60);
            translate([extrusionWidth / 2 - cornerRadius, -extrusionHeight / 2 + cornerRadius])
            circle(r=cornerRadius, $fn = 60);
        }
        circle(d = centerDia, $fn = 60);
        for (angle = [45, 135, 225, 315]) {
            rotate(angle)
            translate([0, centerDia / 2])
            circle(d = wallThickness, $fn = 60);
        }
        for (angle = [0,90,180,270]) {
            rotate(angle)
            slot();
        }
    }
}

module profile2040() {
    difference() {
        union() {
            translate([0,extrusionHeight / 2])
                profile2020();
            translate([0,-extrusionHeight / 2])
                profile2020();
            roundedSquare(wallThickness / 4, extrusionWidth, slotGap);
        }
        joinerCutout();
    }
}

module profile2080() {
    difference() {
        union() {
            translate([0,extrusionHeight])
                profile2040();
            translate([0,-extrusionHeight])
                profile2040();
            roundedSquare(wallThickness / 4, extrusionWidth, slotGap);
        }
        joinerCutout();
    }
}

module joinerCutout() {
        centerGap = ((extrusionWidth - slotMax) / 2 - wallThickness) * 2;
        roundedSquare(wallThickness / 4, extrusionWidth - wallThickness * 2, centerGap);
        difference() {
            circle(d = extrusionWidth - wallThickness, $fn = 4);
            roundedSquare(wallThickness / 4, extrusionWidth, centerGap);
            translate([0, extrusionHeight / 2])
            roundedSquare(wallThickness / 4, centerSquare, centerSquare);
            translate([0, -extrusionHeight / 2])
            roundedSquare(wallThickness / 4, centerSquare, centerSquare);
        }
}

module slot() {
    totalHeight = extrusionHeight / 2 - centerSquare / 2;
    difference() {
        translate([0,totalHeight / 2 + centerSquare / 2])
        square([slotMax, totalHeight], center = true);
        rotate(45)
            square([wallThickness, extrusionHeight * 1.5], center = true);
        rotate(-45)
            square([wallThickness, extrusionHeight * 1.5], center = true);
        translate([-extrusionWidth / 4 - slotGap / 2, totalHeight + centerSquare / 2 - wallThickness / 2])
            roundedSquare(wallThickness / 4, extrusionWidth / 2, wallThickness);
        translate([extrusionWidth / 4 + slotGap / 2, totalHeight + centerSquare / 2 - wallThickness / 2])
            roundedSquare(wallThickness / 4, extrusionWidth / 2, wallThickness);
    }
}

module roundedSquare(radius, width, height) {
    hull() {
        translate([width / 2 - radius, height / 2 - radius])
        circle(r = radius, $fn = 60);
        translate([-width / 2 + radius, height / 2 - radius])
        circle(r = radius, $fn = 60);
        translate([width / 2 - radius, -height / 2 + radius])
        circle(r = radius, $fn = 60);
        translate([-width / 2 + radius, -height / 2 + radius])
        circle(r = radius, $fn = 60);
    }
}