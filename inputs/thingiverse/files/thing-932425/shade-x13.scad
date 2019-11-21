
// Depth of the Sun Shade
Sunshade_Depth = 55; // [0:100]
 
// Width of Device
device_x = 80; // [75:85]

// Height of Device (Try 152 for Galaxy Note 3)
device_y = 155; // [150:160]

// Depth of Device (including back)
Device_Depth = 10; // [9:12]

module dont_customize(){}

outside_x = 118;
outside_xo = 10.6;
outside_cut_y = 68;
step = 1.5;

base_x = 98;
base_y = 170;
base_z = Device_Depth;

screen_z = 3;
screen_xo= 5;
screen_y = 130;

button_r_y1 = 35;
button_r_y2 = 56;

button_l_y1 = 20;
button_l_y2 = 50;

buttons_x = 1.5;

device_cut_y = 10;
device_cut_x = 24;

button_cut_xo = 16;

shade_z = Sunshade_Depth;
shade_w = 2;

usb_x = 12;

post_y = 2;
post_x = 6;
post_d = 8;

curve_r = 15;

big = 50;

buttons_ry1 = device_y-button_r_y1;
buttons_ry2 = device_y-button_r_y2;
buttons_ly1 = device_y-button_l_y1;
buttons_ly2 = device_y-button_l_y2;

rnd = 5;

// base block
difference(){

    translate([-outside_xo,0,0])roundcube([outside_x,base_y,base_z]);  

translate([(base_x-device_x)/2,(base_y-device_y)/2,0]) cube(size=[device_x,device_y,base_z]);
translate([(base_x-usb_x)/2,-base_y/2,0]) cube([usb_x,base_y,base_z]);

translate([0,(base_y-outside_cut_y)/2,0]) translate([0,0,base_z]) rotate([0,10,0]) translate([-big,0,-big]) cube([big,outside_cut_y,big]);

translate([base_x,(base_y-outside_cut_y)/2,0]) translate([0,0,base_z]) rotate([0,-10,0]) translate([0,0,-big]) cube([big,outside_cut_y,big]);

// buttons
translate([0,buttons_ly2+(base_y-device_y)/2,0]) translate([(base_x-device_x)/2-buttons_x,0,0]) cube([buttons_x,buttons_ly1-buttons_ly2,base_z]);
translate([device_x,buttons_ry2+(base_y-device_y)/2,0]) translate([(base_x-device_x)/2,0,0]) cube([buttons_x,buttons_ry1-buttons_ry2,base_z]);
}
// left and right tabs
translate([0,0,base_z]) difference(){
translate([-outside_xo,0,0]) roundcube([outside_x,base_y,screen_z]);
translate([-outside_xo,(base_y-screen_y)/2,0]) cube(size=[base_x+2*outside_xo,screen_y,screen_z]);
translate([(base_x-device_cut_x)/2,(base_y-screen_y)/2-device_cut_y,0]) cube(size=[device_cut_x,screen_y+2*device_cut_y,screen_z]);
}
// screen
translate([0,0,base_z]) difference(){
    translate([0,0,0]) cube([base_x-screen_xo,base_y,shade_z]);
    translate([0,shade_w,0]) cube([base_x-1*shade_w-screen_xo,base_y-2*shade_w,shade_z]);
 
}
// posts
translate([0,0,base_z]) 
{
    
hull(){
    translate([0,post_d/2,0]) cylinder(h=shade_z,d=post_d);
    translate([device_x/2,0,0]) cube([1,shade_w,shade_z]);
}
translate([0,base_y-post_d,0])
hull(){
    translate([0,post_d/2,0]) cylinder(h=shade_z,d=post_d);
    translate([device_x/2,post_d-shade_w,0]) cube([1,shade_w,shade_z]);
}

translate([base_x-screen_xo-curve_r-shade_w,0,0])
{
    difference(){
        cube([curve_r+shade_w,curve_r+shade_w,shade_z]);
translate([0,curve_r+shade_w,0]) cylinder(r=curve_r,h=shade_z);
}}
translate([base_x-screen_xo-curve_r-shade_w,base_y-curve_r-shade_w,0]){
    difference(){
        cube([curve_r+shade_w,curve_r+shade_w,shade_z]);
translate([0,0,0]) cylinder(r=curve_r,h=shade_z);
    }
}

}

module roundcube(v){
    translate([rnd,rnd,v[2]/4]) minkowski(){
    cube([v[0]-2*rnd,v[1]-2*rnd,v[2]/2]);
    cylinder(r=rnd,h=v[2]/2,center=true);
    }
}

    












