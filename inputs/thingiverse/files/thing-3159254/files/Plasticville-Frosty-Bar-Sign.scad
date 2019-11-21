//
//  Customizable Plasticville Frosty Bar Sign.scad
//  Mark DiVecchio
//  July 2018  V1.0
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
// New Frosty Bar Name
Name = "DAIRY QUEEN";
// New Name Font (On Line Fonts: fonts.google.com)
NameFont = "Pump Demi Bold LET";
// Letter spacing in Bar Name
NameSpacing = 1.1;
// New Town Name
Town = "ALIQUIPPA";
// Town Name Font (On Line Fonts: fonts.google.com)
TownFont = "Arial";
// Letter spacing in Town Name
TownSpacing = 1.3;
// Width of base of sign (enter in mm)
Width = 114;
// Height of base of sign (enter in mm)
Height = 3.14;
// Width of town name portion of sign (enter in mm)
WidthName = 90.04;
// Height of name portion of sign (enter in mm)
HeightName = 6.45;
// Thickness of sign  (enter in mm)
Thickness = 1.5;
// Thickness of Letters of the name portion of sign (enter in mm)
ThicknessNameLetters = 2.29;
// Height of Frosty Bar Letters (enter in mm)
HeightFBLetters = 8.25;
// Width of Frosty Bar Letters (enter in mm)
WidthFBLetters = 6.41;
// Height of Town Name letters (enter in mm)
HeightTNLetters = 3.77;
// Width of Town Name Letters  (enter in mm)
WidthTNLetters = 4.03;

print_part();

  /////////////
 // Modules //
/////////////
module print_part() {
    sign();
}
module sign () {
  // Base (Width * Height x Thickness)
  color("peachpuff")
    linear_extrude(Thickness) {
    offset(r = 0.5) {  
    polygon(points=[
        [0 + 0.5,0 + 0.5], 
        [0 + 0.5, Height - 0.5],
        [Width - 1,Height - 0.5],
        [Width - 1, 0 + 0.5]    
        ]);   
        }
    }  
  // Middle (WidthName x HeightName x Thickness)
  color("peachpuff")
    linear_extrude(Thickness) {
    wval = 4;
    offset(r = wval/2) {  
    polygon(points=[
        [((Width - WidthName)/2) + (wval/2),0 + (wval/2)], 
        [((Width - WidthName)/2) + (wval/2), Height + HeightName - (wval/2)],
        [(WidthName + (Width - WidthName)/2) - (wval/2),Height + HeightName - (wval/2)],
        [(WidthName + (Width - WidthName)/2) - (wval/2), 0 + (wval/2)]    
        ]);   
        }
    }  

  // inner fillet - left
  color("peachpuff")
    difference() {
        translate([((Width - WidthName)/2)-2,Height - 2,0])
        cube(size = [4, 4, Thickness], center = false);
        translate([((Width - WidthName)/2)-2,Height + 2,-0.5])
        cylinder(h = Thickness * 2, r=2, center = false);   
    }

  // inner fillet - right
  color("peachpuff")
    difference() {
        translate([(WidthName + (Width - WidthName)/2)-2,Height - 2,0])
        cube(size = [4, 4, Thickness], center = false);
        translate([(WidthName + (Width - WidthName)/2)+2,Height + 2, -0.5])
        cylinder(h = Thickness * 2, r=2, center = false);   
    }           

  // Name of Frosty Bar (letters are HeightFBLetters x WidthFBLetters)
  color("peachpuff")
        translate([Width/2, Height + HeightName, 0])
        linear_extrude(Thickness)
        text(Name, font=NameFont, size=HeightFBLetters, spacing=NameSpacing, halign="center"); 
    
  // Name of town (red) (letters are HeightTNLetters x WidthTNLetters)
   color("red")
        translate([Width/2, Height + ((HeightName - HeightTNLetters)/2), 0])
        linear_extrude(ThicknessNameLetters)
        text(Town, font=str(TownFont, ":style=Bold"), size=HeightTNLetters, spacing=TownSpacing, halign="center"); 
}