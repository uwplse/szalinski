// ****************************************************************************
// Socket Frame for power sockets, light switches, etc.
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language


/* [Outer dimensions] */
// Width of the frame
outerWidth= 68;
// Height of the frame
outerDepth= 68;
// Radius of the rounding
outerRounding= 5;
// Height at the outside
outerHeight= 6;
// Upper side edge rounding
rr2= 1; // [0:5]

/* [Inner Dimensions] */
// Width of the inner space
innerWidth= 50;
// Height of the inner space
innerDepth= 50;
// Radius of the rounding of the inner space
innerRounding=2;
// Height at the inside
innerHeight= 8;
// What to show inside the frame
innerStyle="Fixing 1"; // [Fixing 1,Fixing 2,Empty,Filled]
// Width of inner fixing
innerFixingWidth=0.5;

$fn=100;

Frame();

module Frame() {
    difference() {
        hull() {
            // outer frame
            Button(outerWidth, outerDepth, outerHeight, outerRounding);
            // inner frame
            translate([(outerWidth-innerWidth)/2,(outerDepth-innerDepth)/2,0]) 
                Button(innerWidth, innerDepth, innerHeight, innerRounding);
        }
        if (innerStyle!="Filled") {
            translate([(outerWidth-innerWidth)/2,(outerDepth-innerDepth)/2,-0.01]) 
                Button(innerWidth, innerDepth, innerHeight+5, innerRounding);
        }
    }
    if (innerStyle=="Fixing 1") {
        translate([(outerWidth-innerWidth)/2-2,(outerDepth-innerDepth)/2-2,-0.01])
            difference() {
                cube([innerWidth+4,innerDepth+4,1]);
                translate([2+innerFixingWidth,2+innerFixingWidth,-0.01]) 
                    ChamferedCube([innerWidth-2*innerFixingWidth,
                            innerDepth-2*innerFixingWidth,1.1],innerRounding+2);
            }
    } else if (innerStyle=="Fixing 2") {
        translate([(outerWidth-innerWidth)/2,(outerDepth-innerDepth)/2,0])
            difference() {
                RoundedBox1(innerWidth, innerDepth, 1, 0.1);
                translate([innerFixingWidth,innerFixingWidth,-0.01]) 
                    RoundedBox1(innerWidth-2*innerFixingWidth, 
                            innerDepth-2*innerFixingWidth, 1.02, innerRounding);
            }
    }
}

// /////////////////////////////////////////////////////////////////////
// Box with rounded corners at its upper side
module Button(w, d, h, rr) {
    hull() {
        // upperside shape
        translate([0,0,h-2*rr2]) RoundedBox2(w, d, rr);
        // bottom shape
        RoundedBox1(w, d, 1, rr);
    }
}

// /////////////////////////////////////////////////////////////////////
// a box with rounded corners at its sides
// used as the bottom shape
module RoundedBox1(w, d, h, rr) {
    linear_extrude(h) hull() {
        translate([rr,rr,0]) circle(r=rr);
        translate([w-rr,rr,0]) circle(r=rr);
        translate([rr,d-rr,0]) circle(r=rr);
        translate([w-rr,d-rr,0]) circle(r=rr);
    }
}

// /////////////////////////////////////////////////////////////////////
// a box with all rounded corners
// used as the top shape
module RoundedBox2(w, d, rr) {
    hull() {
        translate([rr,rr,rr2]) Wheel(rr, rr2);
        translate([w-rr,rr,rr2]) Wheel(rr, rr2);
        translate([rr,d-rr,rr2]) Wheel(rr, rr2);
        translate([w-rr,d-rr,rr2]) Wheel(rr, rr2);
    }    
}

// /////////////////////////////////////////////////////////////////////
// a wheel
module Wheel(wr, rr) {
    rotate_extrude(convexity = 4) translate([wr-rr, 0, 0]) circle(r=rr);    
}

// /////////////////////////////////////////////////////////////////////
// a cube with chamfered edges
// dims - dimensions - x, y, z
// ch - chamfering
module ChamferedCube(dims, c) {
    linear_extrude(dims[2]) 
        polygon([[c,0],[dims[0]-c,0],[dims[0],c],[dims[0],dims[1]-c],
                [dims[0]-c,dims[1]],[c,dims[1]],[0,dims[1]-c],[0,c]], 
                [[0,1,2,3,4,5,6,7]], convexity = 4);
}
