//Title: Dop Stick Holder Adapter
//Author: Alex English - ProtoParadigm
//Date: 8/5/16
//License: Creative Commons - Share Alike - Attribution

//Notes: This is designed to be used with the dop stick holder for lapidary work. It will adapt smaller dop sticks to sit upright in a larger holder hole so that one holder with larger holes can be printed and accommodate a variety of dop stick sizes.

IN=25.4*1; //multiplication by 1 to prevent customizer from presenting this as a configurable value

//Units to use, inches or mm - Make sure to update all dimensional values if you change this
units = "i"; //["i":Inches, "m":Millimeters]

//Diameter of the holes in the holder
hole_diameter = 0.5;
od = units=="i" ? hole_diameter*IN : hole_diameter;

//Diameter of the dop stick
dop_diameter = 0.375;
id = units=="i" ? dop_diameter*IN : dop_diameter;

//Height of the adapter - must be less than the depth of the hole)
height = 0.5;
h = units=="i" ? height*IN : height;

difference()
{
    union()
    {
        cylinder(d=od-0.2,h=h, $fa=6, $fs=0.5);
        cylinder(d=od+4, h=3);
    }
    translate([0, 0, -1]) cylinder(d=id+0.5, h=h+2, $fa=6, $fs=0.5);
}