//CUSTOMIZER VARIABLES

//	Number of sides for the Microphone flag
number_of_sides = 4;	//	[3:12]

//	This is the width of the logo area, margin for the rounding will be added (mm)
width_of_logo = 50;

//	This is the height of the logo area (mm)
height_of_logo = 50;

//	This is the diameter of the hole for the microphone (mm)
hole_diameter = 40;

//	Here you can select if you want a bottom plate too, or just the top one
use_bottom = "false";	//	[true,false]

//CUSTOMIZER VARIABLES END

resolution = 100*1;

module flag(size, height, sides, hole, bottom)
{
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					translate([0, 0, height/2-3/2-5])
						cylinder(h = 3, r1 = sqrt((tan((90+((sides-3)*90))/sides)*size/2)*(tan((90+((sides-3)*90))/sides)*size/2)+(size/2)*(size/2))+4, r2 = sqrt((tan((90+((sides-3)*90))/sides)*size/2)*(tan((90+((sides-3)*90))/sides)*size/2)+(size/2)*(size/2))+4, center = true, $fn = resolution);
					if (bottom == "true")
					{
						translate([0, 0, -height/2+3/2])
							cylinder(h = 3, r1 = sqrt((tan((90+((sides-3)*90))/sides)*size/2)*(tan((90+((sides-3)*90))/sides)*size/2)+(size/2)*(size/2))+4, r2 = sqrt((tan((90+((sides-3)*90))/sides)*size/2)*(tan((90+((sides-3)*90))/sides)*size/2)+(size/2)*(size/2))+4, center = true, $fn = resolution);
					}
				}
				union()
				{
					for ( i = [0 : sides-1] )
					{		
						rotate(360/sides*i, [0, 0, 1])
						translate([0, -(tan((90+((sides-3)*90))/sides)*size/2)-2-30/2, 0]) //distance from center
							cube([size+10, 30, height], center = true); // side block

					}
				}
			}
			for ( i = [0 : sides-1] )
			{		
				rotate(360/sides*i, [0, 0, 1])
				translate([0, -(tan((90+((sides-3)*90))/sides)*size/2)-5+3/2, 0]) //distance from center
					cube([size, 3, height], center = true); // side

				difference()
				{
					union()
					{
						rotate(360/sides*i, [0, 0, 1]) // follow sides
						translate([size/2, -(tan((90+((sides-3)*90))/sides)*size/2), 0]) // move to end of side
							cylinder(h = height, r1 = 5, r2 = 5, center = true, $fn = resolution); // outer corner diameter
					}
					union()
					{
						rotate(360/sides*i, [0, 0, 1]) // follow sides
						translate([size/2, -(tan((90+((sides-3)*90))/sides)*size/2), 0]) // move to end of side
							cylinder(h = height+1, r1 = 2, r2 = 2, center = true, $fn = resolution); // inner corner diameter		

						rotate(360/sides*i, [0, 0, 1]) // follow sides
						translate([size/2-10, -(tan((90+((sides-3)*90))/sides)*size/2), 0]) // move to end of side
							cube([20, 20, height+1], center = true);

						rotate(360/sides*i, [0, 0, 1])
						translate([size/2, -(tan((90+((sides-3)*90))/sides)*size/2), 0])
						rotate(360/sides+180, [0, 0, 1])
						translate([-10, 0, 0])
							cube([20, 20, height+1], center = true);
					}
				}
			}
		}
		union()
		{
			cylinder(h = height+1, r = hole/2, center = true, $fn = resolution);
		}
	}
}

// called with customizer parameters
flag(width_of_logo, height_of_logo, number_of_sides, hole_diameter, use_bottom);

//flag(90, 40, 3, 40, "false");

//flag(60, 65, 4, 40, "false");

//flag(45, 30, 5, 40, "false");

//flag(40, 40, 6, 40, "false");

//flag(30, 35, 7, 40, "false");

//flag(45, 45, 4, 35, "true");
