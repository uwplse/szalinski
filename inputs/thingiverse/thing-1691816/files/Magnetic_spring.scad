// Custom magnetic spring
// By Magonegro JUL-2016
// Uses two cylindrical magnets placed in opposite magnetic orientation.
// Depending on the strength of the magnets the spring lenght may vary.
// Insert the magnets and top in the piston and holder and fix them with glue
// You have a working everlasting magnetic spring.

// Piston parameters
// Radius for the piston:
RADIUS_IN=5;
// Height of the piston:
HEIGHT_IN=15;
// Magnet height
MAGHEIGHT=3;
// Magnet radius
MAGRADIUS=3;
// Holder radius:
RADIUS_OUT=8;
// Holder height
HEIGHT_OUT=25;
// Holder base height
BASEHEIGHT_OUT=10;
// Resolution
FACETS=30;
// Tolerance (0.2mm typ)
TOLERANCE=0.2;

// Piston
translate([RADIUS_OUT+RADIUS_IN+2,0,0]) 
    {
    difference()
        {
        cylinder(r=RADIUS_IN,h=HEIGHT_IN,$fn=FACETS);
        translate([0,0,2]) cylinder(r=MAGRADIUS+TOLERANCE,h=HEIGHT_IN-2,$fn=FACETS);
        }
    }

// Part to fix the magnet to the piston
translate([RADIUS_OUT+2*RADIUS_IN+2+MAGRADIUS+2,0,0])
    {
    cylinder(r=MAGRADIUS,h=HEIGHT_IN-2-MAGHEIGHT,$fn=FACETS);
    }

// Holder
union()
{
    difference()
    {
        cylinder(r=RADIUS_OUT,h=HEIGHT_OUT,$fn=FACETS);
        cylinder(r=RADIUS_IN+TOLERANCE,h=HEIGHT_OUT,$fn=FACETS);
    }
    difference()
    {
    cylinder(r=RADIUS_OUT,h=BASEHEIGHT_OUT,$fn=FACETS);
    cylinder(r=MAGRADIUS+TOLERANCE,h=BASEHEIGHT_OUT-2,$fn=FACETS);
    }
}

// To fix the magnet to the holder
translate([-RADIUS_OUT-MAGRADIUS-2,0,0])
    {
    cylinder(r=MAGRADIUS,h=BASEHEIGHT_OUT-2-MAGHEIGHT,$fn=FACETS);
    }
