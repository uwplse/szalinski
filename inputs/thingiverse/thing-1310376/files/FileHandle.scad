// ************* Credits part *************
// "Parametric Tool Handle" 
// Programmed by Marcel Chabot - Feburary 2016
// Optimized for Customizer
//
//
//********************** License ******************
//**        "Parametric Tool Handle"             **
//**                  by Marcel Chabot           **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************

$fn=25;

// ************* Declaration part *************
//Handle diameter
diameter = 25;
//Handle height
height = 80;
//Number of indents
indents = 6;
//Depth of indents
indentDiameter = 6;
//Diameter of tool shaft
toolDiameter = 4.5;
//Include finger divot. It may cause Customizer to fail.
fingerDivot = "false";// [true,false]

difference(){
    
    Handle();
    Indents();
    
    translate([0,0,5])cylinder(height+5, d=toolDiameter, false);
}

module Handle(){
    hull(){
        sphere(d=diameter);
        translate([0,0,5])cylinder(height, d=diameter, false);
    }
}

module Indents(){
    for(i=[0:indents]){
        rotate((360*i)/indents){
            translate([diameter/2,0,5]){
                sphere(d=indentDiameter);
                translate([0,0,height-4])sphere(d=indentDiameter);
                cylinder(height-4, d=indentDiameter, false);
            }
        }
    }
    if(fingerDivot == "true"){
        translate([0,0,height-5]){
            minkowski(){
                difference(){
                    cylinder(1, d=diameter+10);
                    cylinder(1, d=diameter+1);
                }
                sphere(2);
            }
        }
    }
}