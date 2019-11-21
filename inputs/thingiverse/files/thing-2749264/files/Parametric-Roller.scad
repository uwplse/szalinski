//*******************************************************************************
// PARAMETRIC ROLLER
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
//Notes..: Parametric Roller 
//Material...: PLA/ABS
//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------
Overall_Length = 64 ;
Roller_Length = 32 ;
Roller_Outside_Diameter = 30 ;
Wall_Thickness = 3;
Shaft_Through_Hole_Diameter = 5 ;
Shaft_Diameter = 10 ;
Shaft_Secondary_Diameter = 12;
Shaft_Secondary_Step_From_End_Distance = 8;
Smoothing_Factor = 150;

$fn=Smoothing_Factor;
//-------------------------------------------------------------------------------
//                             MAIN CODE
//-------------------------------------------------------------------------------

difference(){
union(){

// Shaft
cylinder(h=Overall_Length-(Shaft_Secondary_Step_From_End_Distance*2),d=Shaft_Secondary_Diameter,center=true);
cylinder(h=Overall_Length,d=Shaft_Diameter,center=true);

//Roller
union(){
cylinder(h=Wall_Thickness*2,d=Roller_Outside_Diameter,center=true);
cube([Roller_Outside_Diameter-(Wall_Thickness/2),Wall_Thickness,Roller_Length],center=true);
// Supports
rotate(90) cube([Roller_Outside_Diameter-(Wall_Thickness/2),Wall_Thickness,Roller_Length],center=true);
// Main Roller
difference(){
cylinder(h=Roller_Length,d=Roller_Outside_Diameter,center=true);
cylinder(h=Roller_Length+10,d=Roller_Outside_Diameter-Wall_Thickness,center=true);
}
}
}
// Shaft Through Hole    
cylinder(h=Overall_Length+10,d=Shaft_Through_Hole_Diameter,center=true);
 }
 //-------------------------------------------------------------------------------