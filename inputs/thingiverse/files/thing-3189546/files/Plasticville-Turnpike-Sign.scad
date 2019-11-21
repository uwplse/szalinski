//
//  Customizable Plasticville Turnpike Sign.scad
//  Mark DiVecchio
//  October 2018  V2.0
//  Original development using OpenSCAD 2017.01.20
//
// This SCAD script is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
/*
My web page: http://www.silogic.com/trains/layout.html
*/
// http://www.silogic.com/trains/layout.html
//
$fn=128 * 1;
//
// CUSTOMIZING
// New Interchange Name
INT = "BEAVER   VALLEY   INTERCHANGE";
// New Interchange Name Font (On Line Fonts: fonts.google.com)
INTFont = "Bungee";
// Letter spacing in Interchange Name
INTSpacing = 1.0;
// New Turnpike Name
Pike = "PENNSYLVANIA  TURNPIKE";
// Turnpike Name Font (On Line Fonts: fonts.google.com)
PikeFont = "Arial";
// Letter spacing in Turnpike Name
TPSpacing = 1.1;
// Width of base of sign 6 11/16" (enter in mm)
Width = (6 + 11/16) * 25.4;
// Height of base of sign 0.0875"(enter in mm)
Height = (0.0875) * 25.4;
// Thickness of sign 0.1" (enter in mm)
ThicknessINTLetters = (0.1) * 25.4;
// Spacing to center horizontal brace (enter in mm)
BraceOffset = (0.2665 - 0.08) * 25.4;
// Height of bottom portion of sign (enter in mm)
BottomHeight = (1.035) * 25.4;
// Height of top horizonal Beam (enter in mm)
TopBeamHeight = (0.2) * 25.4;
// Spacing to top horizontal Beam (enter in mm)
TopBeamOffset = (BottomHeight - TopBeamHeight - 1.75);
// Left Center Bar Offset
LCBarOffset = (Height + (1.91 * 25.4));
// Right Center Bar Offset
RCBarOffset = (Width - LCBarOffset - Height);
// Width of top hat
TopWidth = (7 + 11/16) * 25.4;
// Height of top hat
TopHeight = (0.0685) * 25.4;
// Thickness of top hat
TopThickness = (0.15) * 25.4;

//
// Width of turnpike name portion of sign (enter in mm)
WidthName = 90.04;
// Height of turnpike portion of sign (enter in mm)
HeightName = 6.45;

// Thickness of Letters of the turnpike portion of sign (enter in mm)
ThicknessTPLetters = (0.11 * 25.4);
// Height of interchange Letters (enter in mm)
HeightINTLetters = 8.25;
// Width of interchange Letters (enter in mm)
WidthINTLetters = 6.41;
// Height of Turnpike Name letters(enter in mm)
HeightTPLetters = (0.2665 * 25.4);
// Width of Turnpike Name Letters (enter in mm)
WidthTPLetters = 3.5;

print_part();

  /////////////
 // Modules //
/////////////
module print_part() {
    sign();
}
module sign () {
    // right Riser
  color("blue") translate([Width - Height - 0.5, 0.5, 0])  
    cube([Height, BottomHeight - Height, ThicknessINTLetters - 0.5]);
    // left Riser
  color("blue") translate([0, 0.5, 0])  
    cube([Height, BottomHeight - Height, ThicknessINTLetters - 0.5]);
    // left center Riser
  color("blue") translate([LCBarOffset, BraceOffset + Height, 0])  
    cube([Height, BottomHeight - BraceOffset - Height - Height + 0.5, ThicknessINTLetters - 0.5]);    
    // right center Riser
  color("blue") translate([RCBarOffset, BraceOffset + Height, 0])  
    cube([Height, BottomHeight - BraceOffset - Height - Height + 0.5, ThicknessINTLetters - 0.5]); 
 
  // Top Hat
  color("blue")
    translate([(TopWidth - Width)/-2, BottomHeight, 0])
    rotate([90, 0, 0])
    linear_extrude(TopHeight) {
    offset(r = 0.5) {  
    polygon(points=[
        [0 + 0.5,0 + 0.5], 
        [0 + 0.5, TopThickness - 0.5],
        [TopWidth - 1,TopThickness - 0.5],
        [TopWidth - 1, 0 + 0.5]    
        ]);   
        }
    }
  // Bottom Beam  
  // Base (Width * Height * Thickness) with a fillet
  color("blue")
    linear_extrude(ThicknessINTLetters - 0.5) {
    offset(r = 0.5) {  
    polygon(points=[
        [0 + 0.5,0 + 0.5], 
        [0 + 0.5, Height - 0.5],
        [Width - 1,Height - 0.5],
        [Width - 1, 0 + 0.5]    
        ]);   
        }
    }
    // Middle Beam
    // Base (Width * Height * Thickness) with a fillet and translate
  color("blue")
    translate([0, BraceOffset + Height, 0])
    linear_extrude(ThicknessINTLetters - 0.5) {
    offset(r = 0.5) {  
    polygon(points=[
        [0 + 0.5,0 + 0.5], 
        [0 + 0.5, Height - 0.5],
        [Width - 1,Height - 0.5],
        [Width - 1, 0 + 0.5]    
        ]);   
        }
    } 
  // Top Beam
  // Base (Width * TopBeamHeight * Thickness) with a fillet and translate
  color("blue")
    translate([0, TopBeamOffset, 0])
    linear_extrude(ThicknessINTLetters - 0.5) {
    offset(r = 0.5) {  
    polygon(points=[
        [0 + 0.5,0 + 0.5], 
        [0 + 0.5, TopBeamHeight - 0.5],
        [Width - 1,TopBeamHeight - 0.5],
        [Width - 1, 0 + 0.5]    
        ]);   
        }
    } 
    
  // Name of Interchange (letters are HeightINTLetters x WidthINTLetters)
  color("blue")
        translate([Width/2, BottomHeight, 0])
        linear_extrude(ThicknessINTLetters)
        text(INT, font=INTFont, size=HeightINTLetters, spacing=INTSpacing, halign="center"); 
    
  // Name of Turnpike (blue) (letters are HeightTPLetters x WidthTPLetters)
   color("white")
        translate([Width/2, Height/2, 0])
        linear_extrude(ThicknessTPLetters)
        text(Pike, font=str(PikeFont, ":style=Bold"), size=HeightTPLetters, spacing=TPSpacing, halign="center"); 
}