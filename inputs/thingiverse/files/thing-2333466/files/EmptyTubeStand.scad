// ****************************************************************************
// Customizable parts for a stand from empty tubes
// with additions to create a stand for a camera gimbal or an action cam
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

// Radius of the [empty] tubes that go inside these parts.
radius= 8.1; // [1:100]

// Thickness of these parts
thickness= 1.9; // [1:10]

// Length of the shafts taking the tubes
len= 10; // [1:100]

$fn=50;

// what to print
menu="ShowActionCamStand"; // [EndFlat,EndRound,ConnectorMiddle,ConnectorCorner,ConnectorCornerGimbal,ActionCamMount,ShowActionCamStand,ShowGimbalStand]

// Number of (additional) tubes to attach, only used for ConnectorCorner and ConnectorMiddle
tubes= 2; // [0:5]

// Number of pieces to create
count= 1; // [1:10]

// For a gimbal stand, the distance between two diagonal dampers (mid points)
gimbalDamperDiaDistance= 90.5; // [50:200]
// 2*66;

Menu();
// ShowGimbalStand(71.8);
// ShowActionCamStand(80);

module Menu() {
    if (menu=="EndFlat") {
        EndFlat(count);
    } else if (menu=="EndRound") {
        EndRound(count);
    } else if (menu=="ConnectorMiddle") {
        ConnectorMiddle(tubes, count);
    } else if (menu=="ActionCamMount") {
        translate([0,0,radius+thickness]) rotate([-90,0,0]) 
            ConnectorMiddle(1, count, "ActionCamMount");
    } else if (menu=="ConnectorCorner") {
        ConnectorCorner(tubes, count);
    } else if (menu=="ConnectorCornerGimbal") {
        ConnectorCornerGimbal(tubes, count);
    } else if (menu=="ShowActionCamStand") {
        ShowActionCamStand(80);
    } else if (menu=="ShowGimbalStand") {
        ShowGimbalStand(gimbalDamperDiaDistance);
    }
}


// 0..4 or 5 for the side parts
module ConnectorMiddle(n, count, extras) {
    for (i=[1:count]) {
        translate([(i-1)*2*(radius+len+0.5),0,radius+thickness]) difference() {
            rot=[0,180,90,270];
            union() {
                for (a=[0:n]) {
                    rotate([0,0,rot[a]]) rotate([0,90,0]) 
                        cylinder(r=radius+thickness, h=len+radius);
                }
                if ("ActionCamMount"==extras) {
                    translate([0,0,radius+22]) ActionCamRingsFemale(25);
                }
            }
            for (a=[0:n]) {
                rotate([0,0,rot[a]]) translate([radius,0,0]) rotate([0,90,0]) 
                    cylinder(r=radius, h=len+0.01);
            }
        }
    }
}

module ConnectorCorner(n, count) {
    for (i=[0:count-1]) {
        translate([i*2*(radius+2)+i*len,0,radius+thickness]) {
            ConnectorCornerI(n);
        }
    }
}

// a corner connector with a gimbal hook
module ConnectorCornerGimbal(n, count) {
    for (i=[0:count-1]) {
        translate([i*2*(radius+thickness)+i*(len),-i*(len-10),radius+thickness]) {
            ConnectorCornerI(n, "Gimbal");
        }
    }
}

module ConnectorCornerI(n, extras) {
    rot=[0,0,180,270,90,180];
    difference() {
        union() {
            // Ball(radius, thickness)
            sphere(r=radius+thickness);
            cylinder(r=radius+thickness, h=len+radius);
            if (n >= 2) {
                for (a=[2:n]) {
                    rotate([0,0,rot[a]]) rotate([0,90,0]) 
                        cylinder(r=radius+thickness, h=len+radius);
                }
            }
            if ("Gimbal"==extras) {
                translate([0,0,-radius-thickness]) {
                    translate([-25,-25,0]) cylinder(r=4,h=5.1);
                    translate([-14.4,-14.4,5]) rotate([90,0,45]) halfRing(15,4);
                }
            }
        }
        translate([0,0,radius+0.01]) cylinder(r=radius, h=len);
        if (n >= 2) {
            for (a=[2:n]) {
                rotate([0,0,rot[a]]) translate([radius+0.01,0,0]) rotate([0,90,0]) 
                    cylinder(r=radius, h=len+radius+0.01);
            }
        }
    }
}

// End piece with a round end
// i number of piece being created
module EndRound(count) {
    for (i=[0:count-1]) {
        translate([i*2*(radius+thickness+0.5),0,radius+thickness]) {
            ConnectorCornerI(1);
        }
    }
}

// End piece with a flat end
// i number of pieces to create
module EndFlat(count) {
    for (i=[0:count-1]) {
        translate([i*2*(radius+thickness+0.5),0,0]) difference() {
            cylinder(r=radius+thickness, h=len);
            translate([0,0,thickness]) cylinder(r=radius, h=len);
        }
    }
}

module ShowActionCamStand(xy) {
    height= 100;
    for (a=[0:3]) {
        rotate([0,0,a*90]) translate([xy,-xy,0]) {
            translate([0,0,height]) rotate([180,0,0]) 
                ConnectorCornerI(3);
            color("darkgray") cylinder(r=radius,h=height);
            EndFlat(1);
        }
    }
    for (a=[0:3]) {
        rotate([0,0,a*90]) translate([-xy+radius,-xy,height]) 
            rotate([0,90,0]) color("darkgray") cylinder(r=radius,h=2*(xy-radius));
    }
    translate([0,-xy-radius-thickness,100]) rotate([-90,0,0]) 
        ConnectorMiddle(1, 1, "ActionCamMount");
    color("red") translate([0,-xy-35,0]) linear_extrude(1)
        text(str("For illustration only."), 
                size=20, valign="bottom", halign="center");
}

module ShowGimbalStand(gimbalDamperDiaDistance) {
    damperRadius= gimbalDamperDiaDistance/2;
    a= sqrt(damperRadius*damperRadius/2);
    xy= a+25; // ring offset

    height= 100;
    for (a=[0:3]) {
        rotate([0,0,a*90]) translate([xy,-xy,0]) {
            translate([0,0,height]) rotate([180,0,0]) 
                ConnectorCornerI(3, "Gimbal");
            color("darkgray") cylinder(r=radius,h=height);
            EndFlat(1);
        }
    }
    plen= 2*(xy-radius);
    color("red") translate([0,-xy-30,height]) linear_extrude(1)
        text(str("tube len: ", plen, " mm"), 
                size=20, valign="bottom", halign="center");
    for (a=[0:3]) {
        rotate([0,0,a*90]) translate([-xy+radius,-xy,height]) 
            rotate([0,90,0]) color("darkgray") cylinder(r=radius,h=plen);
    }
}


// /////////////////////////////////////////////////////////////
// Helpers

// Ball - a hollow sphere
module Ball(r, th) {
    difference() {
        sphere(r=radius+thickness);
        sphere(r=radius);
    }
}

// ////////////////////////////////////////////////////////////////
// a ring with a radius and a thickness
module ring(r, th) {
    rotate_extrude(convexity = 4, $fn = 100)
        translate([r, 0, 0])
            circle(r = th, $fn = 100);
}

// OpenSCAD before 2016.xx
module halfRing(r, th) {
    difference() {
        ring(r, th);
        translate([-r-th, -r-th, -th]) cube([2*r+2*th, r+th, 2*th]);
    }
}
module halfRing2016(r, th) {
    rotate_extrude(angle=180, convexity = 4, $fn = 100)
        translate([r, 0, 0])
            circle(r = th, $fn = th*20);
}

// ////////////////////////////////////////////////////////////////
// parts for action cam mount
module ActionCamRingsFemale(l, base) {
    translate([-15.5/2,0,0]) {
        if (base) {
            translate([0,-6,-l]) cube([15, 12, 3]);
        }
        for (i= [0, 6.25, 12.5]) {
            translate ([i, 0, 0]) ActionCamOneRing(l);
        }
    }
}

module ActionCamOneRing(l) {
    rotate([90, 0, 90]) difference() {
        hull() {
            cylinder(r=6, h=3);
            translate([-6, -l, 0]) cube([12,1,3]);
        }
        translate([0,0,-0.01]) cylinder(r=3, h=3.02);
    }
}
