$fn = 100;
// Moto X 2014 from back of phone
//                          139.4mm
//   +-----------------------------------------------------+
//   |                                         | 10mm      |
//   |                                         |-----------|
// 7 |                                    upper- screw     |
// 1 |         000                             O|---50mmm--|
// . |        0   0                                        |
// 2 |        0   0                                        |
// m |         000                                         |
// m |                                                     |
//   |                                                     |
//   |                                                     |
//   |                                                     |
//   +-----------------------------------------------------+
//
// screw_head: 5.5 mm
// holes: 33.7 mm center to center, diameter 3.6 mm
//
// Angles:
//****************************************
//  from top   ** from front             *
//             **                        *
//   |    /    **  ---------- \  phone   *
//  b|   /     **     rail     \         *
//  e|25°      **            20°\        *
//  d|./ phone ** ______________.\       *
//   |/        **    bed                 *
//             **                        *
//****************************************

// Place the phone in the z/y planes by figuring out where in the phone
// the upper screw of the two mounting screw lines up.
// How far down into the phone is the upper screw
screw_z_in_phone = 10;
// How far over into the phone is the upper screw
screw_y_in_phone = 50;
// Phone rotation on y axis (looked at from front)
phone_roll = -20;
// Phone rotation on z axis (looked at from top)
phone_yaw = -25;
// Distance of holder from mount plate
x_off = 5;

// Phone dimensions
// phone horizontal dimension
phone_h = 140.5;
// phone vertical dimension
phone_w = 72.5;
// fudge factor, allows adding some softening material?
depth_fudge = .4;
// MotoX 2014 has a curved back, model this by beveling the back
// set phone_d2 = phone_d1 to remove bevel
// Phone depth at edge (6 for moto x)
phone_d1 = 8 + depth_fudge;
// Phone depth at bevel_w mm into the phone
phone_d2 = 10.2 + depth_fudge;
// Width of the bevel (14 for moto x)
bevel_w = 18;

module rounded_box(points, radius, plate_h){
    hull(){
        for (p = points){
            translate(p) cylinder(r=radius, h=plate_h);
        }
    }
}

////////////////////////////
// Screw Plate
////////////////////////////
plate_h = 50;
plate_w = 20;
plate_d = 4;
screw_c_to_c = 33.7;
screw_hole_d = 1.7;
screw_r = 3.6/2;
screw_head_r = 5.8/2;
upper_screw_hole_x = 7;
upper_screw_hole_y = 8;
lower_screw_hole_y = upper_screw_hole_y + screw_c_to_c;
plate_points = [[0, 0, 0],           [plate_w - 1, 0, 0],
                [0,plate_h - 1, 0],  [plate_w - 1, plate_h - 1, 0]];

module screw_hole(y){
    translate([upper_screw_hole_x, y, -plate_d/2])
        cylinder(r=screw_r, h=2*plate_d);
    translate([upper_screw_hole_x, y, screw_hole_d])
        cylinder(r=screw_head_r, h=plate_d);
}

module screw_plate(){
    difference(){
        // main plate
        rounded_box(plate_points, 1, plate_d);
        // upper screw hole
        screw_hole(upper_screw_hole_y);
        screw_hole(lower_screw_hole_y);
    }
}

////////////////////////////
// Phone model
////////////////////////////
pd1 = phone_d1 + depth_fudge;
pd2 = phone_d2 + depth_fudge;

module phone(){
    cube([phone_w, phone_h, pd1]);
    translate([phone_w/2,phone_h/2,pd1]){
        linear_extrude(height=pd2 - pd1,
                       scale=[(phone_w-bevel_w*2)/phone_w, 1], center=false)
        {
            square([phone_w, phone_h], center=true);
        }
    }
}

// And the phone holder, modeled around the phone shape
holder_h = phone_h/2;
holder_w = phone_w/2;
holder_d = pd2 * 2;
holder_th = pd2;
base_th = 4;
base = phone_h + base_th;
module holder(){
    difference(){
        // Holder block
        union(){
            translate([-holder_th/2, phone_h/4, -pd2/2])
                cube([holder_w, holder_h, holder_d]);
            translate([-holder_th/2, -base_th/2, 0])
                cube([holder_w/2, base, pd1]);
        }
        #phone();
        // Minus squares for material savings
        translate([-holder_th/2+holder_th, phone_h/4+holder_th, -pd2/2-holder_th])
            cube([holder_w, holder_h-(holder_th*2), holder_d*2]);
    }
}

upper_rot_screw_z = screw_c_to_c + upper_screw_hole_y;
// Amount to drop the phone to align it with the upper screw
phone_z_to_screw = sin(90+phone_roll)*phone_w - upper_rot_screw_z;
screw_rot_y = upper_screw_hole_x - sin(90-25)*pd2;
phone_y_to_screw = sin(90+phone_yaw)*phone_h - screw_rot_y;
module positioned_holder(){
    translate([x_off, -phone_y_to_screw + screw_y_in_phone,
               -phone_z_to_screw + screw_z_in_phone])
    rotate([0, phone_roll, phone_yaw])
    rotate([0, -90, 0])
        holder();
}

module plate_to_holder(){
    hull(){
        translate([0,0,-8]) cube([1, plate_w, 10]);
        translate([x_off, -phone_y_to_screw + screw_y_in_phone,
                    -phone_z_to_screw + screw_z_in_phone])
            rotate([0, phone_roll, phone_yaw])
            rotate([0, -90, 0])
            translate([-holder_th/2, phone_h/2, pd2])
                cube([2*holder_w/3, holder_h/2, 1]);
    }
}

////////////////////////////
// Combine everything (oriented for real life)
////////////////////////////
module phonecam_mpsm_mount(){
    rotate([90, 0, 90]) screw_plate();
    plate_to_holder();
    positioned_holder();
}

// rotate for printing
rotate([0, -phone_roll, 0]) rotate([0, 0, -phone_yaw]) phonecam_mpsm_mount();
//phonecam_mpsm_mount();
