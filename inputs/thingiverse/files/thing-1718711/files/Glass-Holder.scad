/**
 * Author: Luis Chardon <luischardon@gmail.com>
 * Description: Prusa i3 Heated Bed Glass Holder
 * Date Modified: 8/13/2016
 */

/* [Heated Bed Properties] */
// Heated Bed PCB Board Thickness
BedThickness = 1.75; // [1:0.01:3]

/* [Glass Bed Properties] */
// Thickness of your glass bed
GlassThickness = 3; // [1:0.1:5]
// Width of your glass bed
GlassWidth = 200; // [180:200]
// Height of your glass bed
GlassHeight = 214; // [200:214]

/* [Clip Properties] */
// Top and bottom clip thickness
ClipThickness = 1; // [0.5:0.1:3]
// How long the clip extends to cover the top of the glass bed
ClipWidth = 7; // [1:15]
// How long the clip extends along the perimeter of the bed
ClipLength = 16; // [5:50]
// Clip outer wall width
ClipOuterWallWidth = 2; // [1:5]

/* [Bed Preview] */
// Preview clips on the bed and glass
ShowPreview = "false"; // [false,true]

/* [Hidden] */
$fn=32;
BedWidthAndHeight = 214;
Hole = 20;
TotalHeight = ClipThickness + BedThickness + GlassThickness + ClipThickness;
SpacerWidth = (BedWidthAndHeight - GlassWidth) / 2; 

module HoleLL()
{
    translate([2.5, 2.5, -Hole / 2]) cylinder(d = 3, h = Hole);
};
module HoleLR()
{
    translate([BedWidthAndHeight - 2.5, 2.5, -Hole / 2]) cylinder(d = 3, h = Hole);
};
module HoleTL()
{
    translate([2.5, BedWidthAndHeight - 2.5, -Hole / 2]) cylinder(d = 3, h = Hole);
};
module HoleTR()
{
    translate([BedWidthAndHeight - 2.5, BedWidthAndHeight - 2.5, -Hole / 2]) cylinder (d = 3, h = Hole);
};

module HeatedBed()
{
    difference(){
        color("red") cube([BedWidthAndHeight, BedWidthAndHeight, BedThickness]);
        HoleLL();
        HoleLR();
        HoleTL();
        HoleTR();
    }
}

module Glass()
{
    translate([SpacerWidth, (BedWidthAndHeight - GlassHeight) / 2, BedThickness]) color([1, 1, 1, 0.5]) cube([GlassWidth, GlassHeight, GlassThickness]);
}

module Holder()
{
    color("blue")
    {
        // Right clip
        difference()
        {
            translate([SpacerWidth, -ClipOuterWallWidth, -ClipThickness]) cube([ClipLength, ClipOuterWallWidth + ClipWidth, TotalHeight]);
            HeatedBed();
            Glass();
        }

        // Top Clip
        difference()
        {
            translate([-ClipOuterWallWidth, SpacerWidth, -ClipThickness]) cube([ClipOuterWallWidth + SpacerWidth, ClipLength, TotalHeight]);
            HeatedBed();
            Glass();
        }

        // Screw Spacer
        difference()
        {
            translate([2.5, 2.5, BedThickness]) cylinder(d = 7, h = 1);
            HoleLL();
        }
        
        // Screw Hole
        difference()
        {
            translate([-ClipOuterWallWidth, -ClipOuterWallWidth, -ClipThickness]) cube([SpacerWidth + ClipOuterWallWidth, SpacerWidth + ClipOuterWallWidth, TotalHeight]);
            // Screw body hole
            HoleLL();
            // Screw head hole
            translate([2.5, 2.5, BedThickness]) cylinder(d = 7, h = GlassThickness + ClipThickness + 0.1);
            // Spring bottom hole
            translate([2.5, 2.5, -ClipThickness - 0.1]) cylinder(d = 7, h = ClipThickness + 0.1);
            HeatedBed();
            Glass();
        }
        
    }
}

module Preview()
{
    Holder();
    translate([BedWidthAndHeight, BedWidthAndHeight, 0]) rotate(a=[0, 0, 180]) Holder();
    translate([BedWidthAndHeight, 0, 0]) mirror([1,0,0]) Holder();
    translate([0, BedWidthAndHeight, 0]) mirror([1,0,0]) rotate(a=[0, 0, 180]) Holder();
    HeatedBed();
    Glass();
}

module Print()
{
    spacex = 50;
    spacey = 50;
    rotation = 270;
    rotate(a=[0, rotation, 90]) Holder();
    translate([0, spacey, 0]) rotate(a=[0, rotation, 90]) Holder();
    translate([spacex, 0, 0]) mirror([1, 0, 0]) rotate(a=[0, rotation, 90]) Holder();
    translate([spacex, spacey, 0]) mirror([1, 0, 0]) rotate(a=[0, rotation, 90]) Holder();
}

if(ShowPreview == "true")
{
    Preview();
}
else
{
    Print();
}