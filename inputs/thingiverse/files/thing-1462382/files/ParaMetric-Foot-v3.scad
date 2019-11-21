// Customizer Foot Designer
// Copyright (c) 2016 www.DIY3DTech.com
//
// REV 2.0 04/02/2016

// Standard Thingiverse Configurations:
// Range = [:] Slider
// Range = [,] Drop Down Box
// Range = None Text Box


// Start Parameters for for Customizer ----
// preview[view:south, tilt:top]

// of Foot (mm)
Height = 14; //[5:1:100]

// Diameter (mm)
Base = 55; //[10:1:100]

// Contact Diameter (mm)
Top = 50; //[5:1:100]

// (Count)
Sides = 60; //[4:1:100]

// Diameter (% of Contact Diameter)
Offset_Percent = 25; //[5:1:100]

//  (mm)
Offset_Thickness = 3; //[1:1:10]

// Diameter (mm)
Screw = 3.6; //[1:1:10]

// End Parameters for for Customizer  ----

// Start Module
Foot();

module Foot(){
difference() {
// Create Base
cylinder( Height, Base/2, Top/2,$fn=Sides, false);
    
// Create Offset Opening
translate([0,0,Offset_Thickness]){
cylinder( (Height+2), ((Top/2)*(Offset_Percent/100)), ((Top/2)*(Offset_Percent/100)),$fn=60, false);
    }
    
// Create Screw Opening   
translate([0,0,-1]){
cylinder( Height+5, Screw/2, Screw/2,$fn=60, false);
    }
}   
}


