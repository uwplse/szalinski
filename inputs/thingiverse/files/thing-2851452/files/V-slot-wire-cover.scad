/**
Make 6 drawers that run the full drawer depth.
Assorted packs of resistors ordered from Amazon typically come in 30 denominations, so 5 drawers with 6 compartments is perfect for my needs

- costmo
- 2018-04-04
**/

// The surface dimensions of the cap
// The width of the cap (the edge that runs along the rail - if you want to entirely cover the wire path, make this the length of the run to cover)
capWidth = 35;
// The height of the cap (make this the rail's height or less) 
capHeight = 20;
// Width of the gap/space in the rail (the gap where your V-nuts/T-nuts slide into the rail, or a little smaller)
railGap = 6.2;
// How deep into the gap do we need to go to "catch." Make this tight to avoid adding a source of vibration.
gapReach = 1.8;
// When multiple insertion tabs are created, how far from the edge are the outer ones
multiTabInset = 6;

// The "catch" in the inertion tab is a ball. What is its diameter.
insertionCatchDiameter = 7.0;
// The height of the insertion catch ball. Leave enough room for wires to pass!
insertionCatchHeight = 3;

// How round to make the corners
cornerDiameter = 6;

// How thick to make the wall/cap
wallThickness = 2.0;

// How tall to make the post that snaps into the gap
gapPostHeight = gapReach;


// Rendering variables
// Minimum angle -- use for final rendering. Comment for preview.
$fa = 4; 
// Minimum size -- use for final rendering. Comment for preview.
$fs = 0.5; 

/* Calculated variables (these don't show in the Customizer) */
capDepth = wallThickness; // The depth of the cap

// adjust for corners
adjustedCapWidth = capWidth - cornerDiameter;
adjustedCapHeight = capHeight - cornerDiameter;

// The radius if the post to make in the rail gap for an insertion tab
gapPostDiameter = railGap;
// How wide to make the split in the insertion tab post
gapPostSplit = railGap * 0.5;


wireCover();

// The base unit that joins the pieces together
module wireCover()
{
    coverPlate();
    gapPosts();
}

// Make all of the insertion posts, based on the width of the piece.
// Break points are:
// Between 0 and 34   = 1 post
// Between 30 and 99 = 2 posts
// Everything larger  = 3 posts
module gapPosts()
{
    if( capWidth < 35 )
    {
        translate( [(adjustedCapHeight/2) + (gapPostDiameter/2), (adjustedCapWidth/2) + (gapPostDiameter/2), capDepth] )
        {
            gapPost();
        }
    }
    else if( capWidth < 100 )
    {
        translate( [(adjustedCapHeight/2) + (gapPostDiameter/2), (railGap + multiTabInset), capDepth] )
        {
            gapPost();
        }
        translate( [(adjustedCapHeight/2) + (gapPostDiameter/2), (capWidth - (railGap + multiTabInset)), capDepth] )
        {
            gapPost();
        }
    }
    else
    {
        translate( [(adjustedCapHeight/2) + (gapPostDiameter/2), (railGap + multiTabInset), capDepth] )
        {
            gapPost();
        }
        translate( [(adjustedCapHeight/2) + (gapPostDiameter/2), (adjustedCapWidth/2) + (gapPostDiameter/2), capDepth] )
        {
            gapPost();
        }
        translate( [(adjustedCapHeight/2) + (gapPostDiameter/2), (capWidth - (railGap + multiTabInset)), capDepth] )
        {
            gapPost();
        }
    }
}

// Make a single post
module gapPost()
{
    difference()
    {
        { // make a main body
            union()
            {
                {
                    // shaft
                    cylinder( d = gapPostDiameter, h = gapPostHeight );
                }
                {
                    difference()
                    {
                        {
                            
                            {
                                // ball at the top for tension
                                translate( [0, 0, (gapPostHeight + (insertionCatchHeight/2))] )
                                {
                                    scale( v = [1, 1, 0.95] )
                                    {
                                        sphere( d = insertionCatchDiameter );
                                    }
                                }
                            }
                        }
                        
                        { // remove the top and bottom of the ball at the set height
                            translate( [(-1 * (capHeight/2)), (-1 * (capWidth/2)), 0] )
                            {
                                cube( [capHeight, capWidth, gapPostHeight] );
                            }
                        }
                        {
                            translate( [(-1 * (capHeight/2)), (-1 * (capWidth/2)), gapPostHeight + insertionCatchHeight] )
                            {
                                cube( [capHeight, capWidth, gapPostHeight + 20] );
                            }
                        }
                        
                    }
                }
            }
        }
        { // Now remove a slice from the middle so the posts can squeeze together a little bit
            translate( [(-0.5 * gapPostSplit), (-0.5 * capWidth), 0] )
            {
                cube( [gapPostSplit, capWidth, 50] );
            }
        }
    }      
}

// Make the cover plate
module coverPlate()
{
    hull()
    {
        {
            translate( [(cornerDiameter/2), (cornerDiameter/2), 0] )
            {
                cube( [adjustedCapHeight, adjustedCapWidth, capDepth] );
            }
        }
        {
            coverPlateCorners();
        }
    }
            
}

// Convenience to add corners to the cover plate for hulling
module coverPlateCorners()
{
    translate( [(cornerDiameter/2), (cornerDiameter/2), 0] )
    {
        cylinder( d = cornerDiameter, h = capDepth );
    }
    
    translate( [(cornerDiameter/2) + adjustedCapHeight, (cornerDiameter/2), 0] )
    {
        cylinder( d = cornerDiameter, h = capDepth );
    }
    
    translate( [(cornerDiameter/2), (cornerDiameter/2) + adjustedCapWidth, 0] )
    {
        cylinder( d = cornerDiameter, h = capDepth );
    }
    
    translate( [(cornerDiameter/2) + adjustedCapHeight, (cornerDiameter/2) + adjustedCapWidth, 0] )
    {
        cylinder( d = cornerDiameter, h = capDepth );
    }
}