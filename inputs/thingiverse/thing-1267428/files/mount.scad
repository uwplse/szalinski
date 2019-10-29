$fn = 50 * 1;

//  Length of the base plate
length = 100;

//  Width of the base plate
width = 40;

//  Thickness of the base plate
thickness = 3;

//  Displacement of the CENTER of the beam in x direction
dx = 20;

//  Displacement of the CENTER of the beam in y direction
dy = 80;

//  Thickness of the beam in x direction
beamWidth = 10;

//  Thickness of the beam in y direction
beamLength = 15;

//  Height of the beam
beamHeight = 60;

mount();

module mount()
{
    union()
    {
        cube([width, length, thickness]);
        translate([dx - beamWidth / 2, dy - beamLength / 2, thickness])
        {
            cube([beamWidth, beamLength, beamHeight]);
        }
    }
}