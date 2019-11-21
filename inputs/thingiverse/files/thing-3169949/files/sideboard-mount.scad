//**********************************************
// Sideboard mounting bracket for MPCNC build
//
// Written by Ippokratis Anastasiadis 2018
// using OpenSCAD 2015.03-2
// 
// Description : the bracket consists of a face touching the panel,
// a foot mounted on the base, and a rib for strengthening the part.
// 
//**********************************************

//                             PARAMS
//----------------------------------------------

$fn = 100;

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

module rib () {
    translate([(foot_width-rib_thickness)/2, face_thickness, foot_thickness])
    rotate([90,0,90])
    linear_extrude(height = rib_thickness) 
    polygon(points = [[0,0], [0,face_height-face_curve-foot_thickness], [foot_depth-face_thickness,0]]);
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

