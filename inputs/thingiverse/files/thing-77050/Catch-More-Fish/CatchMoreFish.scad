// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, February, 2013
//
//
// Catch More Fish

// 2 x Pivot Joint Plate (50% fill, 1 shell)
// 2 x Clamp Plate (100% fill, 1 shell, full support)
// 1 x Rod Holder (15% fill, 2 shells)
// 1 x Hook Setter Clip (100% fill, 2 shells) - You may want to print a few of these with different clip angles for spares and different rods

// Hook Setter Clip, print at 100% fill, 2 shells
// Clamp print at 100% fill and full support
// Quick Release clamp uses 6-32 Nut and 6-32 x 2 inch CounterSunk Machine Screw
// Everything else, print at 50%

// Customizer

include <utils/build_plate.scad>

// preview[view:north, tilt:top]

part	 = "platePivotJoint";		// [platePivotJoint:Pivot Joint Plate, plateClamp:Pivot Joint Quick Release Clamp Plate, rodHolder:Rod Holder, hookSetterClip:Hook Setter Clip, pivotBlock:Pivot Block, bearingBlock:Bearing Block, bearingBlockNut:Bearing Block With Nut, quickReleaseClamp:Quick Release Clamp, quickReleaseBearing:Quick Release Bearing]

toleranceFitClearance = 0.15;		// [0.0,0.05,0.1,0.15,0.2,0.25,0.3]

bearingNutDiameter = 9.5;
bearingNutThickness = 2;
boltDiameter = 4;
boltHeadDiameter = 7;
boltCountersunkDepth = 3;
hookSetterClipAngle = 75;

module dummy() {}        // stop customiser processing variables

// End Customizer



manifoldCorrection = 0.02;



// Hook Setter Clip
hookSetterClipThickness = 2;
hookSetterClipWidth = 3;


// Pivot Joint
tSlotSize = 20;
tSlotCornerRadius = 3.5;
attachmentThickness = 2.25;
//attachmentBlockLength = 30;		//  TESTING - REMOVE ***********
attachmentBlockLength = tSlotSize + attachmentThickness * 2;
attachmentBlockDimensions = [tSlotSize + attachmentThickness * 2 + toleranceFitClearance * 2,
							tSlotSize + attachmentThickness * 2 + toleranceFitClearance * 2,
							attachmentBlockLength];
attachmentBlockCenter = [-attachmentBlockDimensions[0] / 2, -attachmentBlockDimensions[1] / 2, 0];
attachmentBlockInsideRemoval1 = [tSlotSize, tSlotSize - tSlotCornerRadius * 2, attachmentBlockDimensions[2] + manifoldCorrection * 2];
attachmentBlockInsideRemoval2 = [tSlotSize - tSlotCornerRadius * 2, tSlotSize, attachmentBlockDimensions[2] + manifoldCorrection * 2];
attachmentBlockInsideRemoval1Center = [-attachmentBlockInsideRemoval1[0] / 2, -attachmentBlockInsideRemoval1[1] / 2, -manifoldCorrection];
attachmentBlockInsideRemoval2Center = [-attachmentBlockInsideRemoval2[0] / 2, -attachmentBlockInsideRemoval2[1] / 2, -manifoldCorrection];

retainingInsertDimensions = [5 - toleranceFitClearance, 3 - toleranceFitClearance * 2, attachmentBlockDimensions[2]];
retainingInsertDimensionsCenter = [0, -retainingInsertDimensions[1] / 2, 0];

retainingInsertFlangeDimensions = [6.5 - toleranceFitClearance * 2, 2.5 - toleranceFitClearance * 2];

attachmentBlockKeyThickness = 2;
attachmentBlockKeyDimensionsPivot = [attachmentBlockDimensions[0], attachmentBlockKeyThickness, attachmentBlockDimensions[1]];
attachmentBlockKeyDimensionsAttachment = [attachmentBlockDimensions[0], attachmentBlockKeyThickness, attachmentBlockDimensions[2]];
attachmentBlockKeyPositionPivot = [-attachmentBlockDimensions[0] / 2, attachmentBlockDimensions[1] / 2, attachmentBlockDimensions[2] - manifoldCorrection];
attachmentBlockKeyPositionAttachment = [-attachmentBlockDimensions[0] / 2, attachmentBlockDimensions[1] / 2 - manifoldCorrection, 0];
attachmentBlockKeyWayDimensions = [3, attachmentBlockKeyThickness + manifoldCorrection * 2, 5 + manifoldCorrection];
attachmentBlockKeyWayDimensionsWithTolerance = [attachmentBlockKeyWayDimensions[0] - toleranceFitClearance, 
											  attachmentBlockKeyWayDimensions[1],
											  attachmentBlockKeyWayDimensions[2] - toleranceFitClearance];
attachmentBlockKeyWayPosition1 = [(attachmentBlockDimensions[2] - attachmentBlockKeyWayDimensions[0] ) / 2,
								 -manifoldCorrection,
								 attachmentBlockDimensions[0] - attachmentBlockKeyWayDimensions[2] + manifoldCorrection];
attachmentBlockKeyWayPosition2 = [(attachmentBlockDimensions[2] - attachmentBlockKeyWayDimensions[0] ) / 2,
								-manifoldCorrection,
								-manifoldCorrection];
attachmentBlockKeyWayPosition3 = [(attachmentBlockDimensions[0] - attachmentBlockKeyWayDimensions[0]) / 2,
								-manifoldCorrection,
								(attachmentBlockDimensions[1] - attachmentBlockKeyWayDimensions[2] + attachmentBlockKeyWayDimensions[2]) / 2 - manifoldCorrection];
attachmentBlockKeyWayPosition4 = [attachmentBlockKeyWayPosition1[0],
								-manifoldCorrection,
								(attachmentBlockDimensions[1] - attachmentBlockKeyWayDimensions[2] - attachmentBlockKeyWayDimensions[2]) / 2 + manifoldCorrection];
bearingBlockRadius = attachmentBlockDimensions[0] / 2;
bearingBlockClearance = 2;
bearingProtrusion = 1;
bearingBlockBottomDimensions = [attachmentBlockDimensions[0], attachmentBlockKeyThickness + bearingBlockClearance + bearingBlockRadius, attachmentBlockDimensions[2] / 4 - bearingProtrusion];
bearingBlockUprightDimensions = [attachmentBlockDimensions[0], attachmentBlockKeyThickness, attachmentBlockDimensions[2] / 2];
bearingBlockBottomUprightCenter = [-bearingBlockBottomDimensions[0] / 2, 0, 0];
bearingBlockKeyWayPosition = [(attachmentBlockDimensions[0] - attachmentBlockKeyWayDimensionsWithTolerance[0]) / 2,
								-attachmentBlockKeyWayDimensionsWithTolerance[1],
								0];

quickReleaseBearingBorder = 6;
quickReleaseBearingDiameter = boltHeadDiameter + 4 * 2;
quickReleaseBearingLength = boltHeadDiameter + quickReleaseBearingBorder * 2;
quickReleaseClampBorder = 4;
quickReleaseHandleLength = quickReleaseBearingDiameter * 3;
quickReleaseClampHandlePosition = [0, 9.75, 0];



partClearance = 5;
attachmentBlockPlatePosition = [-(attachmentBlockDimensions[0] * 2 + attachmentBlockKeyThickness * 2 + partClearance * 2), 0, 0];
pivotBlockPlatePosition = [-(attachmentBlockDimensions[0] * 1.0 + attachmentBlockKeyThickness + partClearance), 0, 0];
bearingBlockPlatePosition1 = [0, -(bearingBlockBottomDimensions[0] / 2), 0];
bearingBlockPlatePosition2 = [-(bearingBlockBottomDimensions[0] + partClearance) * 2, (attachmentBlockDimensions[0] + partClearance), 0];
bearingBlockPlatePosition3 = [-(bearingBlockBottomDimensions[0] + partClearance), (attachmentBlockDimensions[0] + partClearance), 0];
bearingBlockPlatePosition4 = [0, (attachmentBlockDimensions[1] + partClearance), 0];
quickReleaseBearingPlatePosition = [0, (attachmentBlockDimensions[0] + partClearance) * 2 + bearingBlockRadius, 0];
quickReleaseClampPlatePosition = [-(quickReleaseHandleLength + quickReleaseBearingLength / 2 + partClearance), (attachmentBlockDimensions[0] + partClearance) * 2 + bearingBlockRadius, 0];


// Rod Holder
outerPipeDiameter = 50;
innerPipeDiameter = 40;
pipeTilt = 28;
pipeLength = 85 + 22;
pipeTiltPosition = [0, 0, 13];
baseDimensions = [100, 60, attachmentBlockDimensions[0]];
basePosition = [-baseDimensions[0] / 2, -baseDimensions[1] / 2, 0];
baseAntiWarpCutoutDimensions = [2, baseDimensions[1] + manifoldCorrection * 2, 2];
triggerAttachmentDimensions = [10, 10, baseDimensions[2] + 10];
triggerAttachmentHoleDiameter = 2.5;



$fn = 40;


if ( part == "platePivotJoint" || part == "pivotBlock" )
{
	if ( part == "platePivotJoint" )
		translate( pivotBlockPlatePosition )
			pivotBlock();
	else		pivotBlock();
}

if ( part == "platePivotJoint" || part == "bearingBlock" || part == "bearingBlockNut" )
{
	if ( part == "platePivotJoint" )
		for ( i = [ [bearingBlockPlatePosition1, false],
					[bearingBlockPlatePosition2, false],
					[bearingBlockPlatePosition3, false],
					[bearingBlockPlatePosition4, true]
				  ] )
			translate( i[0] )
				bearingBlock(i[1]);
	else	
	{
		if ( part == "bearingBlockNut" )	bearingBlock(true);
		else								bearingBlock(false);
	}
}

if ( part == "plateClamp" || part == "quickReleaseClamp" )
{
	if ( part == "plateClamp" )
		translate( quickReleaseClampPlatePosition )
			quickReleaseClamp();
	else		quickReleaseClamp();
}

if ( part == "plateClamp" || part == "quickReleaseBearing" )
{
	if ( part == "plateClamp" )
		translate( quickReleaseBearingPlatePosition )
			quickReleaseBearing();
	else		quickReleaseBearing();
}

if ( part == "rodHolder" )
{
	rodHolder();
}

if ( part == "hookSetterClip" )
{
	hookSetterClip();
}



module hookSetterClip()
{

$fn = 40;

lozenge( [hookSetterClipWidth, 30, hookSetterClipThickness] );
translate( [0, 0, 0] )
	rotate( [0, 0, -hookSetterClipAngle] )
		lozenge( [hookSetterClipWidth, hookSetterClipWidth * 2, hookSetterClipThickness] );

translate( [0, 30, 0] )
	rotate( [0, 0, 90] )
		lozenge( [hookSetterClipWidth, 15, hookSetterClipThickness] );

translate( [-13, 20, 0] )
	rotate( [0, 0, 12 ] )
		lozenge( [hookSetterClipWidth, 10, hookSetterClipThickness] );

translate( [-19, 14, 0] )
	rotate( [0, 0, -45 ] )
		lozenge( [hookSetterClipWidth, 8, hookSetterClipThickness] );

translate( [ -13, 3, 0] )
	rotate( [0, 0, 30] )
		lozenge( [hookSetterClipWidth, 12, hookSetterClipThickness] );

translate( [-4, 30 - hookSetterClipWidth, 0] )
	lozenge( [hookSetterClipWidth, hookSetterClipWidth * 2, hookSetterClipThickness] );
}



module lozenge( dimensions )
{
	translate( [-dimensions[0] / 2, 0, 0] )
		cube( [dimensions[0], dimensions[1], dimensions[2]] );
	cylinder( r = dimensions[0] / 2, h = dimensions[2] );
	translate( [0, dimensions[1], 0] )
		cylinder( r = dimensions[0] / 2, h = dimensions[2] );
}



module rodHolder()
{
	difference()
	{
		union()
		{
			translate( basePosition )
				cube( baseDimensions );
			translate( pipeTiltPosition )
				rotate( [0, pipeTilt, 0] )
					rodHolderPipe(pipeLength);

			translate( [0, baseDimensions[1] / 2 - triggerAttachmentDimensions[1], 0] )
				rodHolderTriggerAttachment();
			translate( [0, -baseDimensions[1] / 2, 0] )			
				rodHolderTriggerAttachment();
		}

		//Clean up the bottom
		translate( [0, 0, -baseDimensions[2]] )
			translate( basePosition )
				cube( baseDimensions );

		translate( [-baseDimensions[0] / 2, -baseDimensions[1] / 2, 0] )
			attachmentBlock();
		translate( [-baseDimensions[0] / 2 , baseDimensions[1] / 2 - attachmentBlockKeyWayDimensions[1] + manifoldCorrection * 2, 0] )
			attachmentBlock();

		//Anti warp cutouts
		for ( i = [1:4] )
		translate( [-baseDimensions[0] / 2 + baseDimensions[0] / 5 * i, -(baseDimensions[1] / 2 + manifoldCorrection), -manifoldCorrection] )
			cube( baseAntiWarpCutoutDimensions );
	}
}



module rodHolderPipe(length)
{
	difference()
	{
		cylinder(r = outerPipeDiameter / 2, h = length);
		cylinder(r = innerPipeDiameter / 2, h = length);
	}
}


module rodHolderTriggerAttachment()
{
	difference()
	{
		translate( [baseDimensions[0] / 2 - triggerAttachmentDimensions[1], 0, 0] )
			cube( triggerAttachmentDimensions );
		translate( [baseDimensions[0] / 2 - triggerAttachmentDimensions[1], 0, 0] )
			translate( [-manifoldCorrection, triggerAttachmentDimensions[1] / 2, triggerAttachmentDimensions[2] - (triggerAttachmentDimensions[2] - baseDimensions[2]) / 2] )
				rotate( [0, 90, 0] )
					cylinder( r = triggerAttachmentHoleDiameter / 2, h = triggerAttachmentDimensions[1] + manifoldCorrection * 2, $fn = 20 );
	}
}




module quickReleaseClamp()
{
	difference()
	{
		// Main cylinder for the clamp
		cylinder( r = quickReleaseBearingDiameter / 2 + quickReleaseClampBorder, h = quickReleaseBearingLength, $fn = 20 );

		// Remove the inner cylinder
		translate( [0, 0.1 * quickReleaseBearingDiameter, -manifoldCorrection] )
			cylinder( r = quickReleaseBearingDiameter / 2 + toleranceFitClearance, h = quickReleaseBearingLength + manifoldCorrection * 2);

		// Create 2 parts to the clamp
		translate( [0, 0, quickReleaseBearingBorder] )
			cylinder( r = (quickReleaseBearingDiameter / 2 + quickReleaseClampBorder) * 2, h = boltHeadDiameter );
	}

	// Create the main part of the handle
	translate( quickReleaseClampHandlePosition )
		rotate( [0, 0, -20] )
			cube( [quickReleaseHandleLength, quickReleaseBearingDiameter * 0.5, quickReleaseBearingLength] );
}



module quickReleaseBearing()
{
	difference()
	{
		// Bearing
		translate( [-quickReleaseBearingLength / 2, 0, 0.25 * quickReleaseBearingDiameter] )
			rotate( [0, 90, 0] )
				cylinder( r = quickReleaseBearingDiameter / 2, h = quickReleaseBearingLength );

		// Remove the bottom of the bearing
		translate( [-(quickReleaseBearingLength / 2 + manifoldCorrection), -quickReleaseBearingDiameter / 2, -0.5 * quickReleaseBearingDiameter] )
			cube( [quickReleaseBearingLength + manifoldCorrection * 2, quickReleaseBearingDiameter, 0.5 * quickReleaseBearingDiameter] );

		// Countersink the bolt
		translate( [0, 0, -manifoldCorrection] )
			cylinder( r1 = boltHeadDiameter / 2, r2 = boltDiameter / 2, h = boltCountersunkDepth + manifoldCorrection * 2 );

		// Make the bolt hole
		translate( [0, 0, -manifoldCorrection] )
			cylinder( r = boltDiameter / 2, h = quickReleaseBearingDiameter + manifoldCorrection * 2 );
	}
}



module bearingBlock(withNut)
{
	difference()
	{
		union()
		{
			translate( bearingBlockBottomUprightCenter )
			{
				cube( bearingBlockBottomDimensions );
				cube( bearingBlockUprightDimensions );
				translate( bearingBlockKeyWayPosition )
					cube( attachmentBlockKeyWayDimensionsWithTolerance );
			}
			translate( [0, bearingBlockBottomDimensions[1], 0] ) 
				cylinder( r = bearingBlockRadius, h = bearingBlockBottomDimensions[2] + bearingProtrusion );	
		}

		translate( [0, bearingBlockBottomDimensions[1], -manifoldCorrection] )
			cylinder( r = boltDiameter / 2, h = bearingBlockBottomDimensions[2] + bearingProtrusion + manifoldCorrection * 2 );
		if ( withNut )
			translate( [0, bearingBlockBottomDimensions[1], -manifoldCorrection] )
				cylinder( r = bearingNutDiameter / 2, h = bearingNutThickness + manifoldCorrection, $fn = 6 );
	}
}



//Centered on the center of the female t-slot

module attachmentBlock()
{
	translate( attachmentBlockKeyWayPosition1 )
		cube(attachmentBlockKeyWayDimensions );
	translate( attachmentBlockKeyWayPosition2 )
		cube(attachmentBlockKeyWayDimensions );
}



//Centered on the center of the female t-slot

module pivotBlock()
{
	translate( [0, 0, attachmentBlockDimensions[2] + attachmentBlockKeyDimensionsPivot[1]] )
	 	rotate( [0, 180, 0] )
		{
			femaleTSlot();

			//Add the keyed block to the side
			translate( attachmentBlockKeyPositionPivot )
				rotate( [90, 0, 0] )
					difference()
					{
						cube( attachmentBlockKeyDimensionsPivot );
						translate( attachmentBlockKeyWayPosition3 )
							cube(attachmentBlockKeyWayDimensions );
						translate( attachmentBlockKeyWayPosition4 )
							cube(attachmentBlockKeyWayDimensions );
					}
		}
}



module femaleTSlot()
{
		difference()
		{
			// Main block
			translate( attachmentBlockCenter )
				cube( attachmentBlockDimensions );

			// Rounded corners
			for ( i = [ [-1, -1], [-1, 1], [1, -1], [1, 1] ] )
			{
				translate( [i[0] * (tSlotSize / 2 - tSlotCornerRadius), i[1] * (tSlotSize / 2 - tSlotCornerRadius), -manifoldCorrection] )
					cylinder( r = tSlotCornerRadius, h = attachmentBlockDimensions[2] + manifoldCorrection * 2 );
			}

			// Inside removal
			translate( attachmentBlockInsideRemoval1Center )
				cube( attachmentBlockInsideRemoval1 );
			translate( attachmentBlockInsideRemoval2Center )
				cube( attachmentBlockInsideRemoval2 );
		}

		// Retainining inserts
		for ( i = [ [0, -1, 0], [90, 0, -1], [180, 1, 0], [270, 0, 1] ] )
		{
			translate( [i[1] * (tSlotSize / 2), i[2] * (tSlotSize / 2), 0 ] )
				rotate( [0, 0, i[0]] )
				{
					// Retaining insert joiner
					translate( retainingInsertDimensionsCenter )
						cube( retainingInsertDimensions );

					// Retaining insert flange
					translate( [retainingInsertDimensions[0] - retainingInsertFlangeDimensions[1], 0, 0] ) 
			 	    		linear_extrude( height = attachmentBlockDimensions[2]) 
            					polygon(points = [
												[0.00,								retainingInsertDimensions[1] / 2],
												[retainingInsertFlangeDimensions[1],	retainingInsertFlangeDimensions[0] / 2],
												[retainingInsertFlangeDimensions[1],	-retainingInsertFlangeDimensions[0] / 2],
												[0.00,								-retainingInsertDimensions[1] / 2]
											],
				    			        paths = [
												[0,1,2,3]
										    ] );
				}
		}
}