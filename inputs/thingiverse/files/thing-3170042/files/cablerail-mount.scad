//**********************************************
// Cable rail mount for MPCNC build
//
// Written by Ippokratis Anastasiadis 2018
// using OpenSCAD 2015.03-2
// 
// Description : the mount is attached to the top edge of the stepper motors
// of the upper axis of the MPCNC build and serves the purpose of supporting
// the cables coming from the Z axis, such as stepper cable or spindle cable. 
// As is it supports an aluminum rail of ca 20 mm width, but can easily be adjusted to your needs. The rail is attached via M3 screws and corresponding nuts. 
//**********************************************

$fn = 50;

nema17_width = 42.3;
nema17_screw_spacing = 31;
nema17_screw_offset = (nema17_width-nema17_screw_spacing)/2;

rail_width = 19.4;
rail_thickness = 1.5;

rail_inner_width = rail_width - rail_thickness;

beam_thickness = 5;
beam_length = nema17_width + .5 + rail_width;
beam_overhang = 6;

face_thickness = 4;
face_height = 10+beam_thickness;

rail_mount_length = 40;
rib_thickness = 3;

M3_hole = 3.5;
M3_nut_hole = 6;
M3_nut_inset = 2.2;

cablerail_mount ();

module cablerail_mount () {
    face ();
    top ();
    translate([beam_length-rail_inner_width, 0, 0]) rib ();
    translate([beam_length-rib_thickness, 0, 0]) rib ();
}


module face () {
    difference() {
        cube ([beam_length, face_thickness, face_height]);
        // screwholes
        translate([nema17_screw_offset, 0, face_height-beam_thickness-nema17_screw_offset-.5])
        rotate([270,0,0])
        union() {
            cylinder (d=M3_hole, h=face_thickness+.1);                       
            translate([nema17_screw_spacing, 0, 0])
            cylinder (d=M3_hole, h=face_thickness+.1);            
        }
    }
}

module top () {
    translate([0, 0, face_height-beam_thickness])
    difference() {
        union() {
            cube ([beam_length, face_thickness+beam_overhang, beam_thickness]);
            translate([beam_length-rail_inner_width, 0, 0])
            cube ([rail_inner_width, rail_mount_length, beam_thickness]);
        }
        union() {
            // screwholes
            translate([beam_length-rail_inner_width/2, 30, 0])
            union() {
                cylinder (d=M3_hole, h=beam_thickness+.1);   
                rotate([0,0,90])
                cylinder (d=M3_nut_hole, h=M3_nut_inset+.1, $fn = 6);
            }
            translate([beam_length-rail_inner_width/2, 10, 0])
            union() {
                cylinder (d=M3_hole, h=beam_thickness+.1);   
                rotate([0,0,90])
                cylinder (d=M3_nut_hole, h=M3_nut_inset+.1, $fn = 6);
            }
        }
    }
}

module rib () {
    translate([0, 0, face_height-beam_thickness])
    rotate([0,90,0])
    linear_extrude(height = rib_thickness) 
    polygon(points = [[0,face_thickness], [0,rail_mount_length], [face_height-beam_thickness,face_thickness]]);
}

/*
foot_width = 40;
foot_depth = 20;
foot_thickness = 5;
foot_curve = 8;

face_thickness = 4;
face_curve = 10;
face_height = 50;
face_width = 40;

rib_thickness = 4;

foot_screw_hole = 4;
foot_screw_head = 7;
foot_screw_head_height = 2;
foot_screw_length = 20;
foot_screw_mount_diameter = 11;
foot_screw_mount_height = foot_thickness;


foot_screw_positions = [
    [(foot_width-rib_thickness)/4,face_thickness+(foot_depth-face_thickness)/2],
    [foot_width-(foot_width-rib_thickness)/4,face_thickness+(foot_depth-face_thickness)/2]
];

face_screw_offset = [9, 12];

face_screw_length = 20;
face_screw_mount_diameter = 11;
face_screw_mount_height = face_thickness;

face_screw_positions = [
    [foot_width/2+face_screw_offset[0],face_screw_offset[1]],
    [foot_width/2-face_screw_offset[0],face_screw_offset[1]],
    [foot_width/2,face_height-face_curve/2]
];

mount ();

module mount () {
    difference () {
        union() {
            foot();
            face();
            rib();
        }
        union() {
            foot_screws();
            face_screws();
        }
    }
}



module face () {
    hull () {
        translate([(foot_width-face_width)/2, 0, 0])
        cube ([face_width, face_thickness, foot_thickness]);
        translate([foot_width/2, 0, face_height-face_curve/2])
        rotate([270,0,0])
        cylinder (d=face_curve, h=face_thickness);
    }
}

module foot () {
    hull () {
        cube ([foot_width, foot_depth-foot_curve, foot_thickness]);
        translate([foot_curve/2, foot_depth-foot_curve/2, 0])
        cylinder (d=foot_curve, h=foot_thickness);
        translate([foot_width-foot_curve/2, foot_depth-foot_curve/2, 0])
        cylinder (d=foot_curve, h=foot_thickness);
    }
}

module face_screws() {
    
    for (pos=face_screw_positions) {
        translate([pos[0],-face_screw_length + face_screw_mount_height+.1,pos[1]])
        rotate([270,0,0])
        foot_screw();
    }
}

module foot_screws() {
    for (pos=foot_screw_positions) {
        translate([pos[0],pos[1],-foot_screw_length + foot_screw_mount_height])
        foot_screw();
    }
}

module foot_screw () {
    color ([.7,.7,.7]) union () {
    cylinder (d=foot_screw_hole, h=foot_screw_length-foot_screw_head_height);
    translate([0,0,foot_screw_length-foot_screw_head_height])
    cylinder (d1=foot_screw_hole, d2=foot_screw_head, h=foot_screw_head_height);
    }
}
*/
