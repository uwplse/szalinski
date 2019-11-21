/**
 * A generic bracket for a Nema 17 motor with a modular build approach so that an aribtrary number and type of things can be mounted to it
 *
 * costmo: 2019-09-04
 */

 /** Variables at top, functional code below **/

 // Render Quality: Minimum angle
$fa = 1;
 // Render Quality: Minimum size
$fs = 0.1;

// The X and Y dimensions od the motor. Added 0.2mm to the technically correct size for tolerance
cutoutXY = 42.5;
// How tall to print - or how wide the piece will be. This piece fits between the metal endcaps of the motor housing. The most common motor has a 20mm gap between the raised metal pieces, so you'll probably need that value or less
height = 19.6;
// How thick the printed piece will be
thickness = 7;

// How tall to make the cutout that holds the top nut trap
topBoltCutoutHeight = 10;
// How wide to make the cutout that holds the top nut trap
topBoltCutoutWidth = 8;
// How much material should go beneath the cutout shape for support and space for extra modular options
topPieceSupport = 7;

// How thick/tall the top piece will be in total
topThickness = (topBoltCutoutHeight + topPieceSupport);
// Add a small gap between pieces for easier fit and to provide a small amount of clamping force
toleranceGap = 0.2;

boltCenterOffset = 0.8;

// Set the distance between the nut traps on main unit
distanceBetweenInternalNutTraps = 20;

// Set the distance between the nut traps on the top piece. These need to be a little closer to make room for other stuff that may already be in the way.
distanceBetweenTopNutTraps = 12;

// Calculated for use in code below. Don't change this
internalNutTrapDistance = ((cutoutXY - distanceBetweenInternalNutTraps)/2);
topNutTrapDistance = ((cutoutXY - distanceBetweenTopNutTraps)/2);

// Set to true to orient the pieces to output for printing
orientForPrinting = true;

// Set this to false to not render this model - typically when including this as a base module
renderModel = true;

/** Build the final piece(s) here **/

if( renderModel )
{
    if( !orientForPrinting )
    {
        %mountToView();
    }
    else
    {
        mountToPrint();
    }
}

/** Reusable modules below here **/

module mountToView()
{
    mainUnit();
    baseCorners();
    top();
    topCorners();
}

module mountToPrint()
{
    mainUnit();
    baseCorners();
    translate( [70, 8, 0] )
    {
        rotate( [0, 0, 90] )
        {
            top();
            topCorners();
        }
    }
}

module mainUnit()
{
    difference()
    {
        {
            union()
            {
                body();
                
            }
        }
        {
            cutout();
        }
    }
}

module body()
{
    translate( [(-1 * thickness), (-1 * thickness), 0] )
    {
        cube( [(cutoutXY + (thickness * 2)), (cutoutXY + thickness + topThickness), height ] );
    }
}

module baseCorners()
{
    translate( [-4.9, 0, 0] )
    {
        rotate( [0, 0, -45] )
        {
            cube( [7, 7, height] );
        }
    }

    translate( [(cutoutXY - 4.9), 0, 0] )
    {
        rotate( [0, 0, -45] )
        {
            cube( [7, 7, height] );
        }
    }
}

module internalNutTraps()
{
    translate( [-4.7, internalNutTrapDistance, (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = 90, xRotationAngle = 0 );
    }

    translate( [-4.7, (cutoutXY - internalNutTrapDistance), (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = 90, xRotationAngle = 0 );
    }

    translate( [(cutoutXY + 4.7), internalNutTrapDistance, (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = -90, xRotationAngle = 0 );
    }

    translate( [(cutoutXY + 4.7), (cutoutXY - internalNutTrapDistance), (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = -90, xRotationAngle = 0 );
    }

    translate( [internalNutTrapDistance, 0.1, (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = -90, xRotationAngle = 90 );
    }

    translate( [(cutoutXY - internalNutTrapDistance), 0.1, (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = -90, xRotationAngle = 90 );
    }

    translate( [topNutTrapDistance, (cutoutXY + 4.7), (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = 90, xRotationAngle = 90 );
    }

    translate( [(cutoutXY - topNutTrapDistance), (cutoutXY + 4.7), (height/2)] )
    {
        m3NutAndThroughHole( yRotationAngle = 90, xRotationAngle = 90 );
    }
}

module m3NutAndThroughHole( yRotationAngle, xRotationAngle )
{
    rotate( [xRotationAngle, yRotationAngle, 0] )
    {
        m3InternalNut();
        translate( [0, 0, -10] )
        {
            m3ThroughHole();
        }
    }
}

module topCorners()
{
    translate( [(cutoutXY - 4.9), (cutoutXY - 5.8) + 5.8, 0] )
    {
        difference()
        {
            {
                rotate( [0, 0, -45] )
                {
                    cube( [7, 7, height] );
                }
            }
            {
                translate( [(4.9 - toleranceGap), -5.8, -1] )
                {
                    cube( [5.8, 11.6, (height + 2)] );
                }
            }
        }
    }

    translate( [0, (cutoutXY - 5.8) + 5.8, 0] )
    {
        difference()
        {
            {
                translate( [0, -4.9, 0] )
                {
                    rotate( [0, 0, 45] )
                    {
                        cube( [7, 7, height] );
                    }
                }
            }
            {
                translate( [(-5.8 + toleranceGap), -5.8, -1] )
                {
                    cube( [5.8, 11.6, (height + 2)] );
                }
            }
        }
    }
}

module cutout()
{
    translate( [0, 0, -1] )
    {
        cube( [cutoutXY, (cutoutXY + topThickness + 1), (height + 2)] );
    }

    translate( [(toleranceGap + topBoltCutoutWidth), (cutoutXY + (topThickness - topBoltCutoutHeight)), -1] )
    {
        translate( [((cutoutXY - (toleranceGap * 2)) - (topBoltCutoutWidth * 2)), 3.5, (height/2 + boltCenterOffset)] )
        {
            rotate( [0, 90, 0] )
            {
                m4ThroughHole();
                translate( [0, 0, -4.6 + (topBoltCutoutWidth + (toleranceGap*3) + thickness + 0.2)] )
                {
                    m4HeadCutout();
                }
            }
        }

        translate( [-4.6, 3.5, (height/2 + boltCenterOffset)] )
        {
            rotate( [0, 90, 0] )
            {
                translate( [0, 0, -10] )
                {
                    m4ThroughHole();
                }
                translate( [0, 0, 4.6 - (topBoltCutoutWidth + toleranceGap + thickness + 0.2)] )
                {
                    m4HeadCutout();
                }
            }
        }
    }

    internalNutTraps();
    roundedBodyCorners();
}

module top()
{
    difference()
    {
        {
            // The main cube
            translate( [toleranceGap, cutoutXY, 0] )
            {
                cube( [(cutoutXY - (toleranceGap * 2)), topThickness, height] );
            }
        }
        {
            translate( [(toleranceGap + topBoltCutoutWidth), (cutoutXY + (topThickness - topBoltCutoutHeight)), -1] )
            {
                // main cutout piece
                cube( [((cutoutXY - (toleranceGap * 2)) - (topBoltCutoutWidth * 2)), topBoltCutoutHeight + 1, (height + 2)] );
                
                translate( [((cutoutXY - (toleranceGap * 2)) - (topBoltCutoutWidth * 2)), 3.5, (height/2 + boltCenterOffset)] )
                {
                    rotate( [0, 90, 0] )
                    {
                        m4Nut();
                        m4ThroughHole();
                    }
                }

               translate( [-4.6, 3.5, (height/2 + boltCenterOffset)] )
                {
                    rotate( [0, 90, 0] )
                    {
                        m4Nut();
                        translate( [0, 0, -10] )
                        {
                            m4ThroughHole();
                        }
                    }
                }

                // Top left nut trap angle cutout
                rotate( [0, 0, 30] )
                {
                    cube( [topBoltCutoutWidth, topBoltCutoutHeight + 5, (height + 2)] );
                }

                // Top right nut trap angle cutout
                translate( [(cutoutXY - (toleranceGap * 2) - (topBoltCutoutWidth * 2)), 0, height + 2] )
                {
                    rotate( [0, 180, -30] )
                    {
                        cube( [topBoltCutoutWidth, topBoltCutoutHeight + 5, (height + 2)] );
                    }
                }
            }
            internalNutTraps();
        }
    }

}

module roundedBodyCorners()
{
    xOffset = -3.2;
    yOffset = 11;

    translate( [(-1 * thickness) - 10 + xOffset, (-1 * (thickness + 10)) + yOffset, -1 ] )
    {
        rotate( [0, 0, -45] )
        {
            cube( [20, 10, height + 2] );
        }
    }

    translate( [cutoutXY + 14.0, 2, -1 ] )
    {
        rotate( [0, 0, -135] )
        {
            cube( [20, 10, height + 2] );
        }
    }

    translate( [cutoutXY + thickness + topThickness - 2.9, cutoutXY + thickness + yOffset + (topThickness - 20), -1 ] )
    {
        rotate( [0, 0, 135] )
        {
            cube( [20, 10, height + 2] );
        }
    }

    translate( [(-1 * thickness) - (topThickness - 9.6), cutoutXY + thickness  + (topThickness - 16.4), -1 ] )
    {
        rotate( [0, 0, 45] )
        {
            cube( [20, 10, height + 2] );
        }
    }
}

module m4Nut()
{
    cylinder(h = 4.6, r = 4.45, $fn=6);
}

module m4HeadCutout()
{
    cylinder(h = 4.2, r = 3.8 );
}

module m4ThroughHole()
{
    cylinder( r=2.5, h=20, center=false );
}

// An internal nut trap will go 2.1mm deeper than necessary to make sure it's recessed enough to allow room for the bolt to be screwed in without boring into the motor body
module m3InternalNut()
{
    cylinder(h = 4.8, r = 3.55, $fn=6);
}

module m3ThroughHole()
{
    cylinder( r=1.9, h=20, center=false );
}

module m3HeadCutout()
{
    cylinder(h = 3.4, r = 3.15 );
}

// A spacer to serve as a placeholder for m3 hole placement
module m3Spacer( height, extraBorder )
{
    radius = 1.9;
    difference()
    {
        {
            cylinder( r=(radius + 2.6 + (extraBorder/2)), h=height, center=false );
        }
        {
            cylinder( r=radius, h=height, center=false );
        }
    }
}

module connectedM3ThroughHoles( xDistance, yDistance )
{
    m3ThroughHole();
    translate( [xDistance, yDistance, 0] )
    {
        m3ThroughHole();
    }

}

module connectedM3HeadCutouts( xDistance, yDistance )
{
    m3HeadCutout();
    translate( [xDistance, yDistance, 0] )
    {
        m3HeadCutout();
    }
}

module connectedM3Spacers( height, xDistance, yDistance )
{
    if( yDistance < 1)
    {
        difference()
        {
            {
                union()
                {
                    m3Spacer( height, 2 );
                    translate( [xDistance, yDistance, 0] )
                    {
                        m3Spacer( height, 2 );
                    }
                    translate( [0, (-1 * (9/2)), 0] )
                    {
                        cube( [xDistance, 9, height] ); 
                    }
                }
            }
            {
                translate( [0, 0, -10] )
                {
                    connectedM3ThroughHoles( xDistance, yDistance );
                }
            }
        }
        
        
    }
    else
    {
        translate( [(-1 * (6/2)), 0, 0] )
        {
            cube( [(height + 3.2), yDistance, height] );
        }
    }
    
}

// Create an "S" shaped curve for model strength on what would otherwise be a corner
module essCurve( d, h )
{
  xDimension = d;
  yDimension = d;
  zDimension = h;

  difference()
    {
      {
        translate( [(-1 * (xDimension / 2)), (-1 * (yDimension / 2)), 0] )
        {
          cube( [xDimension, yDimension, zDimension] );
        }
      }
      {
        translate( [ 0, 0, -1 ] )
        {
          cube( [xDimension, yDimension, (zDimension + 2)] );

          translate( [0, (-1 * yDimension), 0] )
          {
            cube( [xDimension, yDimension, (zDimension + 2)] );
          }
          translate( [(-1 * xDimension), 0, 0] )
          {
            cube( [xDimension, yDimension, (zDimension + 2)] );
          }

          linear_extrude( height=(zDimension + 2), twist=0, scale=[1, 1], center=false)
          {
            $fn=64;    //set sides to 64
            circle(r=(xDimension / 2));
          }
          
        }

      }
    
  }
}