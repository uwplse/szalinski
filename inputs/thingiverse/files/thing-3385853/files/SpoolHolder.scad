/////////////////////////////////////////
// Parametric Spool/Reel holder        //
// Author: Ennis Massey                //
// Date: Fri Jan 25 21:37:08 NZDT 2019 //
// Version: 2.0                        //
/////////////////////////////////////////

/* [Render Settings] */

// Check this when creating the STL file to increase quality of the render
renderMode = false;



/* [Holder Parameters] */

// The inner width (from side to side) of the cable spool
spoolInnerWidth = 28.3;
// The outer width (from side to side) of the cable spool
spoolOuterWidth = 33.9;

spoolOuterDiameter = 69.2;
spoolOuterRadius = spoolOuterDiameter / 2;

spoolInnerDiameter = 25.4;
spoolInnerRadius = spoolInnerDiameter / 2;

numOfCables = 8;
cableWidth = 0.4;
enableCableGuides = true;
cableRouterHeight = 15;

// How high to make the base everything sits on
baseHeight = 5;
// Spacing around the central spool area. Data should be entered as [left and right, front and back]
baseSpacing = [8, 10];
// How much space to put between the central spool area and the holder and cable guides
leeway = 2;

enableConnectors = [false, false];


// Assertions



// Holder Base
module HolderBase() {
        
        difference() {
                minkowski() {
                        cube([spoolOuterWidth + (baseSpacing[0]*2), spoolOuterDiameter + (baseSpacing[1] * 2), baseHeight - 1]);
                        cylinder(r=2, h=baseHeight - (baseHeight - 1), $fs = 0.1);
                }
                translate([baseSpacing[0], baseSpacing[1], 3]) {
                    color("green", 1.0) {
                        cube([spoolOuterWidth, spoolOuterDiameter, 3], false);
                    }
                }
        }
}


module HolderArms() {
        difference() {
                polyhedron(
                        points=[
                                [0,0,0],
                                [holderArmWidth(), 0, 0],
                                [holderArmWidth(), spoolOuterDiameter, 0],
                                [0, spoolOuterDiameter, 0],
                                [holderArmWidth(), (spoolOuterDiameter / 4) * 1, spoolOuterRadius + baseHeight],
                                [holderArmWidth(), (spoolOuterDiameter / 4) * 3, spoolOuterRadius + baseHeight],
                                [0, (spoolOuterDiameter / 4) * 3, spoolOuterRadius + baseHeight],
                                [0, (spoolOuterDiameter / 4) * 1, spoolOuterRadius + baseHeight]
                        ],
                        faces=[
                                [0, 1, 2, 3], // BOTTOM
                                [5, 2, 1, 4], // RIGHT
                                [3, 6, 7, 0], // LEFT
                                [7, 6, 5, 4], // TOP
                                [7, 4, 1, 0], // FRONT
                                [5, 6, 3, 2]
                        ]
                );
                union() {
                        translate([0, spoolOuterDiameter / 2, spoolOuterRadius + baseHeight]) rotate([90, 0, 90]) {
                                cylinder(r = spoolRodRadius(), h = (holderArmWidth() / 3), $fs = 0.01, $fn = 150);
                        }
                        translate([holderArmWidth() / 3, spoolOuterDiameter / 2, spoolOuterRadius + baseHeight]) rotate([90, 0, 90]) {
                                cylinder(r = spoolRodRadius() - 1.5, h = (holderArmWidth() / 3), $fs = 0.01, $fn = 150);
                        }
                        translate([(holderArmWidth() / 3) * 2, spoolOuterDiameter / 2, spoolOuterRadius + baseHeight]) rotate([90, 0, 90]) {
                                cylinder(r = spoolRodRadius(), h = (holderArmWidth() / 3), $fs = 0.01, $fn = 150);
                        }
                }
        }

}

module HolderRod() {
        color("cyan", 0.8) {
        difference() {
                cylinder(r = spoolRodRadius() - 0.2, h = spoolOuterWidth + (baseSpacing[0] * 2) , $fs = 0.01, $fn = 150);

                translate([0, 0, (holderArmWidth() / 3)-0.5]) difference() {
                        cylinder(r = spoolRodRadius(), h = (holderArmWidth() / 3) + 1, $fs = 0.01, $fn = 150);
                        cylinder(r = spoolRodRadius() - 2.0, h = (holderArmWidth() / 3) + 1, $fs = 0.01, $fn = 150);
                }

                translate([0, 0, baseSpacing[0] +leeway + spoolOuterWidth + (holderArmWidth() / 3)-0.5]) difference() {
                        cylinder(r = spoolRodRadius(), h = (holderArmWidth() / 3) + 1, $fs = 0.01, $fn = 150);
                        cylinder(r = spoolRodRadius() - 2.0, h = (holderArmWidth() / 3) + 1, $fs = 0.01, $fn = 150);
                }
        }
        }
}

module HolderCableGuide() {
        difference() {
                union() {
                        cube([spoolOuterWidth + (baseSpacing[0] *2), 7, cableRouterHeight]);
                        cube([holderArmWidth(), baseDepth() / 2, cableRouterHeight]);
                        translate([spoolOuterWidth + (baseSpacing[0] + leeway), 0, 0]) cube([holderArmWidth(), baseDepth() / 2, cableRouterHeight]);
                }
                if(numOfCables > 1) {
                        startPoint = (baseWidth() / 2) - ((cableWidth + 3) * (numOfCables / 2) + 1.5) ;
                        for (i=[0:numOfCables]) {
                                translate([startPoint + ((cableWidth + 3) * i), 0, cableRouterHeight - (cableGuideWidth() + cableGuideEntryWidth())] ) {
                                        difference() {
                                        cube([cableGuideWidth(), 7,startPoint + ((cableWidth + 3))]);
                                        translate([0, 0, cableGuideWidth()]) cube([cableGuideEntryWidth(), 7, cableGuideEntryWidth()]);
                                        }
                                }
                        }

                } else { 
                        translate([baseWidth() / 2, 0, cableRouterHeight - (cableGuideWidth() + cableGuideEntryWidth())]) union() {
                                cube([cableGuideWidth(), 7, cableGuideWidth()]);
                                translate([0, 0, cableGuideWidth()]) cube([cableGuideEntryWidth(), 7, cableGuideEntryWidth()]);
                        }
                }
        }

}




module Spool() {
        difference() {
                cylinder(r = spoolOuterRadius, h = spoolOuterWidth, $fn = 150);
                cylinder(r = spoolInnerRadius, h = spoolOuterWidth, $fn = 150);
                translate([0, 0, spoolOuterWidth - spoolInnerWidth]) {
                        difference() {
                                cylinder(r=spoolOuterRadius, h= spoolOuterRadius - (spoolOuterWidth - spoolInnerWidth)*2, $fn = 150);
                                cylinder(r=spoolInnerRadius+(spoolOuterWidth-spoolInnerWidth), h= spoolOuterRadius - (spoolOuterWidth - spoolInnerWidth)*2, $fn=150); 
                        }
                }
        }
}
function baseDepth(baseSpacing = [8, 10]) = spoolOuterDiameter + (baseSpacing[1] * 2); // body...;
function spoolRodRadius() = spoolInnerRadius / 1.5;
function holderArmWidth() = baseSpacing[0] - leeway;
function cableGuideWidth() = cableWidth*3;
function cableGuideEntryWidth() = (cableWidth + (cableWidth / 3));
function baseWidth() = spoolOuterWidth + (baseSpacing[0] * 2);







// OpenSCAD settings
if(renderMode == true) {
        $fn = 0;
        $fa = 50;
} else {
        $fn = 50;
        $fs = 1;
}

union() {
        HolderBase();
        translate([0, baseSpacing[1], baseHeight])  HolderArms();
        translate([baseSpacing[0] + leeway + spoolOuterWidth, baseSpacing[1], baseHeight])  HolderArms();
        HolderCableGuide();
}






if (renderMode == true) {
        translate([-(spoolRodRadius() * 2), spoolRodRadius(), 0]) HolderRod();
} else {
        rotate([90, 0, 90]) translate([baseDepth() /2 , spoolOuterRadius + (baseHeight * 2)]) {
                HolderRod();
        }
        rotate([90, 0, 90]) translate([baseDepth() /2 , spoolOuterRadius + (baseHeight * 2), holderArmWidth()+ leeway]) {
                Spool();
        }
        
}
