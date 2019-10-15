/* [Paperclip Specs] */


//length of clip (mm)
clip_length = 70;

//height of clip as a percentage of total length
clip_width_percentage = 25; //[1:100]

//Thickness of wire
wire_diameter = 2;

//Centre curve position as a percentage of total length (from left) 
centre_loop_percent_offset = 45; //[1:100] 

//Wire end position as a percentage of total length
end_wire_length_percent = 50; //[1:100]

//Wire start position as a percentage of total length
start_wire_length_percent = 70; //[1:100]

/* [Hidden] */
clip_width = clip_length * (clip_width_percentage / 100);

ll_out_r = clip_width / 2;
ll_out_x = clip_width / 2; 
ll_out_y = clip_width / 2; 

ll_in_r = (clip_width / 2) - wire_diameter;
ll_in_x = ll_out_x;
ll_in_y = ll_out_y;

rl_out_r = ll_out_r -  wire_diameter;
rl_out_x = clip_length - rl_out_r;
rl_out_y = clip_width - rl_out_r;

rl_in_r =  rl_out_r - wire_diameter;
rl_in_x = rl_out_x;
rl_in_y = rl_out_y;

cl_out_r = rl_out_r -  wire_diameter;
cl_out_x = ((centre_loop_percent_offset) / 100) * clip_length;
cl_out_y = rl_out_y - wire_diameter;

cl_in_r = rl_out_r - wire_diameter - wire_diameter;
cl_in_x = cl_out_x;
cl_in_y = cl_out_y;

arm_1_w = clip_length - ll_out_r - rl_out_r;
arm_1_h = wire_diameter;
arm_1_x = ll_out_r;
arm_1_y = clip_width - wire_diameter;

arm_2_w = (clip_length - cl_in_x) * (end_wire_length_percent / 100);
arm_2_h = wire_diameter;
arm_2_x = cl_in_x;
arm_2_y = cl_in_y + cl_in_r;

arm_3_w = (clip_length - cl_out_x - rl_out_r);
arm_3_h = wire_diameter;
arm_3_x = arm_2_x;
arm_3_y = arm_2_y - (cl_in_r * 2) - wire_diameter;

arm_4_w = (clip_length - ll_out_r) * (start_wire_length_percent / 100);
arm_4_h = wire_diameter;
arm_4_x = rl_out_r + wire_diameter;
arm_4_y = 0;
module left_loop() {
    difference() {
        difference() {
            translate([ll_out_x, ll_out_y, 0])
                cylinder(wire_diameter, ll_out_r, ll_out_r, false);

            translate([ll_in_x, ll_in_y, -1])
                cylinder(wire_diameter+2, ll_in_r, ll_in_r, false);
        }

        translate([ll_out_x, 0, -ll_out_r])
            cube(ll_out_r * 2);
    }
}

module right_loop() {
    difference() {
        difference() {
            translate([rl_out_x, rl_out_y, 0])
                cylinder(wire_diameter, rl_out_r, rl_out_r, false);

            translate([rl_in_x, rl_in_y, -1])
                cylinder(wire_diameter+2, rl_in_r, rl_in_r, false);
        }
        translate([clip_length - (rl_out_r * 3), clip_width-(rl_out_r*2), -rl_out_r])
            cube(rl_out_r * 2);
    }

}

module centre_loop() {
    difference() {
        difference() {
            translate([cl_out_x, cl_out_y, 0])
                cylinder(wire_diameter, cl_out_r, cl_out_r, false);

            translate([cl_in_x, cl_in_y, -1])
                cylinder(wire_diameter+2, cl_in_r, cl_in_r, false);
        }

        translate([cl_out_x, (cl_out_y-cl_out_r), -cl_out_r])
            cube(cl_out_r * 2);
    }
}

module arm_1() {
    translate([arm_1_x, arm_1_y, 0])
        cube([arm_1_w, arm_1_h, wire_diameter]);
}

module arm_2() {
    translate([arm_2_x, arm_2_y, 0])
        cube([arm_2_w, arm_2_h, wire_diameter]);
}

module arm_3() {
    translate([arm_3_x, arm_3_y, 0])
        cube([arm_3_w, arm_3_h, wire_diameter]);
}

module arm_4() {
    translate([arm_4_x, arm_4_y, 0])
        cube([arm_4_w, arm_4_h, wire_diameter]);
}


union() {
    left_loop();
    right_loop();
    centre_loop();
    arm_1();
    arm_2();
    arm_3();
    arm_4();
}

