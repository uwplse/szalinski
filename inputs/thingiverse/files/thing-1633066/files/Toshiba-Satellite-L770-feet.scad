//
//  Toshiba_Satellite_L770_feet.scad
//
//  EvilTeach 6/17/2016
//
//  Replacement feet.
//
//  Use a bit of alcohol and a tooth brush and tooth pick
//  to get the contact cement out of the holes, before 
//  using contact cement to glue these back in.
//
//  Uses NinjaFlex filament.
//  15/15 speed
//  layer .2
//  2 shells
//  7% infill
//  No Raft
//  No Support

// Set the smoothness that you want
$fn = 180;

// Values 1 to 5
howManyToPrint = 5; // [1, 2, 3, 4, 5]

// Distance between each print
offsetBetween  = 2.00;

// wall and floor thickness
thickness      = 2.00;

// The height of the print
footHeight =  5.50;

// The width of the print
footWidth  =  7.69;     
footRadius = footWidth / 2;

// The depth of the print
footDepth  = 18.51;



module pill_shape(width, depth, height)
{
    hull()
    {
        cylinder(r = width / 2, h = height);
        translate([0, depth - width, 0])
            cylinder(r = width / 2, h = height);
    }
}

module foot()
{
    difference()
    {
        color("yellow")
            pill_shape(footWidth, footDepth, footHeight);
        
        color("cyan")
        translate([0, 0, thickness])
            pill_shape(footWidth  - thickness, 
                       footDepth  - thickness, 
                       footHeight - thickness);
    }
}


module main()
{
    for (x = [1 : howManyToPrint])
    {
        offset = x * (footWidth + offsetBetween) - 
                 howManyToPrint * (footWidth + offsetBetween) / 2
                 - footRadius - offsetBetween / 2;
        translate([offset, 0, 0])
            foot();
    }
}


main();