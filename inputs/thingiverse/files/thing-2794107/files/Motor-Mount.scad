/*
Parametric Mount for Berd-Air MAX motor

For mounting a large high-pressure 12V Vacuum Air pump on a panel of a 3D printer frame, secured with a velcro strap

Designed by Michael Jones [DechAmim] with OpenSCAD v2015.03-2

Originally published on thingiverse.com on February 14, 2018 with a CC-SY license

Thanks for checking out my code!
*/

/* [General] */
//Thickness of the board that the motor is being mounted to (in mm)
board_thick = 5.5;
//Width of the velcro (in mm)
velcro_width = 20;
//Approximate thickness of the velcro (in mm)
velcro_thick = 2;
//Tolerance of the parts
tol = 0.2; //[0:0.5]
//Resolution of the round parts (a lower number will still result in an accurate fit, it will just look less smooth)
seg = 64; //[16:16:64]

/* [Mounting Screw] */
//Diameter of the mounting screw (in mm)
screw_dia = 3;
//Diameter of the head of the mounting screw (in mm)
screw_head_dia = 5.4;
//Width of the mounting screw hexagonal nut (flat-to-flat, in mm)
nut_width = 5.38;
//Thickness of the mounting screw nut (in mm)
nut_thickness = 1.5;

/* [Hidden] */

//Dimensions of the motor
small_dia = 37.6;
large_dia = 60;
small_h = 68;
large_h = 44;
lead_thick = 7.6; //Clearance for the two leads

side_ext = 3; //Amount extending from the sides
holder_length = 60;
ext_depth = 25; //Amount extending down the frame
base_thick = 3; //Thickness of the "base" the motor sits on

function apothem(r,n) = r*cos(180/n);
function circumrad(a,n) = a / cos(180/n);
function circumrad_s(s,n) = s / 2 / sin(180/n);
function poly_side(apo,n) = apo * 2 * tan(180/n);
function pythoside(h,s) = sqrt(pow(h,2)-pow(s,2));

small_r = circumrad(small_dia/2,seg);

velcro_clearance = velcro_thick * 2 + tol;
space_from_board = 4;

board_offset = large_dia/2+space_from_board;

mount_l = board_offset+ext_depth;
mount_w = small_r*2+side_ext*2;
mount_h = small_h+base_thick-tol;

channel_r = small_r+(board_offset-small_r)/2;
channel_w = velcro_width+tol*2;

screw_r = circumrad(screw_dia/2,6);

//This path defines the shape of the main motor mount, and is used for a linear extrusion in the main motor_mount module below
path = [[lead_thick,-mount_w/2],[board_offset,-mount_w/2],[mount_l+lead_thick,-board_thick*1.5],[mount_l+lead_thick,board_thick*1.5],[board_offset,mount_w/2],[lead_thick,mount_w/2]];

module hollow_cyl(r_out,r_in,h,center=false,fn=seg){
    difference(){
        cylinder(h=h,r=r_out,center=center,$fn=fn);
        translate([0,0,center==false ? -0.1 : 0]) cylinder(h=h+0.2,r=r_in,center=center,$fn=fn);
    }
}

module motor(dummy = false){
    small_rd = dummy == false ? circumrad(small_dia/2,seg) : small_dia/2;
    
     
    cylinder(h=small_h,r=small_rd,$fn = dummy == false ? seg : seg*4);
    if(dummy==true) translate([0,0,small_h]) cylinder(h=large_h,d=large_dia,$fn=seg*4);
}


module bottom_support(){
    cylinder(h=base_thick,r=small_dia/4);
    translate([0,-small_dia/4,0]) cube([small_dia/2,small_dia/2,base_thick]);
}

module motor_mount(){
    difference(){
        linear_extrude(height=mount_h) polygon(path);
        translate([0,0,base_thick]) motor();
        translate([0,0,base_thick+small_h/2-channel_w/2]) hollow_cyl(r_in=channel_r-velcro_clearance/2,r_out=channel_r+velcro_clearance/2,h=channel_w);

        translate([board_offset,-board_thick/2,-tol]) cube([mount_l,board_thick,mount_h+tol*2]);
        
        translate([board_offset+ext_depth/2,0,mount_h/2]) rotate([90,0,0]) rotate([0,0,360/12]) cylinder(r=screw_r,h=mount_w,$fn=6,center=true);
        translate([board_offset+ext_depth/2,-mount_w/2-board_thick*1.5,mount_h/2]) rotate([90,0,0]) rotate([0,0,360/12]) cylinder(d=screw_head_dia*1.5,h=mount_w,$fn=6,center=true);
        translate([board_offset+ext_depth/2,mount_w/2+board_thick/2+5,mount_h/2]) rotate([90,0,0]) rotate([0,0,360/12]) cylinder(r=circumrad(nut_width/2,6),h=mount_w,$fn=6,center=true);
    }
    
    bottom_support();
}

motor_mount();
//To visualize the motor inside the motor mount, uncomment the line below
//%translate([0,0,base_thick]) motor(true);