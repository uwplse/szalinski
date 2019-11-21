// prints a left or right hand leg for
// mounting a popsocket holder on the dash of a
// toyota prius prime (2017)
// WARNING: print in ABS, since PLA will deform in the sun

// left-hand
gulch_offset = -1; // use 1 for right-hand, -1 for left-hand
flip = 180; // use flip 0 for right-hand, 180 for left-hand

// right-hand
//gulch_offset = 1; // use 1 for right-hand, -1 for left-hand
//flip = 0; // use flip 0 for right-hand, 180 for left-hand


depth = 4;
leg_width = 3;
clip_depth = 3;
bottom_hook_length = 6;
bottom_hook_angle = 20;
bottom_angle = 150;
bottom_length = 34;
mount_angle = bottom_angle-90;
top_length = 124;
top_base_thickness = 6;
top_tip_thickness = 1;
mount_length = 50;
mount_bulge = 10;
mount_gulch_length = 33;
mount_gulch_depth = 3;
mount_gulch_width = 3;
mount_gulch_from_front = 3;

rotate([0,flip,0]){
    difference(){
        linear_extrude(depth){
            // bottom hook
            translate([-bottom_hook_length,2]){
                rotate([0,0,-bottom_hook_angle]){
                    square([bottom_hook_length+.4, leg_width]);
                    translate([0,leg_width]){
                        polygon([[0,0],[1.5,0],[1.5,clip_depth]]);
                    }
                }
            }

            // bottom clip
            square([bottom_length, leg_width]);

            // top clip
            translate([bottom_length,0]){
                rotate([0,0,bottom_angle]){
                    polygon([[0,0],[top_length-1,0],[top_length-1,-top_tip_thickness],[0,-top_base_thickness]]);
                }
            }

            // mount leg
            translate([bottom_length,0]){
                rotate([0,0,mount_angle]){
                    square([mount_length, leg_width]);
                    translate([0,0]){
                        square([mount_length, mount_bulge]);
                    }
                }
            }
        }
        // mount gulch
        translate([bottom_length,0]){
            rotate([0,0,mount_angle]){

                translate([mount_length-mount_gulch_length-5,mount_gulch_from_front,gulch_offset]){
                    #cube([mount_gulch_length, mount_gulch_width, depth]);
                }
            }
        }
    }
}