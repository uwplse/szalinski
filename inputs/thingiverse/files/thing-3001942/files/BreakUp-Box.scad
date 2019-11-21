////----BreakUp_Box.scad----
////----OpenSCAD 2015.03-2----
////----2018.7.3----
////----By Kijja Chaovanakij----
////----2018.7.12 Parameters changed for "Relationship Break-Up box"
////----By Ernest Negus
////----If the wall's thickness of box & lip don't match, the script will stop. Then check the recommended value on the Console window.
////----If the lip wall's thickness and the nozzle head don't match. The some slicer will make an error.
////----
////----2018.7.8----
////----rename variable and add comment for open in customizer

// preview[view:south, tilt:top]
/* [Global] */

/* [Custom Message] */

// Line01 - Line13 are what you want to say to the person receiving the box. Keep each line short (< 32 characters)
//number of fragments[30=low:60=medium:90=high]
$fn=30;
// First line of message (<32 char)
Line01 = "Sorry Brad,"; // Line 1
// Second line of message (<32 char)
Line02= " "; // Line 2
// Third line of message (<32 char)
Line03 = "But we are just too different.";  // Line 3
// Forth line of message (<32 char)
Line04 = " "; // Line 4
// Fifth line of message (<32 char)
Line05 ="Here is: "; // Line 5
// Sixth line of message (<32 char)
Line06 = " "; // Line 6
// Seventh line of message (<32 char)
Line07 = "1) Your engagement ring."; // Line 7
// Eighth line of message (<32 char)
Line08 = "2) Your apartment key."; // Line 8
// Ninth line of message (<32 char)
Line09 = " "; // Line 9
// Tenth line of message (<32 char)
Line10= "Sorry it didn't work out. I hope"; // Line 10
// Eleventh line of message (<32 char)
Line11 = "you find the right girl for you."; // Line 11
// Twelveth line of message (<32 char)
Line12 = " ";  // Line 12
// Last line of message (<32 char)
Line13 = "                      -Cheryl"; // Line 13
//1=yes other=no 
show_box=1;
//1=yes other=no
show_lid=1;
// Width (80-120)
inner_width=80;  //[80:5:120]
// Length [80-120);
inner_length=80; //[80:5:120]
/* [Hidden] */
// Warning: Change anything below at your own risk!
// It will likely result in an unprintable box.
garbage=0.002;
inner_tolerence=0.5;
inner_height=25;
box_tolerence=0.2;
top_bottom_thickness=1.2;
lid_height=6;
lip_height=8;
box_wall_thickness=1.6;
lip_wall_thickness=0.5;


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
  echo("Please change box_wall_thickness=",box_wall_thickness);
  echo();
}
else {
  if (show_box==1)
    box();
  if (show_lid==1)
    lid();
}
////

////
module box()
translate([-box_wid*0.6,0,0]){
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
  BText(30,Line01);
  BText(25,Line02);
  BText(20,Line03);
  BText(15,Line04);  
  BText(10,Line05);
  BText(5,Line06);
  BText(0,Line07);
  BText(-5,Line08);
  BText(-10,Line09);
  BText(-15,Line10);
  BText(-20,Line11); 
  BText(-25,Line12);
  BText(-30,Line13);
}
////

////
module lid()
translate([box_wid*0.6,0,0]){
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
  RText(30,Line01);
  RText(25,Line02);
  RText(20,Line03);
  RText(15,Line04);  
  RText(10,Line05);
  RText(5,Line06);
  RText(0,Line07);
  RText(-5,Line08);
  RText(-10,Line09);
  RText(-15,Line10);
  RText(-20,Line11); 
  RText(-25,Line12);
  RText(-30,Line13);
}
////vpos=pos of text, Line = text
module RText(vpos,Line) {
    zval=5;
    xval=-141;
    yval=-40;
    sz=4;
    //translate([0,0,-zval])
    //MText(1,xval,vpos,"Comic //Sans MS",sz,Line);
    translate([0,0,-zval])
    LText(1,yval,vpos,"Comic Sans MS",sz,Line);
}
 module BText(vpos,Line) {
    zval=5;
    xval=-141;
    yval=-40;
    sz=4;
    //translate([0,0,-zval])
    //MText(1,xval,vpos,"Comic //Sans MS",sz,Line);
    translate([0,0,-zval])
    MText(1,yval,vpos,"Comic Sans MS",sz,Line);
}   
////Linear text panels -> 
module LText(OnOff,Tx,Ty,Font,Size,Content){
    if(OnOff==1)
    translate([Tx,Ty,1.5])
    linear_extrude(height = 3){
    text(Content, size=Size, font=Font);
    }
}
module MText(OnOff,Tx,Ty,Font,Size,Content){
    if(OnOff==1)
    translate([Tx,Ty,-1])
    linear_extrude(height = 2.5){
    text(Content, size=Size, font=Font);
    }
}
////
module fillet_cube(height,radius)
hull(){
  for (i=[-inner_wid/2,inner_wid/2])
  for (j=[-inner_len/2,inner_len/2])
    translate([i,j,0])
      cylinder(height,radius,radius,true);
}
////