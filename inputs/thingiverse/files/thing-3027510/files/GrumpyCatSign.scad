//
// Customizable Sign for "Grumpy cat with a grumpy sign" by Filopat
//
// This part was designed 29 July 2018 by Joe McKeown. 
// It's available under the terms of the Creative Commons CC-BY-NC license 
// (https://creativecommons.org/licenses/by-nc/3.0/).
// 
// "Grumpy cat with a grumpy sign" by Filopat - https://www.thingiverse.com/Filopat/about
// Avaivailible on Thingiverse - https://www.thingiverse.com/thing:125485
// Licensed by CC-BY-NC
//
// History:
// V1.0 29 July 2018 First version

//Length of the sign's pole (default 80) 
Pole_Length=80;
// Width of the sign
Width=55;
// Height of the sign
Height=35;
// Height of text. (100% fills the sign, go smaller)
Text_Height_Percent=85; // [1:100]

Number_of_lines=2; // [1,2,3]
Line_1="Bite";
Line_2="me";
Line_3="";

/* [Hidden] */
TxtPct=Text_Height_Percent/100;
TextHeight=TxtPct*Height;
LineHeight=TextHeight/Number_of_lines;
TextBase=(Height-TextHeight)/2;
FontSize=LineHeight - (0.1*Height);
Lines=[ Line_1, Line_2, Line_3 ];

translate([0, Height/2, 1.25]) 
  cube([Width,Height,2.5],true);
translate([0,0,1.1])rotate([90,0,0])
  cylinder(d=2.2, h=Pole_Length, $fn=10);
  
for ( i=[0:Number_of_lines-1]){
  translate([0, TextBase + LineHeight/2 + (i * LineHeight), 2.5])
  color("red") linear_extrude(1.5)
    text(Lines[Number_of_lines-1-i], size=FontSize, valign="center", halign="center");
}