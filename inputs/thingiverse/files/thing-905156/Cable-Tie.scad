// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Original Author: Jetty, March, 2013
//	Modified to add a label GordonEndersby June 2015
//
// Cable Tie
//
// Print with 100% fill, 0.27mm Layer Height and 0 shells.
//
// Material Choice:  
//					Taulman3D 618 Nylon is the best choice of material, and has similar performance to 
//					commercial cable ties which are also made from Nylon.				
//					
//					ABS should be considered "Single Careful Use", i.e. clamp large items where the bend
//					of the cable tie does not exceed the strength of the material.
//
//					PLA should be avoided, it will work, but PLA is brittle
//



// Customizer


include <utils/build_plate.scad>

// preview[view:south, tilt:top]

// Length of the cable tie
length						= 190;		//190

// If set to yes, add a screw hole to the cable tie head.
screwHole					= 0;			// [0:No, 1:Yes]

// If set to yes, add a label to the cable tie head.
label  					= 1;			// [0:No, 1:Yes]

// Width of the label
labelWidth					= 30;		//30

// Depth of the label
labelDepth					= 20;		//20

// If set to yes, add a release tab to the Pawl.
releaseTab					= 0;			// [0:No, 1:Yes]

// Width of the tape.  Range 5.6 - Unlimited.
tapeWidth					= 6.6;		//Default: 6.6,  Min: 5.6,  Max: No Upper Limit 

// Thickness of the tape.  Range 1.2 - 2.
tapeThickness				= 1.6;

// Amounts that are 2 x the nozzle diameter are best, effects scaling of the mechanics.  Range 0.4 - 0.8.
tapeScale					= 0.8;


//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module dummy() {}        // stop customiser processing variables

// End Customizer


$fn = 10;
manifoldCorrection = 0.01;

partCount					= 1;

nozzleDiameter				= tapeScale;
layerHeight					= tapeThickness / 8;

tapeGearPitch				= 4 * nozzleDiameter;
tapeGearBorderThickness		= 2 * nozzleDiameter;
tapeGearWidth				= tapeWidth - tapeGearBorderThickness * 2;

leaderThickness				= 0.5 * tapeThickness;
leaderHeightDifference		= tapeThickness - leaderThickness;
leaderTaperedLength			= 4 * tapeGearPitch; 
leaderRoundedFrontDiameter	= 4 * nozzleDiameter;
leaderRetainerThickness		= 3 * layerHeight;
leaderRetainerWidth			= 1 * nozzleDiameter * 1.1;
leaderRetainerCount			= 8;

pawlWidth					= tapeGearWidth - nozzleDiameter * 2;
pawlThickness				= 20 * layerHeight;
pawlToothCount				= 3;
pawlAngle					= 13;
pawlAttachmentThickness		= 12 * layerHeight;


headWidth					= tapeWidth * 1.5;
headLength					= tapeThickness * 3 + tapeWidth;
headHeight					= pawlToothCount * tapeGearPitch + pawlAttachmentThickness / 2;
headTapeGuideWidth			= tapeWidth + nozzleDiameter;
headTapeGuideThickness		= tapeThickness + nozzleDiameter * 2;
headTapeGuidePosition		= [-headLength + tapeWidth / 2, -headWidth / 2 + (headWidth - headTapeGuideWidth) / 2, -manifoldCorrection];
headCornerRadius				= nozzleDiameter;
headPawlCutoutLength			= tapeThickness * 2;
headPawlCutoutPosition		= headTapeGuidePosition + [headTapeGuideThickness - manifoldCorrection, (headTapeGuideWidth - tapeGearWidth) / 2, 0];

pawlAttachmentDimensions		= [headPawlCutoutLength, tapeGearWidth, pawlAttachmentThickness / 2];

pawlPosition					= [headPawlCutoutPosition[0] + pawlThickness - pawlThickness * 0.15, 0, pawlAttachmentThickness / 2];
pawlAttachmentPosition		= [headPawlCutoutPosition[0] + tapeGearPitch/2, -pawlAttachmentDimensions[1] / 2, 0];

releaseTabDimenisons			= [pawlThickness * 0.75, pawlWidth, pawlAttachmentThickness * 2.5];
releaseTabPosition			= [- pawlThickness * 1.4 + headCornerRadius, -pawlWidth / 2, tapeGearPitch * pawlToothCount - tapeGearPitch / 2];

screwHoleOuterDiameter		= headWidth;
screwHoleBorder				= screwHoleOuterDiameter * 0.2;
screwHoleInnerDiameter		= screwHoleOuterDiameter - screwHoleBorder * 2;
screwAttachmentThickness		= 24 * layerHeight;
screwAttachmentLength		= 1.75 * headLength - headCornerRadius;

labelThickness = 1;

leaderLength					= 15 * tapeGearPitch;
tapeLength					= floor((length - leaderLength) / tapeGearPitch) * tapeGearPitch;
completeLength				= headLength + tapeLength + leaderLength;
leaderFilletLength			= 0.1 * leaderLength;

leaderRetainerCountSpacing	= (leaderLength - (leaderTaperedLength + leaderFilletLength)) / (leaderRetainerCount + 1);

cableTieCenterPosition		= [- (headLength + tapeLength + leaderLength) / 2, 0, 0];



// Position so the cable tie is centered on the build platform
for ( i = [0:partCount-1] )
{
	translate( [0, i * headWidth * 1.25, 0] )
		translate( [0, -((partCount - 1) / 2) * headWidth * 1.25, 0] )	//Center all the parts
			translate( cableTieCenterPosition )
				if ( screwHole )
				{
					translate( [((screwAttachmentLength - headLength - headCornerRadius) + screwHoleOuterDiameter / 2) / 2, 0, 0] )
						cableTie();
				}
				else		cableTie();
}



// Create the whole cable tie

module cableTie()
{
	//Make it so the origin is at the start of the cable tie, i.e. the head
	translate( [headLength, 0, 0] )
	{
		translate( [manifoldCorrection, 0, 0] )
			head();
		if ( screwHole )
				screwHoleAttachment();
		if ( label )
				labelAttachment();

		tape();
		translate( [-manifoldCorrection, 0, 0] )
			leader();
	}
}

module labelAttachment()
{
	translate( [-headLength -labelDepth +2, - labelWidth / 2, 0] )
	{
		cube( [labelDepth,labelWidth,labelThickness]);
	}
}

module screwHoleAttachment()
{
	translate( [-(screwAttachmentLength - headCornerRadius), 0, 0] )
		difference()
		{
			union()
			{
				cylinder( r = screwHoleOuterDiameter / 2, h = headHeight, $fn = 40 );
			
				translate( [headCornerRadius, -headWidth / 2, 0] )
					cube( [screwAttachmentLength - headLength, headWidth, screwAttachmentThickness] );
			}

			translate( [0, 0, -manifoldCorrection] )
				cylinder( r = screwHoleInnerDiameter / 2, h = headHeight + manifoldCorrection * 2, $fn = 40 );
		}

}



//Create the head and pawl

module head()
{
	difference()
	{
		// The rounded box for the head
		translate( [-headLength / 2, 0, 0] )
			roundedBox(width=headLength, length=headWidth, height=headHeight, cornerRadius = headCornerRadius);

		// The cutout for the tape guide
		translate( headTapeGuidePosition )
			cube( [headTapeGuideThickness, headTapeGuideWidth, headHeight + manifoldCorrection * 2] );

		// The cutout for the pawl
		translate( headPawlCutoutPosition )
			cube( [headPawlCutoutLength, tapeGearWidth, headHeight + manifoldCorrection * 2] );
	}

	// The pawl attachment
	translate( pawlAttachmentPosition )
		cube( pawlAttachmentDimensions );

	// The pawl
	translate( pawlPosition )
	{
		rotate( [0, -pawlAngle, 0] )
			pawl();

		if ( releaseTab )
		{
			translate( releaseTabPosition )
				cube( releaseTabDimenisons );
		}
	}
}



// Creates a rounded box

module roundedBox(width, length, height, cornerRadius)
{
		cylinderOffsetY = headWidth / 2 - cornerRadius;
		cylinderOffsetX = headLength / 2 - cornerRadius;

		hull()
		{
			for( offsetMult = [[-1, -1], [1, -1], [1, 1], [-1, 1]] )
				translate( [ offsetMult[0] * cylinderOffsetX, offsetMult[1] * cylinderOffsetY, 0] )
					cylinder( r = cornerRadius, h = height, $fn = 10 );
		}
}



//Creates the gear tape

module tape()
{
	translate( [0, 0, tapeThickness] )
		rotate( [180, 0, 0] )
			difference()
			{
				// Create the tape
				translate( [0, -tapeWidth / 2, 0] )
					cube( [tapeLength, tapeWidth, tapeThickness] );
	
				// Create the gear
				for ( i = [0: tapeGearPitch: tapeLength] )
					translate( [i, 0, layerHeight] )
						oneTapeGearRecess();
			}
}




//Creates the leader 

module leader()
{
	translate( [tapeLength, 0, 0] )
	{
		// The flat part of the leader, which is a cubed hulled with a cylinder to form the tapered end
		hull()
		{
			// The cube
			translate( [0, -tapeWidth / 2, 0] )
				cube( [leaderLength - leaderTaperedLength, tapeWidth, leaderThickness] );

			// The rounded end
			translate( [0 + leaderLength, 0, 0] )
				cylinder( r = leaderRoundedFrontDiameter / 2, h = leaderThickness, $fn = 10 );
		}

		// Add the fillet between the main piece of tape and leader
		translate( [0, tapeWidth / 2, leaderThickness - manifoldCorrection] )
			rotate([90, 0, 0] )
				linear_extrude(height = tapeWidth)
					polygon([ [0, leaderHeightDifference],
							  [leaderFilletLength, 0],
							  [0, 0]]);

		// Create the retainers
		translate( [leaderFilletLength, 0, leaderThickness] )
		{
			for ( i = [1: leaderRetainerCount] )
				translate( [i * leaderRetainerCountSpacing, -tapeGearWidth / 2, 0] )
					cube( [leaderRetainerWidth, tapeGearWidth, leaderRetainerThickness] );
		}
	}
}



module pawl()
{
	rotate( [0, 0, 180] )
		translate( [0, 0, tapeGearPitch * pawlToothCount] )
			rotate( [0, 90, 0] )
				difference()
				{	
					// Create the main part of the pawl
					translate( [0, -pawlWidth / 2, 0] )
						cube( [tapeGearPitch * pawlToothCount, pawlWidth, pawlThickness] );

					// Create the teeth in the pawl
					for ( i = [0: tapeGearPitch: tapeGearPitch * pawlToothCount] )
						translate( [i + manifoldCorrection, 0, layerHeight] )
							onePawlRecess();
				}
}



// Creates one tooth in the pawl

module onePawlRecess()
{
	translate( [0, pawlWidth / 2 + manifoldCorrection, pawlThickness + manifoldCorrection] )
		rotate([90, 0, 0] )
			linear_extrude(height = pawlWidth + manifoldCorrection * 2 )
				polygon([[0,0],[tapeGearPitch,-tapeGearPitch/2],[tapeGearPitch,0]]);
}



// Creates one tooth in the gear tape

module oneTapeGearRecess()
{

	translate( [0, tapeGearWidth / 2, tapeThickness + nozzleDiameter * 0.25 + manifoldCorrection] )
		rotate([90, 0, 0] )
			linear_extrude(height = tapeGearWidth )
				polygon([[0,0],[tapeGearPitch/2,-tapeGearPitch/2],[tapeGearPitch,-tapeGearPitch/2],[tapeGearPitch,0]]);
}

