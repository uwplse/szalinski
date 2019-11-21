// J1772-to-Tesla mounting bracket adapter
// Copyright (c) 2019 by Rod Smith
// Licensed under the terms of the GNU GPL, v.2

// This Thing is designed to mount in a J1772 mounting holster,
// converting it for use with a Tesla charging cable or a J1772
// cable with a Tesla J1772 charging adapter connected.
// This should help simplify a switch from a non-Tesla EV or
// PHEV to a Tesla, or use of a non-Tesla EVSE if you simply
// prefer one to Tesla's own Wall Connector.
//
// I've tested this design with the Clipper Creek J1772 holster
// and with a generic one I happened to have on hand. I cannot
// guarantee that it will work with anything else; you may need
// to adjust some parameters....

//
// Global parameters....
//

// Segments per circle....
$fn=120;

// Position of tab for latching onto Tesla plug or adapter
teslaTabHeight = 20;

// Maximum height of the inner ring
ringHeight = 26;

// Diameter of the inner ring; should not normally be changed
ringDiameter = 43.5;

// Height of the outer base
baseHeight = 5;

// Extra radius for base
baseWidth = 10;

//
// Support functions....
//

// Create a hole for the Tesla plug....
module TeslaPlugShape(tHeight=22) {
    sideOffsetX = 9.5;
    sideOffsetY = 2;
    sideCylinderD = 60;
//    hull() {
//        translate([-20, 16, 0]) cylinder(d=3, h=tHeight);
//        translate([20, 16, 0]) cylinder(d=3, h=tHeight);
//        translate([0, 17, 0]) cylinder(d=3, h=tHeight);
//        translate([-18, -16, 0]) cylinder(d=3, h=tHeight);
//        translate([18, -16, 0]) cylinder(d=3, h=tHeight);
//        translate([0, -20, 0]) cylinder(d=3, h=tHeight);
//    }
    intersection() {
        // Top part....
        translate([0, -24, 0]) cylinder(d=80, h=tHeight);
        // Bottom part....
        translate([0, 7.5, 0]) cylinder(d=55, h=tHeight);
        // Side parts....
        translate([sideOffsetX, sideOffsetY, 0])
            cylinder(d=sideCylinderD, h=tHeight);
        translate([-sideOffsetX, sideOffsetY, 0])
            cylinder(d=sideCylinderD, h=tHeight);
    }
} // module TeslaPlugShape()
//
//// Create a hole for the Tesla plug....
//module TeslaPlugShape(tHeight=22) {
//    sideOffsetX = -1;
//    sideOffsetY = -0;
//    sideCylinderD = 44;
//    intersection() {
//        // Top part....
//        translate([0, -23, 0]) cylinder(d=80, h=tHeight);
//        // Bottom part....
//        translate([0, 1, 0]) cylinder (d=ringDiameter, h=tHeight);
//        // Side parts....
//        translate([sideOffsetX, sideOffsetY, 0])
//            cylinder(d=sideCylinderD, h=tHeight);
//        translate([-sideOffsetX, sideOffsetY, 0])
//            cylinder(d=sideCylinderD, h=tHeight);
//    }
//} // module TeslaPlugShape()

// Create a right-angle wedge with the specified dimensions
module RaWedge(width, depth, height) {
    translate([width, 0, 0]) rotate([90,0,-90]) linear_extrude(width)
        polygon(points=[[0, 0], [0, height], [depth, 0]]);
} // module RaWedge()


//
// Main part components....
//

// Create a wider base. This prevents inserting the adapter
// too deep into the J1772 holster and provides a way to attach
// the clip to the main body of the adapter.
module Base() {
    translate([0, 0, -baseHeight]) difference() {
        cylinder(d=ringDiameter+baseWidth, h=baseHeight);
        translate([0, 0, -1]) TeslaPlugShape(baseHeight+2);
    }
} // module Base()

// Create a framing ring that partially surrounds the Tesla
// connector, which both stabilizes the Tesla connector and
// helps keep the adapter from wobbling in the J1772 holster....
module AdapterRing() {
    difference() {
        cylinder(d=ringDiameter, h=ringHeight);
        translate([0,0,-1]) TeslaPlugShape(ringHeight+2);
        translate([-ringDiameter/2,-2,8])
            cube([ringDiameter, ringDiameter/1.5, ringHeight+2]);
        translate([-ringDiameter/2, -2, 0])
            cube([ringDiameter, 13, ringHeight+2]);
        hull() {
            translate([10,4,ringDiameter-4]) sphere(d=ringDiameter*1.25);
            translate([-10,4,ringDiameter-4]) sphere(d=ringDiameter*1.25);
        }
    } // difference()
} // module AdapterRing()

// Create a tab along the side (bottom of the adapter when in use)
// that helps position the adapter in the J1772 holster....
module PositionTab() {
    translate([-4, -2-ringDiameter/2, -baseHeight])
        cube([8, 2.5, ringHeight+baseHeight]);
} // module PositionTab()

// Create a simple latch to hold the adapter in place....
module J1772Latch() {
    latchHeight = 30 + baseHeight;
    latchWidth = 10;
    latchDepth = 12;
    translate([-latchWidth/2, ringDiameter/2 + 4, -baseHeight]) {
        difference() {
            cube([latchWidth, latchDepth, latchHeight]);
            rotate([-20, 0, 0]) translate([-1, latchDepth/2, 1])
                cube([latchWidth + 2, latchDepth, latchHeight/1.5]);
            translate([-1, -1, baseHeight])
                cube([latchWidth + 2, 6, ringHeight - 5]);
            translate([-1, -5, latchHeight]) rotate([-45, 0, 0]) 
                cube([latchWidth + 2, 7, 9]);
            //#cube([latchWidth+2, latchDepth, latchHeight]);
        } // difference()
        translate([0, -8, 0]) cube([latchWidth, 9, baseHeight]);
    } // translate()
} // module J1772Latch()

// Create a tab onto which the Tesla plug hooks when it's
// inserted in the adapter....
module TeslaTab() {
    tabX = 8;
    tabY = 2;
    tabZ = 3;
    translate([-tabX/2, -tabY/2, 0]) cube([tabX, tabY, tabZ]);
    translate([-tabX/2, -tabY/2, 0]) rotate([180, 0, 0])
        RaWedge(tabX, tabY, 3);
} // module TeslaTab()


//
// Main body of the design....
//

Base();
AdapterRing();
PositionTab();
J1772Latch();
translate([0, -20, teslaTabHeight - baseHeight]) TeslaTab();