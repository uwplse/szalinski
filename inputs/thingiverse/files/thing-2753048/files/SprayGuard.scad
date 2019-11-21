// ****************************************************************************
// Spray Guard - put this on hair spray cans to protect the printer
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

CanDiameter= 49;
HoleFromTop= 14;
FunnelRadius= 50;
FunnelLength= 60;
$fn=200;

SprayGuard();

// ****************************************************************************
// Spray Guard
// ****************************************************************************
module SprayGuard() {
    r= CanDiameter/2;
    difference() {
        union() {
            // Ring around the can
            CanRing(2,40);
            // Smaller stopper ring at the top
            translate([0,0,40]) CanRing(4,2);
            // Make sure there is no hole above the can cover
            intersection() {
                CanRing(2,80);
                translate([0,0,7]) rotate([0,-90,0]) FunnelAdd();
            }
        }
        // beveling to reach the spray button
        translate([0,-r-2.01,40]) rotate([0,40,0]) translate([-10,0,0]) 
            cube([CanDiameter,CanDiameter+4.02,CanDiameter]);
        // Spray out opening
        translate([-r-2,0,40-HoleFromTop]) rotate([0,90,0]) cylinder(r=5,h=10);
    }
    difference() {
        translate([0,0,7]) rotate([0,-90,0]) SprayFunnel();
        // remove can space
        cylinder(r=r,h=60);
    }
}

// The ring around the can
module CanRing(th, h) {
    pipe(CanDiameter/2+2,th,h);
}

// The front side funnel
module SprayFunnel() {
    intersection() {
        // Spray funnel
        difference() {
            FunnelAdd();
            FunnelRem();
        }
        // rounded "cap style"
        translate([FunnelLength,FunnelLength,0]) rotate([90,0,0]) 
            cylinder(r= FunnelLength,h= 2*FunnelLength);
    }
}

module FunnelAdd() {
    cylinder(r1=20,r2=FunnelRadius,h=FunnelLength);
}

module FunnelRem() {
    translate([0,0,-0.01]) cylinder(r1=18,r2=FunnelRadius-2,h=FunnelLength+0.02);
}

// ////////////////////////////////////////////////////////////////
// a pipe - a hollow cylinder
module pipe(outerRadius, thickness, height) {
    difference() {
        cylinder(h=height, r=outerRadius);
        translate([0, 0, -0.1]) cylinder(h=height+0.2, r=outerRadius-thickness);
    }
}