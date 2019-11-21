/********************************************************************************************************
P-Plate and L-Plate Holder v1.0 by Mike Thompson 3/1/2015, Thingiverse: mike_linus

The Plate Holder is designed to hold the standard 150mm x 150mm Australian L or P plates. 

The key advantage is the ability to slide the plate in and out without having to remove the mounting mechanism.  This is particularly handy when frequently changing plates between drivers.

The attachment locations and hole size are customisable for various suction cup or hook sizes and placements.
********************************************************************************************************/

/**************************************************************************
Enter the values corresponding to your tray requirements in this section
***************************************************************************/

/* [Attachment Options] */


//The radius of the attachment hole
sucker_hole_radius=4;
//Top Attachment
tsucker="include";//[include,exclude]
//Left Attachment
lsucker="exclude";//[include,exclude]
//Right Attachment
rsucker="exclude";//[include,exclude]
//Bottom Attachment
bsucker="exclude";//[include,exclude]

module holder()
{
	difference()
	{
		hull()
		{
			cylinder(r=2, h=4);
			translate([159,0,0])cylinder(r=2, h=4);
			translate([0,153,0])cylinder(r=2, h=4);
			translate([159,153,0])cylinder(r=2, h=4);
		}
		translate([5,5,0])cube([149,151,6]);	
	}
}

module sucker()
{
	difference()
	{	
		hull()
		{
			cylinder(r=10,h=1);
			translate([-10,-2,0])cube([20,15,1]);
		}
		cylinder(r=sucker_hole_radius,h=1);
	}
}

module slots()
{
	translate([5.1,158,2])rotate([90,180,0])cylinder(r=1.5,h=153,$fn=50);
	translate([5,5.1,2])rotate([0,90,0])rotate([0,0,-90])cylinder(r=1.5,h=149,$fn=50);
	translate([153.9,158,2])mirror(0,0,1)rotate([90,180,0])cylinder(r=1.5,h=153,$fn=50);
	intersection()
	{
		translate([4,5.1,2])rotate([0,90,0])rotate([0,0,-90])cylinder(r=1.5,h=152,$fn=50);
		translate([153.9,156,2])mirror(0,0,1)rotate([90,180,0])cylinder(r=1.5,h=153,$fn=50);
	}
	intersection()
	{
		translate([5.1,155,2])rotate([90,180,0])cylinder(r=1.5,h=152,$fn=50);
		translate([3,5.1,2])rotate([0,90,0])rotate([0,0,-90])cylinder(r=1.5,h=153,$fn=50);
	}

}

module build()
{
	difference()
	{
		union()
		{
			holder();
			if (bsucker=="include")
			{
				translate([79,-10,0])sucker();
			}
			if (rsucker=="include")
			{
				translate([169,141,0])rotate([0,0,90])sucker();
			}
			if (lsucker=="include")
			{
				translate([-10,141,0])rotate([0,0,-90])sucker();
			}
			if (tsucker=="include")
			{
				translate([79,163,0])rotate([0,0,180])sucker();
			}
		}
		slots();
	}
	translate([0,150,0])cube([159,5,1]);	
}

build();