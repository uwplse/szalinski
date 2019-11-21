/*
	
	1/10 Scale Touring Car Body Post Extender

*/

$fn=23;
gPostDia=6.0;
gPostHeight=42.23;
//gPostHeight=23.42;
gConnectorDia=10.0;
gConnectorOverlap=23.42;
gSetscrewDia=1.7; //2.0, 1.4
gDingens=3.0;
gSpace=0.2+0.2;

difference()
{
	union()
	{
		/* Post */
		translate([0, 0, gConnectorOverlap+gDingens])
		cylinder(d=gPostDia, h=gPostHeight-gDingens);
		translate([0, 0, gConnectorOverlap])
		cylinder(d1=gConnectorDia, d2=gPostDia, h=gDingens);
		translate([0, 0, gConnectorOverlap+gPostHeight])
		sphere(d=gPostDia);
		
		
		difference()
		{
			/* Hull */
			cylinder(d=gConnectorDia, h=gConnectorOverlap);

			/* Room for lower post */
			cylinder(d=gPostDia+gSpace, h=gConnectorOverlap);
			
			/* Holes for pins, set screw, or whatever */
			if(0)
			for (sh=[5:7:21])
			translate([0, 0, sh])
			rotate([0, 90, 0])
			cylinder(d=gSetscrewDia, h=42, center=true);

		} // diff
	} // union

	/* Holes for pins, set screw, or whatever */
	if(1)
	for (sh=[7:7:gConnectorOverlap+gPostHeight])
	translate([0, 0, sh])
	rotate([0, 90, 0])
	cylinder(d=gSetscrewDia, h=42, center=true);
} // diff