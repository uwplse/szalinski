// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, 10th December, 2015
// Parametric Snowman Hat For LED Tea Light
//

// preview[view:north, tilt:top diagonal]

// Customizer parameters
tealight_diameter			= 37.5;		// [33:0.5:100.0]
led_holder_outer_diameter	= 8.0;		// [8.0:0.1:13]
nozzle_diameter				= 0.4;		// [0.05:0.05:2.0]

/* [Hidden] */
// DO NOT CHANGE THESE
topThickness				= 1.5;	// Thickness of the flange the candle is attached to (the top)
topLedVoidClearance		    = 0.1;

// [radiusMultipler, heightMultiplier[0-1], xTranslation ]
snowmanCircles 			    = [	
                                [0.291908,0.000000,-0.007225],
                                [0.320809,0.011594,-0.007225],
                                [0.349711,0.023188,-0.007225],
                                [0.372832,0.034783,-0.007225],
                                [0.390173,0.046377,-0.007225],
                                [0.407514,0.057971,-0.007225],
                                [0.424856,0.069565,-0.007225],
                                [0.436416,0.081159,-0.007225],
                                [0.447977,0.092754,-0.007225],
                                [0.459538,0.104348,-0.007225],
                                [0.465318,0.115942,-0.007225],
                                [0.471098,0.127536,-0.007225],
                                [0.476879,0.139130,-0.007225],
                                [0.476879,0.150725,-0.007225],
                                [0.476879,0.162319,-0.007225],
                                [0.476879,0.173913,-0.007225],
                                [0.476879,0.185507,-0.007225],
                                [0.471098,0.197101,-0.007225],
                                [0.468208,0.208696,-0.008671],
                                [0.462428,0.220290,-0.008671],
                                [0.453757,0.231884,-0.007225],
                                [0.445087,0.243478,-0.008671],
                                [0.433526,0.255072,-0.005780],
                                [0.419075,0.266667,-0.007225],
                                [0.404624,0.278261,-0.008671],
                                [0.387283,0.289855,-0.008671],
                                [0.367052,0.301449,-0.007225],
                                [0.343931,0.313043,-0.007225],
                                [0.315029,0.324638,-0.007225],
                                [0.323699,0.336232,-0.008671],
                                [0.343931,0.347826,-0.007225],
                                [0.361272,0.359420,-0.007225],
                                [0.372832,0.371014,-0.007225],
                                [0.384393,0.382609,-0.007225],
                                [0.395954,0.394203,-0.007225],						
                                [0.401734,0.405797,-0.007225],
                                [0.407514,0.417391,-0.007225],
                                [0.407514,0.428986,-0.007225],
                                [0.413295,0.440580,-0.007225],						
                                [0.413295,0.452174,-0.007225],
                                [0.410405,0.463768,-0.008671],
                                [0.407514,0.475362,-0.007225],
                                [0.401734,0.486957,-0.007225],
                                [0.395954,0.498551,-0.007225],
                                [0.384393,0.510145,-0.007225],
                                [0.378613,0.521739,-0.007225],
                                [0.361272,0.533333,-0.007225],
                                [0.349711,0.544928,-0.007225],
                                [0.326590,0.556522,-0.007225],
                                [0.309249,0.568116,-0.007225],
                                [0.280347,0.579710,-0.007225],
                                [0.251445,0.591304,-0.007225],
                                [0.251445,0.602899,-0.007225],
                                [0.268786,0.614493,-0.007225],
                                [0.283237,0.626087,-0.008671],
                                [0.291908,0.637681,-0.007225],
                                [0.303468,0.649275,-0.007225],
                                [0.306358,0.660870,-0.008671],
                                [0.309249,0.672464,-0.007225],
                                [0.309249,0.684058,-0.007225],
                                [0.309249,0.695652,-0.007225],
                                [0.303468,0.707246,-0.007225],
                                [0.297688,0.718841,-0.007225],
                                [0.291908,0.730435,-0.007225],
                                [0.280347,0.742029,-0.007225],
                                [0.263006,0.753623,-0.007225],
                                [0.245665,0.765217,-0.007225],
                                [0.263006,0.776812,-0.007225],
                                [0.280347,0.788406,-0.007225],
                                [0.280347,0.800000,-0.007225],
                                [0.280347,0.811594,-0.007225],
                                [0.245665,0.823188,-0.007225],
                                [0.245665,0.834783,-0.007225],
                                [0.245665,0.846377,-0.007225],
                                [0.245665,0.857971,-0.007225],
                                [0.245665,0.869565,-0.007225],
                                [0.245665,0.881159,-0.007225],
                                [0.245665,0.892754,-0.007225],
                                [0.245665,0.904348,-0.007225],
                                [0.245665,0.915942,-0.007225]
                              ];

snowmanScaling			    = 1.5;
snowmanOuterDiameter		= tealight_diameter * snowmanScaling;
snowmanHeight			    = tealight_diameter * snowmanScaling;
hatThicknessTop             = 0.82;
hatOffset                   = [tealight_diameter / 2 + 3, 0, 0];
hatInsertThickness          = 2.0;

manifoldCorrection = 0.02;

$fn = 50;



snowmanTop();
translate( hatOffset )
    snowmanHatCover();



module snowmanHatCover()
{
    hatDiameter = snowmanOuterDiameter * snowmanCircles[len(snowmanCircles)-1][0];
    innerHatDiameter = hatDiameter - (nozzle_diameter * 4 + topLedVoidClearance * 2);
    
    translate( [hatDiameter / 2, 0, 0] )
    {
        cylinder( r=hatDiameter / 2, h = hatThicknessTop );
        translate( [0, 0, hatThicknessTop - manifoldCorrection] )
               donut( innerHatDiameter, innerHatDiameter - nozzle_diameter * 4, hatInsertThickness );
    }
}



module snowmanTop()
{
	donut(tealight_diameter, led_holder_outer_diameter + topLedVoidClearance * 2, topThickness);

	translate( [0, 0, topThickness] )
		shape(snowmanCircles, height = snowmanHeight, diameter = snowmanOuterDiameter);
}



// diameter is the bottom starting diameter

module shape(circles, height, diameter)
{
	radius = diameter / 2;

	difference()
	{
		// The outershell
		for ( i = [0:len(circles)-2] )
		{
			// Negative hull implemented by multiple hull of adjacent values
			hull()
			{
				translate( [diameter * circles[i][2], 0, height * circles[i][1]] )
						cylinder( r=radius * circles[i][0], h=nozzle_diameter );
				translate( [diameter *  circles[i+1][2], 0, height * circles[i + 1][1]] )
						cylinder( r=radius * circles[i + 1][0], h=nozzle_diameter );
			}
		}

		// The void inside
		for ( i = [0:len(circles)-2] )
		{
			// Negative hull implemented by multiple hull of adjacent values
			translate( [0, 0, -manifoldCorrection] )
				hull()
				{
					translate( [diameter * circles[i][2], 0, height * circles[i][1]] )
							cylinder( r=(radius * circles[i][0]) - nozzle_diameter * 2, h=nozzle_diameter );
					translate( [diameter * circles[i+1][2], 0, height * circles[i + 1][1]] )
							cylinder( r=(radius * circles[i + 1][0]) - nozzle_diameter * 2, h=nozzle_diameter );
				}
		}
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