//	Filler Cap for Blender. Recommend printing using food safe material and process.
//	Copyright (C) 2018 Herb Weiner <herbw@wiskit.com>. Creative Commons by Attribution.

/* [General Settings] */
//	Unit of Measure for all Numeric Entries
units =						25.4;		//	[25.4:inches,1.0:mm,10.0:cm]
//	of Cylindrical Portion of Filler Cap
outer_diameter =			2.0;
//	of filler cap
total_height =				1.5;
//	Height Below Top of Rubber Lid
bottom_height =				0.75;
//	Thickness of Rubber Lid at Innermost Point
rubber_thickness =			0.2;

/* [Settings for Top of Cap] */
//	Present or Absent
top =						1;			//	[1:Top is Present,0:Top is Absent]
//	(of Top of Cap)
top_thickness =				0.1;
//	of Circumscribing Circle
top_radius =				1.35;
//	Radius of Rounded Corners
top_rounding_radius =		0.25;
//	Number of Sides on Top of Cap
top_number_of_sides =		6;			//	[3,4,5,6,7,8]

/* [Settings for Lip Above Rubber Lid] */
//	Present or Absent
lip =						1;			//	[1:Lip is Present,0:Lip is Absent]
//	of Outermost Portion
lip_diameter =				2.3;
//	Thickness of Outermost Portion of Lip above Rubber Lid
outer_lip_thickness =		0.06;
//	Thickness of Innermost Portion of Lip above Rubber Lid
inner_lip_thickness =		0.13;

/* [Settings for Rectangular Latches that Hold Cap in Rubber Lid] */
//	Present or Absent
latch =						1;			//	[1:Latch is Present,0:Latch is Absent]
//	from Side to Side
latch_width =				0.4;
//	from Cylinder to Outside
latch_length =				0.125;
//	from Top to Bottom
latch_thickness =			0.2;

/* [Interior Settings] */
//	Cap can be hollow with open bottom or solid
hollow =					1;			//	[1:hollow with open bottom,0:solid]
//	Only applies for Hollow Cap
inside_diameter =			1.75;
//	Only applies for Hollow Cap
inside_height =				1.25;
//	Radius for Rounding the Top of the Inside Cylinder (Only applies for Hollow Cap)
inside_rounding_radius =	0.2;

module GoAwayCustomizer ()
{
// This module is here to stop Customizer from picking up the variables below
}

delta =						0.01;
LipThicknessDelta =			inner_lip_thickness - outer_lip_thickness;

module Top ()
{
	if (top_rounding_radius > 0)
	{
		hull ()
		{
			for (i = [1:top_number_of_sides])
			{
				rotate ([0, 0, i * 360 / top_number_of_sides]) translate ([top_radius - top_rounding_radius, 0, 0])	cylinder (r = top_rounding_radius, h = top_thickness, $fn = 360);
			}
		}
	}
	else
	{
		cylinder (r = top_radius, h = top_thickness, $fn = top_number_of_sides);
	}
}

module Latches ()
{
	translate ([-(latch_width / 2), -(latch_length + (outer_diameter / 2)), total_height - bottom_height + rubber_thickness])
		cube ([latch_width, outer_diameter + (2 * latch_length), latch_thickness]);
}

module Lip ()
{
	translate ([0, 0, total_height - bottom_height - inner_lip_thickness])
		cylinder (d = lip_diameter, h = outer_lip_thickness, $fn = 360);
	if (inner_lip_thickness > outer_lip_thickness)
	{
		translate ([0, 0, total_height - bottom_height - LipThicknessDelta])
			cylinder (d1 = lip_diameter, d2 = outer_diameter, h = inner_lip_thickness - outer_lip_thickness, $fn = 360);
	}
}

module Cap ()
{
	cylinder (d = outer_diameter, h = total_height, $fn = 360);
}

module outside ()
{
	Cap ();
	if (top)
		Top ();
	if (lip)
		Lip ();
	if (latch)
		Latches ();
}

module inside ()
{
	if (hollow != 0)
	{
        translate ([0, 0, total_height - inside_height + inside_rounding_radius])
		{
			if (inside_rounding_radius > 0)
			{
				minkowski ()
				{
					cylinder (d = inside_diameter - 2 * inside_rounding_radius, h = inside_height - inside_rounding_radius, $fn = 360);
	
					sphere (inside_rounding_radius, $fn = 100);
				}
			}
			else
				cylinder (d = inside_diameter, h = inside_height + delta, $fn = 360);
		}
	}
}

scale (units)
difference ()
{
	outside ();
	inside ();
}
