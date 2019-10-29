mount_height=35;
mount_width=42;
mount_thickness=3;
mount_hole_diameter=6;
mount_hole_separation=8; //set to zero if you only want one hole
controller_arm_height=27;
controller_arm_thickness=5;
controller_arm_depth=7;
controller_arm_one_distance=7; //distance from wall to the outside edge of the arm
controller_arm_two_distance=34; //distance from wall to the outside edge of the arm; make sure this number is the sum of the arm one distance, the depth of the arms, and the gap you want between the arms
controller_arm_separation=18.5; //set to zero if you only want one or (mount_width-controller_arm_thickness)/2 if you want two, one at either end
controller_arm_brace=true;
$fn=50;

controller_mount();

module controller_mount(){
    wall_mount();
    translate([mount_width/2-controller_arm_thickness/2-controller_arm_separation,0,0])
    controller_arm();
    translate([mount_width/2-controller_arm_thickness/2+controller_arm_separation,0,0])
    controller_arm();
    if (controller_arm_brace==true){
    translate([0,controller_arm_two_distance/2,0])
    controller_arm_brace_module();
        }
    }

module controller_arm(){
    difference(){
    controller_arm_solid();
    translate([-0.1,controller_arm_two_distance,-controller_arm_depth])
    rotate([60,0,0])
    cube([controller_arm_depth+0.2,controller_arm_depth*2,controller_arm_depth]);
    }
}   
        
module controller_arm_solid(){
    cube([controller_arm_thickness,controller_arm_two_distance,mount_height-controller_arm_height]);

    translate([0,controller_arm_two_distance-controller_arm_depth,mount_height-controller_arm_height])
    cube([controller_arm_thickness,controller_arm_depth,controller_arm_height-controller_arm_depth/2]);
    translate([0,controller_arm_two_distance-controller_arm_depth/2,mount_height-controller_arm_depth/2])
    rotate([0,90,0]){
    cylinder(d=controller_arm_depth,h=controller_arm_thickness);}

    translate([0,controller_arm_one_distance-controller_arm_depth,mount_height-controller_arm_height])
    cube([controller_arm_thickness,controller_arm_depth,controller_arm_height-controller_arm_depth/2]);
    translate([0,controller_arm_one_distance-controller_arm_depth/2,mount_height-controller_arm_depth/2])
    rotate([0,90,0]){
    cylinder(d=controller_arm_depth,h=controller_arm_thickness);}
}

module wall_mount(){
    difference(){
    cube([mount_width,mount_thickness,mount_height]);
    translate([mount_width/2-mount_hole_separation,mount_thickness+0.1,mount_height*2/3])
    rotate([90,0,0])
    cylinder(d=mount_hole_diameter,h=mount_thickness+0.2);
    translate([mount_width/2+mount_hole_separation,mount_thickness+0.1,mount_height*2/3])
    rotate([90,0,0])
    cylinder(d=mount_hole_diameter,h=mount_thickness+0.2);
}
}

module controller_arm_brace_module(){
    cube([controller_arm_separation*2,2,mount_height-controller_arm_height]);
}