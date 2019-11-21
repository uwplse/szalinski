/* [Reel] */
// What is the width of your duct tape?
DUCT_TAPE_WIDTH = 50; // [40:1:60]

// How long should the reel be?
REEL_LENGTH = 75; // [50:5:100]

// How thick should the fully loaded reel be?
REEL_THICKNESS = 15; // [10:1:20]

// How thick should the reel ends be?
END_THICKNESS = 3; // [2:0.5:4]

// What to print?
PART = "both"; // [single:Single, top:Top Half Only, bottom:Bottom Half Only, both:Both Halves]

// If printing in two pieces how much gap to leave between connector to insure the pieces fit together?
CONNECTOR_GAP_ADJUSTMENT = 0.25; // [0.25:0.05:0.5]

/* [Build Plate] */
use <utils/build_plate.scad>
//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* [Hidden] */
CORE_THICKNESS = 5;
CONNECTOR_HEIGHT = 20;
$fn = 60;

main();

module main() {
    if (PART == "single") {
        whole_reel();
    }
    else {
        if (PART == "top" || PART == "both") {
            top();
        }
        if (PART == "bottom" || PART == "both") {
            bottom();
        }
    }
}

module top() {
    translate ([0, REEL_THICKNESS / 2 + 5, 0]) {
        difference() {
            half_reel();
            translate ([0, 0, (DUCT_TAPE_WIDTH + END_THICKNESS) / 2]) {
                connector (clearance = +CONNECTOR_GAP_ADJUSTMENT);
            }
        }
    }
}

module bottom() {
    translate ([0, -REEL_THICKNESS / 2 - 5, 0]) {
        union() {
            half_reel();
            translate ([0, 0, (DUCT_TAPE_WIDTH + END_THICKNESS) / 2]) {
                connector (clearance = -CONNECTOR_GAP_ADJUSTMENT);
            }
        }
    }
}

module whole_reel() {
    linear_extrude (height = END_THICKNESS) {
        reel_shape (REEL_THICKNESS);
    }
    translate ([0, 0, END_THICKNESS]) {
        linear_extrude (height = DUCT_TAPE_WIDTH) {
            reel_shape (CORE_THICKNESS);
        }
        translate ([0, 0, DUCT_TAPE_WIDTH]) {
            linear_extrude (height = END_THICKNESS) {
                reel_shape (REEL_THICKNESS);
            }
        }
    }
}

module half_reel() {
    linear_extrude (height = END_THICKNESS) {
        reel_shape (REEL_THICKNESS);
    }
    translate ([0, 0, END_THICKNESS]) {
        linear_extrude (height = DUCT_TAPE_WIDTH / 2) {
            reel_shape (CORE_THICKNESS);
        }
    }
}

module connector (clearance = 0) {
    linear_extrude (height = CONNECTOR_HEIGHT - clearance,
                    center = true) {
        reel_shape (CORE_THICKNESS + clearance - 2);
    }
}

module reel_shape(endDiameter) {
    for (x = [-1, 1]) {
        translate ([x * (REEL_LENGTH - REEL_THICKNESS) / 2, 0]) {
            circle (d = endDiameter);
        }
    }
    square (size = [REEL_LENGTH - REEL_THICKNESS, endDiameter], center = true);
}

