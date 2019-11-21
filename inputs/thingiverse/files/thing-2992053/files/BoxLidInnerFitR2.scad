////----BoxLidInnerFit.scad----
////----OpenSCAD 2015.03-2----
////----2018.7.3----
////----By Kijja Chaovanakij----
////----default parameter for 9v battery box
////----If the wall's thickness of box & lip don't match, the script will stop. Then check the recommended value on the Console window.
////----If the lip wall's thickness and the nozzle head don't match. The some slicer will make an error.
////----2018.7.8----
////----Rename variable and add comment for open in the Customizer
////----2018.7.20---
////----Change the position of the box and lid. To the same level.

/* [var] */
//number of fragments[30=low:60=medium:90=high]
$fn=30;
//reduce garbage in preview[0.002]
garbage=0.002;
//1=yes other=no 
show_box=1;
//1=yes other=no
show_lid=1;

/* [inner box var(object size)] */
//inner or object tolerance[0.5]
inner_tolerence=0.5;
//inner or object width[16.4]
inner_width=16.4;
//inner or object length[26.4]
inner_length=26.4;
//inner or object height[48.5]
inner_height=48.5;

/* [box var] */
//lid & box fit[0.2]
box_tolerence=0.2;
//top, bottom thickness[1.2]
top_bottom_thickness=1.2;
//lid height[6], if [0] no vertical wall
lid_height=6;
//lip height[8]
lip_height=8;
//box wall thickness[1.6]
box_wall_thickness=1.6;
//lip wall thickness[0.4-0.8]
lip_wall_thickness=0.5;
////----end of customizer var----

////----main----
inner_wid=inner_width+inner_tolerence;
inner_len=inner_length+inner_tolerence;
inner_hi=inner_height+inner_tolerence;
//box corner radius
box_cor_rad=box_wall_thickness;
//box width
box_wid=inner_wid+box_wall_thickness*2;
//box length
box_len=inner_len+box_wall_thickness*2;
//box height
box_hi=inner_hi-lid_height-lip_height;

if (box_wall_thickness+0.001 < (lip_wall_thickness*2+box_tolerence*3)){
  box_wall_thickness=lip_wall_thickness*2+box_tolerence*3;
  echo();
  echo("Please increase box_wall_thickness=",box_wall_thickness);
  echo();
}
else {
  if (show_box==1)
    box();
  if (show_lid==1)
    lid();
  //echo("outer width=",box_wid);
  //echo("outer length=",box_len);
  //echo("outer height=",inner_hi+top_bottom_thickness*2);
}
////

////
module box()
translate([-box_wid*0.6,0,box_hi/2+top_bottom_thickness/2]){
  difference(){
    fillet_cube(box_hi+top_bottom_thickness,box_cor_rad);
    
    translate([0,0,top_bottom_thickness/2])
    cube([inner_wid,inner_len,box_hi+garbage],true);
  }
  
  color("tan")
  translate([0,0,(box_hi+lip_height+top_bottom_thickness-box_tolerence*2)/2])
  difference(){
    fillet_cube(lip_height-box_tolerence*2,lip_wall_thickness);
    
    cube([inner_wid,inner_len,lip_height-box_tolerence*2+garbage],true);
  }
}
////

////
module lid()
translate([box_wid*0.6,0,lid_height/2+top_bottom_thickness/2]){
  difference(){
    fillet_cube(lid_height+top_bottom_thickness,box_cor_rad);
    
    translate([0,0,top_bottom_thickness/2])
      cube([inner_wid,inner_len,lid_height+garbage],true);
  }

  color("tan")
  translate([0,0,(lid_height+lip_height+top_bottom_thickness)/2+garbage])
  difference(){
    fillet_cube(lip_height,box_cor_rad);
    fillet_cube(lip_height+garbage,lip_wall_thickness+box_tolerence*3);
  }
}
////

////
module fillet_cube(height,radius)
hull(){
  for (i=[-inner_wid/2,inner_wid/2])
  for (j=[-inner_len/2,inner_len/2])
    translate([i,j,0])
      cylinder(height,radius,radius,true);
}
////