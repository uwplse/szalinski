/*
	Filament Spooling Daisy
	by Cid Vilas
	Cerca 2012
*/

bearing_thickness = 7;
bearing_od = 22;
bearing_id = 8;

bolt_head = 8;
bolt_extra = 3;
bolt_length = 45;
bolt_diameter = 8;
bolt_nonlength = 20;

nut_diameter = 15;
nut_id = 8;
nut_thickness = 3.5;

washer_diameter = 17;
washer_id = 9;
washer_thickness = 1.6;

base_od = 80;
base_thickness = 3;
base_wall = 3;
base_foot = 20;

daisy_od = 70;
daisy_bolt1 = 3;
daisy_bolt2 = 5;
daisy_thickness = 3;
daisy_wall = 3;
daisy_divider = 8;
daisy_offset = 5;

platform_od = 200;
platform_id = 10;
platform_bolt = 5;
platform_offset = daisy_od / 2 - daisy_offset;
platform_thickness = 5;

support_layer = 0.4;

time_separate = 10;

kerf = 1;

module platform()
{
	color([0.6, 0.5, 0.5])
	difference()
	{
		union()
		{
			translate([0, 0, platform_thickness / 2])
			cylinder(r = platform_od / 2, h = platform_thickness, center = true);
		}
		union()
		{
			for(i = [0 : 3])
			{
				rotate([0, 0, i * 90])
				translate([daisy_od / 2 - daisy_offset, 0, platform_thickness / 2])
				cylinder(r = daisy_bolt1 / 2 + kerf, h = platform_thickness + 0.05, center = true);

				rotate([0, 0, i * 90 + 45])
				translate([daisy_od / 2 - daisy_offset, 0, platform_thickness / 2])
				cylinder(r = daisy_bolt2 / 2 + kerf, h = platform_thickness + 0.05, center = true);
			}

			translate([0, 0, platform_thickness / 2])
			cylinder(r = platform_id / 2, h = platform_thickness + 0.05, center = true);
		}
	}
}

module daisy()
{
	color([0, 0.9, 0])
	difference()
	{
		union()
		{
			translate([0, 0, (bearing_thickness * 2 + daisy_divider) / 2])
			cylinder(r = bearing_od / 2 + daisy_wall,
				h = bearing_thickness * 2 + daisy_divider,
				center = true);

			translate([0, 0, daisy_thickness / 2])
			cylinder(r = daisy_od / 2, h = daisy_thickness, center = true);
			
		}
		union()
		{
			translate([0, 0, bearing_thickness / 2])
			cylinder(r = bearing_od / 2 + kerf,
				h = bearing_thickness + 0.05,
				center = true);

			translate([0, 0, bearing_thickness + daisy_divider + bearing_thickness / 2])
			cylinder(r = bearing_od / 2 + kerf,
				h = bearing_thickness + 0.05,
				center = true);
			
			translate([0, 0, daisy_divider / 2 + bearing_thickness])
			cylinder(r = bolt_diameter / 2 + kerf,
				h = daisy_divider + 0.05,
				center = true);
			
			for(i = [0 : 3])
			{
				rotate([0, 0, i * 90])
				translate([daisy_od / 2 - daisy_offset, 0, daisy_thickness / 2])
				cylinder(r = daisy_bolt1 / 2 + kerf, h = daisy_thickness + 0.05, center = true);

				rotate([0, 0, i * 90 + 45])
				translate([daisy_od / 2 - daisy_offset, 0, daisy_thickness / 2])
				cylinder(r = daisy_bolt2 / 2 + kerf, h = daisy_thickness + 0.05, center = true);
			}
		}
	}
	translate([0, 0, bearing_thickness + support_layer / 2])
	cylinder(r = bolt_diameter / 2 + base_wall, h = support_layer, center = true);

}
module base()
{
	color([0, 0.8, 0])
	difference()
	{
		union()
		{
			translate([0, 0, (base_thickness + base_thickness + bolt_nonlength) / 2])
			cylinder(r = (bolt_diameter / 2) + bolt_extra + base_wall,
				h = base_thickness + base_thickness + bolt_nonlength,
				center = true);


			for(i = [0 : 3])
			{
				rotate([0, 0, i * 90])
				translate([0, base_od / 4, base_thickness + base_thickness / 2])
				cube([base_foot / 4,
					base_od / 3,
					base_thickness], center = true);

				rotate([0, 0, i * 90])
				translate([0, base_od / 4, base_thickness / 2])
				cube([base_foot,
					base_od / 2,
					base_thickness], center = true);
			}
		}
		union()
		{
			translate([0, 0, bolt_head / 2])
			cylinder(r = bolt_head / 2 + bolt_extra + kerf, h = bolt_head + 0.05, center = true);

			translate([0, 0, (base_thickness + base_thickness + bolt_nonlength) / 2])
			cylinder(r = bolt_diameter / 2 + kerf,
				h = base_thickness + base_thickness + bolt_nonlength + 0.05,
				center = true);
		}
	}
	translate([0, 0, bolt_head + support_layer / 2])
	cylinder(r = bolt_diameter / 2 + base_wall, h = support_layer, center = true);
}

module nut()
{
	color([0.9, 0.9, 0.9])
	difference()
	{
		union()
		{
			cylinder(r = nut_diameter / 2, h = nut_thickness, center = true, $fn = 6);
		}
		union()
		{
			cylinder(r = nut_id / 2, h = nut_thickness + 0.05, center = true);
		}
	}
}
module washer()
{
	color([0.7, 0.7, 0.7])
	difference()
	{
		cylinder(r = washer_diameter / 2, h = washer_thickness, center = true);
		cylinder(r = washer_id / 2, h = washer_thickness + 0.05, center = true);
	}
}

module bearing()
{
	color([0.8, 0.8, 0.8])
	difference()
	{
		union()
		{
			cylinder(r = bearing_od / 2, h = bearing_thickness, center = true);
		}
		union()
	 	{
			color([0.5, 0.5, 0.5])
			translate([0, 0, bearing_thickness / 2])
			cylinder(r = bearing_od / 2 - 1, h = 0.5, center = true);
			color([0.5, 0.5, 0.5])
			translate([0, 0, -bearing_thickness / 2])
			cylinder(r = bearing_od / 2 - 1, h = 0.5, center = true);

			cylinder(r = bearing_id / 2, h = bearing_thickness + 0.05, center = true);
		}
	}
}

module bolt()
{
	color([0.4, 0.4, 0.4])
	difference()
	{
		union()
		{
			translate([0, 0, -bolt_diameter / 2])
			cylinder(r = bolt_diameter / 2 + bolt_extra, h = bolt_diameter, center = true);

			translate([0, 0, bolt_length / 2])
			cylinder(r = bolt_diameter / 2, h = bolt_length, center = true);
		}
		union()
		{
			translate([0, 0, -bolt_diameter / 2])
			cylinder(r = bolt_diameter / 2, h = bolt_diameter + 0.05, center = true, $fn = 6);
		}
	}
}





cube([110, 110, 0.1], center = true);


translate([0, 0, bolt_diameter - time_separate * $t * 6])
bolt();

translate([0, 0, base_thickness + base_thickness + bolt_nonlength + nut_thickness / 2 + time_separate * $t * 3])
nut();

translate([0, 0,
	base_thickness + base_thickness + bolt_nonlength + nut_thickness + washer_thickness / 2 + time_separate * $t * 4])
washer();


base();


translate([0, 0,
	base_thickness + base_thickness + bolt_nonlength + nut_thickness + washer_thickness + bearing_thickness / 2 + time_separate * $t * 5])
bearing();

translate([0, 0,
	base_thickness + base_thickness + bolt_nonlength + nut_thickness + washer_thickness + bearing_thickness / 2 + 15  + time_separate * $t * 9])
bearing();

translate([0, 0, bolt_head + bolt_length + time_separate * $t * 7])
rotate([180, 0, 0])
daisy();

//translate([0, 0, bolt_length + bolt_head + time_separate * $t * 10])
//platform();
