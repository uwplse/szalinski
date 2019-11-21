// 1 to stretch the connection upwards and flatten it, 0 to keep connection height
flat_connection_top = 1;

// 1 to flatten the adapter top to make everything flush (with the build plate) for easier printing
flat_adapter_top = 1;

// Standoff seperation
so_sep = 31;
// Standoff radius is 2.5mm, I added 0.2mm on each side to make it a nice slide-on with PETG
so_r = 2.7;
// Model thickness around standoff
so_t = 1.2;
// Standoff height. The Hawk 5 has a 25mm standoff but the bottom ~0.5mm is covered
so_h = 24.5;

// The sma adapter outer radius
sma_r = 6;
// Angle at which the adapter sits
angle = 25;
// Distance the adapter sticks out
a_offset = 15;
// Offset from the bottom to the adapter-to-standoff mount
a_hoffset = 12;
// Adapter to standoff connection thickness
connection_thickness = 4.5;
// Adapter to standoff connection height
connection_height = 8;

// Tiewrap hole width & height
tw_w = 3.1;
tw_h = 1.2;

// Tiewrap holder width & height
tw_holder_h = 5;
tw_holder_w = (so_r + so_t) * 2;
tw_holder_d = so_r + so_t + tw_w + 2;

// Depth of the recessed hex part in the adapter
hex_h = 3;
// Depth of the sma hole in the adapter
shaft_h = 3;

// Hex and connector radi
hex_r = 4.1;
con_r = 3.4;

// Total 'height' for the adapter
con_h = hex_h + shaft_h;

// 1 to rotate, 0 to have it upright
rotate_model = 0;

$fn = 64;

module arc( height, depth, radius, degrees ) {
    // This dies a horible death if it's not rendered here 
    // -- sucks up all memory and spins out of control 
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}

// Block for the tiewraps
module AntennaHolder() {
    // The tiewrap
    translate([so_sep / 2, 0, so_h - (tw_holder_h / 2)]) {
        rotate([0, 0, 45]) {
            difference() {
                translate([tw_holder_d / -2, 0, 0]) {
                    cube([tw_holder_d, tw_holder_w, tw_holder_h], center = true);
                }
                translate([-(so_r + so_t) - (tw_w / 2), 0, 0.5]) {
                    # cube([tw_w, 40, tw_h], center = true);
                    translate([0, 0, tw_h / -2]) {
                        # cube([1.5, 40, 2], center = true);
                    }
                    # cube([tw_w, 40, tw_h], center = true);
                }
            }
        }
    }
}

module StandOffs() {
    translate([so_sep / 2, 0, 0]) {
        cylinder(r = so_r, h = so_h * 2);
    }
    translate([-so_sep / 2, 0, 0]) {
        cylinder(r = so_r, h = so_h * 2);
    }
}

module StandoffsHolder() {
    translate([so_sep / 2, 0, 0]) {
        cylinder(r = so_r + so_t, h = so_h);
    }
    translate([-so_sep / 2, 0, 0]) {
        cylinder(r = so_r + so_t, h = so_h);
    }
}

// size is the XY plane size, height in Z
module hexagon(size, height) {
    boxWidth = size/1.75;
    for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}


module AdapterCylinder(os = 0) {
    cylinder(r = sma_r - os, h = con_h, center = true);
}

module Adapter() {
    difference() {
        AdapterCylinder();
        translate([0, 0, -(con_h / 2) + (hex_h / 2)]) {
            hexagon(hex_r * 2, hex_h);
        }
        translate([0, 0, (con_h / 2) - (shaft_h / 2)]) {
            cylinder(r = con_r, h = shaft_h, center = true);
        }
    }
}

module RoundBar() {
    difference() {
        scale([1,a_offset / (so_sep / 2),1]) {
            rotate([0,0,-90]) {
                arc(connection_thickness, connection_height + (flat_connection_top * 10), so_sep / 2 + (connection_thickness / 2), 180);
            }
        }
    }
}

module Holder() {
    difference() {
        translate([0, 0, a_hoffset]) {
            rotate([angle, 0, 0]) {
                translate([0, a_offset, 0]) {
                    rotate([-90, 30, 0]) {
                        Adapter();
                    }
                }
            }
        }
    }
}

module HolderArm() {
    AntennaHolder();
    mirror([1,0,0]) {
        AntennaHolder();
    }
    intersection() {
        translate([-20, 0, 0]) {
            cube([40, 40, 40]);
        }
        difference() {
            translate([0, 0, a_hoffset]) {
                rotate([angle, 0, 0]) {
                    translate([0, a_offset, 0]) {
                        difference() {
                            translate([0,-a_offset,-connection_height / 2]) {
                                RoundBar();
                            }
                            rotate([-90, 0, 0]) {
                                AdapterCylinder(0.01);
                            }
                        }
                    }
                }
            }
            translate([0, 0, so_h + 10]) {
                cube([50, 50, 20], center = true);
            }
        }
    }
}

module Model() {
    difference() {
        StandoffsHolder();
        StandOffs();
    }

    difference() {
        union() {
            Holder();
            HolderArm();
        }
        StandOffs();
        translate([-50,0,-100 + so_h + (flat_adapter_top * 100)]) {
            cube([100,100,20]);
        }
    }
}

// Rotate everything to make it print-ready
if (rotate_model == 1) {
    rotate([180 - angle, 0, 0]) {
        Model();
    }
} else {
    Model();
}