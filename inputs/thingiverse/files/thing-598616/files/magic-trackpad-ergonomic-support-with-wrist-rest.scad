/**
 * Parametric module to create an angled ergonomic support for the Apple Magic Trackpad.
 *
 * This OpenSCAD library is part of the [dotscad](https://github.com/dotscad/dotscad)
 * project, an open collection of modules and Things for 3d printing.  Please check there
 * for the latest versions of this and other related files.
 *
 * @copyright  Chris Petersen, 2014
 * @license    http://creativecommons.org/licenses/LGPL/2.1/
 * @license    http://creativecommons.org/licenses/by-sa/3.0/
 *
 * @see        http://www.thingiverse.com/thing:263636
 * @source     https://github.com/dotscad/things/blob/master/magic_trackpad_ergonomic_support/magic_trackpad_ergonomic_support.scad
 */

/* ******************************************************************************
 * Thingiverse Customizer parameters and rendering.
 * ****************************************************************************** */

/* [Global] */

// Target angle of elevation
angle = 15; // [5:45]

// Which hand you use for the trackpad
handed = "right"; // [right,left]

// Add wrist rest to model
wrist_rest = "yes"; // [yes,no]

// Length of the wrist rest (cm)
wrist_rest_length = 8; // [0:12]

/* [Hidden] */

// I don't know why but OpenSCAD freaks out if $fn is 50 or 100
$fn=75;

// A global overlap variable (to prevent printing glitches)
$o = .1;

// Render the part
trackpad_platform(angle, handed);

/* ******************************************************************************
 * Main module code below:
 * ****************************************************************************** */

module round_corner() {
    difference() {
        translate([-5,-5,0]) cube([10,10,200]);
        translate([5,5,-1]) cylinder(r=5, h=202);
    }
}

// Newer variation of the lower wall, but it leaves the bottom edge of the support too
// thin/flimsy, so for now we'll use the original.
module lower_wall2(d) {
    t = 1;
    h = 6 + t;
    r = 11.5;
    union() {
        // back
        // @todo extend further.  may need to extend entire width just for strength.
        intersection() {
            translate([0,-1.3/2,0]) cube([3,16,d]);
            hull() translate([1.5,1,-10.1]) rotate([0,90,0])
                rotate_extrude(convexity = 10)
                translate([17, 0, 0])
                    circle(r = 1.5);
        }
        // front
        intersection() {
            cube([3,d,d]);
            hull() translate([1.5,d-16,-r/2]) rotate([0,90,0])
                rotate_extrude(convexity = 20)
                translate([r, 0, 0])
                circle(r = 1.5);
        }
    }
}

module lower_wall(d) {
    hull() {
        cube([3,1,6]);
        translate([1.5,-.5,6.5]) rotate([0,90,90]) cylinder(r=1.5,h=d-15);
        intersection() {
            cube([3,d,8]);
            translate([1.5,d-16,-5]) rotate([0,90,0])
                rotate_extrude(convexity = 10)
                translate([11.5, 0, 0])
                 circle(r = 1.5);
        }
     }
 }

module back_wall(d, angle) {
    t = .5;
    h = 6 + t;
    difference() {
        union() {
            cube([d+(tan(angle)*t),19+1.5+(1.5*1.5),h]);
            // Rear lip of the "cup"
            translate([0,1.5,h]) rotate([0,90,0]) intersection() {
                cylinder(r=1.5,h=d+(tan(angle)*t));
                hull() { // 5 is just an arbitrary number
                    translate([0,5/2,1.5]) rotate([90,0,0]) cylinder(r=1.5,h=5);
                    translate([0,5/2,d+(tan(angle)*t) -1.5]) rotate([90,0,0]) cylinder(r=1.5,h=5);
                }
            }
            // Front lip of the "cup"
            translate([0,19+1.5*1.5,h]) rotate([0,90,0]) intersection() {
                cylinder(r=1.5,h=d+(tan(angle)*t));
                hull() { // 5 is just an arbitrary number
                    translate([0,5/2,1.5]) rotate([90,0,0]) cylinder(r=1.5,h=5);
                    translate([0,5/2,d+(tan(angle)*t) -1.5]) rotate([90,0,0]) cylinder(r=1.5,h=5);
                }
            }
            // Front of the "cup"
            //intersection() {
                //cube([d+(tan(angle)*t),19.6,4]);
            //    translate([0,17.75-1.3,1.3]) rotate([0,90,0]) hull() { // 25 is just an arbitrary number
            //        translate([0,25/2,1.3+(tan(angle)*t)]) rotate([90,0,0]) cylinder(r=1.3,h=25);
            //        translate([0,25/2,d+(tan(angle)*t) -1.3]) rotate([90,0,0]) cylinder(r=1.3,h=25);
            //    }
            //}
            // Lip for the front of the "cup"
            //translate([0,19.6-1.3,4]) rotate([0,90,0]) intersection() {
            //    cylinder(r=1.3,h=d+(tan(angle)*t));
            //    hull() { // 5 is just an arbitrary number
            //        translate([0,5/2,1.3+(tan(angle)*t)]) rotate([90,0,0]) cylinder(r=1.3,h=5);
            //        translate([0,5/2,d+(tan(angle)*t) -1.3]) rotate([90,0,0]) cylinder(r=1.3,h=5);
            //    }
            //}
        }
        // note: trackpad rear diameter is 17.75mm.  Render at 19mm to account for PLA shrinkage
        translate([-$o,11.5,9.5+1.5-t+$o]) rotate([0,90,0]) {
            cylinder(r=9.5,h=200);
        }
    }
}

module trackpad_platform(angle, handed) {
    d = (13 * 10) + 3; // 13cm on a side, plus a little fudge for the wall
    wp = (wrist_rest == "yes") ? (wrist_rest_length * 10) + 3 : 0; // Convert cm to mm, add a litle fudge, 0 if no wrist rest
    t = 1;
    difference() {
        union() {
            difference() {
                // base
                difference() {
                    union() {
                        translate([0,(handed == "right" ? -2 : -wp),$o]) difference() {
                            cube([d,d+2+wp,d]);
                            rotate([0,-angle,0]) translate([-$o,-$o,t]) cube([d*2,d*2,d*2]);
                        }
                        // platform walls
                        rotate([0,-angle,0]) union() {
                            if (handed == "right") {
                                translate([0,-2,0]) back_wall(d, angle);
                                lower_wall(d);
                            }
                            else {
                                translate([d+(tan(angle)*2),d+2,0]) rotate([0,0,180]) back_wall(d, angle);
                                translate([3,d,0]) rotate([0,0,180]) lower_wall(d);
                            }
                        }
                    }

                    if (wrist_rest == "no") {
                        // front opening under the trackpad
                        translate([cos(angle)*23,(handed == "right" ? d-30 : -5),-$o])
                            cube([cos(angle)*(d-23)-cos(angle)*20, 40, 200]);
                    }

                    // @todo need about 2mm more on rear edge
                    // @todo lower edge is too thin (bends). For now, we're just using the old lower_wall variation
                    translate([0,(handed == "right" ? 10+5 : -10+35),-$o]) hull() {
                        for(t = [ [3+cos(angle)*15,0,0],
                                  [3+cos(angle)*15,d-40,0],
                                  [cos(angle)*(d-10)-3,d-40,0],
                                  [cos(angle)*(d-10)-3,0,0]
                                ]) {
                            translate(t) cylinder(r=5,h=d);
                        }
                    }
                    // Tiny cutout on the back wall for the trackpad feet
                    // @todo make this look right, and add for left handed.
                    //rotate([0,-angle,0]) union() {
                    //    translate([-$o,11, t]) rotate([0,90,0]) cylinder(r=1.25,h=200);
                    //}
                }

                // Rounded edges
                if (wrist_rest == "yes") {
                    // if adding wrist rest, we only want to round the front corners
                     if (handed == "right") {
                        for (tr=[ [ [0,d+wp,-$o],            [0,0,-90] ],
                                  [ [cos(angle)*d,d+wp,-$o], [0,0,180] ],
                                ] ) {
                            translate(tr[0]) rotate(tr[1]) round_corner();
                        }
                    } else {
                        for (tr=[ [ [0,-wp,-$o],            [0,0,0]  ],
                                  [ [cos(angle)*d,-wp,-$o], [0,0,90] ], 
                                ] ) {
                            translate(tr[0]) rotate(tr[1]) round_corner();
                        }
                    }
                } else {
                    // no wrist rest, round all corners of front
                    if (handed == "right") {
                        for (tr=[ [ [0,d,-$o],                    [0,0,-90] ],
                                  [ [cos(angle)*d,d,-$o],         [0,0,180] ],
                                  [ [cos(angle)*(d-20),d,-$o],    [0,0,-90] ],
                                  [ [cos(angle)*(20+3),d,-$o],    [0,0,180] ],
                                  [ [cos(angle)*(20+3),d-20,-$o], [0,0,90]  ],
                                  [ [cos(angle)*(d-20),d-20,-$o], [0,0,0]   ],
                                ] ) {
                            translate(tr[0]) rotate(tr[1]) round_corner();
                        }
                    } else {
                        for (tr=[ [ [0,0,-$o],                           [0,0,0]   ],
                                  [ [cos(angle)*d,0,-$o],                [0,0,90]  ],
                                  [ [cos(angle)*d-cos(angle)*20,0,-$o],  [0,0,0]   ],
                                  [ [cos(angle)*(20+3),0,-$o],           [0,0,90]  ],
                                  [ [cos(angle)*(20+3),20,-$o],          [0,0,180] ],
                                  [ [cos(angle)*d-cos(angle)*20,20,-$o], [0,0,-90] ],
                                ] ) {
                            translate(tr[0]) rotate(tr[1]) round_corner();
                        }
                    }
                }
            }
        }
        // Max-width cutoff
        translate([cos(angle)*d,-d,-d/2]) cube([d*2,d*3,d*2]);
    }
}
