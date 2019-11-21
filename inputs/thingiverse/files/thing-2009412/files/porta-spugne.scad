// Porta spugne 

/// VARIABLES
accurate=true;
height=15; //support height
width=100; //support width
depth=70; //support depth
box_height=20; //height of boxes
thickness=1;
screw_head=3;
delta_mount_y=4;
carves=10;

// CALCULATED VARIABLES
delta_smaller_box=4;
large_box_width=width-delta_smaller_box*thickness;
depth_boxes=depth-delta_smaller_box*thickness;
invito=screw_head/4;
delta_wall=delta_mount_y+thickness;
// calculus for cylinders
  steps=width/carves;
  startcarving=(large_box_width-2*thickness*carves)/carves/2;
  startcarving=(large_box_width-(steps-1)*carves)/2;
echo(startcarving=startcarving);
//$fn=0;$fs=12;$fa=2; // default res
// $fs = 0.01;$fa = 0.01; //hi res
$fn=36;$fs=12;$fa=2; // default res

union()
{
// "Recinto"
difference(){
    translate([0,-delta_wall-0*thickness,0])
        cube([width,depth+delta_wall+2*thickness,height]);
    translate([thickness,2*thickness,1*thickness])
        cube([width-(2*thickness),depth_boxes+(2*thickness),height+2]);
    translate([0,+1*thickness,0*thickness]) rotate([-90,0,0]) 
      for (i=[0:carves-1]){
        translate_cylinder=startcarving + i*width/carves;
        translate([translate_cylinder,0,0])
        cylinder(depth+0*thickness,2*thickness,2*thickness);}
    }
// Wall mount
translate([0,thickness-delta_wall+0.1,0])
rotate([90,0,0]) 
difference(){
    hull(){
        cube([width,height,thickness*2]);
        translate([width/2,depth,thickness]) sphere(thickness);}
    translate([width/2,depth*0.8,-1]) cylinder(height+2,screw_head,invito);
    translate([width*.8,depth*0.35]) cylinder(height+2,screw_head,invito);
    translate([width*.2,depth*0.35]) cylinder(height+2,screw_head,invito);
    }
}
