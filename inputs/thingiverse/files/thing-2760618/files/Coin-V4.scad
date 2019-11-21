//The letter to cut out in the middle of the coin
Letter="J";

//Font size, so that one letter fits on the coin
Fontsize=20;

//Font name
fontname="Arial"; 

//Diameter of the coin
dia=38;

//height of the coin
height=14;

//outer rim thickness of the coin
rand=2;

//connecting plastic in the middle of the coin
connectorthickness=2;

//accuracy of the coin
$fn=50;

/* [Hidden] */
//-------------------

sink_letter=height/2-connectorthickness/2;

/*
Customizable cash register coin

Version 3, January 2018
Written by MC Geisler (mcgenki at gmail dot com)

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/

module ring()
{
    difference()
    {
        cylinder(d=dia-2*rand, h=rand);
        translate([0,0,-.1])
            cylinder(d=dia-4*rand, h=rand);
    }
}

module Writeletter()
{    
    linear_extrude(height=sink_letter,convexity = 10)
        text(Letter,size=Fontsize,font=fontname,halign="center",valign="center");    
}

difference()
{
    cylinder(d=dia, h=height);
    
    translate([0,0,-.1])
        ring();
    
    translate([0,0,height-rand+.1])
        ring();
    
    translate([0,0,-.1])
        scale([-1,1,1])
            Writeletter();
    
    translate([0,0,height-sink_letter+.1])
        Writeletter();
        
}