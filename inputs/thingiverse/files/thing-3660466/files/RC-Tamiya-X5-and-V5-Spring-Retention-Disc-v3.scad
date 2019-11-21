/* Tamiya Damper Spring Cup/Retention Disk X5/V5 (Federteller)

   Fits at least TT-02B and DT-03. Probably many other chassis, too.
   
*/

//$fn=23;
$fn=42;
gRodDia=3.05;

 /* front, no screw */
if (0)
cup(7, 15+2, 0);

 /* front, with locking screw */
if (0)
cup(7, 15+2, 2.0); // M2

 /* rear, no screw */
if (0)
//translate([+30, 0, 0])
cup(7, 17+2, 0);

/* rear, with locking screw */
if (1)
//translate([+30, 0, 0])
cup(7, 17+2, 2.0); // M2

module cup(d1, d2, sd)
{
	difference()
	{
		union()
		{
			/* lower cone */
										cylinder(d1=d1+2, d2=d2, h=4.0);
			
			/* spring retention disk */
			translate([0, 0, 4])		cylinder(d=d2, h=2.0); 
			
			/* spring centering disk */
			translate([0, 0, 4+2.0]) 	cylinder(d=d2-2-3, h=1.5); 
			
			/* lock */
			if (sd>0)
			{
				translate([0, d2/2/2, (4+2)-(sd+3)/2])
				rotate([0, 90, 0])
				cylinder(d=sd+2, h=d2/1, center=true);
			}
		}

		/* ball end connector */
		cylinder(d=d1+0.1, h=4+2);
		
		/* insertion dingenskirchens schlitz */ 
		translate([0, 10/2, 0])
		cube([gRodDia, 10, 23], center=true);
		cylinder(d=gRodDia, h=23);
		
		/* room for screw */
		if (sd>0)
		{
				translate([0, d2/2/2, (4+2)-(sd+3)/2])
				rotate([0, 90, 0])
				cylinder(d=sd, h=d2/1, center=true);
		}

	}
}