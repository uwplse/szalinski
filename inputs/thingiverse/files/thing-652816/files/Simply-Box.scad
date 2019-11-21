//preview[view:south east, tilt:top diagonal]
use <utils/build_plate.scad>
//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
/*[Box]*/
//10mm to 200mm :
box_height=20; //[10:200]
//10mm to 200mm :
box_width=90; //[10:200]
//10mm to 200mm :
box_depth=60; //[10:200]
//1mm to 5mm :
box_thikness=1; //[1:5]
/*[CD]*/
//0=none, 1mm to 5mm :
CD_rise=1; //[0,1,2,3,4,5]
cd_height=box_thikness+CD_rise;
cd_width=(box_width>box_depth)?((box_width-(box_thikness*2))*0.75):((box_depth-(box_thikness*2))*0.75);
Box();
module Box(){
 box_width2=box_width-(box_thikness*2)+0.001;
 box_depth2=box_depth-(box_thikness*2)+0.001;
 difference(){
  translate([0,0,0]) resize([box_width,box_depth,box_height]) cylinder($fn=300);
  translate([0,0,box_thikness]) resize([box_width2,box_depth2,box_height]) cylinder($fn=300);
 }
 if (CD_rise>0) CD(cd_height,cd_width);
}
module CD(cd_height,cd_width){
 cd_x1=cd_width;
 cd_x2=cd_x1-((cd_width/7)*2);
 cd_x3=(cd_x1-cd_x2)/2;
 cd_x4=cd_width/20;
 cd_y1=((cd_width/3)*2);
 cd_y2=cd_y1-((cd_width/7)*2);
 cd_y3=cd_y1/4;
 cd_y4=cd_y1+2;
 cd_z1=cd_height;
 cd_z2=cd_height+2;
 union(){
  difference(){
   translate([0,0,0]) resize([cd_x1,cd_y1,cd_z1]) cylinder($fn=300);
   translate([0,0,-1]) resize([cd_x2,cd_y2,cd_z2]) cylinder($fn=300);
   translate([-cd_x4/2,-cd_y4/2,-1]) cube([cd_x4,cd_y4,cd_z2]);
  }
  translate([-cd_x3-(cd_x4/2),+cd_y3/2,0]) cube([cd_x3,cd_y3,cd_z1]);
  translate([-cd_x3-(cd_x4/2),-cd_y3*1.5,0]) cube([cd_x3,cd_y3,cd_z1]);
  translate([cd_x4/2,-cd_y3*1.5,0]) cube([cd_x3,cd_y3*3,cd_z1]);
 }
}
