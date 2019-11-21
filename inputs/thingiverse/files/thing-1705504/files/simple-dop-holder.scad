//Title: Dop Stick Holder
//Author: Alex English - ProtoParadigm
//Date: 8/5/16
//License: Creative Commons - Share Alike - Attribution

//Notes: This is intnded to hold dop sticks used in lapidary work, and can be configured to use different size dop sticks, have different spacing between them, and different numbers of holes. It may have other applicatoins, particularly tool-holding in other fields.

IN=25.4*1; //multiplication by 1 to prevent customizer from presenting this as a configurable value

//Units to use, inches or mm - Make sure to update all dimensional values if you change this
units = "i"; //["i":Inches, "m":Millimeters]

//Diameter of the Dop sticks or other tools to be used
dop_diameter = 0.5;
dop_d = units=="i" ? dop_diameter*IN : dop_diameter;

//Center-to-center spacing of holes
hole_spacing = 1.5;
spacing = units=="i" ? hole_spacing*IN : hole_spacing;

//Number of rows of holes
rows=2;

//Number of columns of holes
cols=5;

//Height of the entire holder
height=1.5;
h = units=="i" ? height*IN : height;

//Depth of the holes
hole_depth=1;
depth = units=="i" ? hole_depth*IN : hole_depth;

//Turn the index ridge at the bottom of the holes on or off
use_index=1; //[1:On, 0:Off]

//Size of the ridge at the bottom - only used if the index is turned on
index_size=3; //[1:5]

difference()
{
    cube([rows*spacing,cols*spacing,h]);
    for(x=[0:rows-1]) for(y=[0:cols-1]) translate([x*spacing+spacing/2, y*spacing+spacing/2, h-depth]) cylinder(d=dop_d+0.25, h=depth+1, $fa=10, $fs=0.5);
}

if(use_index)
    for(x=[0:rows-1]) translate([spacing/2+spacing*x, 0, h-depth]) rotate([0, 45, 0]) translate([-index_size/2, 0, -index_size/2]) cube([index_size, cols*spacing, index_size]);