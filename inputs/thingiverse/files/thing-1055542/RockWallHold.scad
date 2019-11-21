//Created by Kyle Barie
//MY4777 10/06/2015
//Rock Wall Hold


$fa = 0.5;
$fs = 0.5;

//Units = mm;

GripDepth = 40;
BaseSize = 35;
GripHeight = 10;
GripWidth = 80;
GripComfort = 4;
ShapingConstant1 = 0.75;  //Unitless: Controls Z position of shaping points
ShapingConstant2 = 3.5;    //Unitless: Controls Y position of shaping points
BoltLocation = 25;
BoltEngagement = 25;


//Wall Size. Only change if scaleing very large
w = 600;
h = 300;
l = 100;



module WALL()
{
    translate([w/4,0,-(l/2)]){
cube([w,h,l] , center=true);
    }
}

module Base()
{
  translate([(BaseSize*1.3),0,0]) {
    sphere(BaseSize);   
}  
    
}

module Grip()
{
  //Top point  
 translate([-(GripHeight),0,GripDepth]) {
    sphere(GripComfort*1.25);   
}

 //Shaping Points
translate([-(GripHeight/2),(GripWidth/ShapingConstant2),(GripDepth*ShapingConstant1)]) {
    sphere(GripComfort);   
}
translate([-(GripHeight/2),-(GripWidth/ShapingConstant2),(GripDepth*ShapingConstant1)]) {
    sphere(GripComfort);   
}
 //Extent Points
translate([0,(GripWidth/2),0]) {
    sphere(GripComfort);   
}
translate([0,-(GripWidth/2),0]) {
    sphere(GripComfort);   
}

    
}


module BoltClearance()
{
 *import("Bolt.stl");
    
    
     union(){  
    cylinder(40,d=25);
   translate([0,0,-60]){ 
    cylinder(61,d=10);  
   }
  }
}

module Basic_Hold()
{
difference(){


hull(){


Base();

Grip();
}

WALL();
}
}



module Complete_Hold()
{
difference(){
Basic_Hold();

translate([BoltLocation,0,BoltEngagement]){
BoltClearance();
}
}
}


Complete_Hold();