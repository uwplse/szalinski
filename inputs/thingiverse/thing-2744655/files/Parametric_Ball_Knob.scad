//*******************************************************************************
// PARAMETRIC BALL KNOB 
//------------------------
// Written by Mark C. 2017
// Built using OpenSCAD 2015.03-2
// V1 : Released 
// V2 : Added Functionality to swap between a Hex Nut + Shaft
// 
//*******************************************************************************
//-------------------------------------------------------------------------------
//                             Description
//-------------------------------------------------------------------------------
//Type...: Utility Part
//Notes..: Parametric Round Knob
//Material...: PLA/ABS
//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------

// Knob Diameter
Diameter = 30;
// Flat Spot Distance from edge of knob towards center - ie 5mm
Flat_Spot_Hieght = 3;
// Hex Nut Thickness
Hex_Nut_Thickness = 3;
// Hex Nut Diameter - Set to 0 to turn off and enable brass boss threaded insert
Hex_Nut_Diameter = 0;
// Shaft internal hole width
Shaft_Width = 6;
// Shaft Depth
Shaft_Depth = 10;
// Shaft internal hole
Shaft_Diameter = 6;
// Shaft Flat position - as a distance in from shaft outside in mm
Shaft_FlatSize = 2;
// Global Fitting Tolerance
Fitting_Tolerance = 0.1;
// Mesh Smoothing Factor
Smoothing_Factor = 100;

$fn=Smoothing_Factor;
//-------------------------------------------------------------------------------
//                             MAIN CODE
//-------------------------------------------------------------------------------

difference(){
body();
hexhole();
};

//-------------------------------------------------------------------------------
//                             MODULE CODE
//-------------------------------------------------------------------------------

// Main Body
module body(){
 difference(){ 
     translate ([0,0,Diameter/2]) sphere(d=Diameter);
     translate ([0,0,0]) cylinder(h=Flat_Spot_Hieght,d=Diameter+2);
    } 
}  

// Hex Nut Hole + Shaft
module hexhole(){
    translate([0,0,Flat_Spot_Hieght-1])
    cylinder(h=Hex_Nut_Thickness+1,d=Hex_Nut_Diameter+Fitting_Tolerance,$fn=6);
    
    // Shaft Hole
    intersection(){
    translate([0,0,0])
    cylinder(h=Shaft_Depth+Flat_Spot_Hieght,d=Shaft_Diameter+Fitting_Tolerance);
    }
  
}





