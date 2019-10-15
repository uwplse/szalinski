adapter_height=91;
adapter_width=28;
adapter_length=adapter_height*2/3;
adapter_thickness=4;
wall_mount_screw_diameter=7;
wall_mount_screw_separation_x=adapter_width/3;
wall_mount_screw_separation_y=adapter_height/4;
kinect_mount_screw_diameter=10;
support_cutout_x=0.65; //percentage of width
support_cutout_y=0.8; //percentage of height
support_angle=45;
support_length=87;


adapter_combined();

module adapter_combined(){
rotate([90,0,0]){adapter_height();};
adapter_width();
translate([0,adapter_length,adapter_thickness])
rotate([90+support_angle,0,0]){adapter_support();};
}

module adapter_height(){
    difference(){
    cube([adapter_width,adapter_height,adapter_thickness]);
        translate([adapter_width/2,adapter_height-adapter_width/2,-0.1])
        cylinder(d=kinect_mount_screw_diameter,h=adapter_thickness+0.2);
    }
}

module adapter_width(){
    difference(){
    cube([adapter_width,adapter_length,adapter_thickness]);

//    translate([adapter_width/2-wall_mount_screw_separation_x/2,adapter_width/3,-0.1])
//        cylinder(d=wall_mount_screw_diameter,h=adapter_thickness+0.2);
    translate([adapter_width/2+wall_mount_screw_separation_x/2,adapter_width/3,-0.1])
        cylinder(d=wall_mount_screw_diameter,h=adapter_thickness+0.2);
        
//    translate([adapter_width/2-wall_mount_screw_separation_x/2,adapter_width/2-wall_mount_screw_separation_y,-0.1])
//        cylinder(d=wall_mount_screw_diameter,h=adapter_thickness+0.2);
    translate([adapter_width/2-wall_mount_screw_separation_x/2,adapter_width/2+wall_mount_screw_separation_y,-0.1])
        cylinder(d=wall_mount_screw_diameter,h=adapter_thickness+0.2);
    }
}

module adapter_support(){
    difference(){
    cube([adapter_width,support_length,adapter_thickness]);
        translate([(adapter_width-adapter_width*support_cutout_x)/2,(adapter_height-adapter_height*support_cutout_y)/2,-0.1])
    cube([adapter_width*support_cutout_x,support_length*support_cutout_y,adapter_thickness+0.2]);
    }
}