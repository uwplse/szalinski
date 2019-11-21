//*******************************************************************************
// PARAMETRIC CONTACT WASHER
//------------------------
// Written by Mark C. 2017
// Built using OpenSCAD 2015.03-2
// V1 : Released 
// https://www.bunnings.com.au/pinnacle-m8-washer-conic-contact-10-pack_p1100772
//*******************************************************************************
//-------------------------------------------------------------------------------
//                             Description
//-------------------------------------------------------------------------------
//Type...: Utility Part
//Notes..: Parametric Contact Washer with Grip
//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------

Overall_Diameter = 16;
Inner_Hole_Diameter = 8 ;
Fitting_Tolerance = 0.1;
Washer_Thickness = 2;
num_grips=35;

$fn = 30;

difference(){
   cylinder (h=Washer_Thickness , d1=Overall_Diameter , d2=Overall_Diameter);
     for (i=[1:num_grips])  {
        translate([0,0,Washer_Thickness]) rotate ([90,0,i*360/num_grips]) cylinder(d1=0.5,d2=1.5,h=20);
   translate([0,0,-5]) cylinder(h=50 , d=Inner_Hole_Diameter+Fitting_Tolerance);
    };
};

