/*
	
	1/10 Scale RC Car Body Post Marker(s)

*/

//$fn=23;
$fn=50;

gMS=2.0;
gSpace=0.2+0.2;
gMagnetDiaOuter=6; /* I used magnets I found on eBay, they are 6x3x3 and about 8€ for 20 pcs */
gMagnetDiaInner=3;
gMagnetHeight=3;
gPostDia=6.0; /* Adjust this to the posts of your car */
gConnectorDia=gPostDia+2*gMS;
gHeight=8;


		difference()
		{
			/* This Marker's Post Thing */
			union()
			{
				cylinder(d=gConnectorDia, h=gHeight);

				/* Holder for magnet */
				cylinder(d=gMagnetDiaInner, h=gHeight+gMagnetHeight);
			}
			
			/* Room for car's post */
			cylinder(d=gPostDia+gSpace, h=gHeight-gMS);
			
			/* room for pin */
			translate([0, 23/2-1, 4])
			cube([23, 23, 2.5], center=true);
			
			/* Holes for pins, set screw, or whatever */
			if(0)
			for (sh=[5:7:21])
			translate([0, 0, sh])
			rotate([0, 90, 0])
			cylinder(d=gSetscrewDia, h=42, center=true);

		} // diff
