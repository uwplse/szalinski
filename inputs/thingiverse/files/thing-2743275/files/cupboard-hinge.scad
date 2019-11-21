/*
 * cupboard_hinge.scad
 * v1.0.1 3rd January 2018
 * Written by landie @ Thingiverse (Dave White)
 *
 * This script is licensed under the Creative Commons - Attribution license.
 * https://www.thingiverse.com/thing:2743275
 *
 * A parametised kitchen cupboard style hinge with a quick release
 * v1.0 Concealed Blind Corner Hinge with quick release
 * v1.0.1 Thickened up the sides of the fixed plate receiver block
 */

// Part(s) to generate
generate = "All"; //["Arm", "Cup", "Fixed Plate", "Cam", "All"]

// Generate as an assembly or arranged for printing
assembly = "Printing"; //["Printing", "Assembly"]

/* [Hidden] */

cupDia = 35;
cupDiaInset = 1;
cupDepth = 12;
cupScrewSpacing = 45;
cupScrewYOffset = 28;
cupScrewDia = 4;
cupScrewCSKDia = 9;
cupScrewSCSKDepth = 3;

m3_nut_dia = 6.75;
m3_nut_depth = 3;
m3_bolt_dia = 3.75;
m3_bolt_cap_dia = 6;
m3_bolt_cap_depth = 4;

hingeYOffset = 8;
hingeZOffset = -6.5;

fixedScrewYOffsetToHinge = 30;
fixedScrewSpacing = 32;
fixedPlateWidth = 52;
fixedPlateHeight = 18;
fixedPlateThickness = 5;

cupPlateWidth = 57;
cupPlateHeight = 20;
cupPlateThickness = 5;

armWidth = 12;
armClearance = 1;

hingeOuterDia = 6;

cupMinWall = 1.2;

armFinalZPos = hingeZOffset - fixedPlateThickness - 5;
armPositions = [[0,0,0],
                [-2,-17,0],
                [-25,-17,0],
                [armFinalZPos,15,0],
                [armFinalZPos,fixedScrewYOffsetToHinge + fixedPlateHeight / 2 - hingeOuterDia / 2 + 15,0]
];
toothPitch = 1;
toothLength = 50;
receiverWallWidth = 4;
receiverWidth = armWidth + receiverWallWidth * 2;

camDia = 15;
camOffset = 3;
camArmLength = 40;

receiverCamHeight = -armFinalZPos + hingeOuterDia / 2 + hingeZOffset + camDia / 2 + camOffset - 0.5;

$fn = 80;

if (assembly == "Assembly") {
    if (generate == "All" || generate == "Cup") {
        cup();
    }
    if (generate == "All" || generate == "Arm") {
        arm();
    }
    if (generate == "All" || generate == "Fixed Plate") {
        fixedPlate();
    }
    if (generate == "All" || generate == "Cam") {
        cam();
    }
} else {
    if (generate == "All" || generate == "Cup") {
        translate([0,0,cupDepth + hingeZOffset])
        cup();
    }
    if (generate == "All" || generate == "Arm") {
        translate([35,0,armWidth / 2])
        rotate([0,90,0])
        arm();
    }
    if (generate == "All" || generate == "Fixed Plate") {
        translate([0,0,hingeZOffset])
        fixedPlate();
    }
    if (generate == "All" || generate == "Cam") {
        translate([-50,0,armWidth / 2])
        rotate([0,90,0])
        translate([0,0,-receiverCamHeight + hingeZOffset + camOffset])
        cam();
    }
}

module teeth(offset = 0) {
    translate([0, fixedScrewYOffsetToHinge - toothLength / 2, -armFinalZPos - hingeOuterDia / 2]) {
    for (i = [offset:toothPitch * 2: toothLength + offset]) {
        translate([0,i,0]) {
            rotate([45,0,0])
            cube([armWidth + armClearance, toothPitch * 1.2, toothPitch * 1.2], center = true);
        }
    }
    }
}

module cup() {
    translate([0,-cupDia / 2 + hingeYOffset,-hingeZOffset])
    difference() {
        union() {
            translate([0,0,-cupDepth])
            cylinder(d = cupDia - cupDiaInset, h = cupDepth);
            translate([0,-cupScrewYOffset + cupDia / 2, cupPlateThickness / 2])
            cube([cupPlateWidth, cupPlateHeight, cupPlateThickness], center = true);
        }
        translate([cupScrewSpacing / 2, -cupScrewYOffset + cupDia / 2, 0])
        cupScrew();
        translate([-cupScrewSpacing / 2, -cupScrewYOffset + cupDia / 2, 0])
        cupScrew();
        armCutout();
        cupHinge();
    }
}

module cupScrew() {
    cylinder(d = cupScrewDia, h = cupPlateThickness);
    translate([0,0,cupPlateThickness - cupScrewSCSKDepth])
    cylinder(d1 = cupScrewDia, d2 = cupScrewCSKDia, h = cupScrewSCSKDepth);
}

module slotCupScrew() {
    hull() {
        for(offset = [-0.5, 0.5]) {
             translate([cupScrewDia * offset, 0, 0])
                cylinder(d = cupScrewDia, h = cupPlateThickness);
        }
    }
    hull() {
        for(offset = [-0.5, 0.5]) {
             translate([cupScrewDia * offset, 0, 0])
                translate([0,0,cupPlateThickness - cupScrewSCSKDepth])
    cylinder(d1 = cupScrewDia, d2 = cupScrewCSKDia, h = cupScrewSCSKDepth);
        }
    }
}

module armCutout() {
    depth = cupDepth - cupMinWall + cupPlateThickness;
    translate([0,0,-depth / 2 + cupPlateThickness])
    intersection() {
            cube([armWidth + armClearance, cupDia - cupDiaInset, depth], center = true);
        cylinder(d = cupDia - cupDiaInset - cupMinWall * 2, h = depth, center = true);
    }
}

module cupHinge() {
    translate([0,cupDia / 2 - hingeYOffset ,hingeZOffset])
    rotate([0,90,0]) {
        cylinder(d = m3_bolt_dia, h = cupDia, center = true);
        translate([0,0,armWidth + 2 + armClearance])
                        cylinder(d = m3_nut_dia, h = armWidth, center = true, $fn = 6);
        translate([0,0,-armWidth - 2 - armClearance])
                        cylinder(d = m3_bolt_cap_dia, h = armWidth, center = true);

    }
}

module fixedPlate() {
    translate([0,-cupDia / 2 + hingeYOffset,-hingeZOffset]) {
        difference() {
            translate([0,fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset, fixedPlateThickness / 2])
                    cube([fixedPlateWidth, fixedPlateHeight, fixedPlateThickness], center = true);
                
                translate([fixedScrewSpacing / 2, fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset, 0])
                slotCupScrew();
                translate([-fixedScrewSpacing / 2, fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset, 0])
                slotCupScrew();
        }
    receiverBlock();
    }
}

module receiverBlock() {
    difference() {
        union() {
            hull() {
                translate([0,fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset, fixedPlateThickness / 2])
                    cube([receiverWidth, fixedPlateHeight, fixedPlateThickness], center = true);
                translate([0,fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset, receiverCamHeight - camDia / 2 + camOffset]) {
                    rotate([0,90,0])
                    cylinder(d = fixedPlateHeight, h = receiverWidth, center = true);
                }
            }
            translate([m3_nut_depth / 2 + receiverWidth / 2,fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset,receiverCamHeight])
            rotate([0,90,0])
            cylinder(d = 9, h = m3_nut_depth, center = true);
        }
    translate([0,cupDia / 2 - hingeYOffset,hingeZOffset])
        arm(toothPitch, armWidth + armClearance);
    translate([0,cupDia / 2 - hingeYOffset,hingeZOffset + toothPitch * 1.5])
        arm(toothPitch, armWidth + armClearance);
    
    translate([0,fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset, receiverCamHeight]) {
            rotate([0,90,0])
            cylinder(d = camDia + camOffset, h = armWidth + armClearance, center = true);
        translate([0,0,-hingeOuterDia])
        cube([armWidth + armClearance, fixedPlateHeight, fixedPlateHeight], center = true);
    }
    translate([0,fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset, receiverCamHeight]) {
            rotate([0,90,0])
    cylinder(d = m3_bolt_dia, h = receiverWidth, center = true);
        
        
    }
    
    translate([m3_nut_depth / 2 + receiverWidth / 2,fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset,receiverCamHeight])
        rotate([0,90,0])
        translate([0,0,-(receiverWallWidth - 2) / 2])
        cylinder(d = m3_nut_dia, h = m3_nut_depth + receiverWallWidth - 2, center = true, $fn = 6);
    
    translate([-receiverWidth / 2 + receiverWallWidth / 2 - 2, fixedScrewYOffsetToHinge + cupDia / 2 - hingeYOffset,receiverCamHeight])
        rotate([0,90,0])
        cylinder(d = m3_bolt_cap_dia, h = receiverWallWidth, center = true);
    
    
    }
    
    
}


module arm(toothOffset = 0, width = armWidth) {
        difference() {
            for (i = [1:4]) {
                hull() {
                        rotate([0,90,0]) {
                        translate(armPositions[i-1])
                        cylinder(d = hingeOuterDia, h = width, center = true);
                        translate(armPositions[i])
                        cylinder(d = hingeOuterDia, h = width, center = true);
                        }
                    }
            }
            rotate([0,90,0]) 
            translate(armPositions[0])
            cylinder(d = m3_bolt_dia, h = width, center = true);
            teeth(toothOffset);
        }
}

module cam() {
    translate([0,fixedScrewYOffsetToHinge, receiverCamHeight + -hingeZOffset - camOffset])
    rotate([0,90,0]) {
        difference() {
            union() {
                cylinder(d = camDia, h = armWidth, center = true);
                hull() {
                    translate([-camDia / 4,0,0])
            cylinder(d = camDia / 2, h = armWidth, center = true);
                    translate([-camOffset - 2,-camArmLength,0])
            cylinder(d = 3, h = armWidth, center = true);
                }
                hull() {
                    translate([-camOffset - 2,-camArmLength,0])
            cylinder(d = 3, h = armWidth, center = true);
                    translate([-camOffset - 10,-camArmLength - 5,0])
            cylinder(d = 3, h = armWidth, center = true);
                }
                hull() {
                    translate([-camOffset - 10,-camArmLength - 5,0])
            cylinder(d = 3, h = armWidth, center = true);
                    translate([-camOffset - 10,-camArmLength - 10,0])
            cylinder(d = 3, h = armWidth, center = true);
                }
            }
            translate([-camOffset,0,0])
            cylinder(d = m3_bolt_dia, h = armWidth, center = true);
        }
    }
}
