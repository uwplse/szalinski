// This angled drill and saw jig can help you drill angled holes
// and/or saw round materials with an angled cut.
//
// Designed by Timothy_McPrint
// Date: 2019-01-12
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (https://creativecommons.org/licenses/by-nc-sa/4.0/)

// Number of fragments (how detailed should the model be rendered?)
$fn=100;

// If set to 1, then the diameter of the drill hole (without the tolerance) will be printed on top of the foot
print_text = 1; // [1, 0]


/* [Drill hole] */
// Diameter of the drill hole
diameter = 8;

// Tolerance that will added to the diameter of the drill hole
drill_tolerance = 0.6;

/* [Angled guide] */
// Height of the angled guide
height_guide = 70;

// Angle of the guide
angle = 15; // [0:45]

/* [Foot] */
// Height of the foot
height_foot = 15;

// Length of the foot
length_foot = 80;

// This margin will be added arround the guide and the foot
margin = 15;


/* [Hidden] */
// Total width of the foot and guide
width = diameter + margin;


difference()
{
	union()
	{
		translate( [ 0, length_foot*0.4, 0 ] )
			rotate( [ angle, 0, 0 ] )
				cube( [ width, width, height_guide-height_foot ] );
		cube( [ width, length_foot, height_foot ] );
		if ( print_text == 1 )
		{
			translate( [ width/2, length_foot-10, height_foot ] )
				linear_extrude( height=0.5 )
					text( text=str( diameter, " mm" ), size=5, halign="center" );
		}
	}
	translate( [ 0, length_foot*0.4, 0 ] )
		rotate( [ angle, 0, 0 ] )
			translate( [ width/2, width/2, -height_foot/2-50 ] )
				cylinder( d=diameter + drill_tolerance, h=height_guide+100 );
}
