/* [Basic Settings] */

// How many holes across?
Columns = 5; // [1:30]

// How many rows of holes?
Rows = 2; // [1:10]

// Diameter of the holes
HoleDiameter = 6.4;

// Height of each row
StepSize = 9;


/* [Advanced Settings] */

// Spacing between the holes
Spacing = 3;

// Thickness to leave at the bottom
BottomThickness = 1;

// How round to make the corners
Roundness = 6;


// Cylinder resolution. set it to 10 if you're mucking about, about 120 if you're exporting STL's
circle_resolution = 50;


/* [Printer] */
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]


/* [Hidden] */
// Jitter is used to prevent coincident-surface problems with CSG. Should be set to something small.
j = 0.01;

// Shortcuts used to make arrays easier to reference
x=0; y=1; z=2;

$fn = circle_resolution;
HoleRadius = HoleDiameter/2;

use<utils/build_plate.scad>;

module NozzleFormer()
{
    union()
    {
        cylinder(r = HoleRadius, h = StepSize * Rows);
    }
}



module RoundCube(size, r)
{
    hull()
    {
        translate([r, r, 0]) cylinder(r = r, h = size[z]);
        translate([size[x]-r, r, 0]) cylinder(r = r, h = size[z]);
        translate([size[x]-r, size[1]-r, 0]) cylinder(r = r, h = size[z]);
        translate([r, size[y]-r, 0]) cylinder(r = r, h = size[z]);
    }
}

module NozzleStand()
{
    difference()
    {
        union()
        {
            for(row = [0:Rows-1])
            {
                translate([0, (Spacing + HoleRadius*2 + Spacing) * row, 0])
                RoundCube(
                [
                    Spacing + (((HoleRadius * 2) + Spacing) * Columns), 
                    Spacing + (((HoleRadius * 2) + Spacing) * (Rows-row)), 
                    StepSize * (row+1)
                ],
                Roundness);
            }
        }
        
        for(row = [0:Rows-1])
        {
            for(col = [0:Columns-1])
            {
                translate(
                [
                    Spacing + HoleRadius + ((HoleRadius * 2) + Spacing) * col,
                    Spacing + HoleRadius + ((HoleRadius * 2) + Spacing * 2) * row, 
                    BottomThickness
                ])
                NozzleFormer();
            }
        }
    }
}


translate(-[Spacing + (((HoleRadius * 2) + Spacing) * Columns), Spacing + (((HoleRadius * 2) + Spacing) * Rows), 0]/2)
NozzleStand();

%build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);
