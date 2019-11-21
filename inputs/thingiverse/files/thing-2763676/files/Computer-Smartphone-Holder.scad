/* [Phone details] */
// Enter width of your phone in mm
phone_width = 74;
// Enter height of your phone in mm
phone_height = 142;
// Enter thickness of your phone in mm
phone_thickness = 6;
// Enter the thickness of your computer monitor on the upper side

/* [Monitor details] */
monitor_thickness_upper = 6;
// Enter the thickness of your computer monitor on the right side and your phone_height down
monitor_thickness_side = 8;
// Distance between the two clamps on the computer monitor in mm
monitor_clamp_distance = 25;

/* [Other settings] */
// Specify the roundness of edges
edge = 4; // [0,2,4,6]
// Specify the thickness of walls in mm
wall = 3; // [1,2,3,4]
// Width of a single clamp
cw = 10; // [10,15,20]



difference(){
    cube([phone_width+wall,phone_height+wall,wall]);
    translate([phone_width+wall,phone_height/2,0])
        rotate([0,0,45])
        cube([phone_width+wall,phone_height+wall,wall]);
}
translate([phone_width,0,wall])
    cube([wall,30+wall,wall]);

difference(){
    union(){
        clamp(monitor_thickness_side);
        translate([phone_width-2*wall-edge/2,0,0])
            clamp(monitor_thickness_side);
    }
    translate([0,wall,wall])
    cube([phone_width,phone_height,phone_thickness]);
}

translate([-2*wall,0,0])
    cube([2*wall,wall,wall]);

translate([-2*wall,0,monitor_thickness_side+wall])
    cube([2*wall,wall,wall]);


translate([0,phone_height+wall+edge/2,0])
rotate([180,180,0]){
    clamp(monitor_thickness_upper);
    translate([monitor_clamp_distance,0,0])
        clamp(monitor_thickness_upper);
    translate([0,0,monitor_thickness_upper-wall])
    cube([monitor_clamp_distance,wall,monitor_thickness_upper+edge]);
    translate([-2*wall,0,phone_thickness+2*wall])
        cube([2*wall,cw,wall]);
}
//monitor_clamp_distance+cw,0,
module clamp(ch){
    translate([0,edge/2,edge/2]){
        difference(){
            minkowski(){
                cube([cw,cw-edge,ch+2*wall]);
                rotate([0,90,0])
                    cylinder(r=edge/2,h=1);
            }
            translate([-1,wall-edge/2,wall])
                cube([2*cw,cw,ch]);
        }
    }
}