// DEC PDP-11 H960 rack fascia panel mounting clip
// Measured from an original DEC clip.
// The original appears to be made from a hard black plastic, it does not appear to be ABS though.
// The pins on the originals are quite fragile ...as you may already know!
// For the 5-1/4" fascia panel, one is required each side
// For the 10-1/2" fascia panel, two are required each side
//
// I suggest printing these from ABS. PETG or nylon would probably be good too.
// 
// To generate, use the Customiser to generate original or flexible, with or without 
// an extra set of mounting holes then press F5 to preview, F6 to render, save your STL.
// 
// Measured and scripted by Steve Malikoff in Brisbane, Australia
// Last update 20180514


//////////////////////////////////////////////////////////////////////////////////////////////////
/////////// Customizer: Set 0 or 1 for the following then generate with F5 then F6 ///////////////
// Semi-flexible (1) or Original (0) posts
FLEXIBLE = 0; // [0:No, 1:Yes]
// Extra inter-Rack Unit spacing holes
EXTRA_HOLES = 0; // [0:No, 1:Yes]
// Replace post with hole only, for steel screw (ie.make your own post)
STEEL_SCREWS = 0; // [0:No, 1:Yes]
//////////////////////////////////////////////////////////////////////////////////////////////////

facets = 80;
$fn = facets;

INCH = 25.4;    // da da da Dah-di-Dah Dah-di-Dah (Imperial)

// The flat baseplate, overall dimensions
BASE_LENGTH = 114.8;
BASE_WIDTH = 16.12;
BASE_HEIGHT = 3.12;
CORNER_RADIUS = 1/16 * INCH;

// The riser block. There is one each end
BLOCK_LENGTH = 23.8;
BLOCK_WIDTH = 9.52;
BLOCK_HEIGHT=5.08;

// The two knobbly posts that hold the fascia panel
POST_RADIUS = 2.39;
POST_HEIGHT = 6.32;
BALL_RADIUS = 3.18;

// Fit your own steel screw (thanks to Lou N2M1Y - great idea!)
STEEL_SCREW_DIA = 4;    // 8-32 is 4.1mm, adjust to suit what you have

// Positions of the posts from 0,0:
FIRST_POST_CENTRE_OFFSET_X = 17.2;
SECOND_POST_CENTRE_OFFSET_X = 97.61;
BOTH_POSTS_CENTRE_OFFSET_Y = 4.94;

// The various holes in the thing
LARGE_HOLE_RADIUS = 5.5;
SMALL_HOLE_RADIUS = 1.72;
SCREW_HOLE_RADIUS = 2.78;
CSNK_RADIUS_TOP = 4.9;
CSNK_RADIUS_BOTTOM = 2.78;

// The offsets for these holes (the clip corner being on 0,0,0):
FIRST_SMALL_HOLE_CENTRE_OFFSET_X = 6.56;
SECOND_SMALL_HOLE_CENTRE_OFFSET_X = 108.24;
FIRST_CSNK_HOLE_CENTRE_OFFSET_X = 28.91;
SECOND_CSNK_HOLE_CENTRE_OFFSET_X = 85.89;
CSNK_HOLE_CENTRE_OFFSET_Y = 7;
CSNK_LOWER_HEIGHT = 1;

// These ring definitions are only used if you choose the flexible pin version (ie. ORIGINAL=0)
RING_WALL_THICKNESS = 0.8;  // for flexible ring variant
RING_BRIDGE_THICKNESS = 1;  // bridging the flex rings


//// Generate the desired model, original solid post version or semi-flexible post version
if (FLEXIBLE)
    ClipWithFlexiblePosts();
else
    ClipOriginalPattern();
//////////////// Uncomment out one of the above to generate, Hit F4 then F5 ///////////////

// Modelled directly from an original DEC H960 fascia panel clip
module ClipOriginalPattern()
{
    difference()
    {
        //Base();   // First attempt. Has plain od square corners
        BaseWithRoundedCorners();
        Holes();
        if (EXTRA_HOLES)
            HolesExtra();   // Allows additional inter-Rack Unit spacing
        if (STEEL_SCREWS)
            HolesForOwnPostScrews();
    }
}

// Same fascia panel clip with three cylindrical clearances around each pin
module ClipWithFlexiblePosts()
{
    difference()
    {
        //Base();   // First attempt. Has plain od square corners
        BaseWithRoundedCorners();
        Holes();
        if (EXTRA_HOLES)
            HolesExtra();   // Allows additional inter-Rack Unit spacing
        FlexRingCutoutNumber1();    // Innermost clearance, along post, from top, downwards
        FlexRingCutoutNumber2();    // Middle clearance, from bottom, upwards
        FlexRingCutoutNumber3();    // Outer clearance, from top, downwards
        //Slots();
    }
}

// Innermost ring clearance, from top, downwards, along post
module FlexRingCutoutNumber1()
{
    // One cylindrical channel around the first post
    translate([FIRST_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, RING_BRIDGE_THICKNESS])
        InnerRingCutout();   
    // One cylindrical channel around the second post
    translate([SECOND_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, RING_BRIDGE_THICKNESS])
        InnerRingCutout();
}

module InnerRingCutout()
{
    difference()
    {
        cylinder(r=POST_RADIUS + RING_WALL_THICKNESS, h=10);
        cylinder(r=POST_RADIUS, h=10);
    }
}

// Middle ring clearance, from bottom, upwards
module FlexRingCutoutNumber2()
{
    // Second cylindrical channel around the first post
    translate([FIRST_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, -RING_BRIDGE_THICKNESS])
        MiddleRingCutout();
    // Second cylindrical channel around the second post
    translate([SECOND_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, -RING_BRIDGE_THICKNESS])
        MiddleRingCutout();
}

module MiddleRingCutout()
{
    ringInner = POST_RADIUS + (RING_WALL_THICKNESS * 2);
    ringOuter = POST_RADIUS + (RING_WALL_THICKNESS * 3);
    
    difference()
    {
        cylinder(r=ringOuter, h=BASE_HEIGHT + BLOCK_HEIGHT);
        cylinder(r=ringInner, h=BASE_HEIGHT + BLOCK_HEIGHT);
    }
}

// Outer ring clearance, from bottom, upwards
module FlexRingCutoutNumber3()
{
    // Third cylindrical channel around the first post
    translate([FIRST_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, RING_BRIDGE_THICKNESS])
        OuterRingCutout();    
    // Third cylindrical channel around the second post
    translate([SECOND_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, RING_BRIDGE_THICKNESS])
        OuterRingCutout();
}

module OuterRingCutout()
{
    ringInner = POST_RADIUS + (RING_WALL_THICKNESS * 4);
    ringOuter = POST_RADIUS + (RING_WALL_THICKNESS * 5);
    
    difference()
    {
        cylinder(r=ringOuter, h=BASE_HEIGHT + BLOCK_HEIGHT);
        cylinder(r=ringInner, h=BASE_HEIGHT + BLOCK_HEIGHT);
    }
}


module Slots()
{
    translate([FIRST_POST_CENTRE_OFFSET_X + POST_RADIUS , 2, 0])
        cube([2,8,6]);
    translate([FIRST_POST_CENTRE_OFFSET_X - POST_RADIUS - 1, 2, 0])
        cube([2,8,6]);
}

// Square-cornered base and blocks
module Base()
{
    // main and both outer blocks
    cube([BASE_LENGTH, BASE_WIDTH, BASE_HEIGHT]);
    translate([0,0,BASE_HEIGHT])
        cube([BLOCK_LENGTH, BLOCK_WIDTH, BLOCK_HEIGHT]);
    translate([BASE_LENGTH - BLOCK_LENGTH,0,BASE_HEIGHT])
        cube([BLOCK_LENGTH, BLOCK_WIDTH, BLOCK_HEIGHT]);
    // generate the two posts
    Posts();
}

// Baseplate and both outer blocks with 1/16" rounded corners on outer ends as per original
module BaseWithRoundedCorners()
{
    // main and both outer blocks
    //cube([BASE_LENGTH, BASE_WIDTH, BASE_HEIGHT]);
    translate([CORNER_RADIUS, CORNER_RADIUS])
        linear_extrude(BASE_HEIGHT)
            minkowski()
            {
                square([BASE_LENGTH - CORNER_RADIUS*2, BASE_WIDTH-CORNER_RADIUS*2]);
                circle(r=CORNER_RADIUS);
            }
     // The two riser blocks, one at each end
    // Block closest to 0,0:
    translate([0,0,BASE_HEIGHT])
        linear_extrude(BLOCK_HEIGHT)
            hull()
            {
                translate([CORNER_RADIUS, 0])
                    square([BLOCK_LENGTH - CORNER_RADIUS, BLOCK_WIDTH]);
                translate([CORNER_RADIUS, CORNER_RADIUS])
                    circle(r=CORNER_RADIUS);
                translate([CORNER_RADIUS, BLOCK_WIDTH-CORNER_RADIUS])
                    circle(r=CORNER_RADIUS);
            }           
    // Outer block:
    translate([BASE_LENGTH - BLOCK_LENGTH,0,BASE_HEIGHT])
        linear_extrude(BLOCK_HEIGHT)
            hull()
            {
                //translate([CORNER_RADIUS, 0])
                    square([BLOCK_LENGTH - CORNER_RADIUS, BLOCK_WIDTH]);
                translate([BLOCK_LENGTH - CORNER_RADIUS, CORNER_RADIUS])
                    circle(r=CORNER_RADIUS);
                translate([BLOCK_LENGTH - CORNER_RADIUS, BLOCK_WIDTH-CORNER_RADIUS])
                    circle(r=CORNER_RADIUS);
            }
    // generate the two posts
    if (!STEEL_SCREWS)
        Posts();
}

// Posiiton both posts
module Posts()
{
    translate([FIRST_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, BASE_HEIGHT + BLOCK_HEIGHT])
        Post();
    translate([SECOND_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, BASE_HEIGHT + BLOCK_HEIGHT])
        Post();
}

// A single post with sphere
module Post()
{
    cylinder(r=POST_RADIUS, h=POST_HEIGHT);
    translate([0,0,POST_HEIGHT])
        sphere(r=BALL_RADIUS);
}

// Position the two countersunk screw holes and the large centre hole
module Holes()
{    
    // large centre hole
    translate([BASE_LENGTH/2, 7.1, 0])
        LargeHole();
    // First outer hole
    translate([FIRST_SMALL_HOLE_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, 0])
        SmallHole();
    // Second outer hole
    translate([SECOND_SMALL_HOLE_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, 0])
        SmallHole();    
    // First countersunk hole
    translate([FIRST_CSNK_HOLE_CENTRE_OFFSET_X, CSNK_HOLE_CENTRE_OFFSET_Y, 0])
        CountersunkHole();
    // Second countersunk hole
    translate([SECOND_CSNK_HOLE_CENTRE_OFFSET_X, CSNK_HOLE_CENTRE_OFFSET_Y, 0])
        CountersunkHole();    
}

// 
module HolesForOwnPostScrews()
{
    translate([FIRST_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, 0])
    {
        cylinder(d=STEEL_SCREW_DIA, h=BASE_HEIGHT + BLOCK_HEIGHT);
        cylinder(d1=STEEL_SCREW_DIA * 2, d2=STEEL_SCREW_DIA, h=STEEL_SCREW_DIA / 2); 
    }
    translate([SECOND_POST_CENTRE_OFFSET_X, BOTH_POSTS_CENTRE_OFFSET_Y, 0])
    {
        cylinder(d=STEEL_SCREW_DIA, h=BASE_HEIGHT + BLOCK_HEIGHT);
        cylinder(d1=STEEL_SCREW_DIA * 2, d2=STEEL_SCREW_DIA, h=STEEL_SCREW_DIA / 2); 
    }
}

// Not sure what DEC intended this large hole for, when mounted on the H960
module LargeHole()
{
        cylinder(r=LARGE_HOLE_RADIUS, h=BASE_HEIGHT);
}

// An outer hole
module SmallHole()
{
        cylinder(r=SMALL_HOLE_RADIUS, h=BASE_HEIGHT + BLOCK_HEIGHT);
}

// The countersunck screw fixing hole
module CountersunkHole()
{
        cylinder(r=SCREW_HOLE_RADIUS, h=BASE_HEIGHT);
        translate([0, 0, CSNK_LOWER_HEIGHT])        
            cylinder(r2=CSNK_RADIUS_TOP, r1= CSNK_RADIUS_BOTTOM, h=BASE_HEIGHT - CSNK_LOWER_HEIGHT);
}

// Put two extra countersunk holes in, to allow inter-rack unit adjustment
module HolesExtra()
{    
    OneRackUnit = 1.75 * INCH;
    // Additional countersunk hole, position outwards from first csnk
    translate([FIRST_CSNK_HOLE_CENTRE_OFFSET_X + OneRackUnit, CSNK_HOLE_CENTRE_OFFSET_Y, 0])
        CountersunkHole();
    // Another additional countersunk hole, position inwards from first csnk
    translate([SECOND_CSNK_HOLE_CENTRE_OFFSET_X - OneRackUnit, CSNK_HOLE_CENTRE_OFFSET_Y, 0])
        CountersunkHole();    
}
