//Battery dimensions in mm

battery_diameter=12;
battery_height=2.5;
tolerance=0.5;
wall_thickness=1;
difference()
{
	union()
	{
		difference()
		{
			cylinder(r=(battery_diameter/2)+tolerance+wall_thickness, h=battery_height+(tolerance)+(2*wall_thickness),$fn=50);

			translate([0,0,wall_thickness])
			cylinder(r=(battery_diameter/2)+(tolerance/2), h=battery_height+(tolerance),$fn=50);
			translate([0,-((battery_diameter/2)+2+tolerance),0])
			cube([battery_diameter+10,battery_diameter+5,battery_height+5]);

		}

		difference()
		{
			translate([0,-((battery_diameter/2)+wall_thickness+tolerance),0])
			cube([battery_diameter/2,battery_diameter+(2*wall_thickness)+(2*tolerance),battery_height+(2*wall_thickness)+tolerance]);

			translate([0,-((battery_diameter/2))-(tolerance/2),wall_thickness])
			cube([battery_diameter+tolerance,battery_diameter+tolerance,battery_height+tolerance]);
		}
	}
	translate([0,0,-1])
	cylinder(r=0.5, h=battery_height+tolerance+10,$fn=16);
}
