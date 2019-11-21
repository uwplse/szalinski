

/* [Case top] */

// Case width
case_width = 69;

// Case length
case_length = 69;

// Case top height
case_top_height = 7.4;

// Case bottom height
case_bottom_height = 14;

// Corner radius
case_corner_radius = 10;

// Wall width
case_wall = 2;

// Wall width
construction_height = 3;

// Case screws diameter
case_screw_diameter = 2;

// Case screw head diameter
case_screw_head_diameter = 6;

// Case screw head height
case_screw_head_height = 3;

// Case screws pillar offset
case_screw_pillar_offset = 7;

// Case screws pillar wall width
case_screw_pillar_wall_width = 1.6;

// Hanger large hole
case_hanger_hole_large_diameter = 6.5;

// Hanger small diameter
case_hanger_hole_small_diameter = 3.2;

// Hanger small diameter
case_hanger_slot_length = 5;

// Distance from center in x direction
case_hanger_offset_x = 20;

// Distance from center in y direction
case_hanger_offset_y = 15;

// Depth of the hanger protection
case_protection_depth = 4;

// Wall wifth of the hanger protection
case_protection_wall_width = 1;


/* [PIR] */

// Diameter of the PIR sphere
pir_diameter = 23.4; // Sphere diameter

// Cutout width for the pins
pir_pin_cutout_width = 8.3;

// Cutout length for the pins
pir_pin_cutout_length = 4.4;

// Cutout depth for the pins
pir_pin_cutout_depth = 2;

// Screw hole for PIR module
pir_screw_hole_diameter = 1.8;

// PIR screw hole offset
pir_screw_hole_offset = 3;

// PIR screw hole depth
pir_screw_hole_depth = 4.2;


/* [USB connector] */

// USB mount pcb width
usb_pcb_width = 13.3;

// USB mount pcb length
usb_pcb_length = 14.6;

// USB mount pcb height
usb_pcb_height = 1.8;

// Cutout length for the soldered pins
usb_pin_length = 2.6;

// Cutout depth for the soldered pins
usb_pin_depth = 1;

// USB mount screw diameter
usb_mount_hole_diameter = 1.8;

// USB mount height
usb_mount_hole_depth = 4;

// Distance between the two screw holes
usb_mount_hole_distance = 8;

// USB mount holes distance from case wall
usb_mount_hole_offset = 7;

// USB mount port width
usb_port_width = 8.4;

// Maximum wall 
usb_max_wall_width = 1;


/* [Step down] */

// Width of the step down module
step_down_width = 13.6;

// Width of the step down module
step_down_length = 9.4;

// Height of the stop down module
step_down_height = 3;

// Distance from wall
step_down_offset = 2;


/* [Arduino Nano] */

// Arduino width
arduino_width = 18.3;

// Arduino length
arduino_length = 43.7;

// Arduino height
arduino_height = 2.4;

// Arduino to wall distance
arduino_wall_offset = 0.8;

// Screw hole pillar width and length
arduino_screw_pillar_width = 2.8;

// Screw hole diameter
arduino_screw_hole_diameter = 1.4;

// Screw hole distance from edges
arduino_screw_hole_offset = 1.35;


/* [NRF 24L01] */

// Width of the NRF pcb
nrf_pcb_width = 16;

// Length of the NRF pcb
nrf_pcb_length = 29.6;

// Height of the NRF pcb
nrf_pcb_height = 2;

// NRF to wall distance
nrf_offset = 1.6;

// NRF pins cutout width
nrf_pins_cutout_x = 11;

// NRF pins cutout length
nrf_pins_cutout_y = 5.3;

// NRF pins cutout depth
nrf_pins_cutout_z = 1.6;


/* [LDR] */

// LDR diameter
ldr_diameter = 5.4;

// LDR distance from top
ldr_offset = 10;

// Distance screws from ldr middle
ldr_screw_diameter = 1.8;

// Screw length
ldr_screw_length = 4;

// Distance screws from ldr middle
ldr_screw_offset = 6.4;


/* [Powerrail] */

// Cutout width
powerrail_width = 13;

// Cutout length
powerrail_length = 5;

// Cutout depth
powerrail_height = 2;

// Screw diameter
powerrail_screw_diameter = 1.8;

// Screw distance
powerrail_screw_distance = 8;

// Screw hole depth
powerrail_screw_depth = 4;

// Distance to wall
powerrail_offset_wall = 7;

// Distance to usb connector
powerrail_offset_left = 2.4;

// Distance screws to pin cutout
powerrail_offset_screws = 2;


/* [Misc] */

// Display 0=flat, 1=assembled, 2=top, 3=bottom
mode = 2; // [0,1,2,3]

// Add support to holes
support = true;

// Resolution
$fn=96;

// Avoid artifacts
clearance = 0.01;


///////////////////////
// Calculated values //
///////////////////////

// Case screws pillar height
case_screw_pillar_height = (case_top_height-case_wall-construction_height)+(case_bottom_height-case_screw_head_height-case_screw_pillar_wall_width)-0.1;


////////////
// Build //
////////////

if (mode == 0) { // Flat
    case_top();
    translate([case_width+10,0,0]) {
        case_bottom();
    }
} else if (mode == 1) { // Assembled
    case_bottom();    
    translate([
        case_width,
        0,
        case_bottom_height+case_top_height
    ]) {
        rotate(180, [0,1,0]) {
            case_top();
        }
    }
} else if (mode == 2) { // Top
    case_top();
} else if (mode == 3) { // Bottom
    case_bottom();
}

///////////////
// Modules //
///////////////

module case_bottom() {

    difference() {
        shell_bottom();
        
        // Screw hole top left
        translate([
            case_screw_pillar_offset,
            case_width-case_screw_pillar_offset,
            -clearance
        ]) {
            cylinder(
                d=case_screw_head_diameter,
                h=case_screw_head_height+2*clearance
            );
        }

        // Screw hole top right
        translate([
            case_width-case_screw_pillar_offset,
            case_width-case_screw_pillar_offset,
            -clearance
        ]) {
            cylinder(
                d=case_screw_head_diameter,
                h=case_screw_head_height+2*clearance
            );
        }
        
        // Screw hole bottom right
        translate([
            case_width-case_screw_pillar_offset,
            case_screw_pillar_offset,
            -clearance
        ]) {
            cylinder(
                d=case_screw_head_diameter,
                h=case_screw_head_height+2*clearance
            );
        }

        // Screw hole bottom left
        translate([
            case_screw_pillar_offset,
            case_screw_pillar_offset,
            -clearance
        ]) {
            cylinder(
                d=case_screw_head_diameter,
                h=case_screw_head_height+2*clearance
            );
        }
        
        // Hanger hole left
        translate([
            case_width/2-case_hanger_offset_x,
            case_length/2+case_hanger_offset_y,
            -clearance
        ]) {
            hanger_hole();
        }

        // Hanger hole right
        translate([
            case_width/2+case_hanger_offset_x,
            case_length/2+case_hanger_offset_y,
            -clearance
        ]) {
            hanger_hole();
        }
    }

    // Case screw top left
    translate([
        case_screw_pillar_offset,
        case_width-case_screw_pillar_offset,
        0
    ]) {
        case_scew_hole_case();
    }

    // Case screw top right
    translate([
        case_width-case_screw_pillar_offset,
        case_width-case_screw_pillar_offset,
        0
    ]) {
        case_scew_hole_case();
    }

    // Case screw bottom right
    translate([
        case_width-case_screw_pillar_offset,
        case_screw_pillar_offset,
        0
    ]) {
        case_scew_hole_case();
    }

    // Case screw bottom left
    translate([
        case_screw_pillar_offset,
        case_screw_pillar_offset,
        0
    ]) {
        case_scew_hole_case();
    }
    
    // Hanger protection left
    translate([
        case_width/2-case_hanger_offset_x,
        case_length/2+case_hanger_offset_y,
        case_wall
    ]) {
        hanger_protection();
    }

    // Hanger protection right
    translate([
        case_width/2+case_hanger_offset_x,
        case_length/2+case_hanger_offset_y,
        case_wall
    ]) {
        hanger_protection();
    }
}

module case_top() {
    difference() {
        
        shell_top();
        
        // pir cutout
        translate([
            case_width/2,
            case_length/2,
            -clearance
        ]) {
            pir_cutout();
        }

        // USB mount
        translate([
            case_width/2,
            usb_max_wall_width,
            case_wall
        ]) {
            usb_mount();
        }

        // Step down module
        translate([
            case_width-case_wall-nrf_pcb_width-nrf_offset,
            case_length-case_corner_radius-nrf_pcb_length-step_down_length-step_down_offset,
            case_wall
        ]) {
            step_down();
        }

        // Arduino
        translate([
            case_wall+arduino_wall_offset,
            case_length/2-arduino_length/2,
            case_wall+construction_height
        ]) {
            arduino();
        }

        // NRF
        translate([
            case_width-case_wall-nrf_pcb_width-nrf_offset,
            case_length-case_corner_radius-nrf_pcb_length,
            case_wall+construction_height
        ]) {
            nrf();
        }

        // LDR
        translate([
            case_width/2,
            case_length-ldr_offset,
            0
        ]) {
            ldr();
        }
        
        // Powerrail
        translate([
            case_width/2,
            0,
            case_wall+construction_height+clearance
        ]) {
            powerrail();
        }
    }
}

module pir_cutout() {

    cylinder(
        h=case_wall+2*clearance,
        d=pir_diameter
    );
    translate([
        -pir_diameter/2,
        -pir_diameter/2,
        case_wall+clearance
    ]) {
        cube([
            pir_diameter,
            pir_diameter,
            construction_height+clearance
        ]);
    }

    // PIR screw holes
    translate([
        0,
        0,
        case_wall+construction_height
    ]) {
        pir_screw_holes();
    }

    translate([
        0,
        0,
        clearance+case_wall+construction_height-pir_pin_cutout_depth
    ]) {
        // pir pin cutout (top left)
        translate([
            -pir_diameter/2,
            +pir_diameter/2-clearance,
            0
        ]) {
            pir_pin_coutout();
        }
        // pir pin cutout (top right)
        translate([
            pir_diameter/2-pir_pin_cutout_width,
            pir_diameter/2-clearance,
            0
        ]) {
            pir_pin_coutout();
        }
        // pir pin cutout (bottom right)
        translate([
            pir_diameter/2-pir_pin_cutout_width,
            -pir_diameter/2-pir_pin_cutout_length+clearance,
            0
        ]) {
            pir_pin_coutout();
        }
        // pir pin cutout (bottom left)
        translate([
            -pir_diameter/2,
            -pir_diameter/2-pir_pin_cutout_length+clearance,
            0
        ]) {
             pir_pin_coutout();
        }
    }
}

module pir_pin_coutout() {
    cube([
        pir_pin_cutout_width,
        pir_pin_cutout_length+clearance,
        pir_pin_cutout_depth+clearance
    ]);
}

module pir_screw_holes() {

    translate([0,
        -pir_screw_hole_offset-pir_diameter/2,
        -pir_screw_hole_depth+clearance
    ]) {
        cylinder(
            d=pir_screw_hole_diameter,
            h=pir_screw_hole_depth+clearance
        );

        translate([0, pir_diameter+2*pir_screw_hole_offset, 0]) {
            cylinder(
                d=pir_screw_hole_diameter,
                h=pir_screw_hole_depth+clearance
            );
        }
    }
}

module nrf() {
    translate([0,0,-nrf_pcb_height]) {
        cube([
            nrf_pcb_width,
            nrf_pcb_length,
            nrf_pcb_height+clearance
        ]);
        translate([0,0,-nrf_pins_cutout_z]) {
            cube([
                nrf_pins_cutout_x,
                nrf_pins_cutout_y,
                nrf_pins_cutout_z+clearance
            ]);
        }
    }
}

module arduino() {
    translate([0,0,-arduino_height]) {
        difference() {
            cube([
                arduino_width,
                arduino_length,
                arduino_height+clearance
            ]);
            arduino_pillar();
            translate([
                arduino_width-arduino_screw_pillar_width,
                0,
                0
            ]) {
                arduino_pillar();
            }
            translate([
                arduino_width-arduino_screw_pillar_width,
                arduino_length-arduino_screw_pillar_width,
                0
            ]) {
                arduino_pillar();
            }
            translate([
                0,
                arduino_length-arduino_screw_pillar_width,
                0
            ]) {
                arduino_pillar();
            }
        }
    }
}

module arduino_pillar() {
    difference() {
        cube([
            arduino_screw_pillar_width,
            arduino_screw_pillar_width,
            arduino_height
        ]);
        
        translate([
            arduino_screw_hole_offset,
            arduino_screw_hole_offset,
            0
        ]) {
            cylinder(
                d=arduino_screw_hole_diameter,
                h=arduino_height+clearance
            );
        }
    }
}

module usb_mount() {

    difference() {
        translate([
            -(usb_mount_hole_distance)/2,
            usb_mount_hole_offset,
            -case_wall+1
        ]) {
            cylinder(
                d=usb_mount_hole_diameter,
                h=usb_mount_hole_depth+clearance
            );
            translate([usb_mount_hole_distance,0,0]) {
                cylinder(
                    d=usb_mount_hole_diameter,
                    h=usb_mount_hole_depth+clearance
                );
            }
        }
    }
    
    // Port cutout
    translate([
        -usb_port_width/2,
        -case_wall-clearance,
        construction_height-usb_pcb_height+1
    ]) {
        cube([
            usb_port_width,
            case_wall+2*clearance,
            10
        ]);
    }
    
    // PCB cutout
    translate([
        -usb_pcb_width/2,
        0,
        construction_height-usb_pcb_height
    ]) {
        cube([
            usb_pcb_width,
            usb_pcb_length,
            100+usb_pcb_height+clearance
        ]);

        // Soldered pins cutout
        translate([
            0,
            usb_pcb_length-usb_pin_length,
            -usb_pin_depth
        ]) {
            cube([
                usb_pcb_width,
                usb_pin_length,
                usb_pin_depth+clearance
            ]);
        }
    }
}

module ldr() {
    translate([0,0,-clearance]) {
        cylinder(
            d=ldr_diameter,
            h=case_wall+construction_height+2*clearance
        );
    }
    translate([
        ldr_screw_offset,
        0,
        case_wall+construction_height-ldr_screw_length
    ]) {
        cylinder(
            d=ldr_screw_diameter,
            h=ldr_screw_length+clearance
        );
    }
    translate([
        -ldr_screw_offset,
        0,
        case_wall+construction_height-ldr_screw_length
    ]) {
        cylinder(
            d=ldr_screw_diameter,
            h=ldr_screw_length+clearance
        );
    }
}

module step_down() {
    cube([
        step_down_width,
        step_down_length,
        step_down_height+clearance
    ]);
}

module holeSupport(d, h) {
    difference() {
        cylinder(d=d+0.5,h=h);
        translate([0, 0, -clearance]) {
            cylinder(d=d, h=h+2*clearance);
        }
    }
}

module shell_top() {
    
    translate([0,0,case_wall+construction_height]) {

        // Top left
        translate([
            case_screw_pillar_offset,
            case_width-case_screw_pillar_offset,
            0
        ]) {
            pillar();
        }

        // Top right
        translate([
            case_width-case_screw_pillar_offset,
            case_width-case_screw_pillar_offset,
            0
        ]) {
            pillar();
        }

        // Bottom right
        translate([
            case_width-case_screw_pillar_offset,
            case_screw_pillar_offset,
            0
        ]) {
            pillar();
        }

        // Bottom left
        translate([
            case_screw_pillar_offset,
            case_screw_pillar_offset,
            0
        ]) {
            pillar();
        }
    }

    difference() {
        roundedRectangle(
            case_width,
            case_length,
            case_top_height,
            case_corner_radius
        );
        translate([
            case_wall,
            case_wall,
            case_wall+construction_height
        ]) {
            roundedRectangle(
                case_width-2*case_wall,
                case_length-2*case_wall,
                case_top_height-case_wall+clearance,
                case_corner_radius
            );
        }
    }
}

module pillar() {

    difference() {
        cylinder(
            d=case_screw_diameter+2*case_screw_pillar_wall_width,
            h=case_screw_pillar_height
        );
        cylinder(
            d=case_screw_diameter,
            h=case_screw_pillar_height+clearance
        );
    }
}

module shell_bottom() {

    difference() {
        roundedRectangle(
            case_width,
            case_length,
            case_bottom_height,
            case_corner_radius
        );
        translate([
            case_wall,
            case_wall,
            case_wall
        ]) {
            roundedRectangle(
                case_width-2*case_wall,
                case_length-2*case_wall,
                case_bottom_height-case_wall+clearance,
                case_corner_radius
            );
        }
    }
}

module hanger_protection() {
    translate([
        -case_hanger_hole_large_diameter/2-case_protection_wall_width,
        -case_hanger_hole_large_diameter/2-case_protection_wall_width,
        0
    ]) {
        difference() {
            cube([
                case_hanger_hole_large_diameter+2*case_protection_wall_width,
                case_hanger_hole_large_diameter/2+case_hanger_slot_length+case_hanger_hole_small_diameter/2+2*case_wall,
                case_protection_depth+case_protection_wall_width
            ]);
            translate([
                case_protection_wall_width,
                -clearance,
                -clearance
            ]) {
                cube([
                    case_hanger_hole_large_diameter,
                    case_hanger_hole_large_diameter/2+case_hanger_slot_length+case_hanger_hole_small_diameter/2+2*case_wall+2*clearance,
                    case_protection_depth+clearance
                ]);
            }
        }
    }
}

module hanger_hole() {
    cylinder(
        d=case_hanger_hole_large_diameter,
        h=case_wall+2*clearance
    );
    translate([
        -case_hanger_hole_small_diameter/2,
        0,
        0
    ]) {
        cube([
            case_hanger_hole_small_diameter,
            case_hanger_slot_length,
            case_wall+2*clearance
        ]);
    }
    translate([0,case_hanger_slot_length,0]) {
        cylinder(
            d=case_hanger_hole_small_diameter,
            h=case_wall+2*clearance
        );
    }
        //case_hanger_hole_small_diameter = 3.2;
        //case_hanger_slot_lenth = 5;
}

module roundedRectangle(width, depth, height, radius, center=false) {
    translate([radius,radius,0]) {
        minkowski() {
            cube([width-2*radius,depth-2*radius,height/2], center=center);
            cylinder(r=radius,h=height/2);
        }
    }
}

module case_scew_hole_case() {

    difference() {
        cylinder(
            d=case_screw_head_diameter+case_screw_pillar_wall_width,
            h=case_screw_head_height+case_screw_pillar_wall_width
        );
        translate([0,0,-clearance]) {
            cylinder(
                d=case_screw_head_diameter,
                h=case_screw_head_height+clearance
            );
        }
        translate([
            0,
            0,
            case_screw_head_height-clearance
        ]) {
            cylinder(
                d=case_screw_diameter,
                h=case_wall+2*clearance
            );
        }
    }

    if (support) {
        holeSupport(
            case_screw_diameter,
            case_screw_head_height
        );
    }
}

module powerrail() {
    
    translate([
        -powerrail_width/2+usb_pcb_width+powerrail_offset_left,
        case_wall+powerrail_offset_wall,
        -powerrail_height
    ]) {
        cube([
            powerrail_width,
            powerrail_length,
            powerrail_height,
        ]);

        translate([
            powerrail_width/2-powerrail_screw_distance/2,
            -powerrail_offset_screws,
            -powerrail_screw_depth+powerrail_height
        ]) {
            cylinder(
                d=powerrail_screw_diameter,
                h=powerrail_screw_depth+clearance
            );
        }

        translate([
            powerrail_width/2+powerrail_screw_distance/2,
            -powerrail_offset_screws,
            -powerrail_screw_depth+powerrail_height
        ]) {
            cylinder(
                d=powerrail_screw_diameter,
                h=powerrail_screw_depth+clearance
            );
        }
    }
}