//
//  AlanWrenchWallMount.scad
//
//  EvilTeach 12/28/2015
//
//  Recommended settings 
//      fill   7.0%
//      Layer  0.3
//      shell  0
//      speed  60, 80
//
//  Using the default settings on my Flashforge Creator Dual, 
//  it took about 67 minutes to print, and 11 Meters of filament.

// I like my circles round
$fn = 180;  // [360, 180, 90, 45]

// This is used to hide some parameters fromt he customizer
notAnOption = 1.0 * 1.0;

// These define the side to side diameter for the holes in each of the 4 rows
row1HexDiameter = 3.0;  // [2:9]
row2HexDiameter = 5.5;  // [2:9]
row3HexDiameter = 7.0;  // [2:9]
row4HexDiameter = 8.6;  // [2:9]


// These define the offsets on the shelf, where the various holes will be placed
row1Position =  5.0;
row2Position = 16.0;
row3Position = 30.0;
row4Position = 47.0;

// Two thin plugs are printed to cover the magnet/screw hole.  This controls their thickness
plugHeight = 1.0;       // [1,1.5,2,2.5]

// The wider the shelf the more holes are available
shelfWidth  = 100.0;    // [72, 100, 128, 156]
shelfDepth  =  60.0 * notAnOption;

// The thicker the shelf the stronger it is.  5 seems ok in my testing
shelfHeight =   5.0;    // [4:9]

// For Hex keys, normally we want 6 sided holes.
shelfHoldSides = 6.0;



//
//  This function draws the hex holes that are poked into the shelf.
//
module shelf_holes()
{
    for (x = [8 : 28 : shelfWidth])
    {
        translate([x,  row1Position, 0])
            cylinder(r =  row1HexDiameter/ 2, h = shelfHeight, $fn = shelfHoldSides);

        translate([x, row2Position, 0])
            cylinder(r = row2HexDiameter / 2, h = shelfHeight, $fn = shelfHoldSides);

        translate([x, row3Position, 0])
            cylinder(r = row3HexDiameter / 2, h = shelfHeight, $fn = shelfHoldSides);

        translate([x, row4Position, 0])
            cylinder(r = row4HexDiameter / 2, h = shelfHeight, $fn = shelfHoldSides);
    }
}



mouseEarRadius = 4.5;
mouseEarHeight = 0.5;

//
//  This function pops some mouse ears on to help reduce corner_lift
//
module mouse_ears()
{
    
    {
        translate([0, 0, 0])
            cylinder(r = mouseEarRadius, h = mouseEarHeight);

        translate([shelfWidth, 0, 0])
            cylinder(r = mouseEarRadius, h = mouseEarHeight);

        translate([0, shelfDepth + backPlateDepth, 0])
            cylinder(r = mouseEarRadius, h = mouseEarHeight);

        translate([shelfWidth, shelfDepth + backPlateDepth, 0])
            cylinder(r = mouseEarRadius, h = mouseEarHeight);
    }
}



//
//  This function controls the order of the construction of the shelf
//
module shelf()
{
    color("yellow")   
    difference()
    {
        cube([shelfWidth, shelfDepth, shelfHeight]);
        shelf_holes();
    }

    color("blue")
        mouse_ears();
}



magnetDiameter = 16.0;  // [10:20]
magnetHeight   =  3.2;
magnetRadius   = magnetDiameter / 2.0;

//
//  This function draws the onemagnet
//
module magnet()
{
    cylinder(r = magnetDiameter / 2.0 + 0.5, h = magnetHeight, $fn=360);
}


backPlateWidth  = shelfWidth * notAnOption;
backPlateDepth  = magnetHeight + 2.0 + 1.0;
backPlateHeight = magnetDiameter + 9 + shelfHeight;


//
//  This function draws the holes that are subtracted from the backplate
//
module back_plate_holes()
{
    // Left magnet hole, far enough in to carve out the plug height
    translate([magnetRadius + 5, plugHeight, shelfHeight + magnetRadius + 6])
       rotate([90, 0, 0])
       {
           magnet();
           translate([0, 0,-backPlateDepth])
               cylinder(r = 1.2, h = backPlateDepth+2);        
       }
    
    // Left magnet hole, far enough in to carve out the magnet height
    translate([magnetRadius + 5, plugHeight + magnetHeight, shelfHeight + magnetRadius + 6])
       rotate([90, 0, 0])
       {
           magnet();
       }        
        
    // Right magnet hole, far enough in to carve out the plug height
    translate([backPlateWidth - magnetRadius - 5, plugHeight, shelfHeight + magnetRadius + 6])
       rotate([90, 0, 0])
       {
           magnet();
           translate([0, 0,-backPlateDepth])
               cylinder(r = 1.2, h = backPlateDepth+2);        
       }
    
    // Right magnet hole, far enough in to carve out the magnet height
    translate([backPlateWidth - magnetRadius - 5, plugHeight + magnetHeight, shelfHeight + magnetRadius + 6])
        rotate([90, 0, 0])
        {
            magnet();
        }         
}


//
//  This function controls the order of the drawing of the back plate
//
module back_plate()
{
    translate([0, shelfDepth, 0])
    {
        difference()
        {
            color("cyan")
                cube([backPlateWidth, backPlateDepth, backPlateHeight]);
            color("green")
                back_plate_holes();
        }
    }
}


//
//  This function draws the two plugs that are used to cover the magnet/screw holes
//
module plugs()
{
    color("blue")
    {
        translate([-magnetDiameter + 2, magnetDiameter * 2 + 4, 0])
            cylinder(r = magnetDiameter / 2.0, h = plugHeight, $fn=360);

        translate([-magnetDiameter + 2, magnetDiameter + 2, 0])
            cylinder(r = magnetDiameter / 2.0, h = plugHeight, $fn=360);
    }
}


//
//  This function draws a joint between the shelf and the back plate
//  for added rigidity.  The first few prototypes had an issue with that.
//
module joint()
{
    size = 5.0;
    color("lime")
        translate([0, shelfDepth + .01, shelfHeight - .01])
            rotate([180, 270, 0])
                linear_extrude(shelfWidth)
                    polygon([[0, size], [size, 0], [0,0]]);
}


//
//  This function is responsible for controlling the drawing of the whole model
//
module main()
{
    // Center the print in the middle to fit on build plate as best possible
    translate([(-shelfWidth + magnetDiameter) / 2.0, -shelfDepth / 2.0, 0])
    {
        back_plate();
        shelf();
        joint();
        plugs();
    }
}


// Just an OCD type entry point, for an old C programmers comfort.
main();


