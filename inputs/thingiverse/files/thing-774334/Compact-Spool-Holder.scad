// Inner diameter of the Spool in mm
Spool_Diameter = 52.5;

// Outer diameter of the bearing in mm
Bearing_Diameter = 22.2;

/* [Hidden] */
$fn=100;
difference()
{
	union()
	{
		translate ([0,0,0])cylinder(d=Spool_Diameter+6,h=3); // Outer plate
		translate ([0,0,3])cylinder(d=Spool_Diameter,h=3); // Inner plate
		hull() 
		{
			// Bearing support
			translate ([0,0,6])cylinder(d=Bearing_Diameter+4,h=0.01);  
			translate ([0,0,8])cylinder(d=Bearing_Diameter,h=0.01); 
		}
	}
	translate ([0,0,0]) cylinder(d=Bearing_Diameter,h=7); // Bearing cut

	hull() 
	{
		// Bearing support cut
		translate ([0,0,7])cylinder(d=Bearing_Diameter,h=0.01);
		translate ([0,0,13])cylinder(d=8,h=0.01);
	}

	hull() 
	{
		// Bearing entry cut
		translate ([0,0,0])cylinder(d=Bearing_Diameter+2,h=0.01);
		translate ([0,0,8])cylinder(d=8,h=2);
	}
}

// Made by Tech2C
// https://www.youtube.com/c/Tech2C



