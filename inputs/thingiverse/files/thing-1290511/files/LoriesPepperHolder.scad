//
//  LoriesPepperHolder.scad
//
//  EvilTeach
//
//  1/22/2015
//
//  a holder for a pepper grinder to catch the pepper flakes
//
//  This should be printed in white
//  3-6% fill
//  maybe 2 shells
//  50/75 mm/s
//  abs, about 8 meters, about 1 hour print time


// This controls the smoothness of the cylinder.  This is very smooth
$fn = 360;


// This is the diameter of the pepper grinder + a little extra so it can be removed easily
cylinderDiameter = 60;

// This controls how deep you want the grinder to sit
cylinderHeight   = 10;

// This is how far the cube sticks out beyond the cylinder
extraWidth = 3;

// This is how thick the cube is under the cylinder.
cubeFloorHeight = 3;

cubeWidth  = cylinderDiameter + extraWidth + extraWidth;
cubeHeight = cylinderHeight + cubeFloorHeight;

module cut_out_cylinder()
{
    color("yellow")
    translate([cubeWidth / 2, cubeWidth / 2, cubeFloorHeight])
        cylinder(r = cylinderDiameter / 2, h = cylinderHeight);
}

module base_cube()
{
    color("cyan")
        cube([cubeWidth, cubeWidth, cubeHeight]);
}

module mouse_ear()
{
    color("lime")
        cylinder(r = 10, h = 1);
}

module add_mouse_ears()
{
    translate([0, 0, 0])
        mouse_ear();

    translate([0, cubeWidth, 0])
        mouse_ear();

    translate([cubeWidth, 0, 0])
        mouse_ear();

    translate([cubeWidth, cubeWidth, 0])
        mouse_ear();
}

module main()
{
    difference()
    {
        base_cube();
        cut_out_cylinder();
    }
    
    add_mouse_ears();
}


main();