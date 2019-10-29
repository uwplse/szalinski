//Wire Clip. Created by Michael Warburton

//Define Variables
top_h=4;
top_l=65;
top_w=7;
bot_h=5;
bot_l=80;
bot_w=12;
hole_diam=6;
hole_r=hole_diam/2;
con_angle=5.194;
hole_h=15;

$fn=50;//resolution

//top
translate([-bot_w/2,-bot_l/2+8,bot_h/4])
rotate([con_angle,0,0])//Angle betw Top and Bot
cube([top_w,top_l,top_h]);

//screw holes
difference() {
cube([bot_w,bot_l,bot_h], center=true);
    
translate([0,bot_l/2-4,-bot_h])
cylinder(hole_h,hole_r,hole_r);
translate([0,-bot_l/2+4,-bot_h])
cylinder(hole_h,hole_r,hole_r);

}