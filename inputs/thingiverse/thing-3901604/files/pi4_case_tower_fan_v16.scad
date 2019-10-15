// Raspberry Pi 4 case with accomodation for S2Pi Tower Cooling Fan
// Don Barthel
// 2019-10-04

/* [Parameters] */

// My bolt head diameter was 5.0mm
specify_bolt_head_diameter = 4.5;

// My bolt head height was 1.6mm
specify_bolt_head_height = 1.6;

// My bolt length was 21mm - quite long; best is 12mm, minimum is 10mm
specify_bolt_length = 12;           // [10:100]

// False gives no accomodation for a CPU fan; true gives a cutout for an S2Pi tower fan
cutout_for_tower_fan = "Yes"; // [Yes, No]

// I routed my tower fan power lines outside the case so I needed this
cutout_for_GPIO = "Yes"; // [Yes, No]

print_bottom_case = "Yes"; // [Yes, No]

// It is valid to use the bottom case without the top case
print_top_case = "Yes"; // [Yes, No]

/* [Hidden] */

// Misc constants
$fn = 32;                           // Default resolution of curved surfaces
fudge = 0.01;                       // Factor to inflate a dimension to prevent artifacts    
large = 1000.0;                     // Infinity
thick = 3.0;                        // Thickness of most walls; must be same as board_corner_radius for this design to work (and board_corner_radius is determined by the motherboard)
clearance = 0.5;                    // Extra thickness so that the fit isn't snug

// We're using 2.5mm bolts into the underside of the brass standoffs for the S2Pi tower heatsink
bolt_diameter = 2.5;
bolt_head_diameter = specify_bolt_head_diameter;
bolt_head_depth = specify_bolt_head_height;
bolt_length = specify_bolt_length;  // Length not including the bolt_head_depth

// Size and shape of the motherboard
board_x = 85.0;                     // Board width in X direction
board_y = 56.0;                     // ... and Y direction
board_corner_radius = 3.0;          // Radius of corners

// Printed standoffs are cylinders on the mounting holes and the underside of the motherboard to hold it up

standoff_diameter = 7.0;            
standoff_height = (bolt_length - bolt_head_depth) - (thick-bolt_head_depth) - 4.0; // Standoff height to accomodate bolt
                                    // thick-bolt_head_depth is bolt length in bottom panel
                                    // 4mm for amount of bolt bight in brass standoff
// Mounting hole built into the motherboard
hole1_x = 3.5;                      // Offset of hole 1 in X direction
hole1_y = 3.5;                      // ... and Y direction
hole_x_dist = 58.0;                 // Distance between mounting holes in X direction
hole_y_dist = 49.0;                 // ... and Y direction

// Tower fan protrudes through top of case
fan_x_width = 44;
fan_y_width = 37;
fan_x_offset = -((board_x-fan_x_width)/2 - 8.0);
fan_y_offset = -((board_y-fan_y_width)/2 - 6.0);

// Ports on right side of case
usb_width = 14;
usb_1_offset = 9;
usb_2_offset = 27;
usb_height_diff = 0;                // USB ports are flush with the inside top of the case
ethernet_width = 16.75;
ethernet_offset = 45.75;
ethernet_height_diff = 2.5;         // Ethernet is 2.2mm less height than USB ports, which sit flush up against the inside of the slab of the top case

// SD card on left side of case
sd_width = 11;

// Ports on front of case
usbc_width = 9.0;
usbc_offset = 11.2;
usbc_height_diff = 12.8;
mhdmi_width = 7.25;
mhdmi_1_offset = usbc_offset + 14.8;
mhdmi_2_offset = mhdmi_1_offset + 13.5;
mhdmi_height_diff = 13.0;
audio_width = 6.0;
audio_offset = mhdmi_2_offset + 14.5;
audio_height_diff = 10.0;

// GPIO at the rear of the case
gpio_width = 52.5;
gpio_height = 10.0;
gpio_offset = 7.0;
gpio_depth = 6.5+thick;

// Height of top case
case_height = 21.5 + standoff_height + thick; // 21.5mm from the top of the USB ports to below all protrusions on the bottom of the motherboard.


// Bottom without the standoff patios (outsets around the standoffs)
module bottom_slab(width_x, width_y, height) {
    hull() {
        for (x=[-1, 1]) {
            for (y=[-1, 1]) {
                translate([x*(width_x/2-board_corner_radius), y*(width_y/2-board_corner_radius), 0])
                    cylinder(h=height, r=board_corner_radius, center=true);
            }
        }
    }
}


// Bottom with the standoff patios
module bottom_panel(height, cutout) {
    bottom_slab(board_x, board_y, height);

    patio_size = cutout ? thick+clearance : thick;

    // Patios for standoffs
    for (x1=[0, 1]) {
        for (y1=[0, 1]) {
            hull() {
                for (x2=[-1, 1]) {
                    for (y2=[-1, 1]) {
                        translate([-board_x/2 + hole1_x + x1*hole_x_dist + x2*(hole1_x+patio_size/2), -board_y/2 + hole1_y + y1*hole_y_dist + y2*(hole1_y+patio_size/2), 0]) {
                            if (((x1==0)&&(y1==0)&&(x2==-1)&&(y2==-1)) ||
                                ((x1==0)&&(y1==1)&&(x2==-1)&&(y2==1)))
                                translate([patio_size/2, -y2*patio_size/2, 0])
                                cylinder(h=height, r=patio_size, center=true);
                            else
                                cube([patio_size, patio_size, height], center=true);
                        }
                    }
                }
            }
        }
    }
}


// The whole bottom including the slab and patios
module bottom_case() {
    difference() {
        union() {
            bottom_panel(thick, false);

            // Standoffs on bottom to hold motherboard
            for (x=[0, 1]) {
                for (y=[0, 1]) {
                    translate([-board_x/2 + hole1_x + x*hole_x_dist, -board_y/2 + hole1_y + y*hole_y_dist, standoff_height/2+thick/2]) {
                        cylinder(h=standoff_height, d=standoff_diameter, center=true);
                    }
                }
            }
            
        }

        // Bolt holes for standoffs
        for (x=[0, 1]) {
            for (y=[0, 1]) {
                translate([-board_x/2 + hole1_x + x*hole_x_dist, -board_y/2 + hole1_y + y*hole_y_dist, standoff_height/2+thick/2]) {
                    union() {
                        cylinder(h=large, d=bolt_diameter+clearance, center=true);
                        translate([0, 0, -(standoff_height/2+thick) + (bolt_head_depth+clearance)/2 - fudge])
                        cylinder(h=bolt_head_depth+clearance, d=bolt_head_diameter+2*clearance, center=true);
                    }
                }
            }
        }
    }
}


// The whole top of the case
module top_case() {
    difference() {
        translate([0, 0, case_height/2 - thick/2])
            difference() {
                // Top case is wider than bottom case so it slides overtop
                bottom_slab(board_x+2*thick - fudge, board_y+2*thick - fudge, case_height);

                // Cutout interior cavity using a deep (thick) bottom slab as the cutout shape
                translate([0, 0, -(thick/2 + fudge)]) bottom_slab(board_x+clearance*2, board_y+clearance*2, case_height-thick);
            }

        // Cutout bottom panel to accommodate patios around standoffs
        bottom_panel(thick+clearance, true);

        if (cutout_for_tower_fan == "Yes") {
            // Cutout for S2Pi cooling tower
            translate([fan_x_offset, fan_y_offset, 0])
                cube([fan_x_width, fan_y_width, large], center=true);
        }
            
        // Cutouts for ports

        // Cutout for USB port 1
        translate([(board_x+thick)/2, -(board_y-usb_width)/2 + (usb_1_offset-usb_width/2), case_height/2-thick-usb_height_diff])
            cube([thick+fudge, usb_width, case_height-thick+fudge], center=true);

        // Cutout for USB port 2
        translate([(board_x+thick)/2, -(board_y-usb_width)/2 + (usb_2_offset-usb_width/2), case_height/2-thick-usb_height_diff])
            cube([thick+fudge, usb_width, case_height-thick+fudge], center=true);

        // Cutout for ethernet port
        translate([(board_x+thick)/2, -(board_y-ethernet_width)/2 + (ethernet_offset-ethernet_width/2), case_height/2-thick-ethernet_height_diff])
            cube([thick+fudge, ethernet_width, case_height-thick+fudge], center=true);
         
        // Cutout for Micro SD card
        translate([-(board_x+thick)/2, 0, standoff_height/2+clearance/2])
        cube([thick+fudge, sd_width+2*clearance, standoff_height+thick+clearance+fudge], center=true);
        
        // Cutout for USB-C power port
        translate([-(board_x-usbc_width)/2 + (usbc_offset-usbc_width/2), -(board_y+thick)/2, case_height/2-thick-usbc_height_diff])
            cube([usbc_width, thick+fudge, case_height-thick+fudge], center=true);

        // Cutout for micro HDMI port 1
        translate([-(board_x-mhdmi_width)/2 + (mhdmi_1_offset-mhdmi_width/2), -(board_y+thick)/2, case_height/2-thick-mhdmi_height_diff])
            cube([mhdmi_width, thick+fudge, case_height-thick+fudge], center=true);

        // Cutout for micro HDMI port 2
        translate([-(board_x-mhdmi_width)/2 + (mhdmi_2_offset-mhdmi_width/2), -(board_y+thick)/2, case_height/2-thick-mhdmi_height_diff])
            cube([mhdmi_width, thick+fudge, case_height-thick+fudge], center=true);

        // Cutout for audio port
        translate([-(board_x-audio_width)/2 + (audio_offset-audio_width/2), -(board_y+thick)/2, case_height/2-thick-audio_height_diff])
            cube([audio_width, thick+fudge, case_height-thick+fudge], center=true);

        if (cutout_for_GPIO == "Yes") {
            // Cutout for GPIO (open to the top as well as the back)
            translate([-(board_x-gpio_width)/2 + gpio_offset, (board_y-gpio_depth)/2 + thick, case_height-thick/2-gpio_height/2]) 
                cube([gpio_width, gpio_depth+fudge, gpio_height+fudge], center=true);
        }
    }
}


// These are the two pieces of the case, disable the one you don't want to render
if (print_bottom_case == "Yes") {
    bottom_case();
}

if (print_top_case == "Yes") {
    top_case();
}
