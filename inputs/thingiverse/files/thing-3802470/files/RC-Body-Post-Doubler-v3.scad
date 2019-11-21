/*
	
	1/10 Scale Buggy Body Post Doubler - so you can fit touring car body shells

*/

//$fn=23;
$fn=50;
gPostDia=6.0;
gPostHeight=100.23;
//gPostHeight=23.42;
gConnectorDia=10.0;
gConnectorOverlap=14.23;
gSetscrewDia=1.7; //2.0, 1.4
gDingens=3.0;
gBums=10;
gSpace=0.2+0.2;
gPostsDistance=100;
//gPostsDistance=65;

difference()
{
	union()
	{
			
		/* Left posts's base */
		hull()
		{
			translate([-gPostsDistance/2, 0, (gConnectorOverlap)*2])
			cylinder(d=gConnectorDia, h=gBums);

			translate([0, 0, gConnectorOverlap])
			base();
		}
		
		/* right posts's base */
		hull()
		{
			translate([+gPostsDistance/2, 0, gConnectorOverlap*2])
			cylinder(d=gConnectorDia, h=gBums);

			translate([0, 0, gConnectorOverlap])
			base();
		}
		base();
		
		translate([-gPostsDistance/2, 0, gConnectorOverlap*2+gBums])
		post();
			translate([+gPostsDistance/2, 0, gConnectorOverlap*2+gBums])
			post();
	

	} // union

	/* Room for lower post */
	cylinder(d=gPostDia+gSpace, h=42);

	/* Holes for pins, set screw, or whatever */
	if(1)
	#for (sh=[gConnectorOverlap*2+gBums+gDingens+2:7:gConnectorOverlap*2+gPostHeight+7])
	translate([0, 0, sh])
	rotate([0, 90, 0])
	cylinder(d=gSetscrewDia, h=gPostsDistance+23, center=true);

	if(1)
	#for (sh=[7/2:7:gConnectorOverlap*1])
	translate([0, 0, sh])
	rotate([0, 90, 0])
	cylinder(d=gSetscrewDia, h=gPostsDistance+23, center=true);
} // diff

/* Post (stating the obvious) */
module post()
{	
		if (1)
		{
			translate([0, 0, gDingens])
			cylinder(d=gPostDia, h=gPostHeight-gDingens);
				translate([0, 0, 0])
				cylinder(d1=gConnectorDia, d2=gPostDia, h=gDingens);
			translate([0, 0, gPostHeight])
			sphere(d=gPostDia);
		}

	}


/* Lower part, fitting the original post */
module base()
{
		difference()
		{
			/* Hull */
			cylinder(d=gConnectorDia, h=gConnectorOverlap);

			/* Room for lower post */
	//		cylinder(d=gPostDia+gSpace, h=gConnectorOverlap);
			
			/* Holes for pins, set screw, or whatever */
			if(0)
			for (sh=[5:7:21])
			translate([0, 0, sh])
			rotate([0, 90, 0])
			cylinder(d=gSetscrewDia, h=42, center=true);

		} // diff

}
