$fa=1/1;
$fs=0.5/1;

main_diameter=32;	//[32:50]
keyring_thickness=5;	//[2:0.5:10]
large_hole_diameter=24;	//[0:24]
small_hole_diameter=4;	//[4:0.2:6]


		difference ()										// removing holes from triangle
		{
			intersection_for(a=[0:120:359])						// intersection of 3 cylinders creating reuleaux triangle
			{
				rotate([0,0,a])
					translate([main_diameter/2,0,0])
						cylinder(r=main_diameter,h=keyring_thickness);
			};
			union()										// large & small holes
			{
				translate ([0,0,-1])
					cylinder(r=large_hole_diameter/2,h=keyring_thickness+2) ;			// large hole
				for(b=[0:120:359])							// 3 small holes
				{
					rotate([0,0,b])
						translate([main_diameter/2,0,-1])
							cylinder(r=small_hole_diameter/2,h=30);
				};
			};
		};
	


// designed and uploaded to Thingiverse by brianbutterfield (Daniel Rutterford) June 2015