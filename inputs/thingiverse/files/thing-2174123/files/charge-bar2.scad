// This thing is a simplified version of the Lee AutoDisk Powder Measure Disk.
// It features customizable hole sizes for fine tuning powder drops.
//
// Warning -- some sanding and fitting will be required.
//
// This is licensed under the creative commons+attribution license
// My design was inspired by SBfarmer and his design at
// http://www.thingiverse.com/thing:2174123
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2160227

/* [Main] */

// Define cavity size calcuation method
shape=0; // [0:Determine Cavity Size Using Volume,1:Determine Cavity Size Using Diameter]

// Body thickness in mm
body_height=12.5;

// Leg length in mm
leg_length=2.5;

// Pocket depth in mm
pocket_depth=10.0;

// Set screw pilot hole diameter in mm
pilot_diameter=2.0;

// Desired volume of first hole in cc (only works if using volume method)
volume01=0.5;

// Desired volume of second hole in cc (only works if using volume method)
volume02=1.0;

// Desired diameter of first hole in mm (only works if using diameter method)
diameter01=5.0;

// Desired diameter of second hole in mm (only works if using diameter method)
diameter02=9.0;

module half_body()
{
	difference()
	{
		union()
		{
			intersection()
			{
				// Define main body of structure
				translate([15,0,0]) cube([30,32,body_height],center=true);

				// Round off end of rectangle
				cylinder(h=12.5,r=30,center=true,$fn=40);
			}

			// Let's grow some legs
			translate([20,-9.5,leg_length+2])  cube([5,3,10],center=true);
		}
		// Cut pocket for slide lever
		#minkowski()
		{
			translate([20,10,0]) cube([9.75,3,pocket_depth+1],center=true);
			cylinder(r=1);
		}
	
		// Hollow out inside of shell
		#translate([0,0,0])
		minkowski()
		{
			translate([06,00,00]) cube([11,26,pocket_depth+1],center=true);
			cylinder(r=1);
		}
		// Drill pilot hole for set screw
		#translate([27,00,00]) rotate([00,90,00]) cylinder(h=10,r=pilot_diameter/2.0,center=true,$fn=50);
	}
}
difference()
{
	union()
	{
		half_body();
		rotate([0,0,180]) half_body();

		// Reinforce hollowed out shell
		translate([0,0,-2.5]) rotate([0,0,90]) cube([2,24,body_height/2],center=true);
		translate([0,0,-2.5]) rotate([0,0,0])  cube([2,30,body_height/2],center=true);

		translate([0,0,-2.5])   cylinder(h=6,r=2,center=true,$fn=10);
		translate([12,0,-2.5])  cylinder(h=6,r=2,center=true,$fn=10);
		translate([-12,0,-2.5]) cylinder(h=6,r=2,center=true,$fn=10);
		translate([0,14,-2.5])  cylinder(h=6,r=2,center=true,$fn=10);
		translate([0,-14,-2.5]) cylinder(h=6,r=2,center=true,$fn=10);
	}
	// Let's make some cavities
	if(shape==0) // Use volume to calculate cavity size
	{
		// Determine cavity radius by multiplying volume in cc by 1000 to get cubic mm and soving for r
		#rotate([0,0,00])  translate([-22,0,0]) cylinder(h=body_height+1,r=sqrt(volume01*1000/(3.1415*body_height)),center=true,$fn=50);
		#rotate([0,0,180]) translate([-22,0,0]) cylinder(h=body_height+1,r=sqrt(volume02*1000/(3.1415*body_height)),center=true,$fn=50);
	}
	if(shape==1) // Use diameter to calculate cavity size
	{
		// Determine cavity radius by dividing diameter by 2
		#rotate([0,0,0])  translate([-22,0,0])  cylinder(h=body_height+1,r=diameter01/2,center=true,$fn=50);
		#rotate([0,0,180]) translate([-22,0,0]) cylinder(h=body_height+1,r=diameter02/2,center=true,$fn=50);
	}
}
