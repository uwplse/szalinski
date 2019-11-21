//
//  Toilet_shim
//
//  EvilTeach 11/2015
//
//  This model generates a shim suitable for adjusting your toilet.
//  It is basically a series of smaller and smaller rectangles.
//  As it is parameterized, you can generate it however you want.
//
//  It also lets you print multiple copies.   By default it prints two.
//
//  This is post-card-ware.  Let me know in a comment how this worked out
//  for you.  Defect reports, and suggestions for improvements are always welcome.
//
//  I recommend you use ABS with at least a 50% fill.
//  Anything lower that 4 as a stepDepth doesn't work as well.
//  Your toilet bottom edge will vary, so it may take a print or two
//  to zero in on your desired depth.
//


shimsPerRow  =  1;        // How many shims to fit on print on the X axis
rowsPerPrint =  2;        // How many rows of shims to print on the Y axis

shimLength   = 40;        // Total Length of the shim
shimWidth    = 30;        // Total Width of the shim

stepDepth    =  4;        // The depth of one step of the shim
stepHeight   =  1;        // The height of one step of the shim
stepWidth    = shimWidth; // The width of one step of the shim


//
//  This function draws exactly one layers of the shim
//
module draw_one_layer(length)
{
    translate([0, 0, (shimLength - length) / stepDepth * stepHeight])
        cube([length, stepWidth, stepHeight]);
}


//
//  This function draws exactly one shim
//  at the given offset
//
module draw_one_shim(xOffset, yOffset)
{
    gapBetweenShims = 2;
    
    translate([yOffset * (shimLength + gapBetweenShims), 
               xOffset * (shimWidth  + gapBetweenShims), 
               0])
        for (length=[shimLength : -stepDepth : stepDepth])
        {
            draw_one_layer(length);
        }
}

//
//  This function iterate over the desired number of shims per row
//  and shims per column, drawing each shim as it goes.
//  The loops are designed to try to keep things centered on the build plate
//
module main()
{
    for (yOffset = [-rowsPerPrint / 2 : 1 : rowsPerPrint / 2 - 1])
    {
        for (xOffset =[-shimsPerRow / 2 : 1 : shimsPerRow / 2 - 1])
        {
            draw_one_shim(xOffset, yOffset);
        }
    }
}

// Welcome to the entry point. 
// Can you tell I am a C programmer?
main();
