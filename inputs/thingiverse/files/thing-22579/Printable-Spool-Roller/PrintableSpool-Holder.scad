//Created by Cid Vilas
//http://www.flickr.com/CidVilas/


//################################################################################
//##                                                                            ##
//##                PLEASE READ INSTRUCTIONS BEFORE MODIFYING                   ##
//##                                                                            ##
//################################################################################


//Specification of the Spool Dimensions:
//		spool_wall = The thickness of the walls of the spool
//		spool_width = The dimension of the spool from outer side to opposite outer side
//		spool_diameter = The diameter of the outer edges of the spool body, not the
//					filament outer diameter (The filament should not extend
//					past this dimension)
//		hole_diameter = The diameter of the hole inside the spool (Currently
//					unused.  Included for just to be thorough)

//Specification of the Hardware:
//		bearing_diameter = The outer diameter of the bearing.  (If you plan on adding
//						a fender washer or lip in the plastic, be sure to offset here)
//		bearing_thickness = The side to side dimension of the bearing.  (If you plan on
//						adding washers, be sure to add to the dimensions)
//		bolt_diameter = This is the diameter of the bolt to be used to secure the bearing
//					and washers to the spool holder.

//Specification of the Spool Holder
//		holder_base_length = In order to properly fit your spool, and maintain stability
//						of the spool holder, be sure this dimension is as wide as
//						possible.  If this value is too small, the spool holder
//						will compare to a football balanced on a Golf Tee.
//		holder_base_height = The thickness of the base of the stand.  Increase for
//						durability, but this will increase pastic usage.
//		holder_wall = This is the thickness of the plastic around the bearing capture.

//NOTE:  The remaining values are not for customization of the stand.  They are used for
//		design.  Adjust at your own risk!


spool_wall = 5;
spool_width = 90 - spool_wall;
spool_diameter = 162.5;
hole_diameter = 37.5;

bearing_diameter = 19;			//Bearing + Fender = 13 + 6 = 19
bearing_thickness = 7;			//Bearing + 2xWasher = 5 + (2) = 7
bolt_diameter = 4.5;



holder_wall = 5;
holder_base_height = 5;
holder_base_width = spool_width + holder_wall;
holder_base_length = 100;

holder_bearing_width = bearing_diameter;
bearing_radius = spool_diameter / 2 + bearing_diameter / 2;
bearing_degree = acos((holder_base_length / 2) / (bearing_radius));
holder_bearing_height = bearing_radius * sin(-bearing_degree)  + spool_diameter/2;


module spool()
{
	rotate([0, 90, 0])
	difference()
	{
	union()
	{
		color([0.1,0.1,0.1])
		translate([0, 0, spool_width / 2])
		cylinder(r = spool_diameter / 2, h = spool_wall, center = true, $fn = 64);
		color([0.1,0.1,0.1])
		translate([0, 0, -(spool_width / 2)])
		cylinder(r = spool_diameter / 2, h = spool_wall, center = true, $fn = 64);
		color([0.5, 0, 0.7])
		translate([0, 0, 0])
		cylinder(r = spool_diameter / 2 - spool_wall, h = spool_width - spool_wall, center = true);
	}
	union()
	{
		color([0.6, 0.6, 0.6])
		cylinder(r = hole_diameter / 2, h = spool_width + spool_wall + 0.1, center = true);
	}
	}
}

module holder()
{
	color([1, 0, 0])
	translate([0, 0, -spool_diameter / 2])
	difference()
	{
	union()
	{
		translate([0, 0, -holder_base_height / 2])	
		cube([spool_width + bearing_thickness + holder_wall * 2,
			holder_base_length,
			holder_base_height], center = true);
		
		translate([spool_width / 2,
				holder_base_length / 2 - bearing_diameter / 2,
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2, h = bearing_thickness + holder_wall * 2, center = true);
			
			translate([0, 0, -holder_bearing_height / 2])
			cube([bearing_thickness + holder_wall * 2, bearing_diameter, holder_bearing_height], center = true);
		}
		translate([-spool_width / 2,
				holder_base_length / 2 - bearing_diameter / 2,
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2, h = bearing_thickness + holder_wall * 2, center = true);
			
			translate([0, 0, -holder_bearing_height / 2])
			cube([bearing_thickness + holder_wall * 2, bearing_diameter, holder_bearing_height], center = true);
		}


		translate([spool_width / 2,
				-(holder_base_length / 2 - bearing_diameter / 2),
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2, h = bearing_thickness + holder_wall * 2, center = true);
			
			translate([0, 0, -holder_bearing_height / 2])
			cube([bearing_thickness + holder_wall * 2, bearing_diameter, holder_bearing_height], center = true);
		}
		translate([-spool_width / 2,
				-(holder_base_length / 2 - bearing_diameter / 2),
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2, h = bearing_thickness + holder_wall * 2, center = true);
			
			translate([0, 0, -holder_bearing_height / 2])
			cube([bearing_thickness + holder_wall * 2, bearing_diameter, holder_bearing_height], center = true);
		}

	}
	union()
	{
		translate([0, 0, -holder_base_height / 2])	
		cylinder(r = holder_base_length / 6, h = holder_base_height + 0.05, center = true);		
		for(i = [0 : 3])
		{
			rotate([0, 0, i * 90])
			translate([holder_base_length / 2, 0, -holder_base_height / 2])	
			cylinder(r = holder_base_length / 3.5, h = holder_base_height + 0.05, center = true);
		}
		translate([spool_width / 2,
				holder_base_length / 2 - bearing_diameter / 2,
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bolt_diameter / 2, h = spool_wall + bearing_thickness * 2 + 0.1, center = true);

			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2 + 1, h = bearing_thickness, center = true);
		}
		translate([-spool_width / 2,
				holder_base_length / 2 - bearing_diameter / 2,
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bolt_diameter / 2, h = spool_wall + bearing_thickness * 2 + 0.1, center = true);

			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2 + 1, h = bearing_thickness, center = true);
		}


		translate([spool_width / 2,
				-(holder_base_length / 2 - bearing_diameter / 2),
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bolt_diameter / 2, h = spool_wall + bearing_thickness * 2 + 0.1, center = true);

			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2 + 1, h = bearing_thickness, center = true);
		}
		translate([-spool_width / 2,
				-(holder_base_length / 2 - bearing_diameter / 2),
				holder_bearing_height])
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bolt_diameter / 2, h = spool_wall + bearing_thickness * 2 + 0.1, center = true);

			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2 + 1, h = bearing_thickness, center = true);
		}

	}
	}
}

holder();
//spool();