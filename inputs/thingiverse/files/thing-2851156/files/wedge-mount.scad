// Mount Type
mount_type = 165; // [165:Ball, 247:Flange, 442:Keyed Flange, 221:Hex Socket]

// Include break-away supports
enable_supports = 1 ; // [1:yes, 0:no]

/* [Basic Settings] */

// Inner diameter of the tube
tube_inner_diameter = 19.5;

// Outer diameter of the screw thread
screw_dia = 6.17;

// Distance between opposing edges of the hex nut
nut_width = 10.86;

// Depth to sink the nut
nut_depth = 5;

// Diameter of the ball
ball_dia = 25.4;

// Amount the flange will overlap the tube
flange_over = 0.5;

// Countersink diameter on the ball
countersink_dia = 12;

countersink_wall = 4;

/* [Advanced Settings] */

wedge_play = 0.3;
wedge_length_factor = 3;
wedge_min_thickness = 4;
socket_factor = 0.7;
channel_factor = 0.5;
support_width = 0.6;
stem_length_factor = 0.25;
stem_dia_factor = 0.4;
key_play = 0.5;
flange_thickness = 2;
nut_play = 0.5;
screw_play = 0.4;
max_overhang = 40;

/* [Hidden] */

//
// Constants
//
$fa = 1;
$fs = 1;

F_SEP_FLANGE = 2;
F_BALLS = 3;
F_BALL_FLANGE = 5;
F_BALL_KEY = 7;
F_BALL_WEDGE = 11;
F_TOP_WEDGE = 13;
F_WEDGE_SOCKET = 17;
F_WEDGE_FLANGE = 19;

// Computed
nut_radius = nut_width / 2 / cos(30) + nut_play;
wedge_radius = tube_inner_diameter / 2 - wedge_play;
wedge_dia = wedge_radius * 2;
wedge_length = wedge_radius * wedge_length_factor;
wedge_angle = atan(wedge_radius * 2 / wedge_length);
wedge_offset = wedge_min_thickness / tan(wedge_angle);
channel_raidus = wedge_radius * channel_factor;
wedge_cap_thickness = wedge_length - (channel_raidus + wedge_radius) / tan(wedge_angle);
screw_radius = screw_dia / 2 + screw_play;
support_radius = screw_radius + support_width;
stem_length = ball_dia / 2 + ball_dia * stem_length_factor;
stem_radius = ball_dia * stem_dia_factor / 2;
flange_radius = tube_inner_diameter / 2 + flange_over;
socket_radius = wedge_radius * socket_factor;
key_radius = socket_radius - key_play;
key_length = flange_thickness + nut_depth - key_play;
countersink_radius = countersink_dia/2;
ball_flange_height = (flange_radius - stem_radius) / tan(max_overhang);

function feature(n) = mount_type % n == 0;

// Wedge
module make_wedge(recess_rad) {
    translate([0,0,wedge_length]) {
        rotate([180,0,0]) {
            difference() {
                // Body
                translate([0,0,wedge_offset - nut_depth]) {
                    cylinder(wedge_length - wedge_offset + nut_depth, wedge_radius, wedge_radius);
                }

                // Wedge slope
                translate([-wedge_radius,-wedge_radius,-nut_depth]) {
                    rotate([-wedge_angle,0,0]) {
                        cube([wedge_dia, wedge_dia, wedge_length*2]);
                    }
                }

                // Channel
                cylinder(wedge_length - wedge_cap_thickness, channel_raidus, channel_raidus);

                // Screw hole
                cylinder(wedge_length * 2, screw_radius, screw_radius);

                if (recess_rad > 0) {
                    // Nut Recess
                    translate([0,0,wedge_length-nut_depth]) {
                        cylinder(nut_depth + 1, recess_rad, recess_rad, $fn=6);
                    }
                }
            }

            // Break-away support
            if (enable_supports && recess_rad > 0) {
                translate([0,0,wedge_length - nut_depth - 1]) {
                    difference() {
                        translate([0,0,1])
                            cylinder(nut_depth, support_radius, support_radius);
                        cylinder(nut_depth + 2, screw_radius, screw_radius);
                    }
                }
            }
        }
    }
}

module make_flange() {
    difference() {
        union() {
            // Flange
            cylinder(flange_thickness, flange_radius, flange_radius);

            // Key
            if (feature(F_SEP_FLANGE))
                cylinder(key_length, key_radius, key_radius, $fn=6);
        }

        // Screw hole
        translate([0,0,-1])
            cylinder(wedge_length * 2, screw_radius, screw_radius);
    }
}

module make_ball(is_top) {
    difference() {
        union() {
            sphere(d=ball_dia);

            if (!is_top) {
                // Stem
                translate([0,0,1])
                    cylinder(stem_length-1, stem_radius, stem_radius);

                // Ball-integrated flange
                if (feature(F_BALL_FLANGE)) {
                    translate([0,0,stem_length-0.01]) {
                        // Flange cone
                        cylinder(h=ball_flange_height, r1=stem_radius, r2=flange_radius);

                        translate([0,0,ball_flange_height - 0.01]) {
                            cylinder(flange_thickness, flange_radius, flange_radius);

                            translate([0,0,flange_thickness - 0.01]) {
                                // Key
                                if (feature(F_BALL_KEY))
                                    cylinder(nut_depth - key_play, key_radius, key_radius, $fn=6);

                                if (feature(F_BALL_WEDGE))
                                    make_wedge(0);
                            }
                        }
                    }
                }

                // Key
                //cylinder(100, key_radius, key_radius, $fn=6);
            }
        }

        // Turn the sphere into a hemisphere
        translate([0,0,-ball_dia])
            cylinder(ball_dia, ball_dia, ball_dia);

        if (is_top) {
            // Countersink
            translate([0,0,countersink_wall])
                cylinder(ball_dia, countersink_radius, countersink_radius);
        }

        // Screw hole
        translate([0,0,-1])
            cylinder(ball_dia + ball_flange_height + nut_depth + 2, screw_radius, screw_radius);
    }
}

if (feature(F_BALLS)) {
    translate([0,ball_dia/-2 - wedge_radius - 5, 0]) {
        make_ball(true);
        translate([ball_dia + 5, 0,0])
           make_ball(false);
    }
}

if (feature(F_TOP_WEDGE)) {
    if (feature(F_WEDGE_SOCKET)) {
        make_wedge(socket_radius);
    } else if (feature(F_WEDGE_FLANGE)) {
        make_flange();
        translate([0,0,flange_thickness - 0.01])
            make_wedge(0);
    } else {
        make_wedge(0);
    }
}

translate([wedge_radius*2+5, 0,0])
    make_wedge(nut_radius);

if (feature(F_SEP_FLANGE)) {
    translate([0,wedge_radius + flange_radius + 5,0])
        make_flange();
}
