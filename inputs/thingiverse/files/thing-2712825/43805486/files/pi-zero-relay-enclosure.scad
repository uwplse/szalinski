// Your printers nozzle diameter.
nozzle_diameter = 0.4;

// Set 1 to render the bottom
bottom = 1;
// Set to 1 to render the lid.
lid = 1;

// Enable / disable the 'hanger' tab. 1 adds the tab. 0 removes it.
hanger = 1;

// Desired thickness of the caase walls.
wall_thickness = 1.5;
lid_thickness = 1;

// Space left for SD card protrusion
sd_card_clearance = 5;
pi_standoff = 2;
relay_standoff = 10;

// combined outer bounding box of a pi zero w and the relay board.
board_length = 75;
board_width = 39;

// Calculate the interior dimensions , based upon necessary paddings and 'stacking' the boards.
length = board_length + sd_card_clearance + (wall_thickness *2);
width = board_width + 2 + (wall_thickness *2);

lower_part_height = 32;

module support_peg(standoff_height = 1, upper_diameter = 2.3) {
    if (standoff_height > 0) {
        scale([1/10, 1/10, 1/10]) 
            cylinder(standoff_height * 10, d = 40);       
    }

    translate([0, 0, standoff_height])
        scale([1/10, 1/10, 1/10]) 
            cylinder(10, d = upper_diameter * 10);
    translate([0, 0, standoff_height + 1])
        scale([1/10, 1/10, 1/10])
            cylinder(10, d1 = upper_diameter * 10, d2 = (upper_diameter * 10) - 5);
    
    // TODO: Add a threaded receiver to the pin.
}
 
module pi_supports(standoff_height = 0) {
    translate([3.5, 3.5, 0])
        support_peg(standoff_height);
    translate([3.5, 3.5 + 23, 0])
        support_peg(standoff_height);
    translate([3.5 + 58 , 3.5, 0])
        support_peg(standoff_height);
    translate([3.5 + 58, 3.5 + 23, 0])
        support_peg(standoff_height);
}

module relay_supports(standoff_height = 10) {
// This peg will be in the way.
//    translate([2.75, 2.75, 0])
//        support_peg(standoff_height);
    translate([47.75, 2.75, 0])
        support_peg(standoff_height, 2.9);
    translate([2.75, 36.75, 0])
        support_peg(standoff_height, 2.9);
    translate([47.75, 36.75, 0])
        support_peg(standoff_height, 2.9);
}

module pi_usb_opening(standoff_height = 0) {
    union() {
        translate([0, 0, standoff_height + 2]) // board thickness is 2mm
            cube([8, wall_thickness, 3]); // slightly over sized.
        translate([-3, 0, standoff_height - 1]) 
            cube([14, wall_thickness - 1, 9]);
    }
}

module lid_screw_receiver(height = 12) {    
    difference() {
        translate([0, 0, 0 - height])
            cube([4, 4, 12]);
        translate([2, 2, 0 - height])
            scale([1 / 10, 1 / 10, 1 / 10])
                cylinder(r = 10, height * 10);
        translate([0, 4,  0 - height - 4])
            rotate([45, 0, 0])
                cube([6, 6, 6]);
    }
}

module lid_screw_opening(lid_thickness) {
        translate([2, 2, 0])
            scale([1 / 10, 1 / 10, 1 / 10])
                cylinder(r = 10, lid_thickness * 10);
}

if (bottom == 1) {
    color("lightgreen")
    union() {
        difference() {
            cube([length, width, lower_part_height]);
            translate([wall_thickness, wall_thickness, 1])
                cube([length - (wall_thickness * 2), width - (wall_thickness * 2), lower_part_height - 1]);
            
            // Recess for top cover
            translate([wall_thickness / 2, wall_thickness / 2, lower_part_height - lid_thickness])
                cube([length - wall_thickness, width - wall_thickness, lid_thickness]);
            
            // Raspberry pi power opening
            translate([wall_thickness + sd_card_clearance + 50, 0, 1])
                pi_usb_opening(pi_standoff);
            
            // Subtraction to expose relay contacts
            translate([length - wall_thickness - 12, 0, 1 + relay_standoff + 2]) // thickness of the board
                cube([12 + wall_thickness, width, lower_part_height - (1 + relay_standoff + 2)]);
            
            
        };
        translate([wall_thickness + sd_card_clearance, wall_thickness + 1, 1])
            pi_supports(pi_standoff);
        translate([wall_thickness + 28, wall_thickness + 1, 1])
            relay_supports(relay_standoff);
        
        // Top cover screw receivers
        translate([wall_thickness, wall_thickness, lower_part_height - lid_thickness])
            lid_screw_receiver(12);
        translate([length - wall_thickness - 35 - 4, wall_thickness, lower_part_height - lid_thickness])
            lid_screw_receiver(12);
        translate([wall_thickness, width - wall_thickness, lower_part_height - lid_thickness])
            rotate([0, 0, 180])
                translate([-4, 0, 0])
                    lid_screw_receiver(12);
        translate([length - wall_thickness - 35 - 4, width - wall_thickness, lower_part_height - lid_thickness])
            rotate([0, 0, 180])
                translate([-4, 0, 0])
                    lid_screw_receiver(12);
            
        // Add a 'hanging tab'
        if (hanger > 0) {
            hull() {
                translate([(length / 2) - 20, width, 0])
                    cylinder(r = 20, 1);
                translate([(length / 2) + 20, width, 0])
                    cylinder(r = 20, 1);
            }
        }
    }
}

lidlocation = (bottom != 0) ? 100 : 0;

// The lid
if (lid == 1) {
    color("lightblue")
    translate([lidlocation, 0, 0])
    difference() {
        union() {
            translate([wall_thickness / 2, wall_thickness / 2, 0])
                cube([length - (wall_thickness * 1.5) - 12, width - wall_thickness, lid_thickness]);
            
            // Clamp  to hold the relay board in place.
            translate([length - wall_thickness - 35, wall_thickness + nozzle_diameter, lid_thickness])
                cube([35 - 12, width - (wall_thickness * 2) - (nozzle_diameter * 2),  lower_part_height - (1 + relay_standoff + 2 + lid_thickness)]);
        }
        translate([length - wall_thickness - 35, wall_thickness + nozzle_diameter + 2.5, lid_thickness])
            cube([35 - 12, width - ((wall_thickness + nozzle_diameter + 2.5) * 2), lower_part_height - (1 + relay_standoff + 2 + lid_thickness)]);
        
            // Top cover screw receivers
        translate([wall_thickness, wall_thickness, 0])
            lid_screw_opening(lid_thickness);
        translate([length - wall_thickness - 35 - 4, wall_thickness, 0])
            lid_screw_opening(lid_thickness);
        translate([wall_thickness, width - wall_thickness, 0])
            rotate([0, 0, 180])
                translate([-4, 0, 0])
            lid_screw_opening(lid_thickness);
        translate([length - wall_thickness - 35 - 4, width - wall_thickness, 0])
            rotate([0, 0, 180])
                translate([-4, 0, 0])
            lid_screw_opening(lid_thickness);
    }
}
