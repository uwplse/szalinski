// ****************************************************************************
// Sizeable controller cover
// resize as required, adapt holes for cables as required
// Author: Peter Holzwarth
// ****************************************************************************

// width of the controller box in mm, including the left and right walls
boxWidth= 74+4; // [20:100]

// height of the controller box in mm, including the upper and lower walls
boxHeight= 53+4; // [20:100]

// depth of the controller box in mm
boxDepth= 16; // [10:30]

$fn=50;

// controller enclosure
translate([-boxWidth/2, -boxHeight, 0]) 
    controllerFlex([boxWidth, boxHeight, boxDepth]);

// motor plate fixture for controller
difference() {
    translate([-10, -2, 0]) hull() {
        translate([0, 0, boxDepth-4]) cube([20, 6, 4]);
        translate([0, 0, boxDepth/2]) cube([20, 2, 1]);
    }
    // space for motor
    translate([0, 14, boxDepth/2]) cylinder(r= 14, h= boxDepth/2+0.1);
}

// motor plate
translate([0,14,boxDepth-4]) rotate([0,0,45]) plate2208Back();

// action cam mount
translate([-4.5,12+14-6,boxDepth+8]) rotate([90,0,0]) 
    ActionCamMale(4, true);

// action cam fixture
hull() {
    translate([-4.5, 8,boxDepth+8]) cube([9, 12, 1]);
    translate([-3, 6,boxDepth-1]) cube([6, 16, 1]);
}


module controllerFlex(dimensions) {
    difference() {
        // outer box
        cube([dimensions[0], dimensions[1], dimensions[2]]);
        // inner space for board
        translate([2, 2, 2]) 
            cube([dimensions[0]-4, dimensions[1]-4, dimensions[2]-2+0.1]);
        // opening for cables in upper left corner
        translate([dimensions[0]/5, dimensions[1]-4-9, -0.1]) 
            cube([9, 9, 2.2]);
        // opening for cables in bottom middle
        translate([dimensions[0]/2-1, -0.1, 4]) 
            cube([2, 2.2, dimensions[2]-4]);
        // opening for joytick port right to the cable opening
        translate([dimensions[0]-23-2, -0.1, 4]) 
            cube([6, 2.2, dimensions[2]-4]);
        // opening for cap
        translate([2, -0.1, dimensions[2]-4]) 
            cube([dimensions[0]-4, 2.2, 4.1]);
        // slide-in left
        translate([1, 0, dimensions[2]-4]) 
            cube([2, dimensions[1]-2, 2]);
        // slide-in right
        translate([dimensions[0]-3, 0, dimensions[2]-4]) 
            cube([2, dimensions[1]-2, 2]);
    }
}

// create a back plate for a 2208 motor
module plate2208Back() {
    // plate inner part
    plate2208BackI(2, 1.75, false); 
    // plate outer part
    translate([0,0,2]) plate2208BackI(2, 3, true); 
}

module plate2208BackI(plateHeight, screwRadius, fillAxis) {
    difference() {
        cylinder(r= 14, h= plateHeight);
        // holes for the screws
        radialScrews([[0,9.5], [90,8], [180,9.5], [270,8]], 
                    screwRadius, plateHeight);
        if (!fillAxis) {
            // hole for the axis
            cylinder(r= 4, h= plateHeight); 
        }
    }
}

module radialScrews(screwList, screwRadius= 1, screwHeight= 1) {
    for (screw= screwList) {
        alpha= screw[0];
        c= screw[1];
        x= sin(alpha) * c;
        y= cos(alpha) * c;
        translate([x, y, 0]) 
            cylinder(r= screwRadius, h= screwHeight, $fn=20);
    }
}

// ////////////////////////////////////////////////////////////////
// Action cam connector, camera side
module ActionCamMale(l) {
    for (i= [0, 6]) {
        translate ([i, 0, 0]) ActionCamOneRing(l);
    }
}

// helper
module ActionCamOneRing(l) {
    translate([0, 0, 6]) rotate([0, 90, 0]) difference() {
        hull() {
            translate([0, 6+l, 0]) cylinder(r=6, h=3);
            translate([-6, 0, 0]) cube([12,1,3]);
        }
        translate([0, 6+l, 0]) cylinder(r=2.5, h=3);
    }
}