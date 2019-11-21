cutting_board_thicnkess = 15;

bottom_length = 160;
bottom_height = 5;

edge_width = 5;
slot_width = 5;

knife_1_length = 180;
knife_1_width = 80;

knife_2_length = 185;
knife_2_width = 35;

knife_3_length = 190;
knife_3_width = 35;

module cutting_board_knife_rack(knifes, bottom_length, bottom_height, edge_width, slot_width, offset_angle = 15) {

    offset_y = slot_width + edge_width;
    len_of_knifes = len(knifes);

    bottom_width = offset_y * len_of_knifes + cutting_board_thicnkess + edge_width * 2 + slot_width;

    for(i = [0:len_of_knifes - 1]) {

        a = offset_angle * i;
        offset_z = (knifes[i][1] + 2 * edge_width) * sin(a);
        w = (knifes[i][1] + 2 * edge_width) / cos(a) * 2;

        translate([0, -offset_y * i, 0]) difference() {
            // a knife holder
            translate([-w / 6 , 0, -0.5 * offset_z]) rotate([0, a, 0]) difference() {
                linear_extrude(knifes[i][0]) difference() {
                    square([
                        knifes[i][1] + 2 * edge_width, 
                        slot_width + 2 * edge_width
                    ], center = true);
                        
                    square([knifes[i][1], slot_width], center = true);
                }
                
                // vents
                for(j = [0:7]) {
                    translate([0, 0, knifes[i][0] / 8 * j]) 
                        rotate([0, 90, 0]) 
                            linear_extrude(knifes[i][0], center = true) 
                                circle(slot_width / 2);
                }
            }
            
            // cut off the bottom of the holder
            translate([0, 0, -offset_z]) 
                linear_extrude(offset_z) 
                   square([w, slot_width + 2 * edge_width], center = true);
        }

    }

    // rack bottom
    translate([0, -bottom_width / 2 + edge_width + slot_width, 0]) 
        linear_extrude(bottom_height) minkowski() {
        
        square([bottom_length, bottom_width], center = true);
        circle(bottom_width / 20);
    }

    // cutting board holder
    translate([0, -offset_y * len_of_knifes - cutting_board_thicnkess, 0]) 
        rotate([-90, 0, 0]) linear_extrude(edge_width, center = true) difference() {
        
        circle(bottom_length / 6, $fn = 48);
        
        translate([-bottom_length / 4, 0, 0]) 
            square([bottom_length / 2, bottom_length / 2]);
    }

}

cutting_board_knife_rack(
    [
        [knife_1_length, knife_1_width], 
        [knife_2_length, knife_2_width], 
        [knife_3_length, knife_3_width]
    ], 
    bottom_length, 
    bottom_height, 
    edge_width, 
    slot_width,
    15 // offset_angle
);