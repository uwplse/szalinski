// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, 10th December, 2015
// Parametric LED Tea Light
//
// Suggested Christmas tree settings:
//      tealight_diameter			= 42
//      tealight_height				= 14.65
//      led_holder_outer_diameter	= 9.8;
//
// Defaults (regular Tea Light Size - 1.5mm for top cover):
//      part = "noswitch"
//      tealight_diameters = 37.5
//      tealight_height = 15.5
//      led_holder_outer_diameter = 8.0

// preview[view:north, tilt:top diagonal]

// Customizer parameters
switch                          = "noswitch";   // [noswitch:No Switch, switch:With Switch]
tealight_diameter               = 37.5;         // [33.0:0.5:100.0]
tealight_height                 = 14.65;        // [14.65:0.05:35.0]
led_holder_outer_diameter       = 8.0;          // [8.0:0.1:13]
nozzle_diameter                 = 0.4;          // [0.05:0.05:2.0];

/* [Hidden] */
// DO NOT CHANGE THESE
switchClearance					= 0.1;
switchInsetFromEdge				= 2.0;
switchTravelBlockDimensions		= [5 + switchClearance * 2, 3.0 + switchClearance * 2, 4.0];
switchMainBodyDimensions		= [8.75 + switchClearance * 2, 4.45 + switchClearance * 2, 4.7 + 2.8 + switchClearance * 2];
switchChannelFlange				= [switchMainBodyDimensions[0] - 2,
								   switchMainBodyDimensions[1],
								   (tealight_diameter - led_holder_outer_diameter) / 2 - switchInsetFromEdge - switchMainBodyDimensions[2]];
switchRetainerBorder			= 1.5;
switchRetainerBlockDimensions	= [ switchMainBodyDimensions[0] + switchRetainerBorder * 2,
									switchMainBodyDimensions[2] + switchRetainerBorder,
									switchMainBodyDimensions[1]
								  ];

topRingThickness				= switchMainBodyDimensions[1];
baseHeight						= tealight_height - topRingThickness;
cr2032HolderDiameter			= 22.5;
cr2032HolderBlockWidth			= 8.0;
cr2032HolderBlockDepth			= 2.5;
cr2032HolderLeadDiameter		= 1.8;
cr2032HolderLead1Pos			= [-(cr2032HolderDiameter / 2 - 2.75), 0, 0];
cr2032HolderLead2Pos			= [cr2032HolderLead1Pos[0] + 20, cr2032HolderLead1Pos[1], cr2032HolderLead1Pos[2]];
cr2032HolderThickness			= baseHeight - 1.0;

ledHolderHeight					= 9.0;
ledHolderInsetDepth				= 1.5;
ledDiameter						= 6.0;	// Diameter of the lip of the led, not the led size
ledLeadThickness				= 1.0;

topRingInnerDiameter			= 30;

topLedVoidClearance				= 0.1;

textThickness                   = 0.5;
textSize                        = 3.0;
textPositiveOffset              = [cr2032HolderLead2Pos[0], 3, baseHeight + textThickness/2];
textLine2Offset                 = [0, 12.0, baseHeight + textThickness/2];
textLine1Offset                 = [0, textLine2Offset[1] - (textSize + 1), baseHeight + textThickness/2];

manifoldCorrection = 0.02;

$fn = 80;



if ( switch == "noswitch" )
	createWithoutSwitch();

if ( switch == "switch" )
	createWithSwitch();

// Text
color( [1.0, 0.0, 0.0] )
{
    translate( textPositiveOffset )
        linear_extrude( height=textThickness, center=true)
            text("+", font="Helvetica:Bold", valign="center", halign="center", size=textSize);

    translate( textLine1Offset )
        linear_extrude( height=textThickness, center=true)
            rotate( [0, 0, 180] )
                text("Led Flat=-,", font="Helvetica:Bold", valign="center", halign="center", size=textSize);

    translate( textLine2Offset )
        linear_extrude( height=textThickness, center=true)
            rotate( [0, 0, 180] )
                text("Long=+", font="Helvetica:Bold", valign="center", halign="center", size=textSize);
}



module createWithSwitch()
{
	difference()
	{
		union()
		{
			tealightBase();
			translate( [0, -tealight_diameter / 2 + switchInsetFromEdge, tealight_height] )
				translate( [-switchRetainerBlockDimensions[0]/2, 0, -switchRetainerBlockDimensions[2]] )
					cube( switchRetainerBlockDimensions, center=false );	
		}
		translate( [0, -tealight_diameter / 2 + switchInsetFromEdge, tealight_height + manifoldCorrection] )
			switch();
	}
}



module createWithoutSwitch()
{
	tealightBase();
}



module switch()
{
	translate( [0, 0, -switchMainBodyDimensions[1] / 2] )
		rotate( [90, 0, 0] )
		{
			translate( [0, 0, switchTravelBlockDimensions[2] / 2 - manifoldCorrection] )
				cube( switchTravelBlockDimensions, center = true );
			translate( [0, 0, -switchMainBodyDimensions[2] / 2] )
				cube( switchMainBodyDimensions, center = true );
			translate( [0, 0, -(switchChannelFlange[2] / 2 + switchMainBodyDimensions[2]) + manifoldCorrection ] )
				cube( switchChannelFlange, center = true );
		}
}



module tealightBase()
{
	difference()
	{
		union()
		{
			// The main base
			cylinder( r=tealight_diameter / 2,	 h=baseHeight);
		
			// The led holder
			translate( [0, 0, baseHeight] )
				ledHolder();

			// The top ring
			translate( [0, 0, baseHeight - manifoldCorrection] )
				donut(tealight_diameter, topRingInnerDiameter, topRingThickness);
		}

		// The void for the battery holder
		translate( [0, 0, -manifoldCorrection] )
			union()
			{
				cylinder( r=cr2032HolderDiameter / 2, h=cr2032HolderThickness);
				translate( [(cr2032HolderDiameter + cr2032HolderBlockDepth) / 2, 0, cr2032HolderThickness/2] )
				{
					cube( [cr2032HolderBlockDepth, cr2032HolderBlockWidth, cr2032HolderThickness], center = true ); 
					translate( [-(cr2032HolderBlockDepth-manifoldCorrection), 0, 0] )
						cube( [cr2032HolderBlockDepth, cr2032HolderBlockWidth, cr2032HolderThickness], center = true );
				}
			}

		// The holes for the leads
		translate( cr2032HolderLead1Pos )
			cylinder( r=cr2032HolderLeadDiameter / 2, h=baseHeight + manifoldCorrection * 2);
		translate( cr2032HolderLead2Pos )	
			cylinder( r=cr2032HolderLeadDiameter / 2, h=baseHeight + manifoldCorrection * 2);
	}
}



module ledHolder()
{	
	difference()
	{
		cylinder( r=led_holder_outer_diameter / 2, h=ledHolderHeight );
		translate( [0, 0, (ledHolderHeight - ledHolderInsetDepth) + manifoldCorrection] )
			cylinder( r=ledDiameter / 2, h=ledHolderInsetDepth ); 
		translate( [-(led_holder_outer_diameter / 2 + manifoldCorrection), -ledLeadThickness / 2, -manifoldCorrection] )
			cube( [led_holder_outer_diameter + manifoldCorrection * 2, ledLeadThickness, ledHolderHeight + manifoldCorrection * 2] );
	}
}



module donut(outerDiameter, innerDiameter, thickness)
{
	union()
	difference()
	{
		cylinder( r=outerDiameter / 2, h=thickness );
		translate( [0, 0, -manifoldCorrection] )
			cylinder( r=innerDiameter / 2, h=thickness + manifoldCorrection * 2 );
	}
}