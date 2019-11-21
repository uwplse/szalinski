
// diameter of holder in mm
DIAMETER = 30;

// height of glass bed in mm
BED_THICKNESS = 7;

// distance between openbeam bar to bed lower corner in mm
OPENBEAM_TO_BED_DIST = 5.5;

// diameter of bed in mm
BED_DIAMETER = 170;

// length of part holding the bed in mm, this does not include the part with
// the screw
HOLDER_LENGTH = 16;

//
HOLDER_CUT_OFF = 5;

// diameter sinking for screw
SCREW_HEAD_DIAMETER = 8;

// diameter of screw
SCREW_DIAMETER = 4;

// length of hole for screw in mm
SCREW_LENGTH = 3;

// position of screw hole in mm, distance to outer edge
SCREW_POS = (DIAMETER - HOLDER_LENGTH)/2.;

ROUND_BED_EDGE = true;

// radius of roundness in mm, smaller number more round
BED_ROUNDNESS = 6;

/* * * * * * * * * * * * * * * * * * * * * * * * * */

tot_height = OPENBEAM_TO_BED_DIST + BED_THICKNESS;

difference() {
    cylinder(d=DIAMETER, h=tot_height);
    union() {
        // this is the bed
        translate([0.,
                   -HOLDER_LENGTH + BED_DIAMETER/2. + DIAMETER / 2.,
                   OPENBEAM_TO_BED_DIST])
        {
            union() {
                intersection() {
                    cylinder(d=BED_DIAMETER, h=BED_THICKNESS*2);
                    if (ROUND_BED_EDGE) {
                        translate([0., 0., BED_THICKNESS/2.])
                            rotate_extrude(convexity = 10, $fn = 100)
                                translate([BED_DIAMETER/2. - BED_ROUNDNESS, 0, 0]) {
                                    circle(r = BED_ROUNDNESS, $fn = 100);
                                }
                    }
                }
                cylinder(d=BED_DIAMETER-BED_ROUNDNESS, h=BED_THICKNESS*2);
            }
        }

        translate([0., -DIAMETER/2. + SCREW_POS, ]) {
            // this is the screw
            translate([0., 0., -tot_height/4.])
                cylinder(d=SCREW_DIAMETER, h=tot_height*2);

            // screw head
            translate([0., 0., SCREW_LENGTH])
                cylinder(d=SCREW_HEAD_DIAMETER, h=tot_height);
        }

        // cut off
        translate([0., DIAMETER - HOLDER_CUT_OFF, tot_height * 3./4.])
            cube([DIAMETER, DIAMETER, 2*tot_height], center=true);
    }
}

