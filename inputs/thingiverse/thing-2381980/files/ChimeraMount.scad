/*
 * ChimeraMount.scad
 * v1.2.2 2nd April 2018
 * Written by landie @ Thingiverse (Dave White)
 *
 * This script is licensed under the Creative Commons - Attribution - Non-Commercial license.
 *
 * http://www.thingiverse.com/thing:2381980
 *
 * This project is for an X Carriage for a Core XY printer, in my case based on the Vulcanus 1.1
 *
 */

// Variables you may want to adjust...

// The spacing between the centres of the two support bars
xAxisBarSpacing = 50; //[50:100]

// The bearing type/shaft dia
bearingType = "LM8UU"; //["LM8UU","LM10UU"]

// the height of the belt clamp blocks, also effects the depth of the bearing mounts
beltClampHeight = 18;//[15:30]

// Additional height for the belt clamps, above the bearing mounts - used for Vulcanus Max design where belts are above the bars
additionalBeltClampHeight = 0; //[0:50]

// bowden spacing, 18 for origina chimera, 20 for chimera+
chimeraBowdenSpacing = 18; //[18,20]

/* [Hidden] */

// the outer diameter of the linear bearings
bearingDia = (bearingType == "LM8UU") ? 15.5 : 19.5;
// the length of the linear bearings
bearingLength = (bearingType == "LM8UU") ? 24 : 29;

bearingInnerClampDiameter = (bearingType == "LM8UU") ? 10 : 12;

// how much of a step should the bearing have to clip into
bearingClipStep = 1.5;

// The width of the carriage/mount
mountWidth = bearingLength * 2 + 3;

// the length of the belt clamp blocks
beltClampBlockLength = xAxisBarSpacing / 2;
beltClampFilletWidth = 3;
bearingClampDiameter = bearingDia + 4.8;
mountPlateThickness = 5;


beltClampBlockWidth = 5;
beltClampChamfer = 2;
beltThickness = 1.6;
beltToothThickness = 0.8;
beltGap = 1.2;
beltToothPitch = 2;
beltToothDia = 1.25;
totalClampWidth = beltClampBlockWidth * 2 + beltGap;


chimeraBowdenDia = 10;
chimeraBoltSpacing = 17;

touchMountBoltSpacing = 18;
touchMountDrop = 1;
touchMountLength = touchMountBoltSpacing + 12;
touchMountWidth = 16;
touchMountThickness = 4;

completeMount();

module completeMount() {
    chimeraMount();
    touchMount();
    rotate([0,0,180])
    touchMount();
}
//doubleClamp();
//translate([0,0,-beltClampHeight / 2])
//cube([30, 15, 3], center = true);
module chimeraMount() {
    difference() {
        xAxisBlank();
        
        // Bowden connectors
        translate([chimeraBowdenSpacing / 2,0,-beltClampHeight / 2 - mountPlateThickness - 1])
        cylinder(d = chimeraBowdenDia, h = mountPlateThickness + bearingDia, $fn = 50);
        translate([-chimeraBowdenSpacing / 2,0,-beltClampHeight / 2 - mountPlateThickness - 1])
        cylinder(d = chimeraBowdenDia, h = mountPlateThickness + bearingDia, $fn = 50);
        
        // mounting bolts
        translate([0,-3,-beltClampHeight / 2 - mountPlateThickness - 0.5])
        cylinder(d = 3.5, h = mountPlateThickness + 1, $fn = 50);
        translate([chimeraBoltSpacing / 2,9,-beltClampHeight / 2 - mountPlateThickness - 0.5])
        cylinder(d = 3.5, h = mountPlateThickness + 1, $fn = 50);
        translate([-chimeraBoltSpacing / 2,9,-beltClampHeight / 2 - mountPlateThickness - 0.5])
        cylinder(d = 3.5, h = mountPlateThickness + 1, $fn = 50);
        
        // mounting bolt heads
        translate([0,-3,-beltClampHeight / 2])
        cylinder(d = 6.5, h = mountPlateThickness + beltClampHeight, $fn = 50);
        translate([chimeraBoltSpacing / 2,9,-beltClampHeight / 2])
        cylinder(d = 6.5, h = mountPlateThickness + beltClampHeight, $fn = 50);
        translate([-chimeraBoltSpacing / 2,9,-beltClampHeight / 2])
        cylinder(d = 6.5, h = mountPlateThickness + beltClampHeight, $fn = 50);
        
        // slot for cables
        translate([-13,-mountWidth / 2 - 1,-beltClampHeight / 2 - mountPlateThickness - 1])
        cube([8, 13, mountPlateThickness + 2]);
        // slot for cables
        //translate([8,-26,-beltClampHeight / 2 - mountPlateThickness])
        //cube([5, 12, mountPlateThickness + 1]);
        
        
        
    }
}

module cableSupport() {
    difference() {
        translate([5,-mountWidth / 2 + 12,-beltClampHeight / 2]) {
            //cube([18,3,beltClampHeight + 2]);
            translate([-27,0,0])
            cube([18,3,beltClampHeight]);
            
            //translate([0,mountWidth / 2 + 3,0])
            //cube([18,3,beltClampHeight + 2]);
            translate([-27,mountWidth / 2 + 3,0])
            cube([18,3,beltClampHeight]);
        }
        translate([10, -mountWidth / 2 + 14, 6])
        rotate([90, 0, 0])
        cylinder(d=3.5, h = 5, center = true, $fn = 50);
        translate([-10, -mountWidth / 2 + 14, 6])
        rotate([90, 0, 0])
        cylinder(d=3.5, h = 5, center = true, $fn = 50);
    }
}

module touchMount() {
    // vertical section
    translate([0,0,-beltClampHeight / 2 - touchMountDrop - touchMountThickness])
    translate([bearingClampDiameter / 2 + xAxisBarSpacing / 2 - 2, -touchMountLength / 2, 0])
    cube([touchMountThickness, touchMountLength, beltClampHeight / 2 + touchMountDrop + touchMountThickness]);
    
    difference() {
        // horizontal section
        translate([0,0,-beltClampHeight / 2 - touchMountDrop - touchMountThickness])
        translate([bearingClampDiameter / 2 + xAxisBarSpacing / 2, -touchMountLength / 2, 0])
        cube([touchMountWidth, touchMountLength, touchMountThickness]);
        
        translate([0,0,-beltClampHeight / 2 - touchMountDrop - touchMountThickness])
        translate([bearingClampDiameter / 2 + xAxisBarSpacing / 2 + touchMountWidth / 2 + 2, -touchMountBoltSpacing / 2, -1])
        cylinder(d = 4.3, h = touchMountThickness + 2, $fn = 50);
        
        translate([0,0,-beltClampHeight / 2 - touchMountDrop - touchMountThickness])
        translate([bearingClampDiameter / 2 + xAxisBarSpacing / 2 + touchMountWidth / 2 + 2, touchMountBoltSpacing / 2, -1])
        cylinder(d = 4.3, h = touchMountThickness + 2, $fn = 50);
    }
}

module xAxisBlank() {
    difference() {
        union() {
            translate([-xAxisBarSpacing / 2,0,0])
            bearingClamp(0.5);
            translate([xAxisBarSpacing / 2,0,0])
            rotate([0,0,180])
            bearingClamp(0.5);
            
            translate([0,0,-beltClampHeight / 2 - mountPlateThickness / 2])
            cube([xAxisBarSpacing, mountWidth, mountPlateThickness], center = true);
            
             // cable supports
            translate([-mountWidth / 2 + 12])
            cableSupport();
            
            translate([beltClampBlockLength / 2 + beltThickness / 2,mountWidth / 2 - totalClampWidth / 2 - beltClampFilletWidth,0])
            mirror([0,1,0])
            doubleClamp();
            translate([beltClampBlockLength / 2 + beltThickness / 2,-mountWidth / 2 + totalClampWidth / 2 + beltClampFilletWidth,0])
            doubleClamp();
        }
        translate([-xAxisBarSpacing / 2,0,0])
        bearingClamp(0.5, true);
        translate([xAxisBarSpacing / 2,0,0])
        rotate([0,0,180])
        bearingClamp(0.5, true);
    }
    
    
}

module bearingClamp(extraSpace = 0, cutoutsOnly = false) {
    bearingSpace = (mountWidth - ((bearingLength + extraSpace) * 2)) / 2;
    bearingLip = bearingDia + 10;
    bearingOverlap = bearingClampDiameter / 7;
    lipThickness = 2;
    
    if (!cutoutsOnly) {
        translate([0,-mountWidth / 2, 0])
        rotate([-90,0,0])
        difference() {
            union() {
                cylinder(d = bearingClampDiameter, h = mountWidth, $fn = 50);
                translate([-bearingClampDiameter / 2,0,0])
                cube([bearingClampDiameter, mountPlateThickness + beltClampHeight / 2, mountWidth]);
                //translate([0,beltClampHeight / 2,0])
                //cube([xAxisBarSpacing / 2, mountPlateThickness, mountWidth]);
            }
            bearingClampCutouts(bearingSpace, extraSpace, bearingOverlap, lipThickness);
        }
    } else {
        translate([0,-mountWidth / 2, 0])
        rotate([-90,0,0])
        bearingClampCutouts(bearingSpace, extraSpace, bearingOverlap, lipThickness);
    }
}

module bearingClampCutouts(bearingSpace, extraSpace, bearingOverlap, lipThickness) {
    translate([0,0,-2])
    cylinder(d = bearingInnerClampDiameter, h = mountWidth + 4, $fn = 50);
    translate([0,0,bearingSpace])
    cylinder(d = bearingDia + extraSpace, h = bearingLength * 2 + extraSpace, $fn = 50);
    translate([0,0,bearingSpace + bearingLength + extraSpace])
    cylinder(d = bearingDia + extraSpace, h = bearingLength + extraSpace, $fn = 50);
    //translate([-11, bearingOverlap + lipThickness, -2])
    //cube([17, bearingClampDiameter * 4, mountWidth + 4]);
    //translate([-bearingInnerClampDiameter / 2, 0, -2])
    //cube([bearingInnerClampDiameter, bearingClampDiameter * 4, mountWidth + 4]);
    
    translate([-bearingInnerClampDiameter / 2, 0, -2])
    cube([bearingInnerClampDiameter, bearingClampDiameter * 4, mountWidth + 4]);
    
    translate([-bearingDia / 2 + bearingClipStep / 2, 0, bearingSpace])
    cube([bearingDia - bearingClipStep, bearingClampDiameter * 4, bearingLength * 2 + extraSpace]);
}

module doubleClamp() {
    rotate([0,0,180]) {

    translate([-beltClampBlockLength / 2, -beltClampBlockWidth - beltGap / 2, -beltClampHeight / 2])
    cube([beltClampBlockLength, beltClampBlockWidth, beltClampHeight + additionalBeltClampHeight]);
    translate([-beltClampBlockLength / 2, beltClampBlockWidth * 2 + beltGap / 2 - beltClampBlockWidth, -beltClampHeight / 2])
    mirror([0,1,0])
    beltClamp(beltClampBlockWidth, beltClampBlockLength);
    
    translate([beltClampBlockLength / 2 - mountPlateThickness / 2, beltClampBlockWidth + beltClampFilletWidth / 2 + beltGap / 2, (beltClampHeight + additionalBeltClampHeight) / 2 -beltClampHeight / 2])
    cube([mountPlateThickness, beltClampFilletWidth, beltClampHeight + additionalBeltClampHeight], center = true);
    }
}

module beltClamp(width = 5, length = 20, cornerDia = 3) {
    difference() {
        hull() {
            cube([2,2,beltClampHeight + additionalBeltClampHeight]);
            translate([length - 2, 0, 0])
            cube([2,2,beltClampHeight + additionalBeltClampHeight]);
            translate([cornerDia / 2, width - cornerDia / 2, 0])
            cylinder(d = cornerDia, h = beltClampHeight + additionalBeltClampHeight, $fn = 50);
            translate([length - cornerDia / 2, width - cornerDia / 2, 0])
            cylinder(d = cornerDia, h = beltClampHeight + additionalBeltClampHeight, $fn = 50);
        }
        for (i = [0:beltToothPitch:length]) {
            translate([i,width,0])
            cylinder(d = beltToothDia, h = beltClampHeight + additionalBeltClampHeight, $fn = 50);
        }
        chamfer();
    }
}


module chamfer() {
    translate([0,beltClampBlockWidth,beltClampHeight +  + additionalBeltClampHeight - beltClampChamfer / 2.7])
    rotate([0,90,0])
    cylinder(d = beltClampChamfer * 1.5, h = beltClampBlockLength, $fn = 3);
}