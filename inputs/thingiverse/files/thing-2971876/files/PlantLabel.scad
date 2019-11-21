/* [Text] */
// Your Text
Text_Label="Rosemary";
// Choose Your Font
Style      =   "Arial"; //[Arial, Bookman Old Style, Brush Script MT, Calibri, Comic Sans MS, Courier New, Georgia, Lucida Bright, Segoe Script, Stencil, Tahoma, Times New Roman]
Label_Style = "Indent"; //[Cutout,OnTop,Indent]
// [mm]
Text_Font_Size  = 7;
// [mm]
Text_Thickness=0.5; 
Text_Spacing = 0.9;

/* [Dimensions] */
// [mm] 
Width_Label      =   60;//[20:80]
// [mm] 
Height_Label     =   12;//[10:30]
// [mm]
Thickness_Label =   1;//[1:5]
// [mm]
StickWidth      =   8;//[5:15]
// [mm]
StickHeight     =   150;//[50:200]
OneOrTwoSticks = "One"; //[One, Two]

// ignore variable values
StickBaseHeight =   Thickness_Label;

/* [Optional] */
Angle_Stick=30; //[15:45]


module BuildTextCompatible(){
    color("Yellow")
    text(Text_Label,  size=Text_Font_Size, font = Style, halign = "center", valign = "center", spacing = Text_Spacing);
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
        color("Red") translate([0,-StickHeight-Height_Label/2-2,-10]) rotate(0-Angle_Stick) cube([StickWidth+Angle_Stick,StickWidth+Angle_Stick,20]);
        color("Red") translate([0,-StickHeight-Height_Label/2-2,-10]) rotate(-270+Angle_Stick) cube([StickWidth+Angle_Stick,StickWidth+Angle_Stick,20]);
    }//end difference
} // end module stick

module StickTwo(){  
    color("Blue")
    union(){
        translate([Width_Label/4,0,0])    
        Stick();
        translate([-Width_Label/4,0,0])    
        Stick();
        }// end union
       
        
   // }//end difference
} // end module stick

module Label(){
    union(){
        BasePlate();
        if (OneOrTwoSticks == "One") {
    Stick();
} else if (OneOrTwoSticks == "Two") {
    StickTwo();
}
        linear_extrude(height=Text_Thickness+Thickness_Label/2)
        translate([0,0,Thickness_Label/2]) BuildTextCompatible();
    } // end union
} // end Label

module LabelWithBorder(){
    union(){
        BasePlate();
        if (OneOrTwoSticks == "One") {
    Stick();
} else if (OneOrTwoSticks == "Two") {
    StickTwo();
}
        translate([0,0,Thickness_Label/2+Text_Thickness/2]) RoundedRectangleFrame(Width_Label,Height_Label,Text_Thickness,1);
        linear_extrude(height=Text_Thickness+Thickness_Label/2)
        translate([0,0,Thickness_Label/2]) BuildTextCompatible();
    } // end union
} // end Label

module LabelCutout(){
difference(){
   union(){
        BasePlate();
        if (OneOrTwoSticks == "One") {
    Stick();
} else if (OneOrTwoSticks == "Two") {
    StickTwo();
}
    } // end union
    
    translate([0,0,Thickness_Label/2-Text_Thickness])
    linear_extrude(height = Text_Thickness)
    BuildTextCompatible();
    
} // end Label 
}

if (Label_Style == "Indent") {
    LabelWithBorder();
} else if (Label_Style == "OnTop") {
    Label();
} else if (Label_Style == "Cutout") {
    LabelCutout();
}

if (OneOrTwoSticks == "One") {
    Stick();
} else if (OneOrTwoSticks == "Two") {
    StickTwo();
}
