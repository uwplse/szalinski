// Copyright ©2016 Laurence Gonsalves <laurence@xenomachina.com>
//
// Code licensed under the Creative Commons - Attribution - Share Alike license.

// TODO: Fix port so it's smooth
// TODO: improve screw holes
// TODO: add heat set insert support
// TODO: add parametric hole support
// TODO: add side-bulge support (eg: REU)
// TODO: add top-bulge support (eg: 1541 Ultimate)

// Which part do you want to see? Note that Customizer's preview may time out if you choose "both".
part = "top"; // [top:Top,bottom:Bottom,both:Both]

/* [Appearance] */
// Would you like debossed stripes?
debossed_stripes = 1; // [1:Yes, 0:No]

// Would you like a hole punched out for the label?
label_hole = 0; // [1:Yes, 0:No]

// Add feet to support the back end of the cartridge? These are useful for longer or heavier cartridges.
add_feet = 0; // [1:Yes, 0:No]

/* [Internals] */
// Length of PCB (including edge connector). Adjusting this also ajusts the overall length of the case accordingly. Defaults to length used by standard Commodore cartridges.
PCB_length = 84; // [50: 200]

// Distance between edge connector and *center* of post + screw-hole. Defaults to correct distance for standard Commodore cartridges.
post_y = 43.36; // [20.00: 180.00]

// Size of the post hole in PCB. Use 0 to remove post and screw-hole entirely.
post_diameter = 5; // [0 : 15]

/* [Hidden] */

$fs=1.2;
$fa=10;
EPSILON = 1/128;

ORIGINAL_PCB_LEN = 84;
ORIGINAL_POST_Y = 43.36;
ORIGINAL_POST_DIA = 5;

// Good values for Gyruss (Parker Brothers) cart:
// post_y = 21.67
// PCB_length = 64;
// post_diameter = 9

module frustum(x, y, z, x2, y2) {
    linear_extrude(height=z, scale=[x2/x, y2/y]) {
        square([x, y], center=true);
    }
}

module torus(r1, r2) {
    rotate_extrude(convexity = 10)
    translate([r2 + r1, 0, 0])
    circle(r=r2);
}

module round_cylinder(fillet, r, h) {
    for(z=[fillet, h-fillet])
        translate([0,0,z])
            torus(r-2*fillet, fillet);
    cylinder(r=r-fillet, h);
    translate([0,0,fillet]) cylinder(r=r, h=h-2*fillet);
}

module partition() {
    union() {
        difference(){
            children(0);
            children(1);
        }
        intersection(){
            children(1);
            children(2);
        }
    }
}

HOLE_DEPTH = 18;
COUNTERSINK_DIAMETER = 6.25;
COUNTERSINK_TOP_DEPTH = .5;
SCREW_HEAD_DIAMETER = 4.93;
SCREW_OUTER_DIAMETER = 2.5;
SCREW_INNER_DIAMETER = 2.3;
SCREW_HEAD_HEIGHT = 1.67;

PCB_WIDTH = 58.12;

CART_DEPTH = 20;
CART_WIDTH = 68.38;
CART_LENGTH = PCB_length + 4.5;

PCB_THICKNESS = 1.5748;
SKIN = 2;
EDGE_R = 2.4;
END_R = 6;

COUNTERSINK_HEIGHT = (COUNTERSINK_DIAMETER - SCREW_OUTER_DIAMETER) / (SCREW_HEAD_DIAMETER - SCREW_OUTER_DIAMETER) * SCREW_HEAD_HEIGHT;

module hole() {
    $fn = 36;
    translate([0, 0, -CART_DEPTH/2])
    union() {
        cylinder(r=COUNTERSINK_DIAMETER/2, h=COUNTERSINK_TOP_DEPTH);
        translate([0, 0, COUNTERSINK_TOP_DEPTH]) {
            cylinder(r1=COUNTERSINK_DIAMETER/2, r2=SCREW_OUTER_DIAMETER/2, h=COUNTERSINK_HEIGHT);
        }
        cylinder(r=SCREW_OUTER_DIAMETER/2, h=CART_DEPTH/2);
        cylinder(r=SCREW_INNER_DIAMETER/2, h=HOLE_DEPTH);
    }
}

POST_HEIGHT = CART_DEPTH - 2*SKIN;
LEDGE_DIAMETER = post_diameter + 1;
POST_FILLET_R = EDGE_R * 2;
POST_FLEX_GAP = .2;

module post() {
    $fn = 36;
    difference() {
    translate([0,0,-POST_HEIGHT/2])
    union() {
        cylinder(r=LEDGE_DIAMETER/2, h=POST_HEIGHT);

        // fillet top and bottom
        for(i=[0,1])
            rotate([0,180*i,0])
            translate([0,0,-POST_HEIGHT*i])
            difference() {
                cylinder(r=LEDGE_DIAMETER/2 + POST_FILLET_R, h=POST_FILLET_R);
                translate([0,0,POST_FILLET_R]) torus(LEDGE_DIAMETER/2, POST_FILLET_R);
            }
    }
    // This gap helps keep the PCB snug
    cube([
         LEDGE_DIAMETER + 2*POST_FILLET_R,
         LEDGE_DIAMETER + 2*POST_FILLET_R,
         POST_FLEX_GAP], center=true);
    }
}

module pcb() {
    difference() {
        translate([-PCB_WIDTH / 2, 0, -PCB_THICKNESS])
            cube([PCB_WIDTH, PCB_length, PCB_THICKNESS]);
        if (post_diameter > 0) {
            translate([0, post_y, -PCB_THICKNESS-EPSILON])
                // - .25 is to give a little bit of tolerance
                cylinder(r=post_diameter/2 - .25, h=PCB_THICKNESS + 2* EPSILON);
        }
    }
}

WALL_THICKNESS = 1.6;
CONNECTOR_LENGTH = 10;
DEBOSS_DEPTH = .6;

STRIPE_START = CART_LENGTH - 35.5;
STRIPE_WIDTH = 2;
STRIPE_COUNT = 6;
STRIPE_END = STRIPE_START + (STRIPE_COUNT * 2 - 1) * STRIPE_WIDTH;

LABEL_WIDTH = 54.5;
LABEL_R = STRIPE_WIDTH;

module stripes() {
    for(i=[0:STRIPE_COUNT-1])
        translate([-CART_WIDTH/2-EPSILON, STRIPE_START + i*STRIPE_WIDTH*2, -CART_DEPTH/2-EPSILON])
            cube([CART_WIDTH + 2*EPSILON, STRIPE_WIDTH, CART_DEPTH + 2*EPSILON]);
}

module round_rect(r, w, d, h) {
    union() {
        for (x=[0,w])
            for (y=[0,d])
                translate([x, y, 0]) cylinder(r=r, h=h);
        translate([-r,0,0]) cube([w + 2*r, d, h]);
        translate([0,-r,0]) cube([w, d + 2*r, h]);
    }
}

module label(y=0, h=CART_DEPTH) {
    // label indent
    translate([-LABEL_WIDTH/2+LABEL_R, STRIPE_START + 2* STRIPE_WIDTH + LABEL_R, y])
        round_rect(
                   LABEL_R,
                   LABEL_WIDTH - 2* LABEL_R,
                   (STRIPE_COUNT *2 -3) * STRIPE_WIDTH - 2* LABEL_R - 2*STRIPE_WIDTH,
                   h);
}

module deboss_mask() {
    difference() {
        stripes();

        // label border
        translate([-LABEL_WIDTH/2+LABEL_R, STRIPE_START + 2* STRIPE_WIDTH + LABEL_R, 0])
            round_rect(
                       STRIPE_WIDTH + LABEL_R,
                       LABEL_WIDTH - 2* LABEL_R,
                       (STRIPE_COUNT *2 -3) * STRIPE_WIDTH - 2* LABEL_R - 2*STRIPE_WIDTH,
                       CART_DEPTH);
    }
    label();
}

module shell(inset) {
    $fn=36;
    translate([-CART_WIDTH/2, CART_LENGTH-END_R, 0])
    union() {
        // curved edges at end
        for(z=[-1, 1])
            translate([inset,0,z*(CART_DEPTH/2-END_R)])
                rotate([0, 90, 0])
                round_cylinder(EDGE_R-inset, END_R-inset, CART_WIDTH-2*inset);

        for(x=[0,CART_WIDTH-2*EDGE_R])
            // curved end side edges
            translate([x+EDGE_R, END_R-EDGE_R, -CART_DEPTH/2+END_R]) {
                rotate([0,0,90]) // line up faces
                    cylinder(r=EDGE_R-inset, h=CART_DEPTH-END_R*2);

                // all 4 long edges
                for(z=[0,1])
                    translate([0, -END_R+EDGE_R, z*(CART_DEPTH - 2 * EDGE_R)-END_R+EDGE_R])
                        rotate([90,90+z*90,0])
                        cylinder(r=EDGE_R-inset, h=CART_LENGTH-END_R-inset);
            }

        // top and bottom face
        translate([EDGE_R, inset-CART_LENGTH+END_R, -CART_DEPTH/2+inset])
            cube([CART_WIDTH-2*(EDGE_R), CART_LENGTH-END_R-inset, CART_DEPTH-2*inset]);

        // side face to end
        translate([inset, inset-CART_LENGTH+END_R, -CART_DEPTH/2+END_R])
            cube([CART_WIDTH-2*inset, CART_LENGTH-EDGE_R-inset, CART_DEPTH-2*END_R]);

        // side face to edges
        translate([inset, inset+END_R-CART_LENGTH, -CART_DEPTH/2+EDGE_R])
            cube([CART_WIDTH-2*inset, CART_LENGTH-END_R-inset, CART_DEPTH-2*EDGE_R]);

        // end face
        translate([EDGE_R, inset-CART_LENGTH+END_R, -CART_DEPTH/2+END_R])
            cube([CART_WIDTH-2*EDGE_R, CART_LENGTH-2*inset, CART_DEPTH-2*END_R]);
    }
}

CONNECTOR_MAX_WIDTH = 66.5;
CONNECTOR_MAX_HEIGHT = 15;
CONNECTOR_MIN_WIDTH = 64.1;
CONNECTOR_MIN_HEIGHT = 12.9;

module box() {
    union() {
        // main shell
        difference() {
            if (debossed_stripes) {
                partition() {
                    shell(0);
                    deboss_mask();
                    shell(DEBOSS_DEPTH);
                }
            } else {
                shell(0);
            }
            union() {
                difference() {
                    shell(SKIN);

                    // edge connector wall
                    translate([-CART_WIDTH/2, CONNECTOR_LENGTH, -CART_DEPTH/2])
                        cube([CART_WIDTH, WALL_THICKNESS, CART_DEPTH]);
                }

                // bevelled opening
                translate([0, -EPSILON, -PCB_THICKNESS/2])
                    rotate([270, 0, 0])
                    frustum(
                            CONNECTOR_MAX_WIDTH,
                            CONNECTOR_MAX_HEIGHT,
                            SKIN + 2*EPSILON,
                            CONNECTOR_MIN_WIDTH,
                            CONNECTOR_MIN_HEIGHT);
            }
        }
    }
}

FOOT_DEPTH = 7.6;
FOOT_R = FOOT_DEPTH/2;

module foot() {
    module foot_ball() {
        rotate([0, 90, 0]) // align poles with x-axis
            sphere(r=FOOT_R);
    }
    hull() {
        foot_ball();
        translate([0, 0, FOOT_DEPTH]) foot_ball();
        translate([0, -FOOT_DEPTH, FOOT_DEPTH]) foot_ball();
    }
}

module cart() {
    difference() {
        union() {
            if (post_diameter > 0) {
                translate([0, post_y, 0]) post();
            }
            if (add_feet) {
                difference() {
                    for(i=[-1,1])
                        translate([i * (CART_WIDTH/2 - EDGE_R - FOOT_R -
                        STRIPE_WIDTH),
                                  STRIPE_END - STRIPE_WIDTH - FOOT_R,
                                  -CART_DEPTH/2 - FOOT_DEPTH + FOOT_R])
                            foot();

                    translate([-CART_WIDTH/2, 0, -CART_DEPTH/2 + SKIN - EPSILON])
                        cube([CART_WIDTH, CART_LENGTH, CART_DEPTH/2]);
                }
            }
            box();
        }
        union() {
            if (post_diameter > 0) {
                translate([0, post_y, 0]) hole();
            }
            pcb();
        }
    }
}


module half(top) {
    module top_mask() {
        translate([-CART_WIDTH/2-EPSILON, -EPSILON, -EPSILON])
            difference() {
                cube([CART_WIDTH + 2*EPSILON, CART_LENGTH + 2*EPSILON, CART_DEPTH + 2*EPSILON]);

                // top/bottom interlock
                translate([SKIN/2, CONNECTOR_LENGTH + WALL_THICKNESS + EPSILON, 0])
                    difference() {
                        xl = CART_WIDTH - SKIN;
                        yl = CART_LENGTH - CONNECTOR_LENGTH - WALL_THICKNESS - SKIN/2 - EPSILON;
                        zl = SKIN;
                        cube([xl, yl, zl]);
                        translate([SKIN/2+1, -1, -1]) {
                            cube([xl - SKIN-2*1, yl - SKIN/2-1, zl + 2*1]);
                        }
                    }
            }
    }
    if (top) {
        difference() {
            intersection() {
                cart();
                top_mask();
            }
            if (label_hole) {
                label();
            }
        }

    } else {
        difference() {
            cart();
            top_mask();
        }
    }
}

module main() {
    rotate([90, 0, 0]) // rotate so edge connector is on build-plate
    if (part == "top") {
        half(true);
    } else if (part == "bottom") {
        half(false);
    } else {
        // both
        half(true);
        translate([0, 0, -12])
            half(false);
    }
}


module mockup() {
    color([0.2,0.2,0.2,1])
    cart();

    color([.8,.8,.85,1])
    label(y=CART_DEPTH/2 - DEBOSS_DEPTH, h=DEBOSS_DEPTH);
}

main();
