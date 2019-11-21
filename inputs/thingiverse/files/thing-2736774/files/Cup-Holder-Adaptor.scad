//*******************************************************************************
// Parametric Cupholder Adaptor
//------------------------------
// Written by Mark C. 2017
// Built using OpenSCAD 2015.03-2
// V1 : Initial Prototype
// V2 : Cleaned up Code and Variables + Added Taper Variable for Tapered Cupholders
// V3 : Added Pen Hole Option and fixed up solids rendering
//*******************************************************************************
//-------------------------------------------------------------------------------
//                             Description
//-------------------------------------------------------------------------------
//Type...: Utility Part
//Notes..: Use this to generate a car cupholder adaptor to fit larger holes. Has holes to suit
//redbull 250ml cans and standard cans and also a mobile phone holder slot
//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------

Cupholder_Overall_Dia = 100; // Overall adaptor diameter to suit car oversized cupholder
Cupholder_Hieght = 40; // Thickness of the Adaptor min is probably 20mm
Taper_Difference = 3; // Measurement in mm to reduce from the Overall Dia size as a taper for the adaptor if your cupholders taper down at the bottom
Fitting_Tolerance = 0.2; // Fitting tolerance to allow for snug but not tight fit

Cupholder_Hole_innerdim1 = 66 + Fitting_Tolerance; // 66mm = Standard Coke cans
Cupholder_Hole_innerdim2 = 53 + Fitting_Tolerance; // 53mm = Redbull cans

Phone_Slot_Width = 15; // Make sure to allow for cases and if you want a slight tilt on it.
Phone_Slot_Hieght = 15; // Phone Slot Hieght

Pen_Hole_Dia = 6 ; // Pen Hole that fits common pencils - 0 to disable

Smoothing_Factor = 60; // Mesh Smoothing Factor

$fn = Smoothing_Factor; // Setting Smoothing Factor

//-------------------------------------------------------------------------------
//                             MAIN CODE
//-------------------------------------------------------------------------------

difference(){
cylinder(Cupholder_Hieght , d1=Cupholder_Overall_Dia-Taper_Difference ,d2=Cupholder_Overall_Dia ); // Overall Part
translate([-Cupholder_Overall_Dia/2,-Phone_Slot_Width/2,Cupholder_Hieght-Phone_Slot_Hieght])
    cube([Cupholder_Overall_Dia, Phone_Slot_Width, Phone_Slot_Hieght+10]); // Phone Slot
cylinder(Cupholder_Hieght+10 , d=Cupholder_Hole_innerdim2 , d=Cupholder_Hole_innerdim2 , center=true ); // Smallest Inside Hole
translate([0,0,Cupholder_Hieght/2])
    cylinder(Cupholder_Hieght/2+10 , d=Cupholder_Hole_innerdim1 , d=Cupholder_Hole_innerdim1 ); // 2nd Smallest Inside Hole

if (Pen_Hole_Dia>0) // Check for Pen hole Option
translate([0,(Cupholder_Overall_Dia+Cupholder_Hole_innerdim1)/4,-5])
    cylinder(Cupholder_Hieght+10 , d1=Pen_Hole_Dia , d2=Pen_Hole_Dia+4 ); // Pen Hole with Taper
   else ;
};
