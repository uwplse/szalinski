// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, March, 2013
//
//
// Fish-On Now!
// Print 50% fill, 2 shells

// Customizer


include <utils/build_plate.scad>

// preview[view:south, tilt:top diagonal]

part	 = "plate";		// [plate:Plate, left:Left Enclosure, right:Right Enclosure, clips:Retainer Clips, rodAttachment:Rod Attachment]

rodDiameter = 3;		// [1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9]

retainerClipFitTolerance = 0.1;	// [0.0,0.05,0.1,0.15,0.2,0.25,0.3]

cableTieWidth = 4;	// [4:8]
cableTieHeight = 2;	// [2:8]

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module dummy() {}        // stop customiser processing variables

// End Customizer


//Buzzer dimensions
buzzerDiameter = 17.5;
buzzerLipDiameter = 14.5;
buzzerLipLength = 2;
buzzerLength = 14.5;				//Includes lip length
buzzerRetainerDiameter = buzzerDiameter - 4;
buzzerRetainerLength = 10;
buzzerPosition = [0, 0, 0];

//LED dimensions
ledDiameter = 5.75;
ledLipDiameter = 7.5;
ledLipThickness = 1.4;
ledHoleLength = 1.5;
ledRetainerLength = 2.0;
ledPosition = [0, ledRetainerLength - 2, 13];

//1/4W Resistor
resistorDiameter = 3.5;
resistorLength = 15;
resistorPosition = [0, 10, 14];

//Tilt switch
tiltSwitchDiameter = 6;
tiltSwitchLength = 24;
tiltSwitchRotation = 0;
tiltSwitchPosition = [0, 26, -4];

//On/Off Switch
onOffSwitchDimensions = [6, 12, 8];
onOffSwitchSwitchDimensions = [3, 6, 1.0];
onOffSwitchRetainerDimensions = [onOffSwitchDimensions[0], 8, 2];
onOffSwitchFlangeDimensions = [5, 20, 1];
onOffSwitchPosition = [0, 30, 18];

//Battery A23
batteryDiameter = 10.35;
batteryLength = 27 + 1 + 2;	//+1 for variance in battery length, + 2 for spring length
batteryPositiveDiameter = 5.5;
batteryPositiveLength = 1;
batteryPositiveTerminalDiameter = 8.25;
batteryPositiveTerminalThickness = 3.25;
batterySpringRetainerLength = 6;
batterySpringRetainerDiameter = 6;
batteryPosition = [0, 45, 6];

//Case dimensions, translation
caseBorder = 1;
caseDimensions = [buzzerDiameter + caseBorder * 2, 
				 batteryPosition[1] + batteryLength + batteryPositiveTerminalThickness + batteryPositiveLength + batterySpringRetainerLength + caseBorder,
				 caseBorder + buzzerDiameter / 2 + onOffSwitchPosition[2]];
caseTranslation =  [-caseDimensions[0] / 2, 0, -(buzzerDiameter / 2 + caseBorder)];


manifoldCorrection = 0.01;
manifoldCorrectionVect = [manifoldCorrection, manifoldCorrection, manifoldCorrection];

distanceBetweenLeftRightHolder = 5;
distanceBetweenLeftRightAndRodAttachment = 5;
distanceBetweenLeftRightAndRetainerClip = 5;

//Fishing rod attachment
cableTieRodHolderClearance = 2;

rodAttachmentDimensions = [rodDiameter * 2, 20, cableTieHeight + cableTieRodHolderClearance + rodDiameter / 2];
rodFlangeDimensions = [caseDimensions[0], caseDimensions[1], 3];
rodAttachmentPosition = [rodAttachmentDimensions[0] - caseDimensions[0] / 2 + rodFlangeDimensions[2],
						- rodAttachmentDimensions[1] / 2,
						-(buzzerDiameter / 2 + caseBorder + rodAttachmentDimensions[2] + rodFlangeDimensions[2]) ];
rodAttachmentPositionPlate = [(rodAttachmentDimensions[2] + rodFlangeDimensions[2]) - caseDimensions[0] / 2, -(caseDimensions[1] / 2 + rodFlangeDimensions[0] / 2 + distanceBetweenLeftRightAndRodAttachment), -caseDimensions[2]];
//rodAttachmentPositionAll = [-(rodAttachmentDimensions[0] - caseDimensions[0] / 2 + rodFlangeDimensions[2]), 0, 0];
rodAttachmentPositionAll = [0, 0, -(buzzerDiameter)];
					
cableTieDistanceFromEdge = 1.5;
cableTiePosition1 = [0, cableTieDistanceFromEdge, 0];
cableTiePosition2 = [0, (rodAttachmentDimensions[1] - cableTieWidth) - cableTieDistanceFromEdge, 0];


//Retainer Clips
retainerClipThickness = 2;
retainerClipInnerDimensions = [caseDimensions[0] + retainerClipFitTolerance, 7, caseDimensions[2] + rodFlangeDimensions[2] + + retainerClipFitTolerance ];
retainerClipOuterDimensions = [retainerClipInnerDimensions[0] + retainerClipThickness * 2,
							  retainerClipInnerDimensions[1], 
							  retainerClipInnerDimensions[2] + retainerClipThickness * 2];
retainerClip1PositionAll = [0, - (caseDimensions[1] - retainerClipOuterDimensions[1] ) / 2, (retainerClipOuterDimensions[2] - retainerClipInnerDimensions[2]) / 2];
retainerClip2PositionAll = [retainerClip1PositionAll[0], -retainerClip1PositionAll[1], retainerClip1PositionAll[2]];
retainerClip1PositionPlate = [- caseDimensions[0] / 2 + retainerClipOuterDimensions[1] / 2,
							 (caseDimensions[1] + retainerClipOuterDimensions[0] ) / 2 + distanceBetweenLeftRightAndRetainerClip,
							 distanceBetweenLeftRightAndRetainerClip / 2];
retainerClip2PositionPlate = [ retainerClip1PositionPlate[0],
							  retainerClip1PositionPlate[1],
							  -(retainerClip1PositionPlate[2] + retainerClipOuterDimensions[2])];


//Translation to put object in the center
centerTranslation = [ 0, -caseDimensions[1] / 2, 0];

//Connection Channels
channel1Dimensions = [4, 22, 10];
channel1Position = [-channel1Dimensions[0] / 2, 23.1, -2];
channel2Dimensions = [4, 6, 2];
channel2Position = [-channel1Dimensions[0] / 2, 4.1, 13];
channel3Dimensions = [4, 23, 2];
channel3Position = [-channel1Dimensions[0] / 2, 4, 10];
channel4Dimensions = [4, 3, 10];
channel4Position = [-channel1Dimensions[0] / 2, 23.9, 4];
channel5Dimensions = [4, 34, 7];
channel5Position = [-channel1Dimensions[0] / 2, 45, -3];
channel6Dimensions = [4, 10, 2];
channel6Position = [-channel1Dimensions[0] / 2, 75, -3];
channel7Dimensions = [4, 2, 10];
channel7Position = [-channel1Dimensions[0] / 2, 83, -3];

//Centered On Platform Correction
centeredOnPlatformCorrectionRotation = [0, -90, -90];
centeredOnPlatformCorrectionTranslation = [0, caseDimensions[2] / 2 + distanceBetweenLeftRightHolder / 2, caseDimensions[0] / 2];


$fn = 80;



translate( centeredOnPlatformCorrectionTranslation )
	rotate( centeredOnPlatformCorrectionRotation )
		fishAlert();



module fishAlert()
{
	if ( part == "plate" || part == "assembled" || part == "left" )
		leftHolder();

	if ( part == "plate" || part == "assembled" || part == "right" )
	{
		if	    ( part == "plate" )		rightHolder( translateZ = -caseDimensions[2] - distanceBetweenLeftRightHolder, rotateZ = 180 );
		else if ( part == "assembled" )	rightHolder( translateZ = 0, rotateZ = 0 );
		else					    			rightHolder( translateZ = 0, rotateZ = 180 );
	}

	if ( part == "plate" || part == "assembled" || part == "rodAttachment" )
	{
		if ( part == "plate" || part == "rodAttachment" )
		{
			translate( rodAttachmentPositionPlate )
				rotate( [90, 0, -90 ] )
					rodAttachment();	
		}
		else
		{
			translate( rodAttachmentPositionAll )
				rodAttachment();
		}
	}

	if ( part == "plate" || part == "assembled" || part == "clips" )
	{
		if ( part == "assembled" )
		{
			translate( retainerClip1PositionAll )
				retainerClip();
			translate( retainerClip2PositionAll )
				retainerClip();
		}
		else if ( part == "plate" || part == "clips" )
		{
			translate( retainerClip1PositionPlate )
				rotate( [0, 0, 90] )
					retainerClip();
			translate( retainerClip2PositionPlate )
				rotate( [0, 0, 90] )
					retainerClip();
		}
	}
}



module leftHolder()
{
	difference()
	{
		holder();
		translate( [manifoldCorrection, -caseDimensions[1], -caseDimensions[2]] )
			cube( [caseDimensions[0] / 2 , caseDimensions[1] * 2, caseDimensions[2] * 2] );
	}
}



module rightHolder()
{
	translate( [0, 0, translateZ] )
		rotate( [0, rotateZ, 0] )
			difference()
			{
				holder();
				translate( [-caseDimensions[0] / 2 - manifoldCorrection, -caseDimensions[1], -caseDimensions[2] ] )
					cube( [caseDimensions[0] / 2, caseDimensions[1] * 2, caseDimensions[2] * 2] );
			}
}



module holder()
{
	translate( centerTranslation )
	{
		difference()
		{
			translate( caseTranslation )
				cube( caseDimensions );
			components();
			channels();
		}
	}
}



module channels()
{
	translate( channel1Position )
		cube( channel1Dimensions );
	translate( channel2Position )
		cube( channel2Dimensions );
	translate( channel3Position )
		cube( channel3Dimensions );
	translate( channel4Position )
		cube( channel4Dimensions );
	translate( channel5Position )
		cube( channel5Dimensions );
	translate( channel6Position )
		cube( channel6Dimensions );
	translate( channel7Position )
		cube( channel7Dimensions );
}



module components()
{
	translate( buzzerPosition )
		buzzer();
	translate( ledPosition )
		led();
	translate( resistorPosition )
		resistor();
	translate( tiltSwitchPosition )
		tiltSwitch();
	translate( onOffSwitchPosition )
		onOffSwitch();
	translate( batteryPosition )
		battery();
}



module retainerClip()
{
	difference()
	{
		cube( retainerClipOuterDimensions, center = true );
		cube( retainerClipInnerDimensions + manifoldCorrectionVect, center = true );
	}
}



module rodAttachment()
{
	difference()
	{
		union()
		{
			//Flange
			translate(  [ -rodFlangeDimensions[0] / 2, - (rodFlangeDimensions[1] - rodAttachmentDimensions[1]) / 2, rodAttachmentDimensions[2] ] )
				cube( rodFlangeDimensions );

			//Block
			translate(  [ -rodAttachmentDimensions[0] / 2, 0, 0 ] )
				cube( rodAttachmentDimensions );
		}

		//Cutout for rod
		translate( [0, -manifoldCorrection, 0] )
			rotate( [-90, 0, 0] )
				cylinder( r = rodDiameter / 2, h = rodAttachmentDimensions[1] + 2 * manifoldCorrection );

		//Cable tie cutouts
		translate( cableTiePosition1 )
			cableTieCutOut();
		translate( cableTiePosition2 )
			cableTieCutOut();
	}
}



module cableTieCutOut()
{
	translate( [-(rodAttachmentDimensions[0] / 2 + manifoldCorrection), 0, rodAttachmentDimensions[2] - cableTieHeight] )
		cube( [rodAttachmentDimensions[0] + manifoldCorrection * 2, cableTieWidth, cableTieHeight] );
}



module onOffSwitch()
{
	translate( [ 0, onOffSwitchDimensions[1] / 2, 0 ] )
	{
		rotate( [-180, 0, 0 ] )
		{
			//Switch button
			translate( [ -onOffSwitchSwitchDimensions[0] / 2, -onOffSwitchSwitchDimensions[1] / 2, -manifoldCorrection ] )
				cube( onOffSwitchSwitchDimensions + manifoldCorrectionVect * 2);

			//Switch body
			translate( [ -onOffSwitchDimensions[0] / 2, -onOffSwitchDimensions[1] / 2, onOffSwitchSwitchDimensions[2] ] )
				cube( onOffSwitchDimensions + manifoldCorrectionVect * 2);
	
			//Switch Retainer
			translate( [-onOffSwitchRetainerDimensions[0] / 2, -onOffSwitchRetainerDimensions[1] / 2, onOffSwitchDimensions[2] + onOffSwitchSwitchDimensions[2]] )
				cube( onOffSwitchRetainerDimensions + manifoldCorrectionVect * 2 );

			//Switch Flange	
			translate( [ -onOffSwitchFlangeDimensions[0] / 2, -onOffSwitchFlangeDimensions[1] / 2, onOffSwitchSwitchDimensions[2] ] )		
				cube( onOffSwitchFlangeDimensions );

		}
	}
}



module resistor()
{
	rotate( [-90, 0, 0] )
		cylinder( r = resistorDiameter / 2, h = resistorLength );
}





module tiltSwitch()
{
	rotate( [-90, 0, 0] )
		cylinder( r = tiltSwitchDiameter / 2, h = tiltSwitchLength );
}



module led()
{
	translate( [ 0, -manifoldCorrection, 0 ] )
	{
		rotate( [-90, 0, 0] )
		{
			//LED body
			cylinder( r = ledDiameter / 2, h = ledHoleLength );
			translate( [ 0, 0, ledHoleLength - manifoldCorrection] )
				cylinder( r = ledLipDiameter / 2, h = ledLipThickness );

			//LED Retainer
			translate( [ 0, 0, ledHoleLength + ledLipThickness - manifoldCorrection * 2] )
				cylinder( r = ledDiameter / 2, h = ledRetainerLength );
		}
	}
}


module buzzer()
{
	rotate( [-90, 0, 0] )
	{
		//Buzzer body
		translate( [0, 0, -manifoldCorrection] )
			cylinder( r = buzzerLipDiameter / 2, h = buzzerLipLength + manifoldCorrection );
		translate( [ 0, 0, buzzerLipLength - manifoldCorrection ] )
			cylinder( r = buzzerDiameter / 2, h = buzzerLength - buzzerLipLength );
	
		//Buzzer Retainer
		translate( [ 0, 0, buzzerLength - manifoldCorrection * 2 ] )
			cylinder( r = buzzerRetainerDiameter / 2, h = buzzerRetainerLength) ;
	}
}



module battery()
{
	rotate( [-90, 0, 0] )
	{
		batteryPositiveTerminal();
		translate( [0, 0, batteryPositiveTerminalThickness] )
			cylinder( r = batteryDiameter / 2, h = batteryPositiveLength + 2 * manifoldCorrection);
		translate( [ 0, 0, batteryPositiveLength + batteryPositiveTerminalThickness - manifoldCorrection ] )
			cylinder( r = batteryDiameter / 2, h = (batteryLength) + 2 * manifoldCorrection );
		translate( [ 0, 0, batteryPositiveLength + batteryPositiveTerminalThickness + batteryLength - manifoldCorrection ] )		
			cylinder( r = batterySpringRetainerDiameter / 2, h = batterySpringRetainerLength + 2 * manifoldCorrection);
	}
}



module batteryPositiveTerminal()
{
	$fn = 6;
	
	cylinder( r = batteryPositiveTerminalDiameter / 2, h = batteryPositiveTerminalThickness + 2 * manifoldCorrection );
}