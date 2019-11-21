/*
Trekking pole basket for Outdoor Products trekking poles.
Author: Carl Howard

Some poles may have different thread pitch.
Measure yours and set thread_pitch accordingly.

*/

$fn=180; // use fine circle resolution

thread_pitch = 0.4; // roughly 0.4mm per thread

union() {
    difference() {
        union() {
            central_body();
            outer_skirt();
            bracing_detail();
        }
        translate([18,0,0]) cylinder(d=10, h=11); // hole for locking feature
        translate([18,-3.2,0]) cube([10, 6.4, 20]); // gap for locking feature
        translate([14,8,0]) cylinder(d=3.5, h=11); // mfg hole (?)
    }
}

module central_body() {
    t = 0.5;
    difference() {
        cylinder(d1=20, d2=17.2, h=23); // main body
        cylinder(d=15.5, h=4); // base insert
        translate([0,0,4]) cylinder(d1=15.2, d2=13, h=2); // taper thread start
        translate([0,0,4]) thread(13/2+t,15/2+t,thread_pitch,10); // threads
        translate([0,0,14]) cylinder(d=13.6, h=10); // top hole above threads
    }
}

module skirt_body() {
    union() {
        translate([0,0,2]) cylinder(d1=20, d2=46, h=6); // slope
        translate([0,0,8]) cylinder(d1=46, d2=48, h=1); // transition
        translate([0,0,9]) cylinder(d=48, h=4); // rim
    }
}

module outer_skirt() {
    difference() {
        skirt_body();
        cylinder(d1=19, d2=17, h=23); // leave space for main body
        // remove inner core
        translate([0,0,4]) cylinder(d1=20, d2=44, h=5); // slope
        translate([0,0,9]) cylinder(d=44, h=4); // rim
        // grips
        translate([0,0,13]) rotate([0,0,10]) rotate([0,90,0])
        for (a = [0:20:160])rotate([a,0,0]) cylinder(d=6, h=50, $fn=8, center=true);
    }
}

module bracing_detail() {
    difference() {
        intersection() {
            skirt_body();
            union() {
                // skirt supports
                for (a = [0:60:120])rotate([0,0,a]) cube([50,1.5,18], center=true);
                // pole locking feature
                translate([18,0,0]) cylinder(d=13, h=11);
            }
        }
        cylinder(d1=19, d2=17, h=23); // exclude central space for main body
    }
}

// my sinusoidal thread generator
module thread(r1, r2, pitch, h, res=20, $fn=180) {
    // r1 is inner thread radius.
    // r2 is outer thread radius.
    // pitch is threads per mm. (make negative for left handed threads)
    // h is thread height.
    // res is the vertical resolution in slices per mm.
    // $fn is number of points along thread perimiter.
    
    r = (r1 + r2)/2; // center radius
    a = (r2 - r1)/2; // radius amplitude
    dx = (360)/$fn; // angle step
    
    linear_extrude(height=h, slices=h*res, twist=-360*h*pitch)
    polygon( points=([for (x = [0:dx:360-dx]) [(r + a*sin(x))*sin(x), (r + a*sin(x))*cos(x)] ]));
}


