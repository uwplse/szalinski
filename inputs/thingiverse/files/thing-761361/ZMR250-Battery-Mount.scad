include_strap_tab="Yes";//[Yes,No]
battery_height=21;//[1:100]
battery_width=35;//[1:36]
/* [Hidden] */
$fn=30;

frame_width_max=46;
frame_width_min=39.5;

module battery(){
    translate([-56,-battery_width/2,1.5]){
        cube([103.01,battery_width,battery_height]);
    }
}
module base_mount(){
    linear_extrude(height=battery_height+3)
        polygon(points=[[0,frame_width_max/2],[0,-frame_width_max/2],[47,-frame_width_min/2],[47,frame_width_min/2]],paths=[[0,1,2,3]]);
    translate([-58,-frame_width_max/2,0]){
    cube([58,frame_width_max,battery_height+3]);
    }
}
module strap_tab(){
    difference(){
        cube([7,7,7]);
        translate([-0.01,-0.01,-0.01])cube([4.01,7.02,4.01]);
    }
}
module screw_holes(){
    translate([2.7,17,-0.01])cylinder(h=1.52,r=1.5);
    translate([2.7,-17,-0.01])cylinder(h=1.52,r=1.5);
    translate([2.7,17,1.5])cylinder(h=battery_height+1.51,r=3);
    translate([2.7,-17,1.5])cylinder(h=battery_height+1.51,r=3);
    translate([-58.01,-20,-0.01])cube([4.5,6,2.01]);
    translate([-58.01,14,-0.01])cube([4.5,6,2.01]);
}
module top_hole(){
    translate([-38,-battery_width/2,battery_height+1.49])cube([85.01,battery_width,1.52]);
}
difference(){
    base_mount();
    screw_holes();
    battery();
    top_hole();
}
if (include_strap_tab=="Yes") {
    translate([-58,-3.5,battery_height+3])strap_tab();
}