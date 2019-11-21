// ****************************************************************************
// DJI Phantom Landing gears - customizable in size
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

$fn=100;

// Your DJI Phantom copter:
dist= 51.5; // ["51.5:Phantom 2"]

// Height of the legs:
height= 130; // [40:200]


// What to render:
menu= "Show"; // [Show, Print gears, Print clip]

Menu();
// gearLeft();
// gearRight();
// clipGear();

module Menu() {
    if (menu=="Show") {
        show();
    } else if (menu=="Print gears") {
        print();
    } else { // print clip
        clipGear();
    }
}

module print() {
    translate([0,0,40]) {
        rotate([0,-90,0]) gearLeft();
        translate([-height-2,-14,0]) rotate([0,-90,180]) gearRight();
    }
}

module printClipGear() {
    // translate([-48,-44,0]) clipGear(); // w/left
    translate([-66,-85,5]) clipGear(); // w/right
}

module show() {
    // cube([103,103,1],center=true);
    translate([-dist,0,0]) gearLeft();
    translate([dist,0,0]) rotate([0,0,180]) gearRight();
    if (height >= 120) {
        cgh= height-10;
        translate([0,-dist-10,cgh]) clipGear();
    } else if (height >= 55) {
        cgh= height-25;
        translate([0,-dist-10,cgh]) clipGear();
    }
}

// gear with compass mount
module gearLeft() {
    z= min(90,height-20);
    gear();
    translate([-35+3,-dist-10,z]) rotate([0,0,-90]) compassMount();
}

// gear with can bus mount
module gearRight() {
    z= min(60,height-30);
    difference() {
        gear();
        // space for canbus soldered connectors
        translate([-35+4,-dist-14,z+2]) cube([2,8,21]);
    }
    translate([-35+3,-dist-10,z]) rotate([0,0,-90]) canBusMount();
}

// clip - optionally attach this between the two gears to improve stability
module clipGear() {
    difference() {
        union() {
            hull() {
                translate([-dist-35,0,0]) sphere(r=5);
                translate([dist+35,0,0]) sphere(r=5);
            }
            translate([-dist-35,0,0]) ring(10, 4.9);
            translate([dist+35,0,0]) ring(10, 4.9);
        }
        translate([-dist-35,0,-6]) cylinder(r=5,h=12);
        translate([dist+35,0,-6]) cylinder(r=5,h=12);
        
        translate([-dist-35-4.5,0,-6]) cube([9,11,11]);
        translate([dist+35-4.5,0,-6]) cube([9,11,11]);
    }
}

// draw one basic gear
module gear() {
    // back side plate until first sphere
    difference() {
        hull() {
            translate([0,dist,0]) rotate([0,0,-45]) basePlate(8.5,4);
            translate([-13,dist+10,5]) sphere(r=5);
        }
        translate([0,dist,0]) rotate([0,0,-45]) {
            translate([0,0,4]) basePlate(6,10);
            baseHoles();
        }
    }
    // front side plate until first sphere
    difference() {
        hull() {
            translate([0,-dist,0]) rotate([0,0,45]) basePlate(8.5,4);
            translate([-13,-dist-10,5]) sphere(r=5);
        }
        translate([0,-dist,0]) rotate([0,0,45]) {
            translate([0,0,4]) basePlate(6,10);
            baseHoles();
        }
    }

    r= -13+35+5;
    // quarter ring between plate and gear
    translate([-13,-dist-10,r]) rotate([-90,0,180]) quarterRing(r,5);
    // front vertical gear
    hull() {
        translate([-35,-dist-10,r]) cylinder(r=5,h=1);
        translate([-35,-dist-10,height]) sphere(r=5);
    }
    // quarter ring between plate and gear
    translate([-13,dist+10,r]) rotate([-90,0,180]) quarterRing(r,5);
    // back vertical gear
    hull() {
        translate([-35,dist+10,r]) cylinder(r=5,h=1);
        translate([-35,dist+10,height]) sphere(r=5);
    }
    // horizontal gear
    hull() {
        translate([-35,-dist-10,height]) sphere(r=5);
        translate([-35,dist+10,height]) sphere(r=5);
    }
    // stopper cubes
    translate([-40,-55,height]) cube([10,20,10]);
    translate([-40,35,height]) cube([10,20,10]);
}

// a long rounded plate
module basePlate(r,h) {
    hull() {
        translate([-7.5,0,0]) cylinder(r=r,h=h);
        translate([7.5,0,0]) cylinder(r=r,h=h);
    }
}

// the three holes in the mounting plates
module baseHoles() {
    translate([0,0,-0.01]) {
        // outer screw
        translate([-8.5,0,0]) cylinder(r=3.7/2,h=10.02);
        // cable port
        cylinder(r=4,h=10.02);
        // inner screw
        translate([8.5,0,0]) cylinder(r=3.7/2,h=10.02);
    }
}

// mount for the compass
module compassMount() {
    difference() {
        union() {
            // back side: half cylinder
            intersection() {
                cylinder(r=8,h=15);
                translate([-8,-8,0]) cube([16,8,15]);
            }
            // front side: cube
            translate([-8,0,0]) cube([16,3,15]);
        }
        // screw holes
        translate([0,3.01,7]) rotate([90,0,0]) 
            fourScrews(12.5,9.5,1.5,4);
    }
}

// mount for the CAN bus connector
module canBusMount() {
    difference() {
        union() {
            // back side: half cylinder
            intersection() {
                cylinder(r=8,h=25);
                translate([-8,-8,0]) cube([16,8,25]);
            }
            // front side: cube
            translate([-8,0,0]) cube([16,3,25]);
        }
        // screw holes
        translate([0,3.01,25/2]) rotate([90,0,0]) 
            fourScrews(12.8,22.2,1.5,4);
        // space for soldered pins on platine
        translate([-5,1.01,(25-20)/2]) cube([10,2,20]);
    }
}

// ////////////////////////////////////////////////////////////////////
// generic support stuff

// four screw nuts without threads - good for metal screws
// x, y: distances of mid points
// d: screw diameter
// h: nut height
module fourScrews(x, y, d, h) {
    translate([x/2,y/2,0]) cylinder(r=d/2,h=h);
    translate([-x/2,y/2,0]) cylinder(r=d/2,h=h);
    translate([x/2,-y/2,0]) cylinder(r=d/2,h=h);
    translate([-x/2,-y/2,0]) cylinder(r=d/2,h=h);
}

// a ring
// wr = outer radius
// rr = ring radius
module ring(wr, rr) {
    rotate_extrude(convexity = 4) translate([wr-rr, 0, 0]) circle(r=rr);    
}

// a half ring - works with OpenSCAD 2015 and earlier
module halfRing(wr, rr) {
    difference() {
        ring(wr, rr);
        translate([-wr, -wr, -rr]) cube([2*wr, wr, 2*rr]);
    }
}

// a quarter ring - works with OpenSCAD 2015 and earlier
module quarterRing(wr, rr) {
    difference() {
        halfRing(wr, rr);
        translate([-wr, -0.01, -rr]) cube([wr, wr+0.02, 2*rr]);
    }
}