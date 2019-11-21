/* [Global] */
diameter = 30; // [10:38]
length = 110; //[10:200] 
mini_spool_holder();


module mini_spool_holder()
{
	rotate([0,-90,0])
	{
		union()
		{
			// clip
			translate([0,0,2.5])
			{
				cube([38.5,90,3.125]);
			}
			translate([0,0,-3.125])
			{
				cube([38.5,90,3.125]);
			}
			cube([38.5,18.5,2.5]);

			// axis
			translate([(diameter/2),90-(diameter/2),5.5])
			{
				cylinder(r=diameter/2, h=length);
			}

			// foot
			translate([(diameter/2),90-(diameter/2),length+5.5])
			{
				hull()
				{
					cylinder(r=diameter/2, h=3);
					translate([0,-10,0])
					{
						cylinder(r=diameter/2, h=3);
					}
				}
			}
		}
	}
}
