/*
Bed Corner Post Holder

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: http://paul-houghton.com/

Creative Commons Attribution ShareAlike License
https://creativecommons.org/licenses/by-sa/4.0/legalcode
*/


/* [Post Holder Options] */
// Width of the holder (inside dimension)
Width = 50;

// Wall thickness (reduces Width to create the holder)
Wall_Thickness = 5;
w2 = Width - 2*Wall_Thickness;

// Height to the support level
Height = 110;

// Additional height above the support level
Wall_Height = 40;
h2 = Height + Wall_Height;

difference() {
    cube([Width,Width,h2]);
    translate([Wall_Thickness, Wall_Thickness, Height])
        cube([w2,w2,Height]);
};