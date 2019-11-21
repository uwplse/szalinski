/***********************************************************************
Name ......... : filamentStraightener.scad
Description....: Filament Straightener
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/11/13
Licence ...... : GPL
***********************************************************************/


partSelect = 1; //[1:Filament Straightener Assembly, 2:Filament Straightener Body, 3:Handle,  4:Bearing, 5:Bolt, 6:Nut]
//**********************************************************************
//Bearing Dimensions
//**********************************************************************
//Outer diameter of bearing
bearingOD = 22;
//Add tolerance to bearing OD to oversize bearing mating holes
bearingODTolearnace = 0.5;
//Inner diameter of bearing
bearingID = 8.0;
//Thickness of bearing
bearingThickness = 7.0;

//**********************************************************************
//Nut Dimensions
//**********************************************************************
//Measured thickness of nuts
nutThickness = 6.731;
//Width of nuts- measured corner to corner
nutWidth = 14.75;

//**********************************************************************
//Bolt Dimensions
//**********************************************************************
//Thickness of Bolt Head
boltHeadThickness = 5.08;
//Tolerance of bolt head
boltHeadTolerance = 0.1;
//Length of Bolt
boltLength = 38.1;
//If Hex bolt- corner to corner distance of hex. If Cap Head- diameter of bolt head
boltHeadWidth = 14.75;
//Diameter of bolt
boltDiameter = 7.9375;
//Add tolerance to bolt diameter to oversize slightly
boltDiameterTolerance = 0.1;
boltType = 1; //[1: Hex Bolt, 2:Cap Head]

//**********************************************************************
//Handle Dimensions
//**********************************************************************

//Thickness of Handle
handleThickness = 10;
//Maximum Width of Handle;
handleMaxWidth = 20;
//Length of Handle
handleLength = 50;
//Taper Angle of handle
handleTaper = 85;

handleMinWidth = handleLength / tan(handleTaper);

//**********************************************************************
//Filament Straightener Body Dimensions
//**********************************************************************

//Width of filament guide slot
filamentGuideWidth = 10;
//Width of body
bodyWidth = 50;
//Length of Body
bodyLength = 70;
//Filament guide slot should be same length as body
filamentGuideLength = bodyLength;
//Total height of body
bodyHeight = 17.0;

//Mount tab option
mountTab = 1; //[0:No Mounting Tabs, 1:Mounting Tabs]
//Width of Mounting Tabs
tabWidth = 15;
//Thickness of Mounting Tabs
tabThickness = 6.0;
//Diameter of mounting screw for mounting tabs
tabScrewDiameter = 6.0;
//Length of slot for movable bearing
boltSlotLength = 25;
//Length of bearing guide slot
bearingGuideLength = 30;


module Bearing()
{
    difference(){
    cylinder(r = bearingOD*0.5, h = bearingThickness, center = true, $fn = 100);
    
    cylinder(r = bearingID*0.5, h = bearingThickness, center = true, $fn = 100);
    }
    
}

module Nut()
{
    difference(){
    cylinder(r = nutWidth*0.5, h = nutThickness, center = true, $fn = 6);
    
    cylinder(r = boltDiameter*0.5, h = nutThickness, center = true, $fn = 100);
    }
    
}

module Bolt()
{
    union(){
    if (boltType == 1){
    cylinder(r=boltHeadWidth*0.5, h = boltHeadThickness+boltHeadTolerance , center = true, $fn = 6);
    }
    
    if (boltType == 2){
    cylinder(r=boltHeadWidth*0.5, h = boltHeadThickness+boltHeadTolerance , center = true, $fn = 100);
    }
    
    translate([0,0,boltLength*0.5+boltHeadThickness*0.5]){
    cylinder(r=boltDiameter*0.5+boltDiameterTolerance*0.5, h = boltLength, center = true, $fn = 100);
    }
    }  
}

module Handle()
{
    
    difference()
    {
    union(){
    cylinder(r=bearingOD*0.5, h = handleThickness, center = true, $fn = 100);
    
        
    translate([0,-bearingOD*0.5+bearingID*0.5, 0]){    
    linear_extrude(height = handleThickness, center = true)
    {
        polygon(points = [[-handleMaxWidth*0.5, -handleLength], [handleMaxWidth*0.5, -handleLength], [handleMinWidth, 0], [-handleMinWidth,0]]);
   
    }
    }
    }
    cylinder(r=nutWidth*0.5, h = handleThickness+0.1, center = true, $fn =6);
  
    }
    
    
}


module FilamentStraightenerBody()
{
   difference(){ 
   cube(size = [bodyWidth, bodyLength, bodyHeight], center = true); 
       
   translate([bearingOD*0.5+1,bearingOD*0.5+1,bodyHeight*0.5-bearingThickness*0.5]){ 
   cylinder(r= bearingOD*0.5+bearingODTolearnace*0.5, h = bearingThickness, center = true, $fn=100); 
   }
   
   translate([bearingOD*0.5+1,-bearingOD*0.5-1,bodyHeight*0.5-bearingThickness*0.5]){ 
   cylinder(r= bearingOD*0.5+bearingODTolearnace*0.5, h = bearingThickness, center = true, $fn=100); 
   }
   
   translate([-bearingGuideLength*0.5,0,bodyHeight*0.5-bearingThickness*0.5]){
   cube(size = [bearingGuideLength, bearingOD+bearingODTolearnace*0.5, bearingThickness],center = true);
   }
   
   
   //Slot for filament
   translate([0,0,bodyHeight*0.5-bearingThickness*0.5]){
   cube(size = [filamentGuideWidth, filamentGuideLength, bearingThickness],center = true);
   }
   
      
   //add bolt holes
   translate([bearingOD*0.5+1,bearingOD*0.5+1,-bodyHeight*0.5+boltHeadThickness*0.5]){
   Bolt();
   }
   
   translate([bearingOD*0.5+1,-bearingOD*0.5-1,-bodyHeight*0.5+boltHeadThickness*0.5]){
   Bolt();
   }
   //add movable bolt slot
   translate([-boltSlotLength *0.5+5, 0, 0]){
   cube(size = [boltSlotLength ,boltDiameter, bodyHeight], center = true);
   }
   
   translate([-boltSlotLength *0.5+5, 0, -bodyHeight*0.5+boltHeadThickness*0.5]){
   cube(size = [boltSlotLength , boltHeadWidth, boltHeadThickness+boltHeadTolerance], center = true);
   }
   
   }
   
   if (mountTab == 1)
   {
       
       translate([0,bodyLength*0.5+tabWidth*0.5,-bodyHeight*0.5+tabThickness*0.5]){
           
       difference(){    
       cube(size = [bodyWidth, tabWidth, tabThickness], center = true);
           
           cylinder(r=tabScrewDiameter*0.5, h = tabThickness, center = true, $fn=100);
       } 
       }
       
       translate([0,-bodyLength*0.5-tabWidth*0.5,-bodyHeight*0.5+tabThickness*0.5]){
       
       difference(){    
       cube(size = [bodyWidth, tabWidth, tabThickness], center = true);
           
           
           
           cylinder(r=tabScrewDiameter*0.5, h = tabThickness, center = true,$fn=100);
           
       }
       }
   }
   
   
   
}


module FilamentStraightenerAssembly()
{
    FilamentStraightenerBody();
    
    translate([bearingOD*0.5+1,bearingOD*0.5+1,bodyHeight*0.5-bearingThickness*0.5])
    {    
    color("red")    
    Bearing();
    }
    
    translate([bearingOD*0.5+1,-bearingOD*0.5-1,bodyHeight*0.5-bearingThickness*0.5])
    {    
    color("red")    
    Bearing();
    }
    
    translate([-10,0,bodyHeight*0.5-bearingThickness*0.5])
    {    
    color("red")    
    Bearing();
    }
    
    translate([-10,0,-bodyHeight*0.5+boltHeadThickness*0.5])
    {
    color("green")    
    Bolt();
    }

    translate([bearingOD*0.5+1,bearingOD*0.5+1,bodyHeight*0.5+bearingThickness*0.5]){
    Nut();
    }
    
    translate([bearingOD*0.5+1,-bearingOD*0.5-1,bodyHeight*0.5+bearingThickness*0.5]){
    Nut();
    }
    
    translate([-10,0,bodyHeight*0.5+bearingThickness*0.5]){
    Nut();
    }
    translate([-10,0,bodyHeight*0.5+bearingThickness*0.5+nutThickness*0.5]){
    Handle();
    }
    
    
    translate([bearingOD*0.5+1,bearingOD*0.5+1,-bodyHeight*0.5+boltHeadThickness*0.5])
    {
    color("green")    
    Bolt();
    }
    
    translate([bearingOD*0.5+1,-bearingOD*0.5-1,-bodyHeight*0.5+boltHeadThickness*0.5])
    {
    color("green")    
    Bolt();
    }
}

if (partSelect == 1)
{
    FilamentStraightenerAssembly();
}

if (partSelect == 2)
{
    FilamentStraightenerBody();
}
if (partSelect == 3)
{
    Handle();
}
if (partSelect == 4)
{
    Bearing();   
}

if (partSelect == 5)
{
    Bolt();
}
if (partSelect == 6)
{
    Nut();
}