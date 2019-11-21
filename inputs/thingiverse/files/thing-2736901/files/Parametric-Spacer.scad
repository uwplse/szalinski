
//*******************************************************************************
// PARAMETRIC SPACER
//------------------------
// Written by Mark C. 2018
// Built using OpenSCAD 2015.03-2
// V1 : Released - added optioned nut recess option
// V2 : Fixed up Error in $fn parameter
// V3 : Fixed up radius/diameter bugs in variables - added more notes and uploaded metric nut reference chart to thingyverse
//*******************************************************************************
//-------------------------------------------------------------------------------
//                             Description
//-------------------------------------------------------------------------------
//Type...: Utility Part
//Notes..: Use this to generate spacers for projects all dimensions are 
//         configurable you can also enable a nut recess if required.Tolerances can be adjusted 
//              for fitment.
//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------
OD = 12; // Outer Diameter
OD_tolerance = 0; // Outer Diameter Tolerance
ID = 6; // Inner Through Hole Diameter
ID_tolerance = 0; // Inner Through Hole Tolerance allowance
Thickness = 10; // Spacer Thickness
Qty = 4; // Qty Required

// Optional Nut Recess
Nut_Thickness = 10; // Set to a value to enable Nut Recess
Nut_OD = 10; // Nut Outside size // Metric Nuts are usually width = 1.6 x Hole Diameter ie M6 nut = 9.6mm wide
Nut_Tolerance = 0.1 ; // Tolerance for Fitting

// Smoothing Factor : Disable = 0 | Rough = 30 | Smooth = 50 | UltraSmooth = 80 |
Smoothing_Factor = 100;
$fn = Smoothing_Factor;

//-------------------------------------------------------------------------------
//                             MAIN CODE
//-------------------------------------------------------------------------------
//
// Qty Generator
for (i=[1:Qty])
   translate([i*(2.5*OD),0,0])
     spacer();

// Module
module spacer()
{
difference() {
cylinder(Thickness,(OD+OD_tolerance)/2,(OD+OD_tolerance)/2, center=true);
cylinder(Thickness*2,(ID+ID_tolerance)/2,(ID+ID_tolerance)/2, center=true);
    color([0,1,0])
    translate([0,0,Thickness/2])
    cylinder($fn = 6,Nut_Thickness,(Nut_OD+Nut_Tolerance)/2,(Nut_OD+Nut_Tolerance)/2, center=true);
    
    
};
}