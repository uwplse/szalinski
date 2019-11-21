// ****************************************************************************
// Customizable Smartphone Holders
// to mount your smartphone to a tripod or elsewhere using an action cam hook
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

// for thingiverse:
SmartphoneHolder([PhoneName, PhoneWidth, PhoneHeight, PhoneDepth,
    PhoneCornerRoundingRadius, PhoneEdgeRoundingRadius, 
    PhoneCamPos, CamSlotHeight], MountPos);

// for manual rendering:
// SmartphoneHolder(phone=PhoneiPhone8,mountPos="bottom");

// render only the middle hook
// MiddleHook("female");

// parameters for thingiverse customizer:

/* [Phone] */
// Name of the phone
PhoneName= "Samsung S8";
// Width of the phone
PhoneWidth= 68;
// Height of the phone
PhoneHeight= 149.5;
// Depth/ thickness of the phone - add 0,5mm here!
PhoneDepth= 8.5;
// Rounding radius of the four corners
PhoneCornerRoundingRadius= 12;
// Rounding radius of the edges at all sides
PhoneEdgeRoundingRadius= 2.5;
// Position of the camera, when looking from the front
PhoneCamPos= 0; // [0:Mid,1:Left,2:Right]
// Height of the space for the camera (only required if on left/right side):
CamSlotHeight= 22;

/* [Mounting] */
// Mount at bottom or mid of holder
MountPos= "mid"; // [bottom,mid]
// Bracket thickness
th= 2;
// Bottom thickness
bt= 4;
// Precision of curves
$fn=75;

/* [Hidden] */
// constants for the camera position
CamPosMid= 0;
CamPosLeft= 1;
CamPosRight= 2;

// you may use these pre-defined models in the call below
PhoneSamsungS4= ["Samsung S4", 70, 137, 8, 12, 2, CamPosMid];
PhoneSamsungS5= ["Samsung S5", 73, 143, 8.5, 12, 2, CamPosMid];
PhoneSamsungS6= ["Samsung S6", 70, 144, 8, 12, 2, CamPosMid];
PhoneSamsungS7= ["Samsung S7", 71, 144, 8, 12, 2, CamPosMid];
PhoneSamsungS8= ["Samsung S8", 68, 149.5, 8.5, 12, 2.5, CamPosMid];
PhoneiPhone4= ["iPhone 4", 59.6, 116.2, 10.3, 10, 2, CamPosRight,16];
PhoneiPhone5= ["iPhone 5", 59, 124, 8, 10, 2, CamPosRight,18];
PhoneiPhone6= ["iPhone 6", 67.5, 138.5, 7.5, 10, 2, CamPosRight,20];
PhoneiPhone7= ["iPhone 7", 67.5, 139, 8, 10, 2, CamPosRight,22];
PhoneiPhone8= ["iPhone 8", 68, 139, 8, 10, 2, CamPosRight,22];
PhoneiPhone8Plus= ["iPhone 8 Plus", 78.5, 159, 8, 10, 2, CamPosRight,22];
PhoneiPhoneX= ["iPhone X", 71, 144, 8, 10, 2, CamPosRight,38];
PhoneLG_G6= ["LG G6", 72, 149, 8.5, 8, 2, CamPosMid];
NintendoSwitch= ["Nintendo Switch", 102, 173.5, 15, 1.1, 0.5, CamPosMid];

/*
difference() {
    SmartphoneHolder(phone=NintendoSwitch,mountPos="mid");
    translate([0,0,-5]) cube([200,200,5]);
}
*/
// MiddleHook("female");

// ////////////////////////////////////////////////////////////////
// Holder
module SmartphoneHolder(phone=PhoneSamsungS6, mountPos="mid") {
    if (parametersHaveErrors(phone)) {
        rotate([45,0,45]) color("red") {
            translate([0,30,0]) text("You need to use dots '.'", size=5, valign="center", halign="center");
            translate([0,20,0]) text("instead of commas ','", size=5, valign="center", halign="center");
            translate([0,10,0]) text("for the decimal places,", size=5, valign="center", halign="center");
            translate([0,0,0]) text("or better, round the values up!", size=5, valign="center", halign="center");
        }
    } else {
        SmartphoneHolderI(phone, mountPos);
    }
}

function parametersHaveErrors(phone) =
    phone[1]+phone[2]+phone[3]+phone[4]+phone[5]==undef;

module SmartphoneHolderI(phone, mountPos) {
    // edge rounding radius should be a small value
    er= min(phone[5], phone[4]/2-0.01, 3);
    // the four corners
    // lower left
    if (phone[6]!=CamPosLeft) { 
        HolderCorner(phone,er);
    } else {
        HolderEdge(phone,er);
    }
    // lower right
    translate([phone[2]+2*th,0,0]) rotate([0,0,90]) 
        HolderCorner(phone,er);
    // upper left
    if (phone[6]!=CamPosRight) { 
        translate([0,phone[1]+2*th,0]) rotate([0,0,-90]) 
            HolderCorner(phone,er);
    } else {
        translate([0,phone[1]+2*th,0]) 
        mirror([0,1,0]) HolderEdge(phone,er);
    }
    // upper right
    translate([phone[2]+2*th,phone[1]+2*th,0]) rotate([0,0,180]) 
        HolderCorner(phone,er); 

    difference() {
        union() {
            // the oval half rings
            rd= phone[4]+th;
            // left half ring
            difference() {
                translate([th+2,th+phone[1]/2,0]) rotate([0,0,-90]) 
                    halfOvalRing(phone[1]/2,phone[2]/2,bt+th,th,er);
                    // remove outer roundings from the oval rings
                    roundCut(phone);
                    translate([0,phone[1]+2*th,-0.01]) rotate([0,0,-90]) 
                        roundCut(phone);
            }
            // right half ring
            difference() {
                translate([th+phone[2]-2,th+phone[1]/2,0]) rotate([0,0,90]) 
                    halfOvalRing(phone[1]/2,phone[2]/2,bt+th,th,er);
                translate([phone[2]+2*th,0,-0.01]) rotate([0,0,90]) 
                    roundCut(phone);
                translate([phone[2]+2*th,phone[1]+2*th,-0.01]) rotate([0,0,180]) 
                    roundCut(phone);
            }
            // mounting support
            if (mountPos=="mid") {
                // plate in the middle
                translate([th+phone[2]/2,th+phone[1]/2,0])
                    translate([0,0,(th+bt)/2]) cubeR([26,26,th+bt],2, true);
            } else if (mountPos=="bottom") {
                translate([th+phone[2]/2,0,0]) {
                    // plate from mid to bottom
                    hull() {
                        translate([0,th+phone[1]/2,0]) fring(r=4, th=th+bt);
                        translate([0,0,(th+bt)/2]) 
                            cube([12,1,th+bt],center=true);
                    }
                    rotate([90,0,0]) hull() {
                        // translate([0,7.5,0]) fring(r=3.5, th=6);
                        translate([0,11,0]) scale([1,0.3,1]) cylinder(r=6, h=6);
                        translate([0,0.5,(th+bt)/2]) cube([12,1,6],center=true);
                    }
                    // action cam hook here
                    translate([0,-18,6]) rotate([90,0,0]) 
                        ActionCamRingsMale(16, true);
                }
            }
        }
        // for camera at one side, remove tail of the arm
        if (phone[6]==CamPosLeft) {
            translate([0,0,-0.01]) cube([phone[7]+2,25,25]);
        } else if (phone[6]==CamPosRight) {
            translate([0,phone[1]-25+2*th,-0.01]) cube([phone[7]+2,25,25]);
        }
        if (mountPos=="mid") {
            // holes for screws
            translate([th+phone[2]/2,th+phone[1]/2,0]) {
                translate([0,0,-0.01]) fourScrews(16,16,3.3,th+bt+0.02);
                translate([0,0,(th+bt)/2]) fourScrews(16,16,6.3,th+bt+0.02);
            }
            // stamp phone name into mounting square
            translate([th+phone[2]/2,th+phone[1]/2,th+bt-0.5]) 
                linear_extrude(1)
                    text(phone[0], size=3, valign="center", halign="center");
        } else {
            // stamp phone name into mounting arm
            translate([th+phone[2]/2,th+phone[1]/2,th+bt-0.5]) rotate([0,0,-90]) 
                linear_extrude(1)
                    text(phone[0], size=4, valign="center", halign="left");
        }
    }
    if (mountPos=="mid") {
        translate([th+phone[2]/4,th+phone[1]/2,0]) MiddleHook("male");
        translate([th+phone[2]*3/4,th+phone[1]/2,0]) MiddleHook("female");
    }
}

module roundCut(phone) {
    rd= phone[4]+th;
    difference() {
        cube([rd, rd, rd+th+bt]);
        translate([rd,rd,-0.01]) cylinder(r=phone[4],h=rd+th+bt+0.02);
    }
}

module MiddleHook(hooks) {
    h= 20;
    difference() {
        union() {
            translate([0,0,(th+bt)/2]) cubeR([26,26,th+bt],2, true);
            if (hooks == "male") {
                translate([0,0,h]) ActionCamRingsMale(h, true);
            } else {
                translate([0,0,h]) ActionCamRingsFemale(h, true);
            }
        }
        translate([0,0,-0.01]) fourScrews(16,16,3,th+bt+0.02);
        translate([0,0,(th+bt)/2]) fourScrews(16,16,6.3,(th+bt)/2+2,6);
    }
}

// phone=PhoneSamsungS6;
// ovalRing(phone[1]/2,phone[2]/2,bt+th,2+th,phone[5],180);
// halfOvalRing(phone[1]/2,phone[2]/2,bt+th,2+th,phone[5],180);
// ////////////////////////////////////////////////////////////////
// Oval ring with a constant diameter
// Used to form the arms
module halfOvalRing(w, d, h, rth, rr) {
    difference() {
        difference() {
            scale([1,d/w,1]) fring(w-rth/2, h);
            translate([-0.01,-0.01,-0.01]) scale([1,(d-rth)/(w-rth),1]) difference() {
                cylinder(r=w-rth, h=h+0.02);
                translate([0,0,h/2]) ring(w-rth, h);
            }
        }
        translate([-w-th-0.01,-d-3*th-0.05,-0.01]) 
            cube([2*(w+th), d+3*th+0.05, h+0.03]);
    }
}

// ////////////////////////////////////////////////////////////////
// One corner of the holder
module HolderCorner(phone,er) {
    difference() {
        hull() {
            wl= max(phone[4]+th,10);
            tl= max(er,3);
            // corner
            translate([phone[4]+th,phone[4]+th,0]) rotate([0,0,180]) 
                qwheel(phone[4]+th,phone[3]+2*th+bt,er);
            // x longhole
            translate([wl,tl,phone[3]+er+bt]) rotate([0,90,0]) 
                longHole(radius=tl, length=phone[3]-2*tl+2*th+bt, 
                         height=2);
            // y longhole
            translate([tl,wl,phone[3]+er+bt]) rotate([0,90,90]) 
                longHole(radius=tl, length=phone[3]-2*tl+2*th+bt, 
                         height=2);
        }
        translate([th,th,th+bt]) Smartphone(phone,er);
    }
}


// ////////////////////////////////////////////////////////////////
// Edge, used for smartphones with the camera at one side
module HolderEdge(phone,er) {
    h= bt+th;
    y2= phone[2]/2-sqrt((phone[2]/2)*(phone[2]/2)-phone[7]*phone[7])+2*(bt+th);
    difference() {
        union() {
            // upper part - short to not cover the display much
            translate([phone[7],0,0]) cubeR([15,8,phone[3]+2*th+bt],2, false);
            // lower part - longer to cover the arm
            translate([phone[7],0,0]) cubeR([15,y2,h+2],2, false);
        }
        translate([th,th,th+bt]) Smartphone(phone,er);
    }
}

// ////////////////////////////////////////////////////////////////
// Smartphone model
module Smartphone(phone=PhoneSamsungS6, er=2) {
    hull() {
        translate([phone[2]-phone[4],phone[1]-phone[4],0]) 
            qwheel(phone[4],phone[3],er);
        translate([phone[2]-phone[4],phone[4],0]) rotate([0,0,-90]) 
            qwheel(phone[4],phone[3],er);
        translate([phone[4],phone[4],0]) rotate([0,0,180]) 
            qwheel(phone[4],phone[3],er);
        translate([phone[4],phone[1]-phone[4],0]) rotate([0,0,90]) 
            qwheel(phone[4],phone[3],er);
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

// quater ring, also works with older OpenSCAD versions
module qwheelBike(wr, rr) {
    difference() {
        rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
        translate([-wr-0.01,-wr-0.01,-rr-0.01]) cube([2*wr+0.02,wr+0.01,2*rr+0.02]);
        translate([-wr-0.01,-wr-0.01,-rr-0.01]) cube([wr+0.01,2*wr+0.02,2*rr+0.02]);
    }
}

// ////////////////////////////////////////////////////////////////
// rounded button - lower part is a cylinder, upper part like a filled ring
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
// a ring with a radius and a thickness
// else same as wheelBike
// r - radius
// th - thickness
module ring(r, th) {
    rotate_extrude(convexity= 4, $fn= 100)
        translate([r, 0, 0])
            circle(r = th/2, $fn = 100);
}

// ////////////////////////////////////////////////////////////////
// filled ring - like a round cheese
// fring(20,4);
module fring(r, th) {
    rotate_extrude(convexity= 4, $fn= 100) {
        translate([r, th/2, 0]) 
            circle(r = th/2, $fn = 100);
        square([r,th]);
    }
}

// generic long hole
module longHole(radius, length, height) {
    hull() {
        cylinder(r=radius, h=height);
        translate([length,0,0]) cylinder(r=radius, h=height);
    }
}

// ////////////////////////////////////////////////////////////////
// cube with rounded corners
module cubeR(dims, rnd=1, centerR= false) {
    translate(centerR?[-dims[0]/2,-dims[1]/2,-dims[2]/2]:[]) {
        hull() {
            translate([rnd,rnd,rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,rnd,rnd]) sphere(r=rnd);
            translate([rnd,dims[1]-rnd,rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,dims[1]-rnd,rnd]) sphere(r=rnd);

            translate([rnd,rnd,dims[2]-rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,rnd,dims[2]-rnd]) sphere(r=rnd);
            translate([rnd,dims[1]-rnd,dims[2]-rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,dims[1]-rnd,dims[2]-rnd]) sphere(r=rnd);
        }
    }
}

// ////////////////////////////////////////////////////////////////
// two rings for action cam mount
module ActionCamRingsMale(l, base, adj=-0.25, center= true) {
    translate(center ? [(-9-adj)/2,0,0] : [0,6,l]) {
        if (base) {
            translate([0,-6,-l]) cube([9+adj, 12, 3]);
        }
        for (i= [0, 6]) {
            translate ([i, 0, 0]) ActionCamOneRing(l, adj);
        }
    }
}

// ////////////////////////////////////////////////////////////////
// three rings for action cam mount
module ActionCamRingsFemale(l, base, adj= -0.25, center= true) {
    translate(center ? [(-15-adj)/2,0,0] : [0,6,l]) {
        if (base) {
            translate([0,-6,-l]) cube([15+adj, 12, 3]);
        }
        for (i= [0, 6, 12]) {
            translate ([i, 0, 0]) ActionCamOneRing(l, adj);
        }
    }
}

// one ring, helper for action cam hooks
module ActionCamOneRing(l, adj) {
    rotate([90, 0, 90]) difference() {
        hull() {
            cylinder(r=6, h=3+adj);
            translate([-6, -l, 0]) cube([12,1,3+adj]);
        }
        translate([0,0,-0.01]) cylinder(r=3, h=3.02+adj);
    }
}

// four holes in a square 
// x, y: distances of mid points
// d: screw diameter
// h: nut height
module fourScrews(x, y, d, h, fn=20) {
    translate([x/2,y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
    translate([-x/2,y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
    translate([x/2,-y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
    translate([-x/2,-y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
}

// ////////////////////////////////////////////////////////////////
// a pipe - a hollow cylinder
module pipe(outerRadius, thickness, height) {
    difference() {
        cylinder(h=height, r=outerRadius);
        translate([0, 0, -0.1]) cylinder(h=height+0.2, r=outerRadius-thickness);
    }
}

// ////////////////////////////////////////////////////////////////
// a half pipe
module halfPipe(outerRadius, thickness, height) {
    difference() {
        pipe(outerRadius, thickness, height);
        translate([-outerRadius, -outerRadius, -0.01]) 
            cube([2*outerRadius, outerRadius, height+0.02], center=false);
    }
}

// ////////////////////////////////////////////////////////////////
// a quarter of a pipe
module quarterPipe(outerRadius, thickness, height) {
    difference() {
        pipe(outerRadius, thickness, height);
        translate([-outerRadius, -outerRadius, -0.01]) 
            cube([2*outerRadius, outerRadius, height+0.02], center=false);
        translate([-outerRadius, 0, -0.01]) 
            cube([outerRadius, outerRadius, height+0.02], center=false);
    }
}