//
//  CubicalCoatHanger2
//
//  EvilTeach
//
//  1/15/2015
//
//  This is a replacment of the previous version
//  which is just fine in most cases.  When I added
//  my wintercoat to the mix of hat and jacket, it collapsed.
//  This model is a bit thicker and wider, and printed denser
//  so as to have a longer life.
//

//
//  55 minutes
//  5.8 meters
//  infill 15%
//  .2 layer
//  no shells
//  speed 60/75

// (RED) In effect this is the width of the piece.  For a lighter load this value can be reduced.
modelHeight    = 20.0;

// (RED) This is the thickness of the beam like parts.  With a lighter load this value can be reduced.
modelThickness =  7.0;

// (BLUE) distance across the metal cap on top of the cube partition
capWidth = 52.0;

// (BLUE) the height of the metal cap.
capDepth = 36.0;

// (RED) This is how far out the hook reaches from the cap
hookWidth = 25.0;

// (YELLOW) This is the size of the cube that the coat hooks on to.
hookDepth = modelThickness;

modelDepth = capDepth + modelThickness;
modelWidth = modelThickness + capWidth + modelThickness + hookWidth;

// (LIME) The length of the feet that grip under the cap
footDepth = 2.0;

// (CYAN) dimensions of the mouse ears
mouseEarRadius = 3.5;
mouseEarHeight = 2.0;

module mouse_ear()
{
    cylinder(r = mouseEarRadius, h = mouseEarHeight);
}



module cap()
{
    color("blue")
    {
        translate([modelThickness, 0, 0])
        cube([capWidth, capDepth, modelHeight]);
    }
}



module hook_arm()
{
    hookDepth = capDepth - modelThickness;
    translate([modelThickness + capWidth + modelThickness, modelThickness, 0])
        cube([hookWidth, hookDepth, modelHeight]);
}



module hooks()
{
    color("yellow")
    {
        translate([modelThickness + capWidth + modelThickness + hookWidth - modelThickness, 
                   capDepth + modelThickness, 
                   0])
            cube([modelThickness, modelThickness, modelHeight]);
        
        translate([modelThickness + capWidth + modelThickness + hookWidth - modelThickness, 
                   modelThickness, 
                   0])
            cube([modelThickness, hookDepth, modelHeight]);
    }
}

module base_cube()
{
    color("red")
        cube([modelWidth, modelDepth, modelHeight]);
}



module feet()
{
    color("lime")
    {
        footWidth = modelThickness + 4.5;
        footHeight = modelHeight;
        
        translate([0, -footDepth, 0])
            cube([footWidth, footDepth, footHeight]);

        translate([modelThickness + capWidth + modelThickness - footWidth, -footDepth, 0])
            cube([footWidth, footDepth, footHeight]);
    }
}



module mouse_ears()
{
    color("cyan")
    translate([0, -footDepth, 0])
        mouse_ear();

    color("cyan")
    translate([0, capDepth + modelThickness, 0])
        mouse_ear();
    
    color("cyan")
    translate([modelThickness + capWidth + modelThickness + hookWidth, 0, 0])
        mouse_ear();    

    color("cyan")
    translate([modelThickness + capWidth + modelThickness + hookWidth, modelThickness + hookDepth, 0])
        mouse_ear();

    color("cyan")
    translate([modelThickness + capWidth + modelThickness + hookWidth, capDepth + modelThickness + hookDepth, 0])
        mouse_ear();    

    
}



module main()
{
    difference()
    {
        base_cube();
        cap();
        hook_arm();
    }
    feet();
    hooks();
    
    mouse_ears();
}

main();