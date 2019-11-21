//Grassy knoll
//jweob 8th February 2014
// Creates a small hillock (or knoll) with a randomised grassy covering
// Also puts some lettering on the base


// Next line is to add the build plate library if uploaded to thingiverse
use <utils/build_plate.scad>;

use <write/Write.scad>; //Writing library by HarlanDMii, published	 Jan 18, 2012. From Thingiverse

// The radius of the sphere the knoll is made from. Currently set to:
01_Knoll_Radius = 30; // [10:100]
// How far up sphere the knoll is cut. E.g. if this is set to 0.8 then the knoll is made from cutting out 80% of the diameter of the sphere. Bigger number means a flatter knoll. Currently set to:
02_Cut_Point = 0.8; 
// The grass is put on the knoll following a grid pattern. This variable controls the average distance between the blades in mm. Currently set to:
03_Grass_Spacing = 1.5;// 
// The width of each blade at its base, in mm. Currently set to: 
04_Grass_Blade_Width = 4.5; // 
// The thickness of each blade in mm (and also its width at the top of the blade). Currently set to:
05_Grass_Blade_Thickness = 2; // [1:4]
// Maximum height of a grass blade in mm. Currently set to:
06_Grass_Blade_Height = 10; // [5:20]
// The text that is printed on the bottom of the knoll
07_Bottom_Text = "jweob";
// If you want to make the knoll into a small pot then you can create a cylindrical cut out in the top by setting this value greater than zero
08_Pot_Radius = 0; //[0:10]

//Build plate for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);


Root_Depth = 3/1;
No_Grass_Fudge = 0.4/1;
Removal_Key = [3,10,3]; //Dimensions of key used to lever the knoll off the plate



//Arrays contain scaling factors that will be called randomly to make each "blade" different
Rand_XY_Array = [0.5, 0.2, 0.15, 0.1, 0, 0, -0, -0, -0.1, -0.15, -0.2, -.5]; // Fractional offset from grid pattern
Rand_R_Array = [0, 60, 120, 180, 240, 300]; //Rotation of each blade
Rand_I_Array = [10, 5, 3, 3, 1, 0]; //Inclination of each blade
Rand_H_Array = [0.5, 0.6, 0.8, 0.9, .95, 1]; // Scaling factor for height



Inner_Knoll_Radius = sqrt(pow(01_Knoll_Radius,2)-pow((01_Knoll_Radius*(02_Cut_Point - 0.5)),2));

module Grass_Blade(Grass_H,Grass_R, Grass_I, Grass_W, Grass_T)
	{
	intersection()
		{
		rotate([0,0, Grass_R])
			rotate([Grass_I,0, 0])
				cylinder(h=Grass_H, r1 = Grass_W/2, r2 = Grass_T/2);
		rotate([0,0, Grass_R])
			rotate([Grass_I,0, 0])
				cube([Grass_W, Grass_T, Grass_H]);

		}

	}


color("green")
difference()
{
	union()
	{
		//Create Knoll
		difference(){
			translate([0,0,-(01_Knoll_Radius*(02_Cut_Point - 0.5))]) sphere(r=01_Knoll_Radius);
			translate([0,0,-01_Knoll_Radius]) cube(size=01_Knoll_Radius * 2, 	center = true);
		}
		//Start going through grid
			for (GrassXn = [0:((01_Knoll_Radius*2)/ 03_Grass_Spacing)])	
				for (GrassYn = [0:((01_Knoll_Radius*2)/ 03_Grass_Spacing)])	
					{
					if(sqrt(pow(GrassXn * 03_Grass_Spacing-01_Knoll_Radius,2) +pow(GrassYn * 03_Grass_Spacing-01_Knoll_Radius,2)) < Inner_Knoll_Radius - 03_Grass_Spacing* No_Grass_Fudge) //Checks to see if within radius of knoll, if not don't make grass blade
						{
							// Randomizes the pattern of the grass blades around the grid and puts each grass blade at the right height on the knoll							
							translate([	(GrassXn * 03_Grass_Spacing-01_Knoll_Radius)
												+03_Grass_Spacing*Rand_XY_Array[round(rands(0,11,1)[0])], 
											GrassYn * 03_Grass_Spacing-01_Knoll_Radius
												+03_Grass_Spacing*Rand_XY_Array[round(rands(0,11,1)[0])],
											sqrt(	pow(01_Knoll_Radius,2)- 
													pow(
															sqrt(
																pow(GrassXn * 03_Grass_Spacing-01_Knoll_Radius,2) 
																+pow(GrassYn * 03_Grass_Spacing-01_Knoll_Radius,2)
																	)
														,2)
												)
											-(01_Knoll_Radius*(02_Cut_Point - 0.5))
											-Root_Depth
											]) Grass_Blade(
																06_Grass_Blade_Height*Rand_H_Array[round(rands(0,5,1)[0])] , 
																Rand_R_Array[round(rands(0,5,1)[0])], 
																Rand_I_Array[round(rands(0,5,1)[0])],
																04_Grass_Blade_Width,
																05_Grass_Blade_Thickness); //makes a blade of grass
		
						}
					}
	}
//Chops off the bottom
translate([0,0,-Root_Depth * 2]) cylinder(r=01_Knoll_Radius+03_Grass_Spacing, h = Root_Depth * 2);

//Puts in text
translate([0,0,0]) rotate([0,180,0]) write(07_Bottom_Text,h=8,t=3,font="Letters.dxf",space=1.1, center = true);

//Key to remove the knoll from the bed
translate([0, 01_Knoll_Radius,0]) rotate([0,45,0]) translate([-Removal_Key[0]/2, -Removal_Key[1]/2, -Removal_Key[2]/2]) cube([Removal_Key[0],Removal_Key[1],Removal_Key[2]]);

//Pot conversion
if( 08_Pot_Radius != 0) translate([0,0, 10]) cylinder(r=08_Pot_Radius, h=01_Knoll_Radius+06_Grass_Blade_Height);

}


