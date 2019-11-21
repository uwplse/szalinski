//
//  shaving_cream_can_bottom.scad
//
//  evilteach
//
//  06/10/2016
//
//
//         |                       |
//         |                       |           <- can diameter
//         |                       |
//         \                       /
//         /                       \           <- indentDiameter
//        |                         |
//        |                         |
//        |                         |
//        |-------------------------|          <- bottomLipDiameter
//
//
//  ABS print, speed 60/60, 1 shell, 5% fill, no raft or support structure
//  Just before it is finished printing, spray bottom sides of the 
//  can with car undercoating.  Place it into the finished print while
//  it is still on the print bed.  As the print cools, it will grip 
//  the can tightly.  The undercoating will keep water from getting between the
//  can and the printed bottom.
//

// very, very round so the can will fit snuggly
$fn = 720; 

// This is the lip at the bottom of the can
bottomLipDiameter = 70.00;  
bottomLipRadius   = bottomLipDiameter / 2;
bottomLipHeight   =  5.00;

// This is the the can itself
canDiameter = 65.85;        
canRadius   = canDiameter / 2;
canHeight   =  3.00;

// This is the indent between the can and the bottom
indentOffset  = 0.3;   

indentRadius = canRadius + indentOffset;
indentHeight = canHeight - indentOffset;


difference()
{
    color("yellow")
        cylinder(r = bottomLipRadius, h = bottomLipHeight);

    translate([0, 0, bottomLipHeight - canHeight])
        color("cyan")
            cylinder(r = canRadius, h = canHeight);

    translate([0, 0, bottomLipHeight - canHeight])
        color("red")
            cylinder(r = indentRadius, h = indentHeight);
}