/*

RC MTS FFv3 Front Arm M-128151 (L) M-128152 (R)


*/

/* Modules */
include <../Modules/Module_Rounded_Cube.scad>;

/* Globals */
$fn=23;
gMS=2.2; // Thickness, original carbon parts use 2.2mm

/* Flags */
//gFlagNoInserts=true;
gFlagNoInserts=false;

if (1)
arm("r");

if (0)
//translate([-23, 0, 0])
//mirror([1, 0, 0])
arm("l");

module arm(side)
//hull()
{
	difference()
	{
		union()
		{
			hull() // front mount
			{
				cylinder(d=14, h=gMS);
					
				// MERGE WITH Achsschenkel-mount
				translate([30-2, -25-5, 0])
				cube([0.1, 25, gMS]);
			}
			if (gFlagNoInserts==true)
				if (side=="r")
					cylinder(d=10, h=gMS+0.25);
				else
					translate([0, 0, -0.25])
					cylinder(d=10, h=gMS+0.25);
			
			hull() // rear mount
			{
				translate([2.5-1-1+3, -33+0.5, 0])
				cylinder(d=14, h=gMS);

				// MERGE WITH Achsschenkel-mount
				translate([30-2, -25-5, 0])
				cube([0.1, 25, gMS]);
			}
			if (gFlagNoInserts==true)
				if (side=="r")
					translate([2.5-1-1+3, -33+0.5, 0])
					cylinder(d=10, h=gMS+0.25);
				else
					translate([2.5-1-1+3, -33+0.5, -0.25])
					cylinder(d=10, h=gMS+0.25);

		//	hull()
		//	{
				// antirollbar-mount
				if (0)
				%translate([2.5, -(5+10)+12, 0])
				cube([14, 5+10, gMS]); // not centered
				if (1)
				translate([2.5+14/2, -(5+10)+15/2+12, gMS/2])
				roundedCubeWithCornerDiameter(14, 15, gMS, 0, 0, 5, 5); // centered
			
				// MERGE WITH something
			//	#translate([30, -25-5, 0])
			//	cube([0.1, 25, gMS]);
		//	}
			
			// Achsschenkel-mount
			if (0)
			%translate([30, -25-5, 0])
			cube([20, 25, gMS]);
			if (1)
			translate([30+20/2-2, -25-5+25/2, gMS/2])
			roundedCubeWithCornerDiameter(20, 25, gMS, 0, 5, 0, 5); // centered
			
			// droop "insert" 
			if (gFlagNoInserts==true)
			{
				if (side=="r")
				{
					translate([11-0.5, -27.5, gMS])
					cylinder(d1=5.0, d2=4.0, h=gMS/2);
				}
				else
				{
					translate([11-0.5, -27.5, 0])
					rotate([180, 0, 0])
					cylinder(d1=5.0, d2=4.0, h=gMS/2);
				}
			}
			
		} // union
		
		// front mount
		if (gFlagNoInserts==false)
			cylinder(d=6, h=gMS);
		else
			cylinder(d=5, h=23, center=true);
			
		// rear mount
		translate([2.5-1-1+3, -33+0.5, 0])
		if (gFlagNoInserts==false)
			cylinder(d=6, h=gMS);
		else
			cylinder(d=5, h=23, center=true);

		// space for shock absorber mount
		translate([30*1, -6-5, 0])
		cube([6, 6, gMS]);

		// space for achsschenkel-mount
//		#translate([30+20-6, -11-5-6.7, 0])
		translate([0+42, -11-5-6.7-1+0.5, 0])
		cube([6, 11, gMS]);

		// droop
		if (gFlagNoInserts==false)
			translate([11-0.5, -27.5, 0])
			hull()
			{
				cylinder(d=4.5, h=gMS);
				translate([1-0.5, 0, 0])
				cylinder(d=4.5, h=gMS);
			}
		else
		{
			translate([11-0.5+0.25, -27.5, 0])
			cylinder(d=2.9, h=23, , center=true);
		}
			
		// antiroll-bar
		translate([6, 8, 0])
		cylinder(d=2.5, h=gMS);
			translate([6+7, 8, 0])
			cylinder(d=2.5, h=gMS);

		// Achsschenkel-mount (inner)
		translate([32, -17+0.5, 0])
		{
			//cylinder(d=2.5, h=gMS);
			sunkScrewHole(d=2.5, side=side, h=gMS);
		}

		// Achsschenkel-mount (outer)
		translate([44.5, -10+0.5, 0])
		sunkScrewHole(d=2.5, side=side, h=gMS);
			translate([44.5, -27+0.5, 0])
			sunkScrewHole(d=2.5, side=side, h=gMS);

	} // diff
	
	// test
	if (0)
	translate([23, -11+5-6.7, 0])
	cylinder(d=14, h=gMS);

}


module sunkScrewHole(d, side, h)
{
	
	if (side=="r")
	{
		cylinder(d=2.5, h=gMS);
		cylinder(d1=5.5, d2=d, h=1.8);
	}
	else
	{
		translate([0, 0, h])
		rotate([0, 180, 0])
		{
			cylinder(d=2.5, h=gMS);
			cylinder(d1=5.5, d2=d, h=1.8);
		}
	}
}

