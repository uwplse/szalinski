//
//  toothpastesqueezer.scad
//
//  EvilTeach
//
//  12/11/2016
//

$fn=50;                 // Make very smooth ends


slitWidth  = 66.00;     // Plenty of extra room to make it easy to put on
slitDepth  =  1.50;     // Just a bit too wide to make it easy to put on
slitHeight = 15.00;     // High enough that an adult finger covers it

thickness  =  5.00;     // Material outside of the slit

// Make a cube with rounded ends.
module rounded_cube(width, depth, height)
{
    hull()
    {
        translate([depth / 2, 0, 0])
            cylinder(d = depth, h = height);
        translate([width - depth / 2, 0, 0])
            cylinder(d = depth, h = height);
    }
}



module main()
{
    // Center on build plate
    translate([-((slitWidth + thickness) / 2) , 0, 0])
    
    // Make a large cube and remove the smaller slit from inside it
    difference()
    {
        rounded_cube(slitWidth + thickness, 
                     slitDepth + thickness, 
                     slitHeight);
        translate([thickness / 2, 0, 0])
            rounded_cube(slitWidth, slitDepth, slitHeight);
    }
}

main();