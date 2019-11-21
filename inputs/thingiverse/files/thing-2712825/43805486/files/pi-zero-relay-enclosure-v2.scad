// Your printers nozzle diameter.
nozzle_diameter = 0.4;
layer_thickness = 0.15;

// Set 1 to render the bottom
bottom = 1;

// Set to 1 to render the lid.
lid = 1;

// Enable / disable the 'hanger' tab. 1 adds the tab. 0 removes it.
hanger = 1;
hanger_hole = 9;

// Desired thickness of the caase walls.
wall_thickness = 1.7;
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
        cylinder(standoff_height, d = 4, $fn = 36);       
    }

    translate([0, 0, standoff_height])
        cylinder(1, d = upper_diameter, $fn = 36);
    translate([0, 0, standoff_height + 1])
        cylinder(1, d1 = upper_diameter, d2 = (upper_diameter) - 0.5, $fn = 36);
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

module lid_screw_receiver(height = 13) {    
    difference() {
        translate([0, 0, 0 - height])
            cube([8, 8, height -  (2 + 2 * layer_thickness)]);
        translate([4, 4, 0 - height])
                cylinder(d = 1.85, h = height, $fn = 36);
        translate([0, 4,  0 - height - 4])
            rotate([45, 0, 0])
                cube([10, 15, 6]);
    }
}

module lid_screw_opening(lid_thickness) {
    // Model an M2 cap head screw:
    translate([2, 2, 0]) {
        cylinder(d = 4.4, h = 2, $fn = 36);
        // Eliminate support material...
        render()
        intersection() {
            cylinder(d = 4.4, h = 2 + 2 * layer_thickness, $fn = 36);
            translate([-2.2, -1.1, 0])
                cube([4.4, 2.2, 2 + layer_thickness]);
        }
        render()
        intersection() {
            cylinder(d = 4.4, h = 2 + 2 * layer_thickness, $fn = 36);
            translate([-2.2, -1.1, 0])
                cube([4.4, 2.2, 2. + 2 * layer_thickness]);
            translate([-1.1, -2.2, 0])
                cube([2.2, 4.4, 2 + 2 * layer_thickness]);
        }
        
        translate([0, 0, 2])
            cylinder(d = 2.2, h = lid_thickness + 5, $fn = 36);
    }    
}

if (bottom == 1) {
   union() {
        difference() {
            union() {
                cube([length, width, lower_part_height]);
                // Add a 'hanging tab'
                if (hanger > 0) {
                    hull() {
                        translate([(length / 2) - 20, width, 0])
                            cylinder(r = 20, 1, $fn = 90);
                        translate([(length / 2) + 20, width, 0])
                            cylinder(r = 20, 1, $fn = 90);
                    }
                }
            }
            
            translate([wall_thickness, wall_thickness, 1])
                cube([length - (wall_thickness * 2), width - (wall_thickness * 2), lower_part_height - 1]);
            
            // Recess for top cover
            translate([wall_thickness / 2, wall_thickness / 2, lower_part_height - lid_thickness])
                cube([length - wall_thickness, width - wall_thickness, lid_thickness + 1]);
            
            // Raspberry pi power opening
            translate([wall_thickness + sd_card_clearance + 50, 0, 1])
                pi_usb_opening(pi_standoff);
            
            // Subtraction to expose relay contacts
            translate([length - wall_thickness - 14, 0, 1 + relay_standoff + 2]) // thickness of the board
                cube([14 + wall_thickness, width, lower_part_height - (1 + relay_standoff + 2)]);
            
            // If there's a hole in the hanger...
            if (hanger_hole > 0) {
                translate([(length / 2), width + 10, 0])
                    cylinder(d = hanger_hole, 1);
            }
        };
        translate([wall_thickness + sd_card_clearance, wall_thickness + 1, 1])
            pi_supports(pi_standoff);
        translate([wall_thickness + 28, wall_thickness + 1, 1])
            relay_supports(relay_standoff);
        
        // Top cover screw receivers
        translate([wall_thickness, wall_thickness, lower_part_height - lid_thickness])
            lid_screw_receiver();
        translate([length - wall_thickness - 35 - 8, wall_thickness, lower_part_height - lid_thickness])
            lid_screw_receiver();
        translate([wall_thickness, width - wall_thickness, lower_part_height - lid_thickness])
            rotate([0, 0, 180])
                translate([-8, 0, 0])
                    lid_screw_receiver();
        translate([length - wall_thickness - 35 - 4, width - wall_thickness, lower_part_height - lid_thickness])
            rotate([0, 0, 180])
                translate([-4, 0, 0])
                    lid_screw_receiver();
    }
}

lidlocation = (bottom != 0) ? 100 : 0;

// The lid
if (lid == 1) {
//    translate([0, 0, lower_part_height])
//    mirror([0, 0, 1]) 

    translate([lidlocation, 0, 0])
    difference() {
        union() {
            translate([(wall_thickness / 2) + nozzle_diameter / 2, (wall_thickness / 2) + nozzle_diameter / 2, 0])
                cube([length - (wall_thickness * 1.5) - 14, width - wall_thickness - nozzle_diameter, lid_thickness]);
            // Lid reinforcements
            reinforcez = 2 + 2 * layer_thickness + lid_thickness;
            // reinforcing on the upper lid.
            translate([wall_thickness + nozzle_diameter, wall_thickness + nozzle_diameter, 0]) {
                difference() {
                    cube([length - wall_thickness * 2 - 14 - nozzle_diameter / 2, width - wall_thickness * 2 - nozzle_diameter * 2, reinforcez]);
                    translate([wall_thickness, wall_thickness, 0]) 
                        cube([length - wall_thickness * 4 - 14, width - wall_thickness * 4 - nozzle_diameter * 2, reinforcez]);
                }
            }
            // Clamp  to hold the relay board in place.
            // z = lower_part_height - (bottom + relay_standoff + 1.55 (measured thickness of relay board) + lid_thickness)
            translate([length - wall_thickness - 34 + nozzle_diameter / 2, wall_thickness + nozzle_diameter, lid_thickness])
                cube([34 - 14, width - (wall_thickness * 2) - (nozzle_diameter * 2),  
                    lower_part_height - (1 + relay_standoff + 1.55 + lid_thickness)]);
            
            // Lid screw reinforcements
            reinforcez = 2 + 2 * layer_thickness + lid_thickness;
            translate([wall_thickness + nozzle_diameter, wall_thickness + nozzle_diameter, 0])
                cube([8 - nozzle_diameter, 8 - nozzle_diameter, reinforcez]);
            translate([length - wall_thickness - 35 - 8, wall_thickness + nozzle_diameter, 0])
                cube([8, 8 - nozzle_diameter, reinforcez]);
            translate([wall_thickness + nozzle_diameter, width - wall_thickness - nozzle_diameter, 0])
                rotate([0, 0, 180])
                    translate([-8, 0, 0])
                        cube([8 - nozzle_diameter, 8 - nozzle_diameter, reinforcez]);
            translate([length - wall_thickness - 35 - 4, width - wall_thickness - nozzle_diameter, 0])
                rotate([0, 0, 180])
                    translate([-4, 0, 0])
                        cube([8, 8 - nozzle_diameter, reinforcez]);
        }
        
        translate([length - wall_thickness - 34, wall_thickness + nozzle_diameter + 2.5, lid_thickness])
            cube([34 - 14 - nozzle_diameter, width - ((wall_thickness + nozzle_diameter + 2.5) * 2), 
                lower_part_height - (1 + relay_standoff + 1.55 + lid_thickness)]);
        
        // Top cover screw receivers
        translate([wall_thickness + 2, wall_thickness + 2, 0])
            lid_screw_opening(lid_thickness);
        translate([length - wall_thickness - 35 - 6, wall_thickness + 2, 0])
            lid_screw_opening(lid_thickness);
        translate([wall_thickness, width - wall_thickness, 0])
            rotate([0, 0, 180])
                translate([-6, 2, 0])
            lid_screw_opening(lid_thickness);
        translate([length - wall_thickness - 35 - 4, width - wall_thickness, 0])
            rotate([0, 0, 180])
                translate([-2, 2, 0])
            lid_screw_opening(lid_thickness);
    }
}
