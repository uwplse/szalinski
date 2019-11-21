/* RC Simple Setupwheels 

*/

$fn=100;
gDiaAxle=4.0+0.1;
gDiaOuter=62;
//gWheelWidth=2.4;
gWheelWidth=4.0;
gTipHeight=1.0;
//gTipWidth=1.2;

difference()
{
	union()
	{
		// just to check if we designed it with correct diameter
		//%cylinder(d=gDiaOuter, h=gWheelWidth, center=true);

		/* Base wheel */
		cylinder(d=gDiaOuter-2*gTipHeight, h=gWheelWidth, center=true);

		/* Tip */
		rotate_extrude(convexity = 10)
		translate([gDiaOuter/2-gTipHeight, 0, 0])
		circle(r = gTipHeight);
	}

	/* Save some material */
	if (1)
	{
		for (a=[0:60:300])
		rotate([0, 0, a])
		translate([-18, 0, 0])
		cylinder(d1=gDiaOuter/2-5, d2=gDiaOuter/2-5, h=23, $fn=3, center=true); /* A bit of a hack, decreasing the resultion, but you get a triangle much easier than with a polyhedrum */
	}
	
	/* Axle hole */
	cylinder(d=gDiaAxle, h=23, center=true);
}	
