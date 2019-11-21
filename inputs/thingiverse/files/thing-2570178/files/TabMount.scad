// ****************************************************************************
// Customizable Tablet Mount for DJI Spark remote controller
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

$fn=50;

menu= "Phone Plate"; // [Phone Plate,Spacers,Tab Plate Left,Tab Plate Right]

// Name of the tab/ phablet - written on the upper plate
tabName= "Tab Name";
// Height (shorter side)
tabHeight= 126;
// Width (longer side)
tabWidth= 214;
// Thickness
tabThick= 8;
// Radius of corner roundings
tabRoundings= 9;
// Frame rounding from display to sides
tabFrameRoundings= 2;

// Length of the spacers between the plates
spacerLen= 60;


// make thingiverse customizer ignore these definitions:
function foo(x)= x;
// the phone dummy that goes into the Spark remote
phoneDummy= foo(["PhoneDummy", 80, 110, 8, 8, 2]);
// the inner plate of the tab holder - same x and y sizes as the phone dummy!
tabInnerPlate= foo(["tabInnerPlate", 80, 110, 7, 8, 2]);
// space to carve out of the phone dummy
phoneCarve= foo(["Carve out", 70, 50,12, 6, 2]);

// Samsung Galaxy Tab 8
tabGalaxyS8dot9= foo(["Galaxy Tab 8.9", 126, 214, 8, 9, 2]);
// Chuwi Hi 8 Pro
tabChuwiHi8Pro= foo(["Chuwi Hi8 Pro", 124, 212, 10, 9, 2]);

th= 2+0;

Menu();

// The menu for the thingiverse customizer
module Menu() {
    if (menu=="Phone Plate")  {
        PhonePlate(phoneDummy);
    } else if (menu=="Spacers")  {
        Spacers();
    } else if (menu=="Tab Plate Left")  {
        // TabPlateLeft(tabChuwiHi8Pro);
        TabPlateLeft([tabName,tabHeight,tabWidth,tabThick,
                      tabRoundings,tabFrameRoundings]);
    } else if (menu=="Tab Plate Right")  {
        // TabPlateRight(tabChuwiHi8Pro);
        TabPlateRight([tabName,tabHeight,tabWidth,tabThick,
                       tabRoundings,tabFrameRoundings]);
    }
}

// the complete upper plate - only for large 3D printers
// TabPlate(tabChuwiHi8Pro);

module TabPlateLeft(tab) {
    difference() {
        TabPlatePart(tab);
        tabLRSpaces(tab);
    }
}

module TabPlateRight(tab) {
    difference() {
        translate([tab[2]+2*th,tab[1]+2*th,0]) rotate([0,0,180]) TabPlatePart(tab);
        tabLRSpaces(tab);
    }
}

module tabLRSpaces(tab) {
    translate([(tab[2]+2*th-tabInnerPlate[2])/2,
               (tab[1]+2*th+tabInnerPlate[1])/2,tabInnerPlate[3]]) 
      rotate([180,0,0]) {
        TwoClipSpaces(tabInnerPlate);
        translate([tabInnerPlate[2],0,0]) mirror([1,0,0]) 
            TwoClipSpaces(tabInnerPlate, 2);
    }
    translate([th+tab[2]/2,th+tab[1]/2,tabInnerPlate[3]-0.5]) 
        linear_extrude(1)
            text(tab[0], size=8, valign="center", halign="center");
}

// ////////////////////////////////////////////////////////////////
// A half tab plate and brackets
module TabPlatePart(tab) {
    xm= (tab[2]+2*th)/2;
    ym= (tab[1]+2*th)/2;
    y0= (tab[1]+2*th-tabInnerPlate[1])/2;
    ye= (tab[1]+2*th+tabInnerPlate[1])/2;
    difference() {
        TabPlate2(tab);
        // cutting lines
        // segment 1, 3, 5
        translate([xm+5, -0.01, -0.01]) 
            cube([xm+0.01, tab[1]+2*th+0.02, 5.02+tab[3]+2*th]);
        // segment 2
        translate([xm-5.2, y0+7-0.2, -0.01]) 
            cube([11, 7+0.4, 5.02+tab[3]+2*th]);
        // segment 4
        translate([xm-5.2, ym-0.2, -0.01]) 
            cube([11, ye-ym-14+0.4, 5.02+tab[3]+2*th]);
        // segment 6
        translate([xm-5.2, ye-7-0.2, -0.01]) 
            cube([11, 7.21, 5.02+tab[3]+2*th]);
        // screw thread hole
        translate([xm, y0, tabInnerPlate[3]/2]) rotate([-90,0,0]) cylinder(r=1.6,h=tab[1]);
        // screw head hole
        translate([xm, y0-0.01, tabInnerPlate[3]/2]) rotate([-90,0,0]) cylinder(r=3,h=3);
    }
}

// ////////////////////////////////////////////////////////////////
// The complete tab plate and holder in one piece - only for large 3D printers
module TabPlate(tab) {
    difference() {
        // brackets and inner frame
        TabPlate2(tab);
        translate([(tab[2]+2*th-tabInnerPlate[2])/2,
                   (tab[1]+2*th+tabInnerPlate[1])/2,tabInnerPlate[3]]) 
            rotate([180,0,0]) {
            // left side clip spaces
            TwoClipSpaces(tabInnerPlate);
            // right side clip spaces
            translate([tabInnerPlate[2],0,0]) mirror([1,0,0]) TwoClipSpaces(tabInnerPlate);
        }
        translate([th+tab[2]/2,th+tab[1]/2,tabInnerPlate[3]-0.5]) 
            linear_extrude(1)
                text(tab[0], size=8, valign="center", halign="center");
    }
}

// ////////////////////////////////////////////////////////////////
// Tab brackets and inner plate without holes
module TabPlate2(tab) {
    // tab brackets
    TabHolder(tab);
    translate([(tab[2]+2*th-tabInnerPlate[2])/2,
           (tab[1]+2*th+tabInnerPlate[1])/2,tabInnerPlate[3]]) 
        rotate([180,0,0]) Smartphone(tabInnerPlate);
}

// ////////////////////////////////////////////////////////////////
// The phone-like plate that goes into the Spark remote controller
module PhonePlate(phone) {
    difference() {
        Smartphone(phone);
        TwoClipSpaces(phone);
        ThirdClipSpace(phone);
        translate([phone[2],0,0]) mirror([1,0,0]) {
            TwoClipSpaces(phone);
            ThirdClipSpace(phone);
        }
        translate([(phone[2]-phoneCarve[2])/2,(phone[1]-phoneCarve[1])/2,2])
            Smartphone(phone=phoneCarve);
    }
}

// ////////////////////////////////////////////////////////////////
// Draw space for two spacers
module TwoClipSpaces(phone) {
    translate([0,10+3,phone[3]/2]) {
        ClipSpace(10,15);
    }
    translate([0,phone[1]-10-3,phone[3]/2]) {
        ClipSpace(10,15);
    }
}

// ////////////////////////////////////////////////////////////////
// Draw space for third spacer
module ThirdClipSpace(phone) {
    fy= sqrt(spacerLen*spacerLen-(spacerLen-8)*(spacerLen-8));
    // echo(fy);
    alpha= asin((spacerLen-8)/spacerLen);
    // echo(alpha);
    translate([0,10+3+fy+8,phone[3]/2]) mirror([0,1,0]) {
        ClipSpace(16,15);
        ClipSpace(10,alpha);
    }
}

// ////////////////////////////////////////////////////////////////
// Draw space for one spacer, using a given angle
module ClipSpace(sh,alpha) {
    translate([sh+3,0,0]) {
        rotate([90,-alpha,90]) Spacer(outer=true);
        rotate([90,-90,90]) Spacer(outer=true);
    }
    translate([-0.01,0,0]) {
        rotate([0,90,0]) cylinder(r=1.55,h=25);
        rotate([0,90,0]) cylinder(r=3.2,h=3);
    }
}

// ////////////////////////////////////////////////////////////////
// A set of spacers
module Spacers() {
    for (a= [1:6]) {
        translate([0,10*(a-1),0]) Spacer();
    }
}

// ////////////////////////////////////////////////////////////////
// A single spacer
module Spacer(outer= false) {
    sc= outer ? 1.05 : 1.0;
    translate([0,0,-sc*6/2]) {
        difference() {
            hull() {
                cylinder(r=sc*4,h=sc*6);
                translate([spacerLen,0,0]) cylinder(r=sc*4,h=sc*6);
            }
            if (!outer) {
                translate([0,0,-0.01]) {
                    cylinder(r=1.7,h=6.02);
                    translate([spacerLen,0,0]) cylinder(r=1.7,h=6.02);
                }
            }
        }
    }
}

// ////////////////////////////////////////////////////////////////
// Draw the model of a smartphone
module Smartphone(phone) {
    hull() {
        translate([phone[2]-phone[4],phone[1]-phone[4],0]) 
            qwheel(phone[4],phone[3],phone[5]);
        translate([phone[2]-phone[4],phone[4],0]) rotate([0,0,-90]) 
            qwheel(phone[4],phone[3],phone[5]);
        translate([phone[4],phone[4],0]) rotate([0,0,180]) 
            qwheel(phone[4],phone[3],phone[5]);
        translate([phone[4],phone[1]-phone[4],0]) rotate([0,0,90]) 
            qwheel(phone[4],phone[3],phone[5]);
    }
}

// ////////////////////////////////////////////////////////////////
// a quater wheel with an outer wheel radius, an outer height and a rounding radius
module qwheel(wr, h, rr, center=false) {
    translate([0,0,center?-h/2:0]) {
        hull() {
            translate([0,0,h-rr]) qwheelBike(wr, rr);
            translate([0,0,rr]) qwheelBike(wr, rr);
        }
    }
}

// doesn't work in thingiverse customizer
module qwheelBike2016(wr, rr) {
    rotate_extrude(convexity= 2,angle=90) translate([wr-rr, 0, 0]) circle(r=rr);    
}

module qwheelBike(wr, rr) {
    difference() {
        rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
        translate([-wr-0.01,-wr-0.01,-rr-0.01]) cube([wr+0.02,2*wr+0.02,2*rr+0.02]);
        translate([-0.01,-wr-0.01,-rr-0.01]) cube([wr+0.02,wr+0.01,2*rr+0.02]);
    }
}


// ////////////
// Holder.scad

bpThick= 5;

module TabHolder(phone=tabGalaxyS8dot9) {
    // the four corners
    HolderCorner(phone);
    translate([phone[2]+2*th,0,0]) rotate([0,0,90]) 
        HolderCorner(phone);
    translate([0,phone[1]+2*th,0]) rotate([0,0,-90]) 
        HolderCorner(phone);
    translate([phone[2]+2*th,phone[1]+2*th,0]) rotate([0,0,180]) 
        HolderCorner(phone);
    difference() {
        union() {
            // the oval rings
            translate([th+5,th+phone[1]/2,0]) rotate([0,0,-90]) 
                halfOvalRing(phone[1]/2,phone[2]/2,bpThick+th);
            translate([th+phone[2]-5,th+phone[1]/2,0]) rotate([0,0,90]) 
                halfOvalRing(phone[1]/2,phone[2]/2,bpThick+th);
        }
    }
}

// half an oval ring - a filled ring with a concave inner ring cut out
// hack for Thingiverse customizer, which uses a too old version of OpenSCAD
module halfOvalRing(w, d, h) {
    difference() {
        ovalRing(w, d, h);
        translate([-w-0.01,-d-0.01,-0.01]) cube([2*w+0.02,d+0.02,h+0.02]);
    }
}

// an oval ring - a filled ring with a concave inner ring cut out
module ovalRing(w, d, h, angle=360) {
    difference() {
        scale([1,d/w,1]) fring(w-h/2, h, angle);
        translate([-0.01,-0.01,-0.01]) scale([1,(d-4)/(w-4),1]) difference() {
            cylinderA(w-4, h+0.02, angle);
            translate([0,0,4/2]) ring(w-4, h, angle);
        }
    }
}

module HolderCorner(phone=tabGalaxyS8dot9) {
    difference() {
        hull() {
            // corner
            translate([phone[4]+th,phone[4]+th,0]) rotate([0,0,180]) 
                qwheel(phone[4]+th,phone[3]+2*th+bpThick,phone[5]);
            // x longhole
            translate([phone[4]+th,phone[5],phone[3]+phone[5]+bpThick]) 
                rotate([0,90,0]) longHole(radius=phone[5], 
                                   length=phone[3]-2*phone[5]+2*th+bpThick, height=5);
            // y longhole
            translate([phone[5],phone[4]+th,phone[3]+phone[5]+bpThick]) 
                rotate([0,90,90]) longHole(radius=phone[5], 
                                    length=phone[3]-2*phone[5]+2*th+bpThick,height=5);
        }
        translate([th,th,th+bpThick]) Smartphone(phone);
    }
}

// ////////////////////////////////////////////////////////////////
// rounded button
// r= outer radius
// h= height
// rr= upper rounding
module buttonRound(r, h, rr) {
    hull() {
        translate([0,0,h-rr]) wheelBike(r, rr);
        cylinder(r=r,h=h-rr);
    }
}



// ////////////////////////////////////////////////////////////////
// a pipe - a hollow cylinder
module pipe(outerRadius, thickness, height) {
    difference() {
        cylinder(h=height, r=outerRadius);
        translate([0, 0, -0.1]) 
            cylinder(h=height+0.2, r=outerRadius-thickness);
    }
}

// ////////////////////////////////////////////////////////////////
// a ring with a radius and a thickness
// else same as wheelBike
// r - radius
// th - thickness
// angle - 360 or part of ring
module ring(r, th, angle) {
    rotate_extrude(convexity= 4, angle= angle, $fn= 100)
        translate([r, 0, 0])
            circle(r = th/2, $fn = 100);
}

// filled ring
module fring(r, th, angle=360) {
    rotate_extrude(convexity= 4, angle= angle, $fn= 100) {
        translate([r, th/2, 0]) 
            circle(r = th/2, $fn = 100);
        square([r,th]);
    }
}

// a pie piece - a part of a cylinder
module cylinderA(r, h, angle) {
    rotate_extrude(convexity= 4, angle= angle, $fn= 100)
        square([r,h]);
}

// generic long hole
module longHole(radius, length, height) {
    hull() {
        cylinder(r=radius, h=height);
        translate([length,0,0]) cylinder(r=radius, h=height);
    }
}
