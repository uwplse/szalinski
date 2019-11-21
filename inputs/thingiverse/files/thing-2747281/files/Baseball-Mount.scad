//*******************************************************************************
// PARAMETRIC SIGNED BALL MOUNT
//------------------------
// Written by Mark C. 2017
// Built using OpenSCAD 2015.03-2
// V1 : Released 
// 
//*******************************************************************************
//-------------------------------------------------------------------------------
//                             Description
//-------------------------------------------------------------------------------
//Type...: Utility Part
//Notes..: Parametric Signed Ball Mount
//Material...: PLA/ABS

//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------

// Ball Diameters // 
// Tennis Ball = 68mm
// Soccer Ball = 220mm
// Baseball = 74mm
// Basketball = 242mm
// Golf Ball = 42mm
// American Football = 50mm (unverified)
// Australian Football = 50mm (unverified)
// Snooker Ball = 52mm
Ball_Diameter = 68 ;
// Mount Hieght
Hieght=30;
// Overall Length of Mount Front On
Length = 50;
// Overall Depth of Mount Side On
Depth = 30;
// Top Depression Diameter to suit what looks good
Top_Diameter = 15;
// Mesh Smoothing Factor
Smoothing_Factor = 100;

$fn=Smoothing_Factor;

//-------------------------------------------------------------------------------
//                             MAIN CODE
//-------------------------------------------------------------------------------
 
intersection(){
  difference(){
 cylinder(h=Hieght, d1=Length, d2=Top_Diameter, center=true);
 #translate([0,0,Hieght]) sphere(d=68);
 }
 cube([Length,Depth,Length] , center=true);
 }
 //-------------------------------------------------------------------------------