// ======================================================
// HerbalLabelCustomizer 0.4
// -------------------------
// Author: uit
// 
// Thingiverse Description:
// ------------------------
// Thing Name : Herbal Label Customizer
// Description: never again lose track of your seedlings. Design and print labels for your herbs. Customize dimensions, font and text of your labels. For better contrast of your label, change your filament mid-print. 
// Changelog
// ---------
// 20150316 - 0.4 - preview definition
// 20150316 - 0.3 - optional Angle
// 20150316 - 0.2 - implement write.scad
// 20150316 - 0.1 - initial Version for Customizer
// ======================================================
// Resources: http://customizer.makerbot.com/docs
// Customizer Custom Settings:
// ----------------------------
// preview[view:south,tilt:top]
// ======================================================


// for Makerbot Customizer, which uses an old Version (2013.06) of OpenSCAD
use <write/Write.scad>

/* [Text] */
// Your Text
Text_Label="Rosemary";
// Choose your Font
Text_Font      =   "orbitron.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf,braille.dxf]
// [mm]
Text_FontSize  = 7;
// Height of the text in Z-Dimension [mm]
Text_Thickness    = 0.4; 

/* [Dimensions] */
// [mm] 
Width_Label      =   60;
// [mm] 
Height_Label     =   12;
// [mm]
StickWidth      =   8;
// [mm]
StickHeight     =   60;
// [mm] (without the Text) in Z-Dimension
Thickness_Label =   0.6;
// ignore variable values
StickBaseHeight =   Thickness_Label;

/* [Optional] */
Angle_Stick=30; //[15:45]


module BuildTextCompatible(text){
    color("Yellow")
    union() write(text, h=Text_FontSize, t=Text_Thickness, font=Text_Font, center=true);
} // module BuildTextCompatible

module RoundedRectangleFilled(Width_Label,Height_Label,Thickness_Label){
    $fn=128;    
    union(){
        minkowski(){
            cube([Width_Label,Height_Label,Thickness_Label/2],center=true);
            cylinder(r=2,h=Thickness_Label/2,center=true);
            }
    } // end union
} // end module


module RoundedRectangleFrame(Width_Label,Height_Label,Thickness_Label,ThicknessBorder){
    $fn=128;
    union() difference(){
       RoundedRectangleFilled(Width_Label,Height_Label,Thickness_Label);
       RoundedRectangleFilled(Width_Label-ThicknessBorder,Height_Label-ThicknessBorder,Thickness_Label);
   } // end difference 
} // end module

module BasePlate(){
    color("Blue")    
    union() RoundedRectangleFilled(Width_Label,Height_Label,Thickness_Label);
} // end module BasePlate

module Stick(){
    color("Blue")    
    difference(){
        union(){
            translate([0,-StickHeight/2-Height_Label/2-2,0])
            cube(size=[StickWidth,StickHeight,Thickness_Label], center = true);
        }// end union
       
        // AngleCut
        color("Red") translate([0,-StickHeight-Height_Label/2-2,-10]) rotate(0-Angle_Stick) cube([20,20,20]);
        color("Red") translate([0,-StickHeight-Height_Label/2-2,-10]) rotate(-270+Angle_Stick) cube([20,20,20]);
    }//end difference
} // end module stick

module Label(text){
    union(){
        BasePlate();
        Stick();
        translate([0,0,Thickness_Label/2]) RoundedRectangleFrame(Width_Label-1,Height_Label-1,Thickness_Label,1);
        translate([0,0,Thickness_Label/2]) BuildTextCompatible(text);
    } // end union
} // end Label(text)

Label(Text_Label);
 
