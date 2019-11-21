
////////////////////////////////////
// OpenScad cable strain relief
////////////////////////////////////
//
// Author: assin
////////////////////////////////////
//
// Thanks to steren for the ribs
////////////////////////////////////


///////////////
// Variables //
///////////////

/// Parameters ///

// Select parts
show = 0; // [0:all, 1:bottom, 2:top]

// Print screw head support
support = 1;

// diameter of the cable
cable_diameter = 5.1;

/*[baseplate]*/
// radius of the corners
corner_radius = 6;

// baseplate width
foot_width = 30;

// baseplate length
foot_length = 20;

// baseplate height
foot_height = 2;

// diameter of the large end of the screwhead in baseplate
foot_screw_head_d1 = 6.2;

// diameter of the small end of the screwhead in baseplate
foot_screw_head_d2 = 3.2;

/*[clamp block]*/
// width of the clampblock
block_width = 8;

// height of the clampblock
block_height = 6;

// screwhole diameter in bottom block
block_screw_diameter = 2.4;

// feedthrough diameter in top block
block_screw_feedthrough_diameter = 3;

// hole diameter for sinking screw head
block_screw_head_diameter = 5.8;

// hole depth for sinking screw head
block_screw_head_height = 2.4;

// support width for printing screw hole
block_screw_support = 0.6;

// Add claws (1=on, 0=off)
claws = 1;

// Make cable hole a little smaller for clamping
claws_offset = 1;

/*[hidden]*/
// avoid artifacts
clearance = 0.01;


///////////
// Build //
///////////

if (show < 2) {
    bottom();
}
if (show == 0) {
    translate([foot_width/2-block_width/2+foot_length*3/4, foot_length+2,0]) {
        rotate(90, [0,0,1]) {
            top();
        }
    }
}
if (show == 2) {
    translate([0, block_width,0]) {
        rotate(270, [0,0,1]) {
            top();
        }
    }
}

/////////////
// Modules //
/////////////

module top() {
    difference() {
        bar();

        // Screw holes
        translate([block_width/2,(foot_length-cable_diameter)/4,-clearance]) {
            cylinder(d=block_screw_feedthrough_diameter, h=block_height+2*clearance, $fn=96);
            // Screw head
            cylinder(d=block_screw_head_diameter, h=block_screw_head_height, $fn=96);
        }
        translate([block_width/2,foot_length-(foot_length-cable_diameter)/4,-clearance]) {
            cylinder(d=block_screw_feedthrough_diameter, h=block_height+2*clearance, $fn=96);
            // Screw head
            cylinder(d=block_screw_head_diameter, h=block_screw_head_height, $fn=96);
        }
    }

    // Screw support
    if (support != 0) {
        translate([block_width/2,(foot_length-cable_diameter)/4,-clearance]) {
            holeSupport(
                block_screw_feedthrough_diameter,
                block_height,
                block_screw_support
            );
        }
        translate([block_width/2,foot_length-(foot_length-cable_diameter)/4,-clearance]) {
            holeSupport(
                block_screw_feedthrough_diameter,
                block_height,
                block_screw_support
            );
        }
    }
}

module bottom() {
    difference() {
        
        // foot
        roundedRectangle(foot_width,foot_length,foot_height,corner_radius);
        
        // screw hole
        translate([foot_width/5, foot_length/2, -clearance]) {
            cylinder(d2=foot_screw_head_d1, d2=foot_screw_head_d1, h=foot_height+2*clearance, $fn=96);
        }

        // screw hole
        translate([foot_width-foot_width/5, foot_length/2, -clearance]) {
            cylinder(d2=foot_screw_head_d1, d2=foot_screw_head_d1, h=foot_height+2*clearance, $fn=96);
        }
    }
    translate([foot_width/2-block_width/2,0,foot_height]) {
        difference() {

            bar(1);

            // Screw holes
            translate([block_width/2,(foot_length-cable_diameter)/4,0]) {
                cylinder(d=block_screw_diameter, h=block_height+clearance, $fn=96);
            }
            translate([block_width/2,foot_length-(foot_length-cable_diameter)/4,0]) {
                cylinder(d=block_screw_diameter, h=block_height+clearance, $fn=96);
            }
        }
    }
}

module bar(type) {
    difference() {
        
        // Bar body
        cube([block_width, foot_length, block_height]);

        // Cable cut
        if (claws != 0) {
            translate([-clearance, foot_length/2, block_height+claws_offset/2]) {
                rotate ([0, 90, 0]) {
                    rotate_extrude($fn=200) {
                        
                        if (type == 1) {
                            polygon(points=[
                                [0, -clearance],
                                [cable_diameter / 2, -clearance],
                                [cable_diameter / 2, block_width / 2 - cable_diameter / 10 * 4],
                                [cable_diameter / 2 - cable_diameter / 10, block_width / 2 - cable_diameter / 10 * 3],
                                [cable_diameter / 2, block_width / 2 - cable_diameter / 10 * 2],
                                [cable_diameter / 2, block_width / 2 + cable_diameter / 10 * 2],
                                [cable_diameter / 2 - cable_diameter / 10, block_width / 2 + cable_diameter / 10 * 3],
                                [cable_diameter / 2, block_width / 2 + cable_diameter / 10 * 4],
                                [cable_diameter / 2, block_width + clearance * 2],
                                [0, block_width + clearance * 2]] );
                        } else {
                            polygon( points=[[0, -clearance],
                                [cable_diameter / 2, -clearance],
                                [cable_diameter / 2, block_width / 2 - cable_diameter / 10],
                                [cable_diameter / 2 - cable_diameter / 10, block_width / 2],
                                [cable_diameter / 2, block_width / 2 + cable_diameter / 10],
                                [cable_diameter / 2, block_width + clearance * 2],
                                [0, block_width + clearance * 2]] );
                        }
                    }
                }
            }
        } else {
            translate([-clearance,foot_length/2,block_height+claws_offset/2]) {
                rotate(90, [0,1,0]) {
                    cylinder(d=cable_diameter, h=block_width+2*clearance, $fn=96);
                }
            }
        }
    }
}

module roundedRectangle(width, depth, height, radius) {
    hull () {    
        translate([radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
    }
}
module holeSupport(diameter, height, thickness) {
    difference() {
        cylinder(d=diameter+thickness, h=height, $fn=96);
        translate([0,0,-clearance]) {
            cylinder(d=diameter, h=height+2*clearance, $fn=96);
        }
    }
}
