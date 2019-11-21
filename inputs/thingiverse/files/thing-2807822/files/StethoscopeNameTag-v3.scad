/*  StethescopeTag.scad is designed to auto-generate unique name tags that can be affixed to the stepthescope tubing.
    Copyright (C) 2018  by Patrick Skelley <skellep193@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/*
    Revisions:
    2.0 - Updated positions and sizes of the holes for the zip tie. Set font to bold.
    3.0 - Parameterized all of the dimensions. Added color rendering based on a 1.2 mm textZDepth
*/

// Requires the scad-utils library obtainable here https://github.com/OskarLinde/scad-utils
include <scad-utils/morphology.scad>

// Color parameters e.g. "black","red","white","blue" etc...
faceColor = "Yellow";
textColor = "Red";

// Parameters for tag body
tagX = 40;
tagY = 25;
tagZ = 4;
tagCornerRadius = 2;

// Parameters for text. Size is defaulted using the equation height = (3/8) * tagY
line1Text = "Mighty";
line2Text = "Mouse";
line1Scale = 0.8;
line2Scale= 0.8;
// The calculation can be overriden and a fixed value assigned by replacing the equautions below
line1Size = line1Scale * (0.35 * tagY);
line2Size = line2Scale * (0.35 * tagY);
fontStyle = "Arial:style=Bold";
textZDepth = 1.2;

// Parameters for the tag clip component
clipRadius = 4.75;

$fn=360;

// Generate and add or subtract each sub-component to the tag
module NameTag()
{
    
/* Removed: with user defined dimensions this would be restrictive
  if(len(line1Text) >=10 || len(line2Text)>=10){
     echo("Error - line character length exceeds maximum");
  }
*/ 
    
  difference(){
       union(){ 
        difference(){
            Body();
            Text();  
        };
        Clip();
       };
       ZipTieHoles();
  }
  
}

// Create the rectangular body
module Body(){
    
    union(){   
        translate([0,0,tagZ/2])
        color(faceColor)
        linear_extrude(height=tagZ/2,center=false)
        {
            rounding(r=tagCornerRadius)
            square(size=[tagX,tagY], center=false);
        };
        
        color(textColor)
        linear_extrude(height=tagZ/2,center=false)
        {
            rounding(r=tagCornerRadius)
            square(size=[tagX,tagY], center=false);
        };
    
    }
}

// Engrave the name in the text face
module Text(){
    
    color(textColor)
    union(){
        translate([tagX/2,(0.5625 * tagY),tagZ - textZDepth])
        linear_extrude(height=3, center=false)
        {
            text(line1Text,,font=fontStyle,size=line1Size,halign="center"); 
        };
        
        translate([tagX/2,(0.125 * tagY),tagZ - textZDepth])
        linear_extrude(height=3, center=false)
        {
            text(line2Text,font=fontStyle,size=line2Size,halign="center");
        }
    }
}

// Generate the clip component
module Clip(){

    // n = -(clipRadius + 3.5 - (tagZ/2))
    translate([tagX/2,tagY/2,-(clipRadius + 3.5 - (tagZ/2))])
    rotate(90,[0,1,0])
    color(textColor)
        difference(){
        cylinder(h=tagX/2,r=clipRadius + 3.5,center=true);
        cylinder(h=tagX/2,r=clipRadius,center=true);
        translate([clipRadius,0,0]) cube(size=[(1.5*clipRadius),(1.5*clipRadius),100],center=true);
        }
}

// Generate the holes for a zip tie 
module ZipTieHoles(){
    
    translate([tagX/2,0,0])
    color(textColor)
    cube(size=[3,100,2],center=true);
    
    translate([tagX/2,0,-(1.46 * (clipRadius + 3.5))])
    color(textColor)
    cube(size=[3,100,2],center=true); 
}

NameTag();
