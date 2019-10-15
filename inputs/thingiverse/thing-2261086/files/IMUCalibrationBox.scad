// ****************************************************************************
// Your Gimbal - simple Customizable IMU Calibration cube
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

// Width of your IMU
w= 22; // [10:30]

// Depth of your IMU
d= 14; // [10:20]

// Height of your IMU
h= 4; // [3:15]

IMUCalibrationBox(w, d, h);

module IMUCalibrationBox(w, d, h) {
    difference() {
        cube([w+6,d+6,h+6]);
        translate([-0.01,3,3]) cube([w+3,d,h+3.01]);
    }
}
