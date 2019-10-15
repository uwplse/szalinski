//
//    FlashForgetCreater Dual z stop adjuster
//
//    EvilTeach
//
//    12/25/2015
//

// The actual thickness of the piece of glass.
glassPlateThickness = 6.35;     // .25 inches
// glassPlateThickness = 5.08;     // .20 inches
// glassPlateThickness = 2.33;     // My piece of glass


// This is the thickness of the piece of wood that the part slips over as measured on my machine
woodThickness       = 5.25;


module main()
{
    wallThickness       = 2.00;

    width =  wallThickness + woodThickness + wallThickness;
    depth =  30;
    height = glassPlateThickness + 10.0;
    
    // Move the piece onto the build plate
    translate([0, 0, height])
        // Turn it upside down so no support material is needed
        rotate([0, 180, 0])
            difference()
            {
                // Draw a cube big enough to fit over the wood
                cube([width, depth, height]);
                // Offset into the middle of the block
                translate([wallThickness, 0, 0])
                    // Cut out the block that fits over the wood
                    cube([width - wallThickness - wallThickness, 
                          depth, 
                          height - glassPlateThickness]);
            }
}

main();