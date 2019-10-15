// ****************************************************************************
// Cover for the controller enclosure
// resize and add holes for LEDs as required...
// Author: Peter Holzwarth
// ****************************************************************************

// width of the controller box in mm
boxWidth= 74+4; // [20:100]

// height of the controller box in mm
boxHeight= 53+4; // [20:100]

// distance of the LED window from the front left corner, or 0 for no window
LedWindow= 28; // [0:100]

// controller cap
controllerCap([boxWidth, boxHeight], LedWindow);

module controllerCap(dimensions, LedWindow) {
    difference() {
        // outer box
        cube([dimensions[0]-3, dimensions[1]-2, 3.8]);
        // slide-in left
        translate([-0.1, -0.1, 1.8]) 
            cube([1.1, dimensions[1]-2+0.2, 2.1]);
        // slide-in right
        translate([dimensions[0]-3-1, -0.1, 1.8]) 
            cube([1.1, dimensions[1]-2+0.2, 2.1]);
        if (LedWindow) {
            // opening for LED lights
            translate([LedWindow, -0.1, -0.1]) cube([6, 8.1, 4.2]);
        }
    }
}