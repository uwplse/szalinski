//Eachine Tiny 32bits F3 Brushed Whoop Mount with Camera Holder
height=1;
center_circle_width=20;

mmount_x=35;
mmount_y=35;

hole_factor=0.7;
bar_width_inner=2;
bar_width_outer_x=5;
bar_width_outer_y=6;

mount_hole_d=1.5;

fc_x = 19.5;
fc_y = 19.5;
fc_z = 2.5;

fc_mount_w=2;                   //Strength of the fc holder sidebars
fc_mount_top=1;                 //How much to add from the fc height to the sideclamps

$fn=50;

option_fc_mount=true;
option_fc_mount_cut=0.5;        //Add some clamp holders to the top of the fc sidebars

option_cam_mount=true;
option_show_template=false;

module mount() {
    //Main body
    translate([0,0,height*0.5])
        intersection() {
            union() {
                
                //Circle platform area
                difference() {
                    cylinder(d=center_circle_width,h=height,center=true);
                    cylinder(d=center_circle_width*hole_factor,h=height+0.1,center=true);
                }

                //Center beams
                cube([bar_width_inner,mmount_y,height],center=true);
                cube([center_circle_width,bar_width_inner,height],center=true);
                
            }
            
            cylinder(d=center_circle_width,h=height,center=true);
        }


    //Extended Crossarm
    translate([0,0,height*0.5])
        difference() {
               union() {
                    cube([bar_width_outer_y,mmount_y,height],center=true);
                    cube([mmount_x,bar_width_outer_x,height],center=true);
                   
                   //Rounded endparts
                   translate([mmount_x*0.5,0,0])
                        cylinder(d=bar_width_outer_x,h=height,center=true);
                   
                   translate([-mmount_x*0.5,0,0])
                        cylinder(d=bar_width_outer_x,h=height,center=true);
                   
                   translate([0,mmount_y*0.5,0])
                        cylinder(d=bar_width_outer_y,h=height,center=true);
                   
                   translate([0,-mmount_y*0.5,0])
                        cylinder(d=bar_width_outer_y,h=height,center=true);
               }
           
           //Center cutout
           cylinder(d=center_circle_width*hole_factor,h=height+0.1,center=true);
           
           //Mounting holes on arms
            translate([mmount_x*0.5,0,0])
                cylinder(d=mount_hole_d,h=height+1,center=true);
           
            translate([-mmount_x*0.5,0,0])
                cylinder(d=mount_hole_d,h=height+1,center=true);
           
            translate([0,mmount_y*0.5,0])
                cylinder(d=mount_hole_d,h=height+1,center=true);
           
            translate([0,-mmount_y*0.5,0])
                cylinder(d=mount_hole_d,h=height+1,center=true);
        }

    //FC Mounts

    //fc mount thingies
    if(option_fc_mount) {    
        difference() {
            translate([0,0,(fc_z+height*2+fc_mount_top)*0.5])
            union() {            
                //Front
                translate([0,fc_y*0.5+(fc_mount_w-option_fc_mount_cut)*0.5,0])
                    cube([bar_width_outer_y,fc_mount_w+option_fc_mount_cut,fc_z+fc_mount_top],center=true);
                
                //Back
                //translate([0,-fc_y*0.5-(fc_mount_w-option_fc_mount_cut)*0.5,(fc_z+height+fc_mount_top)*0.5])
                //    cube([bar_width_outer_y,fc_mount_w+option_fc_mount_cut,fc_z],center=true);
                
                //Right
                translate([fc_x*0.5+(fc_mount_w-option_fc_mount_cut)*0.5,0,0])
                    cube([fc_mount_w+option_fc_mount_cut,bar_width_outer_x,fc_z+fc_mount_top],center=true);
                
                //Left
                translate([-fc_x*0.5-(fc_mount_w-option_fc_mount_cut)*0.5,0,0])
                    cube([fc_mount_w+option_fc_mount_cut,bar_width_outer_x,fc_z+fc_mount_top],center=true);
        
            }
            //Holding ridge
            translate([0,0,(height*2+fc_z)*0.5])
                cube([fc_x,fc_y,fc_z],center=true);
            
        }
    }


    //Camera Mount

    if(option_cam_mount) {
        //fc_z+fc_mount_top
        cam_width= 8;
        cam_mount_width=10;
        cam_mount_thickness=fc_mount_w+option_fc_mount_cut;   //2
        cam_angle=10;
        cam_z=cam_mount_width;
        cam_mount_z_gap=0;
        cam_z_to_lense=3;
        cam_mount_slot_w=2.5;
        
        translate([0,0,(fc_z+height+fc_mount_top)])
        intersection() {
            difference() {
                    //Cam mount base
                    union() {            
                        translate([0,fc_y*0.5+(fc_mount_w-option_fc_mount_cut)*0.5,(cam_z+cam_z_to_lense-fc_mount_top)*0.5])
                            cube([cam_mount_width,cam_mount_thickness,cam_z+(cam_z_to_lense-fc_mount_top)],center=true);    
                    }
                
                    //Cam cut out
                    translate([0,fc_y*0.5+(fc_mount_w-option_fc_mount_cut)*0.5,cam_width*0.5+(cam_z_to_lense-fc_mount_top)+cam_mount_z_gap])
                        rotate([90,0,0])
                            cylinder(d=cam_width,h=cam_width,center=true);
                    
            }
        
        //Cam cut out
        translate([0,fc_y*0.5+(fc_mount_w-option_fc_mount_cut)*0.5,cam_width*0.5+cam_mount_z_gap])
            union() {
                rotate([90,0,0])
                    cylinder(d=cam_width+2,h=cam_width,center=true);
                //Cut top half
                translate([0,0,2])   //cam_width*0.5
                        cube([cam_width+2,cam_width,cam_width*0.5],center=true);
            }
        }
    }
}

mount();