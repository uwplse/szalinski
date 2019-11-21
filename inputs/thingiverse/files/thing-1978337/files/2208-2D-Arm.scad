// ****************************************************************************
// Arm between the two motors
// enter the width and height of the cam and the weight of the cam and one motor
// to get the camera balanced
// author: Peter Holzwarth
// ****************************************************************************

// Camera width in millimeters, e.g. ActionCam 60, GoPro Session 38, compact camera 110
camWidth= 60; // [5:350]

// Camera height in millimeters, e.g. ActionCam 42, GoPro Session 38, compact cam 60
camHeight= 42; // [20:170]

// cam weight in grams, e.g. ActionCam 63 or small camera 200
camWeight= 63; // [10:400]

// weight of one motor in grams, e.g. 2208 motor 39
motorWeight= 39; // [10:100]

// weight of left side except camera - weight of left part of arm, holder and screws
leftParts= 8; // [0:40]

$fn=150;

armRange= 12.5+16+camWidth/2;
// echo("arm range =", armRange);

leftWeight= motorWeight+leftParts; 

shiftFactor= 0.5 -(leftWeight-camWeight)/2/(leftWeight+camWeight);
// echo("shiftFactor", shiftFactor);

armLen= shiftFactor * armRange +12.5+4-20-12.5;;
echo("arm x len", armLen);

leftMotorY= camHeight/2 +10 +10 +5;
echo("arm y len", leftMotorY-20-10);

// roll motor mount
translate([0,0,16]) rotate([-90,0,0]) plate2208Front();

// left arm - 1) strong start
difference() {
	hull() {
		translate([-12.5,0,6]) cube([0.1, 10, 20]);
		translate([0,0,12]) cube([0.1, 5, 8]);
	}
	translate([0,-0.1,16]) rotate([-90,0,0]) union() {
        // cut out the axis
		cylinder(r= 4.7, h= 3, $fn=50);
        // cut out two of the screw holes
		radialScrews([[0,6], [240,6]], 2, 10);
	}
    // space for wires in strong start
    translate([-13,10,5.5]) rotate([90, 0, 0]) quaterRing(10.5, 4.1);
}

// left arm - 2) middle of arm
translate([-12.5-armLen,0,6]) difference() {
    cube([armLen, 10, 20]);
    // space for wires in arm
    translate([0,10,10]) rotate([0,90,0]) cylinder(r=4.1, h=armLen);
}


// arm knick
translate([-12.5-armLen,20, 6]) difference() {
    rotate([0, 0, 180]) quarterPipe(20, 10, 20);
    // space for wires
    translate([0,0,10]) rotate([0, 0, 180]) quaterRing(10, 4.1);
}

// arm to the front
translate([-12.5-armLen-20,20,6]) difference() {
    // 10mm cube
	cube([10, leftMotorY-20-10, 20]);
    // space for motor
	translate([0, leftMotorY-20, 10]) rotate([0, 90, 0]) cylinder(r= 14, h= 10.1);
    // space for cable 
    hull() {
        translate([10, 0, 10]) rotate([-90,0,0]) cylinder(r= 4.1, h=1);
        translate([4, leftMotorY-33, 4]) cube([6, 1, 12]);
    }
}


// tilt/pitch motor mount
translate([-12.5-armLen-20+4, leftMotorY,16]) difference() {
    rotate([0,-90,0]) union() {
        // plate
        rotate([0,0,-45]) plate2208Back();
        // ring around the motor
        translate([0,0,-6]) pipe(16, 2, 10);
    }
    // cable connector hole
    translate([0, -16, -6]) cube([6.1, 4, 12]);
    translate([0,11.5,8]) rotate([0, 90, 0]) roofTop(16, 7, 6.1);
}


// beauty box to improve print
translate([-12.5-armLen-20,leftMotorY+10,6]) difference() {
    // 10mm cube
	cube([10, 9, 20]);
    // space for motor
    translate([4,0,20]) rotate([0, 90, 0]) roofTop(20, 7, 6.1);
}

// create a back plate for a motor
module plate2208Back() {
    plate2208BackI(2, 1.75, false); // plate inner part
    translate([0,0,2]) plate2208BackI(2, 3, true); // plate outer part
}

module plate2208BackI(plateHeight, screwRadius, fillAxis) {
    difference() {
        cylinder(r= 14, h= plateHeight);
        radialScrews([[0,9.5], [90,8], [180,9.5], [270,8]], screwRadius, plateHeight); // holes for the screws
        if (!fillAxis) {
            cylinder(r= 4, h= plateHeight); // hole for the axis
        }
    }
}

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

module radialScrews(screwList, screwRadius= 1, screwHeight= 1) {
    for (screw= screwList) {
        alpha= screw[0];
        c= screw[1];
        x= sin(alpha) * c;
        y= cos(alpha) * c;
        translate([x, y, 0]) cylinder(r= screwRadius, h= screwHeight, $fn=20);
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
        translate([-outerRadius, -outerRadius, -0.1]) 
            cube([2*outerRadius, outerRadius, height+0.2], center=false);
        translate([-outerRadius, 0, -0.1]) 
            cube([outerRadius, outerRadius, height+0.2], center=false);
    }
}

// ////////////////////////////////////////////////////////////////
// a ring with a radius and a thickness
module ring(r, th) {
    rotate_extrude(convexity = r, $fn = 100)
    translate([r, 0, 0])
    circle(r = th, $fn = 100);
}

// ////////////////////////////////////////////////////////////////
// a half ring
module halfRing(r, th) {
    difference() {
        ring(r, th);
        translate([-r-th, -r-th, -th-0.1]) cube([2*r+2*th, r+th, 2*th+0.2]);
    }
}

// ////////////////////////////////////////////////////////////////
// a quater of a ring
module quaterRing(r, th) {
    difference() {
        halfRing(r, th);
        translate([-r-th, -0.01, -th-0.1]) cube([r+th, r+th+0.02, 2*th+0.2]);
    }
}

// ////////////////////////////////////////////////////////////////
// isosceles triangle
module roofTop(c, h, height) {
    translate([0,0,height/2]) 
        linear_extrude(height= height, center = true, convexity = 1) 
            polygon(points = [[0,0], [c,0], [c/2,h]], 
                paths = [[0, 1, 2]], 
                convexity = 1);
}