/* START main.scad*/
/* START customizer.scad*/
/* [General] */

// Which part do you want to access?
cnf_part = "all"; // [camera:Camera Body, lid:Camera Lid, post:Camera Post, arm:Bed Mounting Arm, all:All]

/* [Camera Case] */

// Do want to screw the lid on the camera body?
cnf_lidscrew = 1; // [0: no, 1: yes]

// Do you want to flip the camera and have the cable at the bottom?
cnf_flip = 0; // [0: no, 1: yes]

/* [Bed Mounting Arm] */

// Which type of arm do you need? Currently only one available
cnf_armtype = "mk3"; // [mk3:Prusa MK3]

// Length of the arm from the mount (mm)
cnf_armlength = 80;

// Rotation of the arm (deg)
cnf_armrotation = 0; // [-45:45]

/* [Camera Post] */

// height of the camera post (mm)
cnf_postheight = 26;

/* [Advanced] */

// smothness of rounded edges
$fn = 70;

// Thickness of Walls (mm)
cnf_walls = 2;

// size of screw holes (mm)
cnf_screw = 4;

// size of screw heads (for sinking them) (mm)
cnf_screwhead = 6;

// size of tap holes (mm)
cnf_drill = 3;

/* [Hidden] */
/* END customizer.scad*/
/* START picamera.scad*/
/* START primitives.scad*/
/**
 * A centered cube, but flat on the Z-Surface
 */
module ccube(v) {
    translate([0, 0, v.z/2]) cube(v, true);
}

/**
 * An upright standing centered cylinder, flat on the Z-Surface
 */
module ccylinder_y(h, d) {
    translate([h/-2, 0, d/2])
        rotate([0, 90, 0])
            cylinder(h=h, d=d);
}

/**
 * Creates a rounded cube
 *
 * @param {vector} v The size of the cube
 * @param {number} r The radius of the rounding
 * @param {bool} flatcenter centered but flat on Z
 */
module roundedCube(v, r=1, flatcenter=true) {
    mv = flatcenter ? [0,0,0] : [v.x/2, v.y/2 ,0];

    translate(mv) hull() {
        // right back bottom
        translate([v.x/2 - r, v.y/2 - r, r])
            sphere(r=r);

        // right front bottom
        translate([v.x/2 - r, v.y/-2 + r, r])
            sphere(r=r);

        // left back bottom
        translate([v.x/-2 + r, v.y/2 - r, r])
            sphere(r=r);

        // left front bottom
        translate([v.x/-2 + r, v.y/-2 + r, r])
            sphere(r=r);


        // right back top
        translate([v.x/2 - r, v.y/2 - r, v.z - r])
            sphere(r=r);

        // right front top
        translate([v.x/2 - r, v.y/-2 + r, v.z - r])
            sphere(r=r);

        // left back top
        translate([v.x/-2 + r, v.y/2 - r, v.z - r])
            sphere(r=r);

        // left front top
        translate([v.x/-2 + r, v.y/-2 + r, v.z - r])
            sphere(r=r);
    }
}
/* END primitives.scad*/

//picamera(part="camera");
//picamera(part="lid");

/**
 * Creates the body or lid for the camera
 *
 * @param {string} part The part to print, either "camera" or "lid"
 * @param {bool} flip Should the cable come out of the bottom?
 * @param {bool} lidscrew Should the be screwed on?
 * @param {number} walls The wall thickness in mm
 * @param {number} screw The diameter of the screw hole
 * @param {number} screwhead The diameter of the screw head hole
 */
module picamera (
    part = "camera",
    flip = false,
    lidscrew = true,
    walls = 2,
    screw = 4,
    screwhead = 4
) {
    // basic setup
    pcb = [26, 25, 1];
    pcb_part = [17, pcb.y, 1.5];
    cable_z = 1; // above pcb
    pcb_clear = 4;
    tab = 14;
    body_z   = walls+pcb.z+pcb_part.z+pcb_clear;
    holder_z = walls+pcb.z+pcb_part.z+cable_z;
    $fn = $fn ? $fn : 90;

    // print part
    if(part == "camera") {
        camera();
    } else {
        lid();
    }

    /**
     * The lid
     */
    module lid() {
        ridge=1; // thickness of the inner ridge
        cable=1; // space for the cable
        pin_off=0.2;

        // the lid itself
        linear_extrude(height=walls) {
            offset(r=walls) {
                square([pcb.x, pcb.y],true);
            }
        }

        translate([0,0,walls]) {
            // the inner ridge
            difference() {
                linear_extrude(height=ridge) {
                    square([pcb.x, pcb.y],true);
                }

                linear_extrude(height=ridge) {
                    offset(r=walls*-1) {
                        square([pcb.x, pcb.y],true);
                    }
                }
            }
            // the pins holding the pcb down (half a rigde shorter)
            difference(){
                pins(4, pcb_clear-pin_off);
                translate([0,0,pcb_clear-ridge/2]) pins(2, ridge);
            }

            // closes the cable outlet (half a ridge smaller than the outlet)
            translate([0, (pcb.y+walls) /2,0]) {
                ccube([pcb_part.x-ridge/2, walls, pcb_clear-cable_z-cable]);
            }
        }

        // the tab for screwing down the lid
        if(lidscrew) translate([0, -1*pcb.y/2, 0]) {
            tab();
        }
    }

    /**
     * Create the camera case
     */
    module camera() {
        holder_space = 10;
        mod = flip ? 1 : -1;

        body();

        // add two arms
        translate([0, mod*(pcb.y/2 + walls), 0]) {
            translate([(holder_space+walls)/-2, 0 , 0]) {
                holderarm(flip);
            }
            translate([(holder_space+walls)/2, 0 , 0]) {
                holderarm(flip);
            }
        }

        // mechanism to screw the lid on
        if(lidscrew) translate([0, pcb.y/-2, 0]) {
            closer();
        }
    }

    /**
     * Screw mechanism for the lid
     *
     * Basically the same as the closer() but we don't need to cut
     * the cylinder and we have no sink hole for the screw head
     */
    module tab() {
        translate([0,-1*walls,0]) {
            difference() {
                cylinder(h=walls, d=tab);
                translate([0, screwhead/-2, walls/-2]) {
                    cylinder(h=walls*2, d=screw);
                }
            }
        }
    }

    /**
     * Screw mechanism for the case
     *
     * Basically the same as the tab() but with a sunken hole for the
     * screw head.
     */
    module closer() {
        translate([0,-1*walls,0]) {
            difference() {
                cylinder(h=body_z, d=tab);

                // drill holes for head and screw
                translate([0, screwhead/-2, 0]) {
                    cylinder(h=body_z/2, d=screwhead);
                    cylinder(h=body_z*2, d=screw);
                }

                // cut off a little less than half
                translate([0, tab/2 + walls, body_z/-2]) {
                    ccube([tab, tab, body_z*2]);
                };
            }
        }
    }

    /**
     * Creates a single holder arm
     */
    module holderarm() {
        length = 10;

        rot = flip ? 180 : 0;

        rotate([0,0,rot]) {
            translate([0,length/-2,0]) {
                difference() {
                    // tapered shape for when the cable is at the same end
                    hull() {
                        ccube([walls, length, holder_z]);
                        translate([0, -1*length, 0]) {
                            ccylinder_y(walls, body_z);
                        }
                    }

                    // the screw hole
                    translate([0, -1*length, body_z/2-screw/2]) {
                        ccylinder_y(walls*2, screw);
                    }
                }
            }
        }
    }

    /**
     * Creates the camera body
     */
    module body() {
        difference() {
            linear_extrude(height=body_z) {
                offset(r=walls) {
                    square([pcb.x, pcb.y],true);
                }
            }
            pcb_cutout();
        }
    }

    /**
     * the 4 pins to hold the pcb
     */
    module pins(d, h) {
        pin_off_w = 2.5; // center from walls
        pin_off_y = 13; // distance upper from lower pin center

        // lower right
        translate([(pcb.x/-2)+pin_off_w, (pcb.y/-2)+pin_off_w, 0]) {
            cylinder(h=h, d=d);
        }

        // lower left
        translate([(pcb.x/2)-pin_off_w, (pcb.y/-2)+pin_off_w, 0]) {
            cylinder(h=h, d=d);
        }

        // upper right
        translate([(pcb.x/-2)+pin_off_w, (pcb.y/-2)+pin_off_w+pin_off_y, 0]) {
            cylinder(h=h, d=d);
        }

        // upper left
        translate([(pcb.x/2)-pin_off_w, (pcb.y/-2)+pin_off_w+pin_off_y, 0]) {
            cylinder(h=h, d=d);
        }
    }

    /**
     * Carves the space for the PCB
     */
    module pcb_cutout() {
        lens = [9, 9, walls];
        lens_yoffset = 2.5; // from center
        pin_d = 1.5;
        cut = lens.z + pcb_part.z + pcb.z; // cut through all

        difference() {
            union() {
                translate([0, lens_yoffset, -1]) {
                    ccube([lens.x, lens.y, lens.z+1], true); // lens
                }
                translate([0,0,lens.z]) {
                    ccube([pcb_part.x, pcb_part.y, pcb_part.z], true); // front parts

                    translate([0,0,pcb_part.z]) {
                        ccube([pcb.x, pcb.y, pcb.z]); // pcb

                        // cable outlet
                        translate([0, pcb_part.y/2, pcb.z+cable_z]) {
                            ccube([pcb_part.x, walls*2, pcb_clear-cable_z]);
                        }
                    }
                }
            }

            pins(pin_d, cut);
        }

        // upper clearance
        translate([0, 0, cut]) {
            ccube([pcb.x, pcb.y, pcb_clear]);
        }
    }
}
/* END picamera.scad*/
/* START post.scad*/

//post();

/**
 * Creates the post to mount the camera on the arm
 *
 * @param {number} height The height of the post in mm
 * @param {number} width The diameter of the post in mm
 * @param {number} screw The diameter of the screw hole
 * @param {number} walls The wall thickness in mm
 * @param {number} drill The diameter of the hole in the post bottom
 */
module post(
    height = 26,
    width = 10,
    screw = 4,
    walls = 2,
    drill = 3,
) {
    holder_space = 10;
    $fn = $fn ? $fn : 90;

    difference() {
        // smooth from round to square
        hull(){
            translate([0,0,(height/3)*2]) {
                roundedCube([width, width, height/3]);
            }
            cylinder(d=width, h=height/3);
        }

        // screw hole
        translate([0, 0, height - screw/2 - walls]) {
            rotate([90,0,0]) {
                cylinder(d=screw, h=width, center=true);
            }
        }

        // drill hole
        cylinder(d=drill, h=(width/3)*2);
    }
}
/* END post.scad*/
/* START arm.scad*/

//arm();

/**
 * Creates the arm for mounting the camera to the bed
 *
 * Currently only the prusa MK3 bed is supported, but others could be
 * added here.
 *
 * @param {number} armlen The length of the arm from the mounting in mm
 * @param {number} armrot The arm's rotation in degrees
 * @param {number} walls The wall thickness in mm
 * @param {number} screw The diameter of the screw hole
 * @param {number} screwhead The diameter of the screw head hole
 */
module arm (
    armlen = 80,
    armrot = 0,
    walls  = 2,
    screw = 4,
    screwhead = 6
) {
    // basic setup
    arm = [armlen, 10, 10];
    bedarm = [17, 12.5, 6.5];
    zip = [4, bedarm.y+walls*2, 0.5]; // zip tie grove
    attachment = bedarm.y+walls*2; // the size of the attachment overlap
    $fn = $fn ? $fn : 90;

    // build part
    prusaMK3mount();
    arm();

    /**
     * Creates the actual Arm
     *
     * This is basically device independent. The arm is postioned
     * to be attached (and rotated) around [0,0]
     */
    module arm() {
        rotate([0, 0, armrot]) {
            translate([attachment/-4, arm.y/-2, 0]) {
                difference(){
                    roundedCube(arm, walls, false);
                    translate([arm.x-screwhead/2-walls, arm.y/2, 0]) {
                        cylinder(h=arm.z, d=screw);
                        translate([0,0,arm.z/2])
                          cylinder(h=arm.z/2, d=screwhead);
                    }
                }
            }
        }
    }

    /**
     * Create the mounting mechanism for a Prusa i3 MK3
     *
     * The attachment point for the arm is at [0,0]
     */
    module prusaMK3mount() {
        open = [bedarm.x - 2.5, 7, walls];

        // move everything so that the attachment point is centered
        translate([
            (bedarm.x+walls+attachment/2)*-1,
            (bedarm.y+walls*2)/-2,
            0
        ]) {
            // create the casing
            difference(){
                roundedCube([
                    bedarm.x+walls+attachment,
                    bedarm.y+walls*2,
                    bedarm.z+walls*2
                ], walls, false);

                translate([0, walls, walls]) {
                    // hole for the arm
                    cube(bedarm);

                    // opening for the screw
                    translate([0, bedarm.y/2 - open.y/2, -walls]) {
                        cube(open);
                    }
                }

                // zip tie grove
                translate([zip.x, 0, 0]){
                    cube(zip);
                }
            }
        }
    }
}
/* END arm.scad*/

print_part(cnf_part);

/**
 * Decide which part to print based on the given parameter
 */
module print_part(part="all") {
    if (part == "camera" ) {
        picamera(
            part="camera",
            flip = cnf_flip,
            lidscrew = cnf_lidscrew,
            walls = cnf_walls,
            screw = cnf_screw,
            screwhead = cnf_screwhead
        );
    } else if (part == "lid") {
        picamera(
              part="lid",
              flip = cnf_flip,
              lidscrew = cnf_lidscrew,
              walls = cnf_walls,
              screw = cnf_screw,
              screwhead = cnf_screwhead
          );
    } else if (part == "post") {
        post(
          height = cnf_postheight,
          screw = cnf_screw,
          walls = cnf_walls,
          drill = cnf_drill
        );
    } else if (part == "arm") {
        arm (
            armlen = cnf_armlength,
            armrot = cnf_armrotation,
            walls  = cnf_walls,
            screw = cnf_screw,
            screwhead = cnf_screwhead
        );
    } else {
        translate([-30, 0, 0]) print_part("camera");
        translate([30, 0, 0]) print_part("lid");
        translate([0, -45, 0]) print_part("post");
        translate([0, 45, 0]) print_part("arm");
    }
}
/* END main.scad*/

