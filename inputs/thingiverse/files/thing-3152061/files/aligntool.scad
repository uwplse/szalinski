//**********************************************
// Alignment tool for MPCNC build
//
// Written by Ippokratis Anastasiadis 2018
// using OpenSCAD 2015.03-2
// 
//**********************************************

//                             PARAMS
//----------------------------------------------
$fn = 50;

foot_thickness_min = 2;
foot_thickness_max = 8;
foot_OD = 70;
foot_ID = 15;
foot_curve = 8;
foot_num = 4;
screw_OD = 8.2;
base_height = 70;

knob_OD = 26;
knob_curve = 3;
knob_height = 15;
knob_screw_height = 12;
knob_base_height = 30;
knob_num = 16;

pipe_OD = 26;
top_thickness = 3;
top_width = 60;

M8_OD = 14.38; 
M8_FD = 13;
M8_height = 9;

string_hole_OD = 2;
string_holes = 4;

top_foot_OD_min = foot_ID;
top_foot_OD_max = 20;
top_foot_height = 30;
top_foot_screw_height = 15;

top_foot_lower_height = top_foot_height-top_foot_screw_height;

all();

module all() {
    base();
    translate([0,0,base_height+knob_base_height+10])
    knob();
    translate([0,0,base_height+knob_height+knob_base_height+20])
    top_foot();
    translate([0,0,base_height+knob_height+knob_base_height+top_foot_height+30])
    top_head();
}

module knob() {
    difference () {
        union() {
            for(n = [1 : knob_num])
            {
                rotate([0, 0, n * 360/knob_num])
                {
                    hull() {
                        translate([knob_OD/2-knob_curve/2,0,0])
                        cylinder (d=knob_curve, h=knob_height);
                        cylinder (d=foot_ID, h=knob_height);
                    }
                }
            }  
        }  
        union() {
            translate([0,0,-.05])
            cylinder (d=screw_OD, h=knob_height+.1);
            translate([0,0,-.1])
            cylinder (d=M8_OD, h=M8_height+.1, $fn=6);
        }
    } 
    translate([0,0,-knob_base_height])
    difference () {
        cylinder (d=top_foot_OD_max, h=knob_base_height);
        translate([0,0,-.05])
        cylinder (d=foot_ID+.3, h=knob_base_height+.1);
    }        
    
}


module top_head() {   
    difference () {
        cylinder (d=top_foot_OD_max+2*top_thickness, h=top_foot_screw_height/2);
        translate([0,0,-.05])
        cylinder (d=top_foot_OD_max+.25, h=top_foot_screw_height/2+.1);
    }        
    
    translate([-top_width/2,0,top_foot_screw_height/2+pipe_OD/2+top_thickness])
    rotate([0,90,0]) 
    difference () {
        union() {
            translate([-pipe_OD/2,pipe_OD/2,0])
            cube([pipe_OD/2,top_thickness,top_width+.1]);
            translate([pipe_OD/2,-pipe_OD/2,0])
            cube([top_thickness,pipe_OD/2,top_width+.1]);
            intersection () {
                difference () {
                    union() {
                        translate([0,0,top_width/2])
                        rotate([0,90,0])
                        cylinder (d=top_foot_OD_max+2*top_thickness, h=pipe_OD/2+top_thickness);
                        cylinder (d=pipe_OD+2*top_thickness, h=top_width);
                    }
                    union() {
                        translate([0,0,-.05])
                        cylinder (d=pipe_OD, h=top_width+.1);
                    }
                } 
                cube([(pipe_OD+2*top_thickness),(pipe_OD+2*top_thickness),top_width+.1]);
            }
        }
        union() {
            /*
            translate([pipe_OD/2-M8_height-2+top_thickness,0,top_width/2])  
            rotate([0,90,0])        
            cylinder (d=M8_OD, h=M8_height+2.1, $fn=6);
            */
            union(){
                for(n = [1 : string_holes]) {                   
                    translate([0,pipe_OD/2+5*top_thickness/4,(n-1)*(top_width/(string_holes-1))])
                    rotate([90,0,0])
                    cylinder (d=string_hole_OD, h=2*top_thickness);
                }
            }
        }
    }
}

module top_foot() {
    // lower part
    difference () {
        cylinder (d=top_foot_OD_min, h=top_foot_lower_height);
        union() {
            translate([0,0,-.05])
            cylinder (d=screw_OD, h=top_foot_lower_height+.1);
        }
    }        
    translate([0,0,top_foot_lower_height])
    difference () {
        union() {
            cylinder (d2=top_foot_OD_max, d1=top_foot_OD_min, h=top_foot_screw_height/2);
            translate([0,0,top_foot_screw_height/2])
            cylinder (d=top_foot_OD_max, h=top_foot_screw_height/2);
        }
        union() {
            translate([0,0,-.05])
            cylinder (d=screw_OD, h=top_foot_screw_height+.1);
            translate([0,0,top_foot_screw_height-M8_height])
            cylinder (d=M8_OD, h=M8_height+.1, $fn=6);
        }
    }        
}

module base () {
    foot ();
    difference () {
        cylinder (d=foot_ID, h=base_height);
        translate([0,0,foot_thickness_min])
        cylinder (d=screw_OD, h=base_height+.1);
    }
}

module foot () {
    union() {
        for(n = [1 : foot_num])
        {
            rotate([0, 0, n * 360/foot_num])
            {
                hull() {
                    translate([foot_OD/2-foot_curve/2,0,0])
                    cylinder (d=foot_curve, h=foot_thickness_min);
                    cylinder (d=foot_ID, h=foot_thickness_max);
                }
            }
        }  
    }  
}

/*
base_thickness = 5;
base_width = 38;
base_depth = 32;
base_curve = 5;
base_offset = 2;

handle_diameter = 16;
handle_z = 30;

cup_width = 15;
cup_depth = 15;
cup_thickness = 4;
cup_diameter = handle_diameter + 2*cup_thickness;

screw_hole = 4;
screw_head = 7;
screw_head_height = 2;
screw_length = 20;
screw_mount_diameter = 11;
screw_mount_height = base_thickness;

screw_dx = base_width/2-base_curve;
screw_dy = base_depth/2-base_curve;

screw_positions = [
    [screw_dx+base_offset-2,0],
    [-screw_dx+base_offset,screw_dy],
    [-screw_dx+base_offset,-screw_dy]
];

// handle ();
handle ();

module handle () {
    difference () {
        union () {
            upright_body();
            base();
        }
        screws();
    }
}

module upright_body() { 
    translate([(cup_depth+cup_thickness)/2, 0, 0])
    rotate ([0,-90,0])
    difference () {
        union () {
            translate([handle_z, 0, 0])
            cylinder (d=cup_diameter, h=cup_depth+cup_thickness);
            translate([0, 0, (cup_depth+cup_thickness)/2-base_thickness/2])
            linear_extrude(height = base_thickness) 
            polygon(points = [ 
                [0,base_depth/2], 
                [base_thickness,base_depth/2], 
                [handle_z,cup_diameter/2],
                [handle_z,-cup_diameter/2],
                [base_thickness,-base_depth/2], 
                [0,-base_depth/2]
            ]);
            translate([0, -base_thickness/2, 0])
            cube ([handle_z,base_thickness,cup_depth+cup_thickness]);
        }
        union () {
            translate([handle_z, 0, cup_thickness])
            cylinder (d=handle_diameter, h=cup_depth+.1);
        }
    }
}

module base() { 
    translate([-base_width/2+base_offset, -base_depth/2, 0])
    linear_extrude(height = base_thickness) 
    offset(r=base_curve) offset(delta=-base_curve)
    polygon(points = [ 
        [0,base_depth], 
        [base_width/2+base_thickness-base_offset,base_depth], 
        [base_width,base_depth/2],
        [base_width/2+base_thickness-base_offset,0],
        [0,0]
    ]);
}

module screws() {
    for (pos=screw_positions) {
        translate([pos[0],pos[1],-screw_length + screw_mount_height])
        screw();
    }
}

module screw () {
    color ([.7,.7,.7]) union () {
    cylinder (d=screw_hole, h=screw_length-screw_head_height, $fn=36);
    translate([0,0,screw_length-screw_head_height])
    cylinder (d1=screw_hole, d2=screw_head, h=screw_head_height, $fn=36);
    }
}
*/
