// This script creates a wire rack with a variable number of tines

$fn = 32+1-1;	// Dummy math to avoid showing in customizer.

// Number of tines
N = 8;			// [2:20]
tine_width = 10;
tine_height = 4+1-1;
tine_length = 50;
tine_pitch = 12;

base_height = 20;
base_width = base_height*2 + (N-1)*(tine_pitch) + tine_width;
base_thickness = 4+1-1;

echo("<b>Base width [mm]:", base_width);

countersink_diameter = 10;
hole_diameter = 5;

difference()
{
	// Baseplate
	union()
	{
		translate([base_height/2,0,0]) cube([base_width-base_height,base_height,base_thickness]);
		translate([base_height/2,base_height/2,0]) cylinder(base_thickness,base_height/2,base_height/2);
		translate([base_width-base_height/2,base_height/2,0]) cylinder(base_thickness,base_height/2,base_height/2);		
	}

	// Screw holes
	for (i = [0:1])
	{
		translate([base_height/2+(base_width-base_height)*i,base_height/2,4])
		{
			union()
			{
				// Countersink
				cylinder(base_thickness,countersink_diameter/2,countersink_diameter/2,true);

				// Screw hole
				cylinder(base_thickness*3,hole_diameter/2,hole_diameter/2,true);
			}

		}
	}

	// Text
	/*translate([base_width/2-10.75*2.4,2,base_thickness-1])
		scale([12,12,2])
			import("WireRackText.stl");*/
}

// Tines
for (i = [0:(N-1)])
{
	// Tine
	translate([base_height + tine_pitch*i, base_height - tine_height, 0])
		cube([tine_width,tine_height,tine_length]);

	// Tine support
	translate([base_height + tine_pitch*i, base_height-tine_height, 0])
		rotate([45, 0, 0])
			cube([tine_width, tine_height, tine_height]);

	// Upturned tine end
	translate([base_height+tine_pitch*i,base_height-tine_height,tine_length])
		rotate([-30,0,0])
			cube([tine_width,tine_height,tine_height]);
}




