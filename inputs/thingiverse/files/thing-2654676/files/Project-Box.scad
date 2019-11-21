//------------------------------------
// Customisable Project Box by Mattki
//------------------------------------

// Dimensions in mm unless otherwise specified

// Outer Box dimensions

length = 168; // length of the box
width = 186; // width of the box
height = 60; // height or depth of the box (including fitted lid)
lid_height = 2; // height or thickness of the lid (the part of the lid that sits above the top of the box
overlap_box_to_lid = 2; // additional thickness for the lid (reduces available interior volume but helps to locate the lid in assembly)
wall_thickness = 3; // thickness of the side walls of the box (take two times this figure off of the length and width of the box to find the available internal space!)
base_thickness = 3; // thickness of the base of the box
corner_radius = 8; // corner radius

// Mounting Post dimensions

post_height = 6; // height of the mounting post
od = 8; // outer diameter of post
id = 3; // diameter of internal hole

module screw_stand(){
    // Note this part has not been modified to be customisable and has not been incorporated into the design.
    difference(){
        union(){
            translate([0,0,11]) cylinder(h=22,d=8,$fn=36,center=true);
            translate([0,-3,11]) cube([8,6,22],center=true);
        }
        translate([0,4,0]) rotate([0,90,0]) cylinder(h=8.01,d=20,$fn=4,center=true);
        translate([0,0,17.01]) cylinder(h=10,d=3,$fn=36,center=true);
    }
}

module post_set(board_width,board_height,post_height,od,id,board_edge){
    // Ready but not used in the example
    translate([board_height/2,board_width/2,0]) mounting_post(post_height,od,id);
    translate([-board_height/2,board_width/2,0]) mounting_post(post_height,od,id);
    translate([board_height/2,-board_width/2,0]) mounting_post(post_height,od,id);
    translate([-board_height/2,-board_width/2,0]) mounting_post(post_height,od,id);
}

module mounting_post(post_height,od,id){
    // Ready but not used in the example
    difference(){
        translate([0,0,post_height/2]) cylinder(h=post_height,d=od,$fn=(od/2)*6,center=true);
        translate([0,0,post_height/2]) cylinder(h=post_height,d=id,$fn=(od/2)*6,center=true);
    }
}

module corner_subt(use_radius,use_length,use_width,use_height){
    translate([(use_radius-use_length)/2,(-use_width+use_radius)/2,use_height/2]) difference(){
        translate([-0.5,-0.5,0]) cube([use_radius+1,use_radius+1,use_height+0.005],center=true);
        translate([use_radius/2,use_radius/2,0]) cylinder(h=use_height+0.01,d=use_radius*2,$fn=round(use_radius*8)- round(use_radius*8) % 4,center=true);
    }
}

module project_box(){
    translate([0,width/2+5,0]) difference(){
        difference(){
            translate([0,0,(height-lid_height)/2]) cube([length,width,height-lid_height],center=true);
            corner_subt(corner_radius,length,width,height-lid_height);
            scale([1,-1,1]) corner_subt(corner_radius,length,width,height-lid_height);
            scale([-1,-1,1]) corner_subt(corner_radius,length,width,height-lid_height);
            scale([-1,1,1]) corner_subt(corner_radius,length,width,height-lid_height);
        }
        difference(){
            translate([0,0,(height-lid_height+base_thickness+0.005)/2]) cube([length-wall_thickness*2,width-wall_thickness*2,height-lid_height-base_thickness+0.01],center=true);
            corner_subt(corner_radius-wall_thickness,length-wall_thickness*2,width-wall_thickness*2,height-lid_height);
            scale([1,-1,1]) corner_subt(corner_radius-wall_thickness,length-wall_thickness*2,width-wall_thickness*2,height-lid_height);
            scale([-1,-1,1]) corner_subt(corner_radius-wall_thickness,length-wall_thickness*2,width-wall_thickness*2,height-lid_height);
            scale([-1,1,1]) corner_subt(corner_radius-wall_thickness,length-wall_thickness*2,width-wall_thickness*2,height-lid_height);
        }
    }
}

module project_box_lid(){
    difference(){
        translate([0,-(width/2+5),0]) union(){
            difference(){
                translate([0,0,lid_height/2]) cube([length,width,lid_height],center=true);
                corner_subt(corner_radius,length,width,lid_height);
                scale([1,-1,1]) corner_subt(corner_radius,length,width,lid_height);
                scale([-1,-1,1]) corner_subt(corner_radius,length,width,lid_height);
                scale([-1,1,1]) corner_subt(corner_radius,length,width,lid_height);
            }
            difference(){
                translate([0,0,(lid_height+overlap_box_to_lid)/2]) cube([length-wall_thickness*2-1,width-wall_thickness*2-1,lid_height+overlap_box_to_lid],center=true);
                corner_subt(corner_radius-wall_thickness-0.5,length-wall_thickness*2-1,width-wall_thickness*2-1,lid_height+overlap_box_to_lid);
                scale([1,-1,1]) corner_subt(corner_radius-wall_thickness-0.5,length-wall_thickness*2-1,width-wall_thickness*2-1,lid_height+overlap_box_to_lid);
                scale([-1,-1,1]) corner_subt(corner_radius-wall_thickness-0.5,length-wall_thickness*2-1,width-wall_thickness*2-1,lid_height+overlap_box_to_lid);
                scale([-1,1,1]) corner_subt(corner_radius-wall_thickness-0.5,length-wall_thickness*2-1,width-wall_thickness*2-1,lid_height+overlap_box_to_lid);
            }
        }    
    }
}

project_box();
project_box_lid();