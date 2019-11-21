/*//////////////////////////////////////////////////////////////////
-                              OpenScad                            -
-              cable strain relief with clamping ribs              -
-                         CC BY 3.0 License                        -
-           https://creativecommons.org/licenses/by/3.0/           -
-                                                                  -
-                          Author: steren                          -
-             https://www.thingiverse.com/thing:2735435            -
-                                                                  -
-                            Declaration                           -
-                            -----------                           -
-      As a template I used the project "cable strain relief"      -
-      from assin. https://www.thingiverse.com/thing:2612943       -
//////////////////////////////////////////////////////////////////*/

// 13/01/2018 - Version 1.0

/// - parameters - ///
//- choice of parts
build = 0; // [0:all parts, 1:bottom clamp + top clamp, 2:baseplate + bottom clamp, 3:bottom clamp, 4:top clamp, 5:baseplate]

// diameter of the cable
clmp_cbl_dia = 6.4;

/*[baseplate]*/
// baseplate length - X
bp_len    = 30;
// baseplate depth - Y
bp_dep    = 20;
// baseplate height - Z
bp_hi     = 2;
// radius of the corners - 0-x or 0.1-x.x
bp_c_rad  = 3.0;
// number of screwholes
bp_qu_scr = 1; // [0:0, 1:2, 2:4]

// diameter of the screwhead
bp_scr_hd   = 6.2;
// diameter of the screwhead
bp_scr_thd  = 3.1;
// height of the screwhole
bp_scr_hi   = 8;
// screwhole for a countersunk screw
bp_scr_sunk = 1; // [0:No, 1:Yes]

/*[clamp block]*/
// width of the clampblock - X
clmp_wid = 20;
//- length of the clampblock - Y
clmp_len = 6.4;
//- entire height of the clampblock - Z
clmp_hi = 10;
//- with clamp ribs?
clmp_clws = 0; // [0:No, 1:Yes]
//- number of screwholes
clmp_qu_scr = 0; // [0:2, 1:4]

// dimension for screwholes in clampblock
//- diameter screwhead
clmp_scr_hd = 3.2;
//- diameter screwthread
clmp_scr_thd = 1.2;
//- height of the screwhole
clmp_scr_hi = 10;
// screwhole for a countersunkscrew?
clmp_scr_sunk = 1; // [0:No, 1:Yes]

/*[hidden]*/
// avoidance of artifacts
clr = 0.01;


/// Build ///
// all parts
if (build == 0) {
    baseplate();

    translate([bp_len / 2 + clmp_len / 2, 0, bp_hi]){
        rotate([0, 0, 90]) {
            clampBottom();
        }
    }

    translate([0, bp_dep + 10, 0]){
        clampTop();
    }
}

// bottom clamp + top clamp
if (build == 1) {
    clampBottom();

    translate([0, clmp_len + 10, 0]){
        clampTop();
    }
}

// baseplate + bottom clamp
if (build == 2) {
    baseplate();

    translate([bp_len / 2 + clmp_len / 2, 0, bp_hi]){
        rotate([0, 0, 90]) {
            clampBottom();
        }
    }
}

// bottom clamp
if (build == 3) {
    clampBottom();
}

// top clamp
if (build == 4) {
    clampTop();
}

// baseplate
if (build == 5) {
    baseplate();
}


/// - modules - ///
module screwHole(sH_head_dim, sH_thread_dim, sH_height, sH_sunk) {
/*
    module: screwHole()

    parameter:
    sH_head_dim   = head diameter
    sH_thread_dim = thread diameter
    sH_height     = screwhole height
    sH_sunk       = countersunk screw, 0=No, 1=Yes

    description:
    create a screwholeobject for subtracting from other objects
*/

    if (sH_sunk == 1) {
        rotate_extrude($fn=200) {
            polygon( points=[[0, -clr],
                            [sH_thread_dim / 2, -clr],
                            [sH_thread_dim / 2, sH_height - sH_thread_dim / 2],
                            [sH_head_dim / 2, sH_height + clr * 2],
                            [0, sH_height + clr * 2]] );
        }
    }
    else {
        cylinder(h=sH_height + clr * 2, r=sH_thread_dim / 2, $fn=90);
    }
}

module r_screwHole(sH_head_dim, sH_thread_dim, sH_height, sH_sunk) {
/*
    module: r_screwHole()

    parameter:
    sH_head_dim   = head diameter
    sH_thread_dim = thread diameter
    sH_height     = screwhole height
    sH_sunk       = countersunk screw, 0=No, 1=Yes

    description:
    create a reverse screwholeobject for subtracting from other objects
*/

    if (sH_sunk == 1) {
        rotate_extrude($fn=200) {
            polygon( points=[[0, -clr],
                            [sH_head_dim / 2, -clr],
                            [sH_thread_dim / 2, (sH_head_dim - sH_thread_dim) / 2],
                            [sH_thread_dim / 2, sH_height + clr * 2],
                            [0, sH_height + clr * 2]] );
        }
    }
    else {
        cylinder(h=sH_height + clr * 2, r=sH_thread_dim / 2, $fn=90);
    }
}

module baseplate() {
 /*
    module: basePlate()

    parameter:
    bp_len    = length, X
    bp_dep    = depth, Y
    bp_hi     = height, Z
    bp_c_rad  = corner radius
    bp_qu_scr = number of holes | 0, 2 or 4

    create a baseplate with or without screwholes
*/
 
    difference() {
        
        // baseplate
        roundedRectangle(bp_len, bp_dep, bp_hi, bp_c_rad);
        
        // screw holes
        if (bp_qu_scr != 0) {
            if (bp_qu_scr == 1) {
                translate([bp_len / 5, bp_dep / 2, bp_hi - bp_scr_hi - clr]) {
                    screwHole(bp_scr_hd, bp_scr_thd, bp_scr_hi, bp_scr_sunk);
                }    
        
                translate([bp_len - bp_len / 5, bp_dep / 2, bp_hi - bp_scr_hi - clr]) {
                    screwHole(bp_scr_hd, bp_scr_thd, bp_scr_hi, bp_scr_sunk);
                }
            }
            if (bp_qu_scr == 2) {
                translate([bp_len / 5, bp_dep / 4, bp_hi-bp_scr_hi-clr]) {
                    screwHole(bp_scr_hd, bp_scr_thd, bp_scr_hi, bp_scr_sunk);
                }    
        
                translate([bp_len-bp_len / 5, bp_dep / 4, bp_hi-bp_scr_hi-clr]) {
                    screwHole(bp_scr_hd, bp_scr_thd, bp_scr_hi, bp_scr_sunk);
                }
                translate([bp_len / 5, bp_dep-bp_dep / 4, bp_hi-bp_scr_hi-clr]) {
                    screwHole(bp_scr_hd, bp_scr_thd, bp_scr_hi, bp_scr_sunk);
                }    
        
                translate([bp_len-bp_len / 5, bp_dep-bp_dep / 4, bp_hi-bp_scr_hi-clr]) {
                    screwHole(bp_scr_hd, bp_scr_thd, bp_scr_hi, bp_scr_sunk);
                }
            }
        }
    }
}

module roundedRectangle(rR_width, rR_length, rR_thick, rR_radius) {
/*
    module: roundedRectangle()

    parameter:
    rR_width  = rectangle width
    rR_length = rectangle length
    rR_thick  = rectangle thickness
    rR_radius = corner radius

    create a rectangle with or without rounded corners
*/

    if (rR_radius == 0) {
        cube([rR_width, rR_length, rR_thick]);
    }
    else {
        hull () {    
            translate([rR_radius, rR_radius, 0]) {
                cylinder(h=rR_thick, r=rR_radius, $fn=90);
            }
            translate([rR_width - rR_radius, rR_radius,0]) {
                cylinder(h=rR_thick, r=rR_radius, $fn=90);
            }
            translate([rR_radius, rR_length - rR_radius,0]) {
                cylinder(h=rR_thick, r=rR_radius, $fn=90);
            }
            translate([rR_width - rR_radius, rR_length - rR_radius,0]) {
                cylinder(h=rR_thick, r=rR_radius, $fn=90);
            }
        }
    }
}

module clampBottom() {
    difference() {

        cube([clmp_wid, clmp_len, clmp_hi / 2]);
        
        translate([clmp_wid / 2, -clr, clmp_hi / 2]) {
           rotate ([0, 90, 90]) {

                if (clmp_clws != 0) {
                    rotate_extrude($fn=200) {
                        polygon( points=[[0, -clr],
                                         [clmp_cbl_dia / 2, -clr],
                                         [clmp_cbl_dia / 2, clmp_len / 2 - clmp_cbl_dia / 10 * 4],
                                         [clmp_cbl_dia / 2 - clmp_cbl_dia / 10, clmp_len / 2 - clmp_cbl_dia / 10 * 3],
                                         [clmp_cbl_dia / 2, clmp_len / 2 - clmp_cbl_dia / 10 * 2],
                                         [clmp_cbl_dia / 2, clmp_len / 2 + clmp_cbl_dia / 10 * 2],
                                         [clmp_cbl_dia / 2 - clmp_cbl_dia / 10, clmp_len / 2 + clmp_cbl_dia / 10 * 3],
                                         [clmp_cbl_dia / 2, clmp_len / 2 + clmp_cbl_dia / 10 * 4],
                                         [clmp_cbl_dia / 2, clmp_len + clr * 2],
                                         [0, clmp_len + clr * 2]] );
                    }
                }
                else {
                    cylinder(h=clmp_len + clr * 2, r=clmp_cbl_dia / 2, $fn=90);
                }
            }
        }
        
        // two screwholes
        if (clmp_qu_scr == 0) {
            translate([clmp_wid / 6, clmp_len / 2,  clmp_hi - clmp_scr_hi - clr]) {
                screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }

            translate([clmp_wid / 6 * 5, clmp_len / 2,  clmp_hi - clmp_scr_hi - clr]) {
                screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }
        }

        // four screwholes
        if (clmp_qu_scr == 1) {
            translate([clmp_wid / 6, clmp_len / 4,  clmp_hi - clmp_scr_hi - clr]) {
                screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }

            translate([clmp_wid / 6 * 5, clmp_len / 4,  clmp_hi - clmp_scr_hi - clr]) {
                screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }

            translate([clmp_wid / 6, clmp_len / 4 * 3,  clmp_hi - clmp_scr_hi - clr]) {
                screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }

            translate([clmp_wid / 6 * 5, clmp_len / 4 * 3,  clmp_hi - clmp_scr_hi - clr]) {
                screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }
        }
    }
}

module clampTop() {
    difference() {

        cube([clmp_wid, clmp_len, clmp_hi / 2]);

        translate([clmp_wid / 2, -clr, clmp_hi / 2]) {
           rotate ([0, 90, 90]) {

                if (clmp_clws != 0) {
                    rotate_extrude($fn=200) {
                        polygon( points=[[0, -clr],
                                         [clmp_cbl_dia / 2, -clr],
                                         [clmp_cbl_dia / 2, clmp_len / 2 - clmp_cbl_dia / 10],
                                         [clmp_cbl_dia / 2 - clmp_cbl_dia / 10, clmp_len / 2],
                                         [clmp_cbl_dia / 2, clmp_len / 2 + clmp_cbl_dia / 10],
                                         [clmp_cbl_dia / 2, clmp_len + clr * 2],
                                         [0, clmp_len + clr * 2]] );
                    }
                }
                else {
                    cylinder(h=clmp_len + clr * 2, r=clmp_cbl_dia / 2, $fn=90);
                }
            }
        }
        
        // two screwholes
        if (clmp_qu_scr == 0) {
            translate([clmp_wid / 6, clmp_len / 2, -clr]) {
                r_screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }
        
            translate([clmp_wid / 6 * 5, clmp_len / 2, -clr]) {
                r_screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }
        }

        // four screwholes
        if (clmp_qu_scr == 1) {
            translate([clmp_wid / 6, clmp_len / 4, -clr]) {
                r_screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }

            translate([clmp_wid / 6 * 5, clmp_len / 4, -clr]) {
                r_screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }

            translate([clmp_wid / 6, clmp_len / 4 * 3, -clr]) {
                r_screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }

            translate([clmp_wid / 6 * 5, clmp_len / 4 * 3, -clr]) {
                r_screwHole(clmp_scr_hd, clmp_scr_thd, clmp_scr_hi, clmp_scr_sunk);
            }
        }
    }
}
