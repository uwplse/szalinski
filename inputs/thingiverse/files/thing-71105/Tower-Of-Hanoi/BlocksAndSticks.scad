/* [Parameters] */
// How many rings do you want to make? (This determines the difficulty of the game)
numberOfRings = 10; // [3 : 20]
// How wide should the bottom ring be?
largestRingDiameter = 50.0; // [5 : 100]
// How tall should the bottom ring be?
largestRingHeight = 8.0; // [6 : 16]
// Stack the rings or lay them out for easier printing?
stackTheBlocks = 1; // [1:Stack the Rings, 0:Layout the Rings]
// Have angled sides on the rings or flat sides? (Angled sides are harder to grab)
angledBlockSides = 0; // [0:Flat Sides, 1:Angled Sides]

/* [Hidden] */
offsetMargin = 0.1;
$fn = 100;

createBlocksAndSticks(numberOfBlocks = numberOfRings, largestBlockRadius = largestRingDiameter / 2.0, largestBlockHeight = largestRingHeight, stacked = stackTheBlocks, angledPieces = angledBlockSides);

module createBlocksAndSticks(numberOfBlocks = 10, largestBlockRadius = 25.0, largestBlockHeight = 6.0, stacked = true, angledPieces = false)
{
    //* These are our 'private' variables */
    
    marginBetweenBlocks = largestBlockRadius * 2.0 * 0.1;
    
    // Stacking Hole Variables
    stackingHoleRadiusScale = 0.2;
    stackingHoleFemaleMargin = 0.5; //mm
    
    // Height Variables
    smallestBlockHeight = largestBlockHeight * 0.5;
    blockHeightEquationSlope = (smallestBlockHeight - largestBlockHeight) / (numberOfBlocks - 1);
    blockHeightEquationB = largestBlockHeight - blockHeightEquationSlope;
    blockHeights = [blockHeightEquationSlope * 1 + blockHeightEquationB, blockHeightEquationSlope * 2 + blockHeightEquationB, blockHeightEquationSlope * 3 + blockHeightEquationB, blockHeightEquationSlope * 4 + blockHeightEquationB, blockHeightEquationSlope * 5 + blockHeightEquationB, blockHeightEquationSlope * 6 + blockHeightEquationB, blockHeightEquationSlope * 7 + blockHeightEquationB, blockHeightEquationSlope * 8 + blockHeightEquationB, blockHeightEquationSlope * 9 + blockHeightEquationB, blockHeightEquationSlope * 10 + blockHeightEquationB, blockHeightEquationSlope * 11 + blockHeightEquationB, blockHeightEquationSlope * 12 + blockHeightEquationB, blockHeightEquationSlope * 13 + blockHeightEquationB, blockHeightEquationSlope * 14 + blockHeightEquationB, blockHeightEquationSlope * 15 + blockHeightEquationB, blockHeightEquationSlope * 16 + blockHeightEquationB, blockHeightEquationSlope * 17 + blockHeightEquationB, blockHeightEquationSlope * 18 + blockHeightEquationB, blockHeightEquationSlope * 19 + blockHeightEquationB, blockHeightEquationSlope * 20 + blockHeightEquationB,
        blockHeightEquationSlope * 21 + blockHeightEquationB];
    
    // Radius Variables
    smallestBlockRadius = largestBlockRadius * 0.5;
    blockRadiusEquationSlope = (smallestBlockRadius - largestBlockRadius) / (numberOfBlocks - 1);
    blockRadiusEquationB = largestBlockRadius - blockRadiusEquationSlope;
    blockRadiuss = [blockRadiusEquationSlope * 1 + blockRadiusEquationB, blockRadiusEquationSlope * 2 + blockRadiusEquationB, blockRadiusEquationSlope * 3 + blockRadiusEquationB, blockRadiusEquationSlope * 4 + blockRadiusEquationB, blockRadiusEquationSlope * 5 + blockRadiusEquationB, blockRadiusEquationSlope * 6 + blockRadiusEquationB, blockRadiusEquationSlope * 7 + blockRadiusEquationB, blockRadiusEquationSlope * 8 + blockRadiusEquationB, blockRadiusEquationSlope * 9 + blockRadiusEquationB, blockRadiusEquationSlope * 10 + blockRadiusEquationB, blockRadiusEquationSlope * 11 + blockRadiusEquationB, blockRadiusEquationSlope * 12 + blockRadiusEquationB, blockRadiusEquationSlope * 13 + blockRadiusEquationB, blockRadiusEquationSlope * 14 + blockRadiusEquationB, blockRadiusEquationSlope * 15 + blockRadiusEquationB, blockRadiusEquationSlope * 16 + blockRadiusEquationB, blockRadiusEquationSlope * 17 + blockRadiusEquationB, blockRadiusEquationSlope * 18 + blockRadiusEquationB, blockRadiusEquationSlope * 19 + blockRadiusEquationB, blockRadiusEquationSlope * 20 + blockRadiusEquationB,
        blockRadiusEquationSlope * 21 + blockRadiusEquationB];
    
    for(i = [0 : numberOfBlocks - 1])
    {
        if(stacked)
        {
            translate(v = [0, 0, largestBlockHeight * i + offsetMargin * i + offsetMargin])
            {
                union()
                {
                    if(angledPieces)
                    {
                        difference()
                        {
                            // Main body
                            cylinder(r1 = blockRadiuss[i], r2 = blockRadiuss[i + 1], h = blockHeights[i]);
                            
                            translate(v = [0, 0, -offsetMargin])
                            {
                                // Stacking Hole cutout
                                cylinder(r1 = blockRadiuss[0] * stackingHoleRadiusScale + stackingHoleFemaleMargin, r2 = blockRadiuss[0] * stackingHoleRadiusScale + stackingHoleFemaleMargin, h = blockHeights[0] + offsetMargin * 2);
                            }
                        }
                    }
                    else
                    {
                        difference()
                        {
                            // Main body
                            cylinder(r = blockRadiuss[i], h = blockHeights[i]);
                            
                            translate(v = [0, 0, -offsetMargin])
                            {
                                // Stacking Hole cutout
                                cylinder(r = blockRadiuss[0] * stackingHoleRadiusScale + stackingHoleFemaleMargin, h = blockHeights[0] + offsetMargin * 2);
                            }
                        }
                    }
                }
            }
        }
        else
        {
            translate(v = [0, (largestBlockRadius * 2) * i + largestBlockRadius * 3, offsetMargin])
            {
                union()
                {
                    if(angledPieces)
                    {
                        difference()
                        {
                            // Main body
                            cylinder(r1 = blockRadiuss[i], r2 = blockRadiuss[i + 1], h = blockHeights[i]);
                            
                            translate(v = [0, 0, -offsetMargin])
                            {
                                // Stacking Hole cutout
                                cylinder(r1 = blockRadiuss[0] * stackingHoleRadiusScale + stackingHoleFemaleMargin, r2 = blockRadiuss[0] * stackingHoleRadiusScale + stackingHoleFemaleMargin, h = blockHeights[0] + offsetMargin * 2);
                            }
                        }
                    }
                    else
                    {
                        difference()
                        {
                            // Main body
                            cylinder(r = blockRadiuss[i], h = blockHeights[i]);
                            
                            translate(v = [0, 0, -offsetMargin])
                            {
                                // Stacking Hole cutout
                                cylinder(r = blockRadiuss[0] * stackingHoleRadiusScale + stackingHoleFemaleMargin, h = blockHeights[0] + offsetMargin * 2);
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Base
    translate(v = [-((blockRadiuss[0] * 2) * 3 + marginBetweenBlocks * 4) / 2, -(blockRadiuss[0] * 2 + marginBetweenBlocks * 2) / 2, -marginBetweenBlocks])
    {
        cube(size = [(blockRadiuss[0] * 2) * 3 + marginBetweenBlocks * 4, blockRadiuss[0] * 2 + marginBetweenBlocks * 2, 5.0]);
    }
    
    // Sticks
    for(i = [-1 : 1])
    {
        translate(v = [(blockRadiuss[0] * 2) * i + i * marginBetweenBlocks, 0, 0])
        {
            cylinder(r = blockRadiuss[0] * stackingHoleRadiusScale, h = blockHeights[0] * numberOfBlocks);
        }
    }
}
