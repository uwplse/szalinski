////----FoldingRod2.scad----
////----OpenSCAD Version 2015.03-2----
////----2018.6.23
////----By Kijja Chaovanakij----
////
////----2018.7.6----
////----rename variable and add comment for easy understand
////
////----2018.7.8----
////----joint can rotate 4 directions

/* [var] */
//number of fragments[30=low:60=medium:90=high]
$fn=30;
//reduce garbage in preview[0.01]
garbage=0.01;

/* [rod var] */
//rod size[12]
rod_size=12;
//rod length[50]
rod_length=50;

/* [pipe var] */
//pipe radius[2.5]
pipe_radius=2.5;
//[1=insert pipe:other=no pipe:]
pipe_insert=1;

/* [joint var] */
//bolt M3[1.35] M4[1.9]
bolt_radius=1.35;
//bolt hole tolerence[0.2]
hole_tolerence=0.2;
//1=top:2=bottom:3=left:4=right:other=no joint:
joint_a=1;
//1=top:2=bottom:3=left:4=right:other=no joint:
joint_b=3;

////----main----
//horizontal pipe length
pipe_length=rod_length-rod_size*1.75-pipe_radius*2;
difference(){
  rod();
  if (pipe_insert==1)
    pipe();
}
//

module rod()
union(){
  cube([rod_size,rod_length,rod_size],true);
  
  if (joint_a==1)
    translate([0,(rod_length+rod_size)/2,rod_size/4])
    rodjoint();
  
  if (joint_a==2)
    translate([0,(rod_length+rod_size)/2,-rod_size/4])
    rodjoint();
  
  if (joint_a==3)
    translate([-rod_size/4,(rod_length+rod_size)/2,0])
    rotate([0,90,0])
    rodjoint();
  
  if (joint_a==4)
    translate([rod_size/4,(rod_length+rod_size)/2,0])
    rotate([0,90,0])
    rodjoint();
  
  if (joint_b==1)
    translate([0,-(rod_length+rod_size)/2,rod_size/4])
    rotate([0,0,180])
    rodjoint();
  
  if (joint_b==2)
    translate([0,-(rod_length+rod_size)/2,-rod_size/4])
    rotate([0,0,180])
    rodjoint();
  
  if (joint_b==3)
    translate([-rod_size/4,-(rod_length+rod_size)/2,0])
    rotate([0,90,180])
    rodjoint();
  
  if (joint_b==4)
    translate([rod_size/4,-(rod_length+rod_size)/2,0])
    rotate([0,90,180])
    rodjoint();
}
//

module rodjoint()
color("Tan")
difference(){
  union(){
    cylinder(rod_size/2,rod_size/2,rod_size/2,true);
    translate([0,-rod_size/4,0])
    cube([rod_size,rod_size/2,rod_size/2],true);
  }
  
  cylinder(rod_size/2+garbage,bolt_radius+hole_tolerence,bolt_radius+hole_tolerence,true);
}
//

module pipe()
union(){
  rotate([90,0,0])
  cylinder(pipe_length,pipe_radius,pipe_radius,true);
  
  translate([0,pipe_length/2,0])
  sphere(pipe_radius);
  
  translate([0,pipe_length/2,0])
  rotate([-45,0,0])
  cylinder(rod_size,pipe_radius,pipe_radius);
  
  translate([0,-pipe_length/2,0])
  sphere(pipe_radius);
  
  translate([0,-pipe_length/2,0])
  rotate([45,0,0])
  cylinder(rod_size,pipe_radius,pipe_radius);
}
//