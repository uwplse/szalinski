// Version 2 of my rainbarrel diverter.
// Improvements in this version.
// Most of the calculations are based upon hull(), which makes this a lot easier to code.
// Rounded corners. :-)

/* [Printer Constraints and Quality] */

// Your printer Nozzle diameter. Used to ensure radial fit with a hoses and other items.
nozzle_diameter = 0.4; 
// Total height of the diverter. What's the max your printer can handle on the z-axis?
diverter_height = 197; 
// Used in a few places to smooth out transitional parts. or bits with super-tricky geometry.
layer_res = 0.05;
// Number of subdivisions on curved surfaces. 90 Seems about right.
$fn = 90;
// Wall thickness for the diverter
diverter_wall_thickness = 1.74;
// Wall thickness of the grate
diverter_grate_thickness = 2.59;

/* [Downspout Dimentions] */

// Width of your downspout tubing.
downspout_width = 80;
// Depth of the downspout
downspout_depth = 55;
// Corner Radius of your downspout.
downspout_corner_radius = 8.5;
// Wall thickness of the downspout. Including any ribbing variation.
downspout_wall_thickness = 1.75;
// How much of a sleeve you want on the top / bottom for interfacing with downspout.
downspout_sleeve_height = 18;
// How tall the 'transition' between the bottom outlet and the main body of the diverter should be.
sleeve_transition_height = 2.5;

/* [Grate Mesh Parameters] */
// Include drip flap to direct water toward the grate? If so, this will 
drip_flap = true;

// Width of grates.
diverter_grate_width = 2.59;
// Number of openings across the width of the grate
diverter_grate_openings = 10;
// Number of offset segments between the top of the grate and the bottom of the grate.
diverter_grate_segments = 4;

/* [Grit Drains] */

// How many grit drains?
grit_drains = 2;
// Diameter of the grit drain holes?
grit_drain_diameter = 2;

// x axis size available for grit drain placement.
grit_drain_region = downspout_width - (downspout_corner_radius * 2) - grit_drain_diameter;
grit_drain_step = grit_drain_region / (grit_drains - 1);

diversion_chamber_height = diverter_height - (downspout_sleeve_height * 2) - sleeve_transition_height;

/* [Hidden] */
z_mirror = (drip_flap == true) ? 1 : 0;

//We'll build this one from the bottom up.
mirror([0, 0, z_mirror])
difference() {
    union() {
        lower_sleeve();
        lower_transition();
        diversion_chamber_innards();
        diversion_chamber_casing();
        upper_sleeve();
        if (drip_flap == true) {
            drip_flap();
        }

        // Barbs
        translate([-(downspout_width / 2), 
                        -(downspout_depth / 2) + downspout_corner_radius + 13,
                       downspout_sleeve_height + sleeve_transition_height + (diversion_chamber_height / 2) - 10 - 20])
        rotate([0, -90, 0]) {
            inverted_barb(180);
            translate([24.5, 0, 0]) {
                inverted_barb(360);
            }
        }
    };

    // Locations of barb-hollows.
    translate([-(downspout_width / 2) + (diverter_wall_thickness * 2), 
                    -(downspout_depth / 2) + downspout_corner_radius + 13,
                   downspout_sleeve_height + sleeve_transition_height + (diversion_chamber_height / 2) - 10 - 20])
    rotate([0, -90, 0]) {
        cylinder(d = 18, h = diverter_wall_thickness * 3);
        translate([24.5, 0, 0]) {
            cylinder(d = 18, h = diverter_wall_thickness * 3);
        }
    };

    // Grit drain holes
    translate([-(downspout_width / 2) + downspout_corner_radius,
                    -(downspout_depth / 2) + diverter_wall_thickness,
                    downspout_sleeve_height + sleeve_transition_height])
        
        for( i = [0 : grit_drains - 1] ) {
            translate([i * grit_drain_step, grit_drain_diameter / 2, 0])
                cylinder(d = grit_drain_diameter, h = diversion_chamber_height / 2);
        };
}


module drip_flap() {
 translate([0, 0, downspout_sleeve_height + sleeve_transition_height + diversion_chamber_height - downspout_corner_radius])    
    for (z = [0 : layer_res : downspout_corner_radius]) {
        intersection() {
            difference() {
                hull() {
                    translate([-((downspout_width / 2) - downspout_corner_radius),
                                    ((downspout_depth / 2) - downspout_corner_radius),
                                    z])
                        cylinder(r = downspout_corner_radius, h = layer_res);
                    
                    mirror([1, 0, 0]) 
                    translate([-((downspout_width / 2) - downspout_corner_radius),
                                    ((downspout_depth / 2) - downspout_corner_radius),
                                    z])
                        cylinder(r = downspout_corner_radius, h = layer_res);
                };
            };
            union() {
                translate([-(downspout_width / 2),
                                (downspout_depth / 2) - diverter_wall_thickness - downspout_corner_radius + z,
                                z])
                    cube([downspout_width, diverter_wall_thickness, layer_res]);
            }
        }
    }
}

module upper_sleeve() {
    translate([0, 0, downspout_sleeve_height + sleeve_transition_height + diversion_chamber_height])
    difference() {
        hull() {
            all_quad() {
                translate([((downspout_width) / 2) - downspout_corner_radius,
                                ((downspout_depth) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius, h = layer_res);
            }
            translate([0, 0, downspout_sleeve_height]) all_quad() {
                translate([((downspout_width) / 2) - downspout_corner_radius,
                                ((downspout_depth) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius, h = layer_res);
            }
        };
        hull() {
            all_quad() {
                translate([((downspout_width) / 2) - downspout_corner_radius,
                                ((downspout_depth) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
            }
            translate([0, 0, downspout_sleeve_height]) all_quad() {
                translate([((downspout_width) / 2) - downspout_corner_radius,
                                ((downspout_depth) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
            }
        }
    }
}

module diversion_chamber_casing() {
    translate([0, 0, downspout_sleeve_height + sleeve_transition_height])
    for (t = [0 : 1]) {
        mirror([0, 0, t]) {
            translate([0, 0, t == 1 ? -(diversion_chamber_height): 0]) {
                intersection() {
                    difference() {
                        hull() {
                            all_quad() {
                                translate([((downspout_width) / 2) - downspout_corner_radius,
                                                ((downspout_depth) / 2) - downspout_corner_radius,
                                                0])
                                    cylinder(r = downspout_corner_radius, h = layer_res);
                            }
                            translate([0, 
                                            downspout_depth / 2, 
                                            (diversion_chamber_height / 2)]) 
                            all_quad() {
                                translate([((downspout_width) / 2) - downspout_corner_radius,
                                                (downspout_depth) - downspout_corner_radius,
                                                0])
                                    sphere(r = downspout_corner_radius, h = layer_res);
                            }
                        };
                        hull() {
                            all_quad() {
                                translate([((downspout_width) / 2) - downspout_corner_radius,
                                                ((downspout_depth) / 2) - downspout_corner_radius,
                                                0])
                                    cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
                            }
                            translate([0, 
                                downspout_depth / 2, 
                                (diversion_chamber_height / 2)])
                            all_quad() {
                                translate([((downspout_width) / 2) - downspout_corner_radius,
                                                (downspout_depth) - downspout_corner_radius,
                                                0])
                                    sphere(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
                            }
                        }
                    };
                   translate([-downspout_width / 2, -downspout_depth / 2, 0]) 
                        cube([downspout_width, downspout_depth * 2, diversion_chamber_height / 2]);
                }
            }
        }
    }
}

module diversion_chamber_innards() {
    translate([0, 0, downspout_sleeve_height + sleeve_transition_height]) {
        difference() {
            // Inner Components First, because it'll be easier to visualize that way.
            for (t = [0 : 1]) {
                mirror([0, 0, t]) {
                    
                translate([0, 0, t == 1 ? -diversion_chamber_height : 0])
                // Back half of the diverter's curved wall.
                hull() {
                        for (z = [(t == 1 ? -diverter_grate_thickness : 0) : layer_res : downspout_corner_radius]) {
                        intersection() {
                            difference() {
                                hull() {
                                    translate([-((downspout_width / 2) - downspout_corner_radius),
                                                    -((downspout_depth / 2) - downspout_corner_radius),
                                                    z])
                                        cylinder(r = downspout_corner_radius, h = layer_res);
                                    mirror([1, 0, 0]) translate([-((downspout_width / 2) - downspout_corner_radius),
                                                    -((downspout_depth / 2) - downspout_corner_radius),
                                                    z])
                                        cylinder(r = downspout_corner_radius, h = layer_res);
                                };
                                hull() {
                                    translate([-((downspout_width / 2) - downspout_corner_radius),
                                                    -((downspout_depth / 2) - downspout_corner_radius),
                                                    z])
                                        cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
                                    mirror([1, 0, 0]) translate([-((downspout_width / 2) - downspout_corner_radius),
                                                    -((downspout_depth / 2) - downspout_corner_radius),
                                                    z])
                                        cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
                                }
                            };
                            union() {
                                translate([-(downspout_width / 2),
                                                -(downspout_depth / 2) + z,
                                                z])
                                    cube([downspout_width, t == 0 ? diverter_wall_thickness : diverter_grate_thickness, layer_res]);
                            }
                        }
                    }
                    translate([-(downspout_width / 2),
                                    (downspout_depth / 2) - (diverter_grate_thickness - diverter_wall_thickness),
                                    (diversion_chamber_height / 2) - layer_res])
                        cube([downspout_width, diverter_grate_thickness, layer_res]);
                    }
                }
            };
            // s = grate row
            for ( s = [0 : ((downspout_width + diverter_grate_width) / diverter_grate_openings) : downspout_width]) {
                translate([-(downspout_width / 2) + s,
                                -(downspout_depth / 2),
                                diversion_chamber_height / 2])
                {
                    // o = column iteration.
                    for ( o = [0 : 1 : diverter_grate_segments - 1] ) {
                        // Grate Openings are shifted every other row.
                        if (o % 2 == 0) {
                            translate([0, (downspout_depth / diverter_grate_segments) * o, 0])
                                grate_opening((downspout_width / diverter_grate_openings) - diverter_grate_width, 
                                                        (downspout_depth - 6) / diverter_grate_segments, 
                                                        diversion_chamber_height / 2);
                        } else {
                            translate([(((downspout_width / diverter_grate_openings) / 2) - (diverter_grate_width / 2)),
                                            (downspout_depth / diverter_grate_segments) * o, 
                                            0])
                                grate_opening((downspout_width / diverter_grate_openings) - diverter_grate_width, 
                                                        (downspout_depth - 6) / diverter_grate_segments, 
                                                        diversion_chamber_height / 2);
                        }
                    }
                }
            }
        }
    }    
}

module grate_opening(x, y, z) {
    hull() {
        translate([x / 2, x / 2, 0]) cylinder(d = x, h = z);
        translate([x / 2, y - (x / 2), 0]) cylinder(d = x, h = z);
    }   
}

module lower_transition() {
    translate([0, 0, downspout_sleeve_height])
    difference() {
        hull() {
            all_quad() {
                translate([((downspout_width - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                ((downspout_depth - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - (nozzle_diameter / 2), h = layer_res);
            }
            translate([0, 0, sleeve_transition_height]) all_quad() {
                translate([((downspout_width) / 2) - downspout_corner_radius,
                                ((downspout_depth) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius, h = layer_res);
            }
        };
        hull() {
            all_quad() {
                translate([((downspout_width - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                ((downspout_depth - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
            }
            translate([0, 0, sleeve_transition_height]) all_quad() {
                translate([((downspout_width) / 2) - downspout_corner_radius,
                                ((downspout_depth) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
            }
        }
    }
}

module lower_sleeve() {
    difference() {
        hull() {
            all_quad() {
                translate([((downspout_width - (3 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                ((downspout_depth - (3 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - (nozzle_diameter / 2), h = layer_res);
            }
            translate([0, 0, downspout_sleeve_height]) all_quad() {
                translate([((downspout_width - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                ((downspout_depth - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius, h = layer_res);
            }
        };
        hull() {
            all_quad() {
                translate([((downspout_width - (3 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                ((downspout_depth - (3 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
            }
            translate([0, 0, downspout_sleeve_height]) all_quad() {
                translate([((downspout_width - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                ((downspout_depth - (2 * downspout_wall_thickness)) / 2) - downspout_corner_radius,
                                0])
                    cylinder(r = downspout_corner_radius - diverter_wall_thickness, h = layer_res);
            }
        }
    }
}

module inverted_barb(orientation = 0) {
    difference() {
        hull() {
            cylinder(d1 = 26 + (diverter_wall_thickness * 2), d = 26, h = 1);
            cylinder(d = 26, h = 20);
            if (orientation != 0) {
                rotate([0, 0, orientation]) translate([30, 0, 0]) cylinder(d = 4, h = layer_res / 4);
            }
        }
        union() {
            for ( z = [0:5:20] ) {
                translate([0, 0, z]) cylinder(d1 = 20 + nozzle_diameter, d2 = 21 + nozzle_diameter, h = 5);
            }
            cylinder(d = 20 + nozzle_diameter, h = 21);
        }
    }        
}

module all_quad() {
    for (i = [0 : $children - 1]) {
        for (x = [0 : 1]) {
            mirror([x, 0, 0]) {
                for (y = [0 : 1]) {
                    mirror([0, y, 0]) children(i);
                }
            }
        }
    }
}
        
