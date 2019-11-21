// ****************************************************************************
// Customizable Resistor Rack and Drawers
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

// rack total height = n * (drawer height +2 * spc +1) +2 * rack wall thickness -1
// e.g. 87 = 7 * (10+2*0.5 +1) +2*2 -1

// what to build
menu= "Model"; // [Rack,OneDrawer,TwoDrawers,Model]
// Build a light rack - less solid, but faster to print
light= "yes"; // [yes,no]

/* [Rack Overall] */
// width of the rack
rackWidth= 187;
// depth of the rack
rackDepth= 76.5;
// height of the rack
rackHeight= 87;
// rack wall thickness
rackWall= 2;
// number of drawers
rackDrawers= 7;
// spacings between parts
spc= 0.5;

/* [Drawers] */
drawerWidth= rackWidth-2*(rackWall+spc);
drawerDepth= rackDepth-(rackWall+spc);
drawerHeight= (rackHeight-2*rackWall+1)/rackDrawers-2*spc-1;
drawerWall= 1.4;
// Number of drawers in the rack
drawerSlots= 12; // [1:20]
// outer radius of the drawer handle
drawerGripRadius= 10;

$fn=100;

echo(str("Drawer Height: ",drawerHeight));
echo(str("Drawer Slot Width: ",(drawerWidth-drawerWall)/drawerSlots));

Menu();

module Menu() {
    if (menu=="Rack") {
        translate([0,0,rackDepth]) rotate([-90,0,0]) Rack();
    } else if (menu=="Model") {
        Model();
    } else {
        Drawer();
        if (menu=="TwoDrawers") {
            translate([drawerWidth,2*drawerDepth+1,0]) rotate([0,0,180]) Drawer();
        }
    }
}

// ///////////////////////////////////////////////////////////////////////////
// a model of the rack and its drawers
// ///////////////////////////////////////////////////////////////////////////
module Model() {
    color("black") Rack();
    for (a= [1:rackDrawers]) {
        translate([rackWall+spc,0,2+spc+(a-1)*(drawerHeight+2*spc+1)]) {
            color("white") Drawer();
        }
    }
}

// ///////////////////////////////////////////////////////////////////////////
// the rack
// ///////////////////////////////////////////////////////////////////////////
module Rack() {
    difference() {
        // the box
        cube([rackWidth,rackDepth,rackHeight]);
        // the empty space inside
        translate([rackWall,-0.01,rackWall]) {
            cube([rackWidth-2*rackWall, 
                rackDepth-rackWall,rackHeight-2*rackWall]);
        }
        if (light=="yes") {
            // back side
            translate([0,rackDepth,0]) rotate([90,0,0]) 
                LightMask(rackWidth,rackHeight,rackWall);
            // bottom - better not, doesn't print well
            // translate([0,0,0]) 
                // LightMask(rackWidth,rackDepth,rackWall);
            // left
            translate([0,0,0]) rotate([90,0,90])
                LightMask(rackDepth,rackHeight,rackWall);
            // right
            translate([rackWidth-rackWall,0,0]) rotate([90,0,90])
                LightMask(rackDepth,rackHeight,rackWall);
        }
    }
    // drawer separators if desired
    if (rackDrawers > 1) {
        for (a= [1:rackDrawers]) {
            translate([0,drawerWall+spc,1+a*(drawerHeight+2*spc+1)]) {
                // cube([rackWidth,rackDepth-(drawerWall+spc),1]);
                if (a < rackDrawers) {
                    RackSep();
                }
                translate([rackWall+drawerWall+1,0,-drawerHeight/4]) DropStop();
                translate([rackWidth-(rackWall+drawerWall+1+drawerHeight/2),0,
                    -drawerHeight/4]) 
                    DropStop();
            }
        }
    }
}

// ///////////////////////////////////////////////////////////////////////////
// Test masking
// ///////////////////////////////////////////////////////////////////////////
// LightTest();
module LightTest() {
    w= 150;
    d= 100;
    h= 2;
    difference() {
        cube([w, d, h]);
        LightMask(w, d, h);
    }
}

// ///////////////////////////////////////////////////////////////////////////
// Maks out parts of the walls to speed up printing
// ///////////////////////////////////////////////////////////////////////////
module LightMask(w, d, h) {
    MaskPart(w, d, h);
    translate([w, d, 0]) rotate([0,0,180]) MaskPart(w, d, h);
    translate([w, 0, 0]) rotate([0,0,90]) MaskPart(d, w, h);
    translate([0, d, 0]) rotate([0,0,-90]) MaskPart(d, w, h);
}

// ///////////////////////////////////////////////////////////////////////////
// Part of the mask
// ///////////////////////////////////////////////////////////////////////////
module MaskPart(w, d, h) {
    r= min(w, d)/16;
    translate([0,0,-0.05]) {
        hull() {
            translate([2*r,4*r,-0.01]) cylinder(r= r, h= h+0.1);
            translate([2*r,d-4*r,-0.01]) cylinder(r= r, h= h+0.1);
            translate([w/2-2*r,d/2,-0.01]) cylinder(r= r, h= h+0.1);
        }
    }
}

// ///////////////////////////////////////////////////////////////////////////
// small stoppers for drawers to stop them from falling out of the rack
// ///////////////////////////////////////////////////////////////////////////
// DropStop();
module DropStop() {
    rotate([90,0,90]) 
        linear_extrude(height= drawerHeight/2,convexity=2) 
            polygon(points=[[0,0],[0,drawerHeight/4],[drawerHeight/2,drawerHeight/4]]);
}

// ///////////////////////////////////////////////////////////////////////////
// one drawer
// ///////////////////////////////////////////////////////////////////////////
module Drawer() {
    difference() {
        // the box
        cube([drawerWidth, drawerDepth,drawerHeight]);
        // the empty space inside
        translate([drawerWall,drawerWall,drawerWall]) {
            cube([drawerWidth-2*drawerWall, 
                drawerDepth-2*drawerWall,drawerHeight]);
        }
    }
    // the grip
    translate([drawerWidth/2,0,0]) Grip();
    // inner slots if desired
    if (drawerSlots > 1) {
        for (a= [1:drawerSlots-1]) {
            translate([a*(drawerWidth-1)/drawerSlots,0,0]) 
                cube([1,drawerDepth,drawerHeight-1]);
        }
    }
}

// ///////////////////////////////////////////////////////////////////////////
// drawer grip
// ///////////////////////////////////////////////////////////////////////////
module Grip() {
    gh= max(drawerWall,2);
    difference() {
        cylinder(r=drawerGripRadius,h=gh);
        translate([0,0,-0.01]) {
            translate([-drawerGripRadius,0,0]) 
                cube([2*drawerGripRadius,drawerGripRadius,gh+0.02]);
            cylinder(r=drawerGripRadius/2,h=gh+0.02);
        }
    }
}

// ///////////////////////////////////////////////////////////////////////////
// separation plates between drawers
// ///////////////////////////////////////////////////////////////////////////
// RackSep();
module RackSep() {
    lrWidth= rackWall+drawerWall+1+drawerHeight/2;
    // left part
    cube([lrWidth,rackDepth-(drawerWall+spc),1]);
    translate([lrWidth,lrWidth,0]) cylinder(r=lrWidth,h=1);
    translate([lrWidth,lrWidth,0]) cube([lrWidth,rackDepth-(drawerWall+spc)-lrWidth,1]);
    // mid part
    difference() {
        translate([0,rackDepth-(drawerWall+spc)-2*lrWidth,0]) cube([rackWidth,2*lrWidth,1]);
        translate([0,0,-0.1]) hull() {
            translate([3*lrWidth,rackDepth-(drawerWall+spc)-2*lrWidth,0]) 
                cylinder(r=lrWidth,h=1.2);
            translate([rackWidth-3*lrWidth,rackDepth-(drawerWall+spc)-2*lrWidth,0]) 
                cylinder(r=lrWidth,h=1.2);
        }
    }
    // right part
    translate([rackWidth-lrWidth,0,0])
        cube([rackWall+drawerWall+1+drawerHeight/2,rackDepth-(drawerWall+spc),1]);
    translate([rackWidth-lrWidth,lrWidth,0]) cylinder(r=lrWidth,h=1);
    translate([rackWidth-2*lrWidth,lrWidth,0]) 
        cube([lrWidth,rackDepth-(drawerWall+spc)-lrWidth,1]);
}
