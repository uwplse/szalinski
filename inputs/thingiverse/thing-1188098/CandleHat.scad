// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, 10th December, 2015
// Parametric Candle Hat For LED Tea Light
//

// preview[view:north, tilt:top diagonal]

// Customizer parameters
tealight_diameter			    = 37.5;		// [33:0.5:100.0]
led_holder_outer_diameter	    = 8.0;		// [8.0:0.1:13]
nozzle_diameter				    = 0.4;		// [0.05:0.05:2.0]
candle_height_diameter_ratio	= 1.87;		// [1.0:0.01:6.0]

/* [Hidden] */
// DO NOT CHANGE THESE
topThickness				    = 1.5;	// Thickness of the flange the candle is attached to (the top)
topLedVoidClearance		        = 0.1;


// [radiusMultipler, heightMultiplier[0-1], rotation, xTranslation ]
candleCircles 			        = [	
                                    [1.0,   0.0,  0.0,  0.0],
                                    [1.075, 0.05, 0.0,  0.0],
                                    [1.15,  0.1,  0.0,  0.0],
                                    [1.2,   0.15, 0.0,  0.0],
                                    [1.23,  0.2,  0.0,  0.0],
                                    [1.24,  0.25, 0.0,  0.0],
                                    [1.25,  0.3,  0.0,  0.0],
                                    [1.24,  0.35, 0.0,  0.0],
                                    [1.22,  0.4,  0.0,  0.0],
                                    [1.18,  0.45, 0.0,  0.0],
                                    [1.13,  0.5,  0.0,  0.0],
                                    [1.06,  0.55, 0.0,  0.0],
                                    [0.985, 0.6,  0.0,  0.0],
                                    [0.88,  0.65, 0.0,  0.15],
                                    [0.75,  0.7,  2.0,  0.5],
                                    [0.63,  0.75, 4.0,  1.0],
                                    [0.52,  0.8,  6.0,  1.5],
                                    [0.43,  0.85, 8.0,  2.0],
                                    [0.32,  0.9,  10.0, 2.8],
                                    [0.20,  0.95, 12.0, 3.6],
                                    [0.01,  1.0,  14.0, 4.4]
                                  ];
candleOuterDiameter		        = led_holder_outer_diameter + topLedVoidClearance * 2 + nozzle_diameter * 4;
candleHeight			        = candle_height_diameter_ratio * candleOuterDiameter;

manifoldCorrection = 0.02;

$fn = 50;



candleTop();



module candleTop()
{
	donut(tealight_diameter, led_holder_outer_diameter + topLedVoidClearance * 2, topThickness);

	translate( [0, 0, topThickness] )
		shapeWithRotation(candleCircles, height = candleHeight, diameter = candleOuterDiameter);
}



// diameter is the bottom starting diameter

module shapeWithRotation(circles, height, diameter)
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
				translate( [circles[i][3], 0, height * circles[i][1]] )
					rotate( [0, circles[i][2], 0] )
						cylinder( r=radius * circles[i][0], h=0.1 );
				translate( [circles[i+1][3], 0, height * circles[i + 1][1]] )
					rotate( [0, circles[i + 1][2], 0] )
						cylinder( r=radius * circles[i + 1][0], h=0.1 );
			}
		}

		// The void inside
		for ( i = [0:len(circles)-2] )
		{
			// Negative hull implemented by multiple hull of adjacent values
			translate( [0, 0, -manifoldCorrection] )
				hull()
				{
					translate( [circles[i][3], 0, height * circles[i][1]] )
						rotate( [0, circles[i][2], 0] )
							cylinder( r=(radius * circles[i][0]) - nozzle_diameter * 2, h=0.1 );
					translate( [circles[i+1][3], 0, height * circles[i + 1][1]] )
						rotate( [0, circles[i + 1][2], 0] )
							cylinder( r=(radius * circles[i + 1][0]) - nozzle_diameter * 2, h=0.1 );
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