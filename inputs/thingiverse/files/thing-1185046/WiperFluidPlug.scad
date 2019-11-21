//
//  WiperFluidPlug.scad
//
//  EvilTeach
//
//  12/8/2015
//
//  25%   infill
//    .3  layer height
//   0    shells
//  60    feedrate
//        abs
//        no raft
//        no support

// Total height of the plug in MM
plugHeight         = 40.0;

// Total Diameter of the top of the plug in MM. This is expected to be larger than the bottom diameter
plugDiameterTop    = 53.0;

// Total Diameter of the bottom of the plug in MM
plugDiameterBottom = 50.0;

module main()
{
    // Make a very smooth print
    $fn = 360;
    
    topRadius     = plugDiameterBottom / 2.0;
    bottomRadius  = plugDiameterTop    / 2.0;

    // This is thick enough to make it strong enough
    thickness = 2.0;
    
    difference()
    {
        // Draw the basic cylinder
        cylinder(r2 = topRadius, 
                 r1 = bottomRadius, 
                  h = plugHeight);
        
        // Hollow out the basic cylinder
        translate([0, 0, thickness])
            cylinder(r2 = topRadius      - thickness, 
                     r1 = bottomRadius   - thickness, 
                      h = plugHeight     - thickness);
        
        // Add a small hole to allow pressure to equalize
        cylinder(r = 1, h = thickness);
        
        // Engrave some roughly relative text.
        translate([bottomRadius / 2, 8, 1])
            rotate([0, 180, 0])
                linear_extrude(1)
                    text("WIPER", size = 6);

        translate([bottomRadius / 2, -10, 1])
            rotate([0, 180, 0])
                linear_extrude(1)
                    text("FLUID", size = 6);
    }
}


main();