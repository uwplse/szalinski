// This is a custom powder bushing the Lee AutoDisk Powder Measure Disk.
// It features customizable powder drop volumes in cc.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2176431
//
// As of 14 April 2017

/* [Main] */

// in mm
bushing_height=12.125; //[6:0.05:12.5]

// in mm
bushing_diameter=12.0; //[6:0.05:12.5]

// of hole in cc
volume=0.25; //[0.1:0.05:0.6]

// Number of sides on face of inner hole (higer number=smoother)
sides=100;

module body()
{
	difference()
	{
		cylinder(h=bushing_height,r=bushing_diameter/2,center=true,$fn=50);
		// To solve for radius given volume in cc, multiply cc by 1000 to get cubic mm
		#cylinder(h=bushing_height+1,r=sqrt((volume*1000)/(3.14159*bushing_height)),center=true,$fn=sides);
	}
}

body();
