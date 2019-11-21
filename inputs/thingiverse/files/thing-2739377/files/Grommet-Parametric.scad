//*******************************************************************************
// PARAMETRIC GROMMET 
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
//Notes..: Parametric Grommet
// Material ... : Print from TPU Flexible
//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------

// Overall Grommet Diameter
Overall_Diameter = 12;
// Thickness of the Grommet
Grommet_Thickness = 6;
// Cable Hole Diameter 
Cable_Hole_Diameter = 6 ;
// Cable Hole Depth : Default = 20 Set this to 0 if you want a blanked Grommet to drill out later
Cable_Hole_Depth = 20 ;
// Adjust the Depth of the outer cable hole chamfer Default is 3
Cable_Hole_Chamfer_Depth = 3;
// Specify the Chassis thickness you are plugging through - The Chassis Hole size = Cable_Hole_Diameter + 2
Chassis_Thickness = 2;
Chassis_Hole_Diameter = Cable_Hole_Diameter + 2;
// Adjust Fitting tolerance if needed to allow for 3D Printer drift
Fitting_Tolerance = 0.1;
// Smoothing Factor for a Higher Resolution Mesh Output
Smoothing_Factor = 80;

$fn = Smoothing_Factor;

//-------------------------------------------------------------------------------
//                             MAIN CODE
//-------------------------------------------------------------------------------
difference(){
   cylinder (h=Grommet_Thickness , d1=Overall_Diameter , d2=Overall_Diameter); // Overall Grommet
     
   translate([0,0,-5]) cylinder(h=Cable_Hole_Depth , d=Cable_Hole_Diameter+Fitting_Tolerance); // Cable Hole
    
    difference(){
     translate([0,0,Grommet_Thickness/2-Chassis_Thickness/2]) cylinder (h=Chassis_Thickness , d1=Overall_Diameter+5 , d2=Overall_Diameter+5); // Chassis Groove
    translate([0,0,-5]) cylinder(h=50 , d=Chassis_Hole_Diameter); // Chassis Groove Inner Wall
    }
    translate([0,0,Grommet_Thickness-5]) cylinder(h=20,d1=Cable_Hole_Chamfer_Depth,d2=20); // Outer Chamfer
};



