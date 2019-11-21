arm_length=60;
arm_width=15;
arm_height=10;

hook_length=20;
hook_depth=10;
clip_depth=10.25;
clip_width=77;
catch_height=7;
catch_length=5;

f=0.001;
fillet=3;

module dup(v) {
    children();
    mirror(v) children();
}

translate([0,0,arm_height/2]) cube([arm_length+f,arm_width,arm_height],center=true);
translate([arm_length/2+arm_height/2,0,hook_depth/2+arm_height]) cube([arm_height,arm_width,arm_height*2+hook_depth,],center=true);
translate([arm_length/2+arm_height+hook_length/2,0,hook_depth+1.5*arm_height]) cube([hook_length+f,arm_width,arm_height],center=true);
translate([arm_length/2+1.5*arm_height+hook_length,0,hook_depth/2+1.5*arm_height]) cube([arm_height,arm_width+f,hook_depth+arm_height],center=true);
translate([-(arm_length+arm_width)/2,0,arm_height/2]) cube([arm_width,clip_width,arm_height],center=true);
dup([0,1,0]) {
    translate([-(arm_length+arm_width)/2,(clip_width+arm_height)/2,hook_depth/2+arm_height]) cube([arm_width,arm_height,hook_depth+arm_height*2],center=true);
    translate([-(arm_width+arm_length)/2,clip_width/2,arm_height+clip_depth]) rotate([90,0,-90]) linear_extrude(arm_width,center=true) polygon(points=[[-f,0],[-f,catch_height],[0,catch_height],[catch_length,0]]);
}
