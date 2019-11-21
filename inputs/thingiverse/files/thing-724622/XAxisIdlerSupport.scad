// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, 9th August, 2012
//
//
// X-Axis Idler Support Bracket for Thing-O-Matic

// Small changes by Aaron Ciuffo - aaron.ciuffo@gmail.com
// removed endstopSpacers to accomodate strain relief thing:
// http://www.thingiverse.com/thing:15489

manifoldCorrection = 0.1;
plateDimensions = [40, 75, 5];
squareHoleDimensionsSide = [10.5, 5.5, plateDimensions[2] + manifoldCorrection * 2];
squareHoleDimensionsEnd = [squareHoleDimensionsSide[1], squareHoleDimensionsSide[0], squareHoleDimensionsSide[2]];
hole1LocationX = 2.1;
hole2LocationX = 22.2;
holeSideLocationY = 1.8;
hole3LocationX = 32.35;
holeEndLocationY = 22.3;
boltHoleM3Radius = 3.3 / 2;
boltHoleM3SideLocationX = 15.75 + boltHoleM3Radius;
boltHoleM3SideLocationY = 2.85 + boltHoleM3Radius;
boltHoleM3EndLocationX = 27.75 + boltHoleM3Radius;
boltHoleM3EndLocationY1 = 33 + boltHoleM3Radius;
boltHoleM3EndLocationY2 = 52.2 + boltHoleM3Radius;
endstopSpacerRadius = 8 / 2;
endstopSpacerHeight = 0;
idlerRetainerOuterRadius = 15.5 / 2;
idlerRetainerInnerRadius = 7 / 2;
idlerRetainerHeight = 3.2;
idlerRetainerLocationX = 17.3;
idlerRetainerLocationY = 28.75;
boltSupportInnerRadius = 3.2 / 2;
boltSupportHeight = 14;
boltSupportOuterRadius = 15 / 2;

$fn = 40;

idlerPlate();
translate( [-(plateDimensions[0] / 2 + idlerRetainerOuterRadius + 5), 0, 0] )
	boltSupport();


module boltSupport()
{
	difference()
	{
		cylinder( r = boltSupportOuterRadius, h = boltSupportHeight );
		translate( [0, 0, -manifoldCorrection] )
			cylinder( r = boltSupportInnerRadius, h = boltSupportHeight + manifoldCorrection * 2 );
	}
}



module idlerPlate()
{
	translate( [-plateDimensions[0] / 2, -plateDimensions[1] / 2, 0] )
	{
		difference()
		{
			//The main plate
			union()
			{
				cube( plateDimensions );

				//Add the end stop spacers
				translate( [boltHoleM3EndLocationX, boltHoleM3EndLocationY1, 0] )
					cylinder( r = endstopSpacerRadius, h = endstopSpacerHeight + plateDimensions[2] );
				translate( [boltHoleM3EndLocationX, boltHoleM3EndLocationY2, 0] )
					cylinder( r = endstopSpacerRadius, h = endstopSpacerHeight + plateDimensions[2] );	
	
				//Add the idler bolt retainer
				translate( [idlerRetainerLocationX, idlerRetainerLocationY, 0] )
					cylinder( r = idlerRetainerOuterRadius, h = idlerRetainerHeight + plateDimensions[2] );
			}

			//Remove holes
			translate( [0, 0, -manifoldCorrection] )
			{
				//Side Square Holes (1 and 2)
				for ( x = [hole1LocationX, hole2LocationX] )
				{
					translate( [x, holeSideLocationY, 0] )
						cube( squareHoleDimensionsSide );
					translate( [x, plateDimensions[1] - (holeSideLocationY + squareHoleDimensionsSide[1]), 0] 	)
						cube( squareHoleDimensionsSide );
				}

				//End Square Holes (3)
				translate( [hole3LocationX, holeEndLocationY, 0] )
					cube( squareHoleDimensionsEnd );
				translate( [hole3LocationX, plateDimensions[1] - (holeEndLocationY + squareHoleDimensionsEnd[1]), 0] )
					cube( squareHoleDimensionsEnd );

				//Side Bolt Holes
				translate( [boltHoleM3SideLocationX, boltHoleM3SideLocationY, 0] )
					cylinder( r = boltHoleM3Radius, h = plateDimensions[2] + manifoldCorrection * 2 );
				translate( [boltHoleM3SideLocationX, plateDimensions[1] - boltHoleM3SideLocationY, 0] )
					cylinder( r = boltHoleM3Radius, h = plateDimensions[2] + manifoldCorrection * 2 );	

				//Endstop Bolt Holes
				translate( [boltHoleM3EndLocationX, boltHoleM3EndLocationY1, 0] )
					cylinder( r = boltHoleM3Radius, h = plateDimensions[2] + endstopSpacerHeight + manifoldCorrection * 2 );
				translate( [boltHoleM3EndLocationX, boltHoleM3EndLocationY2, 0] )
					cylinder( r = boltHoleM3Radius, h = plateDimensions[2] + endstopSpacerHeight + manifoldCorrection * 2 );

				//Idler hole
				translate( [idlerRetainerLocationX, idlerRetainerLocationY, 0] )
					cylinder( r = idlerRetainerInnerRadius, h = idlerRetainerHeight + plateDimensions[2] + manifoldCorrection * 2 );

			}
		}
	}
}