$fa=1/1;
$fs=0.5/1;

circle_diameter=28;	//[20:64]
keyring_thickness=3;	//[1:0.5:10]
ring_thickness=2.5;	//[1:0.5:5]
number_of_circles=3;	//[3:2:7]

offset=ring_thickness/2;
circle_r=circle_diameter/2;
circle_a=360/number_of_circles;

		
			for(a=[0:circle_a:359])						// intersection of cylinders creating reuleaux polygon
			{
				rotate([0,0,a])
					translate([circle_r/2,0,0])
						difference()					// creating ring from 2 cylinders
						{
							cylinder(r=circle_r+offset,h=keyring_thickness, center=true);
							cylinder(r=circle_r-offset,h=keyring_thickness+offset,center=true);
						};
			};
			

	


// designed and uploaded to Thingiverse by brianbutterfield (Daniel Rutterford) July 2015