// CD Slot Smartphone holder

Smartphone_length = 146;
Smartphone_depth = 11;
Smartphone_frame_left_right = 10;
Smartphone_frame_bottom = 4;
Smartphone_height_button = 25;
CD_slot_angle = 15;
CD_slot_height= 52;
CD_slot_depth = 25;

union() {
    difference() {
        translate([-(Smartphone_length+4)/2,-(Smartphone_depth+4)/2,0]) {
            cube([Smartphone_length+4,Smartphone_depth+4,Smartphone_height_button+2]);
        }
        translate([-Smartphone_length/2,-Smartphone_depth/2,2]) {
            cube([Smartphone_length,Smartphone_depth,Smartphone_height_button+2]);
        }
        translate([-(Smartphone_length-2*Smartphone_frame_left_right)/2,-10,Smartphone_frame_bottom+2]) {
            cube([Smartphone_length-2*Smartphone_frame_left_right,10,Smartphone_height_button]);
        }
    }

    translate([-110/2,(Smartphone_depth)/2,0]) {
        cube([110,2,CD_slot_height]);
    }

    translate([-110/2,(Smartphone_depth+2)/2,CD_slot_height]) {
        rotate([-90-CD_slot_angle,0,0]) {
            union() {
                translate([2,0,CD_slot_depth]) {
                    rotate([-90,0,0]) {
                        cylinder(1.5,2,2);
                    }
                }
                translate([110-2,0,CD_slot_depth]) {
                    rotate([-90,0,0]) {
                        cylinder(1.5,2,2);
                    }
                }
                cube([110,1.5,CD_slot_depth]);
                translate([2,0,CD_slot_depth]) {
                    cube([110-4,1.5,2]);
                }
            }
        }
    }
}