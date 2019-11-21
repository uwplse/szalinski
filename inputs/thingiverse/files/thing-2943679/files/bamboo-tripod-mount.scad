//Diameter of the bamboo rod (width of the arm is aligned with this value)
bamboo_diameter = 20;

/* [Arm] */
//Length of one arm (+ mount_length)
arm_length    = 20;
//Thickness of the whole construction
arm_thickness = 10;
//Number of arms
arm_count     = 3; // [2:12]
//Width, that will added to the width of each arm (important for robust hinges)
arm_extra_mounting_width = 12;

/* [Relief bore] */
//Diameter of the bore
relief_bore_diameter = 20;
//Number of relief bores (set to < 1.0 to get only one in the middle)
relief_bores_count = 0.9;
//relief_bores_count   = arm_length / relief_bore_diameter / 2;

/* [Mount] */
//Length of each mounting section (this length will be added to arm_length!)
mount_length                  = 12;
//Diameter of one axle
mount_hole_diameter           = 5;
//How big should be the extra tolerance for the axle bore?
mount_hole_diameter_tolerance = 0.8;

/* [Zip Tie mounting hole] */
//Width of the zip tie
zip_tie_width     = 3;
//Thickness of the zip tie
zip_tie_thickness = 2;

//How many details for round structures? (the bigger, the more details)
$fn = 120;


//Hidden settings:
//Width of each arm:
arm_width     = bamboo_diameter + arm_extra_mounting_width;
//Angle of rotation for each arm segment
rotate_by     = 360 / arm_count;
//Width of the mount will be calculated:
mount_width = (arm_width - bamboo_diameter) / 2 - 1;


for( i = [1:arm_count] )
{
	difference()
	{
		arm( i );
		arm_mount( i );
	}
	rotate([0,0,90+rotate_by*i])
			mounting_module();
}


//the main part:
module arm( i )
{
	difference()
	{
		linear_extrude( height=arm_thickness )
		rotate([0,0,rotate_by*i])
			translate([-arm_width/2,0])
			{
				square([arm_width,arm_length]);
				translate([0,arm_length,0])
					square([mount_width,mount_length]);
				translate([arm_width-mount_width,arm_length,0])
					square([mount_width,mount_length]);
			}
		//relief bore:
		rotate([0,0,rotate_by*i])
			for( k=[0:relief_bores_count] )
				translate([0, arm_length / relief_bores_count * k,0])
					cylinder( h=arm_thickness, d=relief_bore_diameter );
	}
}


//the mounts at the end of the arms:
module arm_mount( i )
{
	rotate([0,90,rotate_by*i])
		translate([-arm_thickness/2,arm_length+mount_length/2*1.2,0])
			cylinder( d=mount_hole_diameter + mount_hole_diameter_tolerance, h=arm_width, center=true );
}


module mounting_module()
{
	translate([arm_length+mount_length/2*1.2,0,arm_thickness/2])
	{
		rotate([90,0,0])
			cylinder( d=mount_hole_diameter, h=arm_width+5, center=true );
		difference()
		{
			translate([bamboo_diameter*0.45,0,0])
				cube([bamboo_diameter*1.2,bamboo_diameter,bamboo_diameter/2], center=true);
			translate([bamboo_diameter*1.2,0,0])
				cylinder( d=bamboo_diameter, h=arm_width, center=true );
			translate([bamboo_diameter*1.1,0,0])
				cube([5,arm_width+5,arm_width+5], center=true );
			//Mounting hole for a Zip-Tie:
			translate([bamboo_diameter*0.5,0,0])
				cube([zip_tie_thickness,arm_width,zip_tie_width], center=true);
		}
	}
}