//U120 Cam mount
//Designed based on the original one but from scratch and customizable

cam_angle=20;
cam_height=4;
cam_hole=9.5;
cam_offset_y=0;
cam_width=13;

cut=0.5;
cutout_size=30;

$fn=60;


//U120
standoff_height=7;
standoff_width=10;
standoff_hole=6;
standoff_distance=20;

cam_offset_z=cam_height*0.5+2;
total_height=15;

difference() {
    union() {
        //left standoff
        cylinder(d=standoff_width,h=standoff_height,center=true);
        //rightstandoff
        translate([standoff_distance,0,0])
            cylinder(d=standoff_width,h=standoff_height,center=true);
            
        //cam
        translate([standoff_distance*0.5,cam_offset_y,cam_offset_z])
            rotate([90-cam_angle,0,0])
                cylinder(d=cam_width,h=cam_height,center=true);

    }

    union() {
        //cut out angle for printing
        translate([-standoff_width,cam_offset_y,cam_height*0.5+cam_offset_z])
            rotate([90-cam_angle,0,0])
                translate([0,-cutout_size*0.5,0])
                    cube([standoff_distance*2,cutout_size,20],center=false);
        
        //holes
        
        //left standoff
        cylinder(d=standoff_hole,h=standoff_height+cut,center=true);
        
        //right standoff
        translate([standoff_distance,0,0])
            cylinder(d=standoff_hole,h=standoff_height+cut,center=true);
            
        //cam
        translate([standoff_distance*0.5,cam_offset_y,cam_offset_z])
            rotate([90-cam_angle,0,0])
                cylinder(d=cam_hole,h=cam_height+cut,center=true);
    }
}