/**
Make 6 drawers that run the full drawer depth.
Assorted packs of resistors ordered from Amazon typically come in 30 denominations, so 5 drawers with 6 compartments is perfect for my needs.

Use the Thingiverse Customizer or OpenSCAD to change the build parameters.

- costmo
- 2017-10-12
**/

// Various measurements
// Number of compartments to make
numCompartments = 6;
// How thick to make the outer walls
wallThickness = 1;
// How round to make the corners
cornerRadius = 2; 
// The total width of the drawer
totalWidth = 120; 
// The usable (inner) width of the drawer
usableWidth = (totalWidth - (wallThickness * 2));
// The number of inner walls there will be
numInnerWalls = numCompartments - 1;
// The width of each section's cutout block
innerSectionWidth = (totalWidth - ((wallThickness * 2) + (wallThickness * numInnerWalls))) / numCompartments;
// The total height of the drawer
totalHeight = 18; 

// Minimum angle -- use for final rendering. Comment for preview.
$fa = 4; 
// Minumum size -- use for final rendering. Comment for preview.
$fs = 0.5; 

// Rotate the whole thing 180 deg so that the STL file preview is oriented correctly on Thingiverse :-)
rotate( a = 180, v = [0, 0, 1] )
{
	union() // make the unit by pulling in the orginial drawer, fill the drawer, then cutout rounded rectangles
	{
		// pull in the original model and move it to somewhere on the platform that's easier to translate
		translate( [5, -133, 0] )
		{
			import( "Drawer_1_compartment.stl" );
		}
		difference()
		{
			// make a cube that fills the tray
			translate( [(-1 * (wallThickness + usableWidth)), wallThickness, wallThickness] )
			{
				cube( [usableWidth, usableWidth, (totalHeight - wallThickness)] );
			}
			for( i = [1 : 1: numCompartments] ) // remove the compartments
			{
				loopY = ((i * wallThickness) + ((i - 1) * innerSectionWidth));
				wallCutout( loopY );
			}
		}
	}
}

// create a block for cutout (difference) from a loop
module wallCutout( positionY )
{
	hull()
	{
		translate( [(-1 * (usableWidth)), (positionY + cornerRadius), (wallThickness + cornerRadius)] ) // main block
		{
			cube( [(usableWidth - cornerRadius - wallThickness), (innerSectionWidth - (cornerRadius * 2)), (totalHeight - wallThickness)] ); // main cube for the cutout
		}
		union() // spheres for corner hulls
		{
			innerCutoutCorners( positionY, (wallThickness + cornerRadius) ); // bottom corners
			innerCutoutCorners( positionY, (totalHeight) ); // top corners
		}
	}
}

// Add corners to the cutout to create a hull
module innerCutoutCorners( positionY, positionZ )
{
	translate( [(-1 * (cornerRadius + wallThickness)), (positionY + cornerRadius), positionZ] )
	{
		sphere( cornerRadius );
	}
	translate( [(-1 * usableWidth), (positionY + cornerRadius), positionZ] )
	{
		sphere( cornerRadius );
	}
	translate( [(-1 * (cornerRadius + wallThickness)), (positionY + innerSectionWidth - cornerRadius), positionZ] )
	{
		sphere( cornerRadius );
	}
	translate( [(-1 * usableWidth), (positionY + innerSectionWidth - cornerRadius), positionZ] )
	{
		sphere( cornerRadius );
	}
}

