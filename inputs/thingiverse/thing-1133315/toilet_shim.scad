//
//  Toilet_shim
//
//  EvilTeach 11/2015
//
//  A quick and dirty toilet shim, cause i need one now.
//


stepDepth   =  6;   // The depth of one step of the shim
stepHeight  =  2;   // The height of one step of the shim
stepWidth   = 30;   // The width of one step, and hence the width of the shim

shimLength  = 60;   // Total Length of the shim


module draw_one_layer(length)
{
    translate([0, 0, (shimLength - length) / stepDepth * stepHeight])
        cube([length, stepWidth, stepHeight]);
}


module main()
{
    for (length=[shimLength: -stepDepth : stepDepth])
    {
        draw_one_layer(length);
    }
}

main();