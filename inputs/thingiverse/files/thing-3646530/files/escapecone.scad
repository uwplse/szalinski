/* [Main Dimensions] */

// Size of drill hole
hole_size = 23.5;
// Thickness of wood divider board
board_thickness = 3.6;
// Height
height = 35;
// Top hole size
top_hole = 7;


/* [Hidden] */

rad = hole_size;

$fn = 100;

translate([0,0,board_thickness+.5])
difference()
{
    cylinder(r2=top_hole/2,r1=rad/2+.4,h=height - board_thickness - .5);
    cylinder(r2=top_hole/2-.4,r1=rad/2,h=height - board_thickness - .5);
}

translate([0,0,.5])
difference()
{
    cylinder(r=rad/2+.4,h=board_thickness);
    cylinder(r=rad/2,h=board_thickness);
}



difference()
{
    cylinder(r=rad/2+4,h=.5);
    cylinder(r=rad/2,h=.5);
}

