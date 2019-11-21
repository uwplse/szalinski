//------------------------------------------------------------------------
//  Filename:  Global_dynamics.scad
//	Author:    Robert H. Morrison
//	Date:      16 Oct 2014
//---[ D e s c r i p t i o n ]--------------------------------------------
//	This is an improvment on my first version even though it must be
//	assembled.  This prints the LOGO face down so it will be easy to
//	color it using metallic gold flake paint.
//	Also a base has been added with "GLOBAL DYNAMICS" on it.
//	The only thing missing is the globe of the Earth in the center.
//------------------------------------------------------------------------

use <write/Write.scad>
use <utils/build_plate.scad>

//---[ USER Customizable Parameters ]-----------------------------------------

part = 3; //[1:Complete,2:LOGO,3:Base,4:Pyramid]
base = 1; //[1:Solid,2:Hollow]
text = 1; //[1:Show,2:Hide]

//---[ Build Plate ]----------------------------------------------------------

//: for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//------------------------------------------------------------------------
//	How the LOGO was created:  680
//	------------------------
//	I found the biggest good image of the Global Dynamics LOGO that I
//	could on the Internet (using Google of course) and then wrote down
//	the coordinates for the 9 points that describe the left part of the
//	LOGO.  I also measured the distance between the left and right parts
//	of the LOGO and created the right part by rotating the left part.
//------------------------------------------------------------------------

module left_logo()
{
	translate([-450,-227,0])
		polygon(points=[[416,227],[416,471],[111,471],[416,3],[416,147],[247,404],[360,404],[360,344],[340,344]], paths=[[0,1,2,3,4,5,6,7,8]], convexity=10);
}

module right_logo()
{
	rotate([0,180,0])
		left_logo();
}

module logo()
{
	translate([0,0,0])
		linear_extrude(height=2, center = true, convexity = 10)
			union()
			{
				left_logo();
				right_logo();
			}
}

tw = 99.25;

module base()
{
	translate([0,0,20])
		rotate([0,180,0])
			difference()
			{
				union()
				{
					hull()
					{
						translate([0,0,20])
							cube([tw,tw,0.01], true);
						cube([134,134,0.01], true);
					}
					
					if (text == 1)
					{
						for (a=[0,90,180,270])
							rotate([0,0,a])
								translate([0,-58,10])
									rotate([90,0,0])	// 63
										write("GLOBAL DYNAMICS",t=8,h=9,center=true,rotate=0,font="orbitron.dxf");
					}
				}
				
				if (base == 2)
				{
					translate([0,0,-2])
						hull()
						{
							translate([0,0,20])
								cube([tw-2,tw-2,0.01], true);
							cube([132,132,0.01], true);
						}
				}
			}
}

module logo_face_down()
{
	difference()
	{
		scale([0.1470588,0.1470588,1])
			logo();
			
		translate([0,36.75,1])
			rotate([40.5,0,0])
				cube([101,4,4], true);
				
		translate([27.5,0,1.25])
			rotate([57.5,0,57])
				cube([101,4,4], true);
				
		translate([-27.5,0,1.25])
			rotate([57.5,0,-57])
				cube([101,4,4], true);
	}
}

module pyramid()
{
	for(a=[0,90,180,270])
		rotate([0,0,a])
			translate([0,-25.625,46.6])
				rotate([-130.5,0,0])
					logo_face_down();
}

module logo_plate()
{
	for(b=[0,90,180,270])
		rotate([0,0,b])
			translate([0,40,1])
				logo_face_down();
}

if (part == 1)
{
	translate([0,0,20])
		rotate([0,180,0])
			base();

	translate([0,0,0])
		pyramid();
}
else if (part == 2)
{
	logo_plate();
}
else if (part == 3)
{
	if (base == 1)
	{
		translate([0,0,20])
			rotate([0,180,0])
				base();
	}
	else
		base();
}
else if (part == 4)
{
	translate([0,0,-20])
		pyramid();
}
