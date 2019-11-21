/**********************************************************************************************************************************
Customisable Cable Junction Enclosure v1.0 by Mike Thompson 8/5/2014

Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.  Further 
information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB

This enclosure is a simnple and robust customisable design able to hide and provide protection for cable junctions. It is easy to 
print without support and is configurable to handle multiple cable entry points and configurations.

Key features:
- Fully customisable 
- Easy to print without support
- Clam shell design allows cables to be placed in enclosure without disconnecting. 

Instructions:
Adjust the dimensions below to suit your requirements and separately generate the case and lid.
************************************************************************************************************************************/

/**************************************************************************
Enter the values corresponding to your requirements in this section
***************************************************************************/

/* [General Options] */

//Choose which component to generate. 'All' will show both halves to visualise the complete set. Remember to set to 'case' or 'lid' before compilation
Component = "all";//[case,lid,all]
//Number of cable entry/exit holes. Set to 0 if cable entry through base.
number_cables=2;//[0:12]
//Diameter of cable entering or exiting enclosure
cable_diameter=7;
//Overall height (depth) of enclosure 
height=30;
//Diameter of enclosure
enclosure_diameter=56;
//Number of standoffs for atttaching the two halves
number_standoffs=2;
//Diameter of the screw hole in the standoff.  Set to a value that the screw will grab snuggly.  The lid hole will be 1mm wider in diameter to allow the screw to pass through easily
standoff_inner_diameter=2.5;

/* [Mounting Holes] */

//Central mounting hole in case
mount_hole_centre="true";//[true,false]
//Diameter of the central mounting hole. Note: The diameter can be changed to accommodate a cable entry point if required
mount_hole_centre_diameter=3.5;
//Top mounting hole in case
mount_hole_top="false";//[true,false]
//Diameter of the top mounting hole. Note: The diameter can be changed to accommodate a cable entry point if required
mount_hole_top_diameter=3.5;
//Bottom mounting hole in case
mount_hole_bottom="false";//[true,false]
//Diameter of the bottom mounting hole. Note: The diameter can be changed to accommodate a cable entry point if required
mount_hole_bottom_diameter=3.5;
//Left mounting hole in case
mount_hole_left="false";//[true,false]
//Diameter of the left mounting hole. Note: The diameter can be changed to accommodate a cable entry point if required
mount_hole_left_diameter=3.5;
//Right mounting hole in case
mount_hole_right="false";//[true,false]
//Diameter of the right mounting hole. Note: The diameter can be changed to accommodate a cable entry point if required
mount_hole_right_diameter=3.5;


/************************************************************************************************************
The following values can be be tweak defaults and adjust optional settings
*************************************************************************************************************/

/* [Advanced Options] */
//Thickness of walls
thickness=1.5;
//thickness of inner wall lip of lid to lock in place
lip_thickness=1.5;
//Provides small gap between lip and inside of case to prevent grabbing
tolerance=0.25; 
//Outer diameter of standoffs. Should not need to be changed unless using a very large screw 
standoff_outer_diameter=8;
//Offset angle of standoff relative to cable entry hole. May need to adjust to ensure standoff does not obstruct cable entry hole
standoff_angle_offset=45;
//Countersink hole in lid. Note: if used, printing may require support or cleanup
countersink="false";
//Diameter of countersink in lid
countersink_diameter=7;
//Depth of countersink.  Note: do not set the countersink depth to the same or greater value than the thickness
countersink_depth=1;

/*********************************************************************************************************
The following should not be changed
**********************************************************************************************************/


internal_radius=enclosure_diameter/2;

//Curve resolution
$fn=64;

if (Component=="all") //'all' displays case and lid together (display only - set to case or lid to generate separate components)
{
	mirror([0,0,1])case();
	translate([0,0,10])lid();
} 
else
{
	if (Component=="case")
	{
		mirror([0,0,1])case(); //build case and flip to print in correct orientation
	}
	else
	{
		mirror([0,0,1])lid(); //build lid and flip to print in correct orientation
	}
}

module case() //generate the case
{
	difference()
	{
		union()
		{
			casebase();
			standoffs(standoff_inner_diameter,standoff_angle_offset);
		}
		union() //
		{
			if (mount_hole_centre=="true")
			{
				translate([0,0,(height/2)-thickness-0.1])cylinder(r=mount_hole_centre_diameter/2,h=thickness+0.2);
			}
			if (mount_hole_right=="true")
			{
				translate([0,-internal_radius/2,(height/2)-thickness-0.1])cylinder(r=mount_hole_right_diameter/2,h=thickness+0.2);
			}
			if (mount_hole_left=="true")
			{
				translate([0,internal_radius/2,(height/2)-thickness-0.1])cylinder(r=mount_hole_left_diameter/2,h=thickness+0.2);
			}
			if (mount_hole_top=="true")
			{
				translate([internal_radius/2,0,(height/2)-thickness-0.1])cylinder(r=mount_hole_top_diameter/2,h=thickness+0.2);
			}
			if (mount_hole_bottom=="true")
			{
				translate([-internal_radius/2,0,(height/2)-thickness-0.1])cylinder(r=mount_hole_bottom_diameter/2,h=thickness+0.2);
			}
		}
	}
}

module lid() //generate the lid
{
	difference()
	{
		union()
		{
			lidbase();
			standoffs(standoff_inner_diameter+1,standoff_angle_offset-180);
		}	
		lid_holes(standoff_inner_diameter+1,standoff_angle_offset-180);
	}
}

module casebase()
{	
	difference()
	{
		difference()
		{
			cylinder(r=internal_radius+thickness,h=height/2);
			translate([0,0,-thickness])cylinder(r=internal_radius,h=height/2);
		}
		cableholes();
	}
}

module cableholes()
{
	for(i=[1:number_cables])
	{
		translate([cos(360/number_cables*i)*internal_radius, sin(360/number_cables*i)*internal_radius, 0 ])
		hull() //hull used to stretch cut to include a vertical component on lip section
		{
			sphere(r=cable_diameter/2); //spheres used as cutouts rather than cylinders to improve sealing if sealing compound used	
			translate([0,0,-2])sphere(r=cable_diameter/2);
		}
	}
}	

module lidbase()
{
	difference()
	{
		union()
		{
			difference()
			{
				cylinder(r=internal_radius+thickness,h=height/2);
				translate([0,0,-thickness])cylinder(r=internal_radius-tolerance,h=height/2);
			}
			translate([0,0,-thickness])difference()
			{
				cylinder(r=internal_radius-tolerance,h=height/2);
				cylinder(r=internal_radius-lip_thickness,h=height/2);
			}	
		}
		cableholes();
	}
}	

module lid_holes(inner_hole_diameter, offset_angle)
{
	for(i=[1:number_standoffs])
	{
		rotate([0,0,offset_angle])translate([cos(360/number_standoffs*i)*(internal_radius-(standoff_outer_diameter/2)-lip_thickness), sin(360/number_standoffs*i)*(internal_radius-(standoff_outer_diameter/2)-lip_thickness), 0 ])
		union()
		{
			translate([0,0,(height/2)-thickness])cylinder(r=inner_hole_diameter/2,h=thickness);
			if (countersink=="true")
			{
				translate([0,0,(height/2)-countersink_depth-0.1])cylinder(r=countersink_diameter/2,h=countersink_depth+0.2);
			}
		}
	}
}

module standoffs(inner_hole_diameter,offset_angle) //generates standoffs. No more than 4 recommended.
{
	for(i=[1:number_standoffs])
	{
		rotate([0,0,offset_angle])translate([cos(360/number_standoffs*i)*(internal_radius-(standoff_outer_diameter/2)-lip_thickness), sin(360/number_standoffs*i)*(internal_radius-(standoff_outer_diameter/2)-lip_thickness), 0 ])
		difference()
		{
			translate([0,0,tolerance/2])cylinder(r=standoff_outer_diameter/2,h=(height/2)-(tolerance/2)); //tolerance used to ensure sufficent gap between standoffs for flush closure
			translate([0,0,(tolerance/2)-0.1])cylinder(r=inner_hole_diameter/2,h=(height/2)-(tolerance/2)+0.2);
		}
	}
}