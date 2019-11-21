// ****************************************************************************
// Cooling fan tube for Wanhao Duplicator i3 Plus
// v1.1 - changed mounting screw positions, changed tube for cooling duct
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language
// include <threads.scad> // http://dkprojects.net/openscad-threads/

// Angle of cooling ring, 0 for none
angle=270; // [0:360]

// Tilt of cooling ring
tilt=0; // [-10:10]

fast= true;

// SimpleCooler();
CoolingDuct(angle, tilt);

// ****************************************************************************
// Simple cooler, matches the original one, but is a little bit less high
// ****************************************************************************
module SimpleCooler(simple= true) {
    difference() {
        union() {
            difference() {
                cover(41,44,25);
                // translate([2,9,-0.01]) cover(38,23,23);
                translate([2,2,-0.01]) cover(37,40,23);
                if (simple) {
                    translate([41-10,-0.01,22]) cube([11,45,5]);
                } else {
                    translate([-0.01,-0.01,8]) cube([43,45,20]);
                }
            }
            translate([41/2,41/2+3,0]) {
                translate([-16,-16,0]) nutBlock(3);
                translate([-16,16,0]) nutBlock(5);
                translate([16,-16,0]) nutBlock(3);
                translate([16,16,0]) nutBlock();
            }
        }
        translate([-0.01,41/2-15-2,4.5]) rotate([0,90,0]) mt(length=10);
        translate([-0.01,41/2+15-2,4.5]) rotate([0,90,0]) mt(length=10);
    }
}

// the simple cover
module cover(x, y, z) {
    translate([0,y,0]) rotate([90,0,0]) 
        linear_extrude(height=y,convexity=4) 
            polygon([[0,0],[x,0],[x,z],[0,0.33*z]], [[0,1,2,3]], convexity=2);
}

// a block with a screw nut
module nutBlock(wp=0) {
    difference() {
        translate([-9/2,-9/2-wp,0]) cube([9,9+wp,25*0.33]);
        translate([0,0,-0.001]) mt(length=10);
    }
}

// a thread or a simple cylinder for faster rendering and smaller stls
// as the M3 threads seem to be beyond the resolution of the Wanhao, the fast
// way seems to be good enough
module mt(length=10) {
    if (fast) {
        cylinder(r=3/2-0.1,h=length,$fn=20);
    } else {
        metric_thread (diameter=3, pitch=0.4, length=length, internal=true);
    }
}


// ****************************************************************************
// More sophisticated cooling duct
// ****************************************************************************
module CoolingDuct(angle=270, tilt=0) {
    difference() {
        union() {
            SimpleCooler(simple= false);
            tube(41,44, 6, 10);
            translate([35,23,23]) rotate([0,-tilt,0]) translate([0,0,28]) 
                rotate([90,0,0]) rotate([0,-90,0]) coolingRing(angle);
        }
        translate([2,2,-0.01]) tube(41-4,44-4, 5-2, 7);
        // open the simple case for the flat pipe
        translate([35,18,15]) rotate([0,0,90]) longHole(5,10,8);
    }
}

// the tube from the fan cube to the cooling ring
module tube(w, d, r, l) {
    hull() {
        translate([0,0,25*0.33-1]) cube([w, d, 1]);
        translate([35,18,20]) rotate([0,0,90]) longHole(r,l,1);
    }
}

// generic long hole
module longHole(radius, length, height) {
    hull() {
        cylinder(r=radius, h=height);
        translate([length,0,0]) cylinder(r=radius, h=height);
    }
}

// the cooling ring - a hollow 270 degrees ring
module coolingRing(angle=270) {
    if (angle>0) {
        router=28;
        rotate([0,0,-90-angle/2]) difference() {
            ringPart(r=router,th=6,a=angle);
            ringPart(r=router,th=4,a=360);
            translate([0,0,-4]) ringPart(r=router-5,th=4,a=360);
        }
    }
}

module ringPart(r, th, a) {
    rotate_extrude(angle=a, convexity = r, $fn = 100)
        translate([r, 0, 0]) circle(r = th, $fn = 25);
}