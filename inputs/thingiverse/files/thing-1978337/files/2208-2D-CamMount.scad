// ****************************************************************************
// Arm for ActionCams using a belt and for compact cameras, using a 1/4 screw
// enter the width and height of the cam to get it balanced
// enter the width of the sensor platine to get a hole for it, or 0 for no hole
// Author: Peter Holzwarth
// ****************************************************************************

// Cam type, 1 action cam, 2 compact camera
camType= 1; // [1:ActionCam/Belt, 2:CompactCam/Screw]

// Camera width in millimeters, e.g. ActionCam 60, GoPro Session 38
camWidth= 60; // [5:350]

// Camera height in millimeters, e.g. ActionCam: 42, GoPro Session 38
camHeight= 42; // [20:170]

// For compact camera, ignore for action cam
boltFromLeftOfCamera= 15; // [8:340]

// width of the sensor platine in mm, e.g. 16
sensorWidth= 16; // [0:18]

$fn=150;

// roll motor mount
translate([0,0,12.5]) rotate([-90,30,0]) plate2208Front();

// length of the arm above the bow, needs to be positive
armLen= camHeight/2 -(16-10)-8;
echo ("Arm len ", armLen);

// strong start of arm
difference() {
    hull() {
        translate([-8-armLen,0,0]) cube([armLen, 10, 25]);
        translate([8.8-1,0,3.5+18]) rotate([90,90,90]) trapezoid(18, 10, 6, 1);
    }
    translate([0,-0.1,12.5]) rotate([-90,30,0]) 
        radialScrews([[0,6], [120,6], [240,6]], 2, 10); 
    translate([0,-0.1,12.5]) rotate([-90,30,0]) cylinder(r= 4.7, 3); 
}

// arm bow
translate([-8-armLen, 0, 0]) difference() {
    translate([0, 16, 0]) rotate([0,0,180]) 
        quarterPipe(16, 10, 25);
    translate([-16+3.5, 0, (25-sensorWidth)/2]) cube([3, 20, sensorWidth]);
}


// arm for camera
translate([-8-armLen-16,16,0]) difference() {
    cube([10,camWidth,25]);
    // hole for bolt
    if (camType == 1) {
        translate([3.5,0,-0.1]) cube([3,camWidth-10,25.2]);
    } else if (camType == 2) {
        translate([-0.1,boltFromLeftOfCamera,12.5]) rotate([0,90,0]) 
            screwMask(7.5,5,3,12);
    }
}

// translate([0,85,0]) rotate([0,0,-90]) trapezoid(30, 20, 5, 25);

// create a front plate for a motor
module plate2208Front() {
    plate2208FrontI(2, 1.1, false);
    translate([0,0,2]) plate2208FrontI(1, 1.1, true);
    translate([0,0,3]) plate2208FrontI(1, 2, true);
}

module plate2208FrontI(plateHeight, screwRadius, fillAxis) {
    difference() {
        cylinder(r= 12.5, h= plateHeight);
        // holes for the screws
        translate([0, 0, -0.1])
            radialScrews([[0,6], [120,6], [240,6]], 
                screwRadius, plateHeight+0.2); 
        if (!fillAxis) {
            // hole for the axis
            translate([0, 0, -0.1])
                cylinder(r= 4.7, h= plateHeight+0.2, $fn=50); 
        }
    }
}

// draw cylinders around a center
module radialScrews(screwList, screwRadius= 1, screwHeight= 1) {
    for (screw= screwList) {
        alpha= screw[0];
        c= screw[1];
        x= sin(alpha) * c;
        y= cos(alpha) * c;
        translate([x, y, 0]) cylinder(r= screwRadius, h= screwHeight);
    }
}

// a pipe - a hollow cylinder
module pipe(outerRadius, thickness, height) {
    difference() {
        cylinder(h=height, r=outerRadius);
        translate([0, 0, -0.1]) cylinder(h=height+0.2, r=outerRadius-thickness);
    }
}

// a quarter of a pipe
module quarterPipe(outerRadius, thickness, height) {
    difference() {
        pipe(outerRadius, thickness, height);
        // lower half
        translate([-outerRadius, -outerRadius, -0.01]) 
            cube([2*outerRadius, outerRadius, height+0.02], center=false);
        // left quater
        translate([-outerRadius, -0.01, -0.01]) 
            cube([outerRadius, outerRadius+0.02, height+0.02], center=false);
    }
}

// a trapezoid
module trapezoid(w1, w2, h, height) {
    translate([0,0,height/2]) 
        linear_extrude(height= height, center = true, convexity = 1) 
            polygon(points = [[0,0], [w1,0], [w1/2+w2/2,h], [w1/2-w2/2,h]], 
                paths = [[0, 1, 2, 3]], 
                convexity = 1);
}

module screwMask(headRadius, headHeight, threadRadius, threadHeight) {
    cylinder(r= headRadius, h= headHeight);
    translate([0,0,headHeight]) cylinder(r= threadRadius, h= threadHeight);
}