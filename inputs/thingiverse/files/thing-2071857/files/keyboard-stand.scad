num_keyboards = 2;		// [1:1:20]
keyboard_to_keyboard = 24;	// [8:100]
keyboard_thickness = 12;	// [5:100]
flange = 4;			// [1:50]
thickness = 10;			// [3:50]

/* [Hidden] */
$fa = 6;
$fs = 0.2;
e = 0.01;

for (side=[0,1]) translate([side * 15, 0, side*thickness]) rotate([0, -90+side*180, 0])
difference()
{
	minkowski()
	{	
		difference()
		{
			minkowski()
			{	
				difference()
				{
					ySz = (num_keyboards - 1) * keyboard_to_keyboard + keyboard_thickness + 16;
					cube([thickness, ySz, 30]);
					translate([-e, ySz-keyboard_thickness-2, max(e, flange - 3.5)])cube([thickness+2*e, ySz, 30]);
				}
				rotate([0, 90, 0]) cylinder(e, r=5);
			}
			
			for (keyb = [0:num_keyboards-1])
			translate([-10, 17 + keyb * keyboard_to_keyboard, 0]) rotate([5, 0, 0]) union()
			{
				cube([200, keyboard_thickness, 100]);
				if (keyb < num_keyboards-1)
					translate([0, keyboard_thickness-e, flange]) cube([200, keyboard_thickness/2, 100]);
			}
			
		}

		rotate([0, 90, 0]) cylinder(e, r=1);
	}

	translate([-10, 5.5, 5.5]) rotate([0, 90, 0]) cylinder(200, d=8.2);
}

