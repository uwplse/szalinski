// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License.
// (See http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.)


/* [Main Dimensions] */
// How long is your phone (mm)?
PHONE_LENGTH = 144; // [75:1:175]

// How wide is your phone (mm)?
PHONE_WIDTH  =  71; // [40:1:100]

// How thick is your phone (mm)?
PHONE_THICKNESS = 7.5; // [5:0.5:20]

// What is the diameter of your charging pad (mm)?
PAD_DIAMETER = 100; // [75:1:150]

// How thick is your charging pad (mm)?
PAD_THICKNESS = 11; // [5:1:20]

/* [Other Dimensions] */
// How thick should the bottom be (mm)?
BASE_THICKNESS = 2; // [1:1:5]

// How thick should the wall surrounding the charging pad be (mm)?
WALL_THICKNESS = 5; // [5:1:10]

// How big should the cubes that hold the phone in place be (mm)?
CORNER_SIZE = 15; // [5:1:20]

// How much "wiggle room" to insure the pad and phone fit should there be (mm)?
FIT_CLEARANCE = 2; // [0:0.5:2.5]

$fn = 120;

totalLength = PHONE_LENGTH + 2 * WALL_THICKNESS + 2 * FIT_CLEARANCE;
totalWidth  = PHONE_WIDTH  + 2 * WALL_THICKNESS + 2 * FIT_CLEARANCE;
totalHeight = BASE_THICKNESS + PAD_THICKNESS + 0.75 * PHONE_THICKNESS;

holder();

module holder() {
    difference() {
        union() {
            // Base:
            rounded_cube (size = [totalLength, totalWidth, BASE_THICKNESS],
                          bottomRadius = 0, sideRadius = 5, topRadius = 0,
                          center = [true, true, false]);
            // Corners:
            for (x = [-1, 1]) {
                for (y = [-1, 1]) {
                    translate ([x * (totalLength - CORNER_SIZE) / 2,
                                y * (totalWidth  - CORNER_SIZE) / 2,
                                0]) {
                        rounded_cube (size = [CORNER_SIZE,
                                              CORNER_SIZE,
                                              totalHeight],
                                      bottomRadius = 0, sideRadius = 5,
                                      topRadius = 5,
                                      center = [true, true, false]);
                    }
                }
            }
        }
        // Base cutout:
        translate ([0, 0, -1]) 
        rounded_cube (size = [totalLength - 2 * 10,
                               totalWidth  - 2 * 10,
                               BASE_THICKNESS + 2],
                       bottomRadius = 0, sideRadius = 5, topRadius = 0,
                       center = [true, true, false]);
        
        // Phone nest:
        translate ([0, 0, BASE_THICKNESS]) {
            centered_cube (size = [PHONE_LENGTH + 2 * FIT_CLEARANCE,
                           PHONE_WIDTH + 2 * FIT_CLEARANCE, totalHeight],
                           center = [true, true, false]);
        }
    }
    
    intersection() {
        difference() {
            // Charging pad:
            cylinder (d = PAD_DIAMETER + 2 * WALL_THICKNESS + 2 * FIT_CLEARANCE,
                      h = BASE_THICKNESS + PAD_THICKNESS - 5,
                      center = false);
            translate ([0, 0, BASE_THICKNESS]) {
                cylinder (d = PAD_DIAMETER + 2 * FIT_CLEARANCE, h = PAD_THICKNESS,
                          center = false);
            }
            // Area beneath pad:
            cylinder (d = PAD_DIAMETER - 20, h = BASE_THICKNESS,
                      center = false);
        }
        centered_cube (size = [totalLength, totalWidth, totalHeight],
                       center = [true, true, false]);
    }
}


// Like cube() but the "center" argument is a vector of booleans specifying how the
// cube is to be centered with respect to the X, Y and Z axies.  For example,
// [true, true, false] means that the cube will be centered on the X-Y plane (with the
// Z axis passing through the cube's center) but the bottom will sit on the X-Y plane.
module centered_cube (size, center) {
	translate ([center[0]? 0 : size[0] / 2,
				   center[1]? 0 : size[1] / 2,
				   center[2]? 0 : size[2] / 2]) {
		cube (size, center = true);
	}
}

// Like centered_cube() above but with rounded corners and edges.
module rounded_cube (size,
					 bottomRadius = 0.001, topRadius = 0.001, sideRadius = 0.001,
					 center = [false, false, false], fn = 30) {
	if (sideRadius < 0) {
		echo ("Warning: rounded_code() invoked with sideRadius < 0; continuing with sideRadius = 0.");
	}

	if (bottomRadius < 0) {
		echo ("Warning: rounded_code() invoked with bottomRadius < 0; continuing with bottomRadius = 0.");
	}

	if (topRadius < 0) {
		echo ("Warning: rounded_code() invoked with topRadius < 0; continuing with topRadius = 0.");
	}

	translate ([center[0]? 0 : size[0] / 2,
				center[1]? 0 : size[1] / 2,
				center[2]? -size[2] / 2 : 0]) {
		//union() {
		hull() {
			// Base:
			if (bottomRadius > 0) {
				for (a = [0 : 360 / fn : 90 + 360 / fn]) {
					translate ([0, 0, bottomRadius * (1 - cos(a))]) {
						linear_extrude (height = 0.01, center = false) {
							scale ([(size[0] - 2 * bottomRadius * (1 - sin(a))) / size[0],
									  (size[1] - 2 * bottomRadius * (1 - sin(a))) / size[1], 1]) {
								rounded_rectangle (size[0], size[1], sideRadius, fn);
							}
						}
					}			
				}
			}
			else {
				linear_extrude (height = 0.01, center = false) {
					rounded_rectangle (size[0], size[1], sideRadius, fn);
				}
			}

			// Main body (middle part) is created by the hull() operation in which this
			// code is enclosed.

			// Top:	
			if (topRadius > 0) {
				for (a = [0 : 360 / fn : 90 + 360 / fn]) {
					translate ([0, 0, size[2] - topRadius * (1 - cos(a))]) {
						linear_extrude (height = 0.01, center = false) {
							scale ([(size[0] - 2 * topRadius * (1 - sin(a))) / size[0],
									  (size[1] - 2 * topRadius * (1 - sin(a))) / size[1], 1]) {
								rounded_rectangle (size[0], size[1], sideRadius, fn);
							}
						}
					}			
				}
			}
			else {
				translate ([0, 0, size[2] - 0.01]) {
					linear_extrude (height = 0.01, center = false) {
						rounded_rectangle (size[0], size[1], sideRadius, fn);
					}
				}
			}
		}
	}
}

module rounded_rectangle (length, width, radius, fn) {
	square ([length, width - 2 * radius], center = true);
	if (radius > 0) {
		square ([length - 2 * radius, width], center = true);
		for (x = [-1, 1]) {
			for (y = [-1, 1]) {
				translate ([x * (length / 2 - radius), y * (width / 2 - radius)]) {
					circle (r = radius, $fn = fn);
				}
			}
		}
	}
}

use <utils/build_plate.scad>
//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);