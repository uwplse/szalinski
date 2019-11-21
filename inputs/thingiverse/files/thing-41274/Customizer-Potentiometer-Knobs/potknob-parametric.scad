/*

Parametric Potentiometer Knob Generator
version 1.4
2013 Steve Cooley
http://sc-fa.com
http://beatseqr.com
http://hapticsynapses.com

parametric potentiometer knob generator by steve cooley is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. Based on a work at sc-fa.com. Permissions beyond the scope of this license may be available at http://sc-fa.com/blog/contact.

view terms of the license here:
http://creativecommons.org/licenses/by-nc-sa/3.0/


version history
---------------
1.4 2013-07-16 added an additive OR subtractive pill shaped indicator type
1.3 2013-04-01 updated for more awesome Thingiverse Customizer
1.2 2013-01-09 updated for Thingiverse Customizer
1.1 2012-04-12 fixed the arrow indicator code to be more robust and easier to adjust parameters for.
1.0 2012-03-?? initial release.


*/

/* [Physical attributes] */

// All values are in Millimeters!  How big the top of the knob is:
01_knob_diameter_top = 20; //[10:100]
knob_radius_top = 01_knob_diameter_top / 2;

// How big the bottom of the knob is:
02_knob_diameter_bottom = 20; // [10:100]
knob_radius_bottom = 02_knob_diameter_bottom / 2;

// how tall the knob is:
03_knob_height = 16; // [5:50]
knob_height = 03_knob_height / 1;

// how smooth or geometric the knob is:
04_knob_smoothness = 40; // [3:40]
knob_smoothness = 04_knob_smoothness / 1;

// (measure the potentiometer shaft with calipers and remember to add a bit for shrinkage.)
05_shaft_diameter = 6.2; // this could be a slider if precision were available
shaft_radius = 05_shaft_diameter / 2;

// how much of the shaft the knob should allow space inside for:
06_shaft_height = 13; // [1:40]
shaft_height = 06_shaft_height / 1;

// higher is smoother
07_shaft_smoothness = 20; // [3:20]
shaft_smoothness = 07_shaft_smoothness / 1;

// some potentiometers have a flat surface on the shaft to allow for the use of a set screw.
08_shaft_hole_is_flatted = "true"; // [true,false]

// ignore if no flat is needed.
09_shaft_hole_flat_size = 5.0; // this could be a slider if precision were available
flat_size = 09_shaft_hole_flat_size / 1;

/* [Set screw] */

// some potentiometers need to have their knobs affixed with a set screw.
10_set_screw = "true"; //[true,false]

// in MM:
11_set_screw_diameter = 3; // [0:8]
set_screw_radius = 11_set_screw_diameter / 2;

// how deep into the knob, from the side:
12_set_screw_depth = 9; // [0:20]
set_screw_depth = 12_set_screw_depth / 1;

// from the top:
13_set_screw_height = 4; // [0:20]
set_screw_height = 13_set_screw_height / 1;

// higher is smoother:
14_quality_of_set_screw = 20; // [0:20]
quality_of_set_screw = 14_quality_of_set_screw / 1;

/* [Decorations] */

// thanks to http://www.iheartrobotics.com/ for the articles!
15_top_edge_smoothing = "true"; // [true,false]

// how big of a smoothing radius to apply
16_top_edge_smoothing_radius = 5.0; // [1:10]
smoothing_radius = 16_top_edge_smoothing_radius / 1;

// Number of facets for the rounding cylinder
17_top_edge_smoothing_smoothness = 20.0; // [1:40]
smooth = 17_top_edge_smoothing_smoothness / 1;

ct = -0.1 / 1; 							// circle translate? not sure.
circle_radius = knob_radius_top / 1;  	// just match the top edge radius
circle_height = 1 / 1; 					// actually.. I don't know what this does.
pad = 0.2 / 1;							// Padding to maintain manifold



/* [External indicator] */

// this is a corner edge of a cube sticking out of the cylinder at the bottom, you can use it instead of the arrow shaped cutout in the top if you like. Or both.
18_pointy_external_indicator = "false"; // [true,false]


// how tall should the indicator be, from the bottom:
19_pointy_external_indicator_height = 3; // [1:50]
pointy_external_indicator_height = 19_pointy_external_indicator_height / 1;

// how far out the indicator should poke out:
20_pointy_external_indicator_pokey_outey_ness = 1.0;
pointy_external_indicator_pokey_outey_ness = 20_pointy_external_indicator_pokey_outey_ness * 1;

pokey_outey_value = pointy_external_indicator_pokey_outey_ness - 1 - pad;
pokey_outey = [pokey_outey_value, pokey_outey_value,0];

// there's an arrow shaped hole you can have. There aren't a lot of controls for this.
// please feel free to improve on this script here.

/* [Pill-shaped indicator] */

// there's an arrow shape you can have in the top of the knob.
00_pill_indicator = "true"; // [true,false]

// add or subtract the pill shape?
00_pill_add_or_subtract = "add"; // [add,subtract]

// relative scale of the pill shape:
00_pill_scale = 1.0;

// height of the pill shape:
00_pill_height = 16.0;

// relative scale of length of the pill shape:
00_pill_length = 2.5;

// where to put the arrow, x:
00_pill_location_x = 0.0;

// where to put the arrow, y:
00_pill_location_y = 5.0;

// where to put the arrow, z:
00_pill_location_z = 0.0;

pill_translate = [00_pill_location_x,00_pill_location_y,00_pill_location_z];


/* [Internal Arrow indicator] */

// there's an arrow shape you can have in the top of the knob.
21_top_of_knob_arrow_indicator = "false"; // [true,false]

// scale the arrow head:
22_arrow_head_scale = 2.0;
arrow_scale_head = 22_arrow_head_scale / 1;

// scale the arrow shaft:
23_arrow_shaft_scale = 1.5;
arrow_scale_shaft = 23_arrow_shaft_scale / 1;

// how big the overall arrow indicator should be:
24_arrow_indicator_scale = 1.3;
arrow_indicator_scale = 24_arrow_indicator_scale / 1;

// where to put the arrow, x:
25_arrow_location_x = 0.0;

// where to put the arrow, y:
26_arrow_location_y = 1.0;

// where to put the arrow, z:
27_arrow_location_z = 16.0;

arrow_indicator_translate = [25_arrow_location_x,26_arrow_location_y,27_arrow_location_z];



/* [Sphere Indentations] */

// for spherical indentations, set the quantity, quality, size, and adjust the placement
28_indentations_sphere = "false"; // [true,false]

29_sphere_number_of_indentations = 12; // [1:50]
sphere_number_of_indentations = 29_sphere_number_of_indentations / 1;

30_sphere_quality_of_indentations = 40; // [1:100]
sphere_quality_of_indentations = 30_sphere_quality_of_indentations / 1;

31_size_of_sphere_indentations = 4; // [1:20]
size_of_sphere_indentations = 31_size_of_sphere_indentations / 1;

// the first number in this set moves the spheres in or out. smaller is closer to the middle
32_sphere_indentation_location_x = 12.0;

// the second number in this set moves the spheres left or right
33_sphere_indentation_location_y = 00.0;

// the third number in this set moves the speheres up or down
34_sphere_indentation_location_z = 15.0;

translation_of_sphere_indentations = [32_sphere_indentation_location_x,33_sphere_indentation_location_y,34_sphere_indentation_location_z];

// in case you are using an odd number of indentations, you way want to adjust the starting angle so that they align to the front or set screw locations.
35_sphere_indentation_starting_rotation = 30; // [-90:90]
sphere_starting_rotation = 35_sphere_indentation_starting_rotation / 1 + 90;

/* [Cylinder Indentations] */

// for cylinder indentations, set quantity, quality, radius, height, and placement
36_indentations_cylinder = "true"; // [true,false]

37_number_of_cylinder_indentations = 6; // [1:40]
cylinder_number_of_indentations = 37_number_of_cylinder_indentations / 1;

// higher is smoother:
38_smoothness_of_cylinder_indentations = 50; // [3:100]
cylinder_quality_of_indentations = 38_smoothness_of_cylinder_indentations / 1;

39_diameter_of_top_of_the_cylinder = 5.0; // [1:20]
radius_of_cylinder_indentations_top = 39_diameter_of_top_of_the_cylinder / 2;

40_diameter_of_bottom_of_the_cylinder = 5.0;  // [1:20]
radius_of_cylinder_indentations_bottom = 40_diameter_of_bottom_of_the_cylinder / 2;

41_height_of_cylinder_indentations = 15.0; // [0:40]
height_of_cylinder_indentations = 41_height_of_cylinder_indentations / 1;

// this moves the cylinders in or out from the center
42_position_of_cylinder_x = -0.0; //[-20:20]

// this moves the cylinders left or right
43_position_of_cylinder_y = 0.0; //[-20:20]

// this moves the cylinders up or down
44_position_of_cylinder_z = -5.0; //[-20:20]

translation_of_cylinder_indentations = [42_position_of_cylinder_x,43_position_of_cylinder_y,44_position_of_cylinder_z];

45_cylinder_starting_rotation = -30; // [-90:90]
cylinder_starting_rotation = 45_cylinder_starting_rotation / 1 - 90;


// these are some setup variables... you probably won't need to mess with them.
negative_knob_radius = knob_radius_bottom*-1;


// this is the main module. It calls the submodules.
make_the_knob();

module make_the_knob()
{
difference()
{
	union()
	{
	difference()
		{
		difference()
			{
		
			difference() 
				{
				difference() 
					{
					
					union()
						{
						
						difference()
							{
							// main cylinder
							cylinder(r1=knob_radius_bottom,r2=knob_radius_top,h=knob_height, $fn=knob_smoothness);
							
							smoothing();				
		
							}
				
						external_direction_indicator();	
						}
					
					}
					
				set_screw_hole();
				}
			
			if(00_pill_add_or_subtract == "subtract")
				{
				pill();
				}
			arrow_indicator();
			indentations();
			}
		
	}
	if(00_pill_add_or_subtract == "add")
							{
							pill();
							}
	
	}
shaft_hole();
}

}
module smoothing() {

// smoothing the top
				if(15_top_edge_smoothing == "true")
					{		
						translate([0,0,knob_height])
						rotate([180,0,0])
						difference() {
							rotate_extrude(convexity=10,  $fn = smooth)
							translate([circle_radius-ct-smoothing_radius+pad,ct-pad,0])
							square(smoothing_radius+pad,smoothing_radius+pad);
	
							rotate_extrude(convexity=10,  $fn = smooth)
							translate([circle_radius-ct-smoothing_radius,ct+smoothing_radius,0])
							circle(r=smoothing_radius,$fn=smooth);
							}	
					}
}

module external_direction_indicator() {

				if(18_pointy_external_indicator == "true")
						{
						
						
						// outer pointy indicator
						rotate([0,0,45])
						translate(pokey_outey)
						// cube size of 8 minimum to point out
						cube(size=[knob_radius_bottom,knob_radius_bottom,pointy_external_indicator_height],center=false);
						}

}

module shaft_hole() {
				// shaft hole
				difference()
					{
					
					// round shaft hole
					translate([ 0, 0, -1 ]) 
					cylinder(r=shaft_radius,h=shaft_height, $fn=shaft_smoothness);
					
					if(08_shaft_hole_is_flatted  == "true")
						{
						// D shaft shape for shaft cutout
						rotate( [0,0,90]) 
						translate([-7.5,-5,0]) 
						cube(size=[flat_size,10,13],center=false);
						}
					}
}


module set_screw_hole() {

			if(10_set_screw == "true")
				{
				// set screw hole
				rotate ([90,0,0])
				translate([ 0, set_screw_height, 1 ])
				cylinder(r=set_screw_radius,h=set_screw_depth, $fn=quality_of_set_screw);
				}
}

module arrow_indicator() {
		if(21_top_of_knob_arrow_indicator == "true")
			{
			translate(arrow_indicator_translate)
			// begin arrow top cutout
			// translate([(knob_radius/2),knob_height,knob_height])
			rotate([90,0,45])
			scale([arrow_indicator_scale*.3,arrow_indicator_scale*.3,arrow_indicator_scale*.3])
			union()
				{			  
				rotate([90,45,0])
				scale([arrow_scale_head,arrow_scale_head,1])
				cylinder(r=8, h=10, $fn=3, center=true);
				rotate([90,45,0])
				translate([-10,0,0])
				scale([arrow_scale_shaft,arrow_scale_shaft,1])
				cube(size=[15,10,10],center=true);
				}
			}
}

module indentations() {

if(28_indentations_sphere == "true")
			{
			for (z = [0:sphere_number_of_indentations]) 
				{
				rotate([0,0,sphere_starting_rotation+((360/sphere_number_of_indentations)*z)])
				translate(translation_of_sphere_indentations)
				sphere(size_of_sphere_indentations, $fn=sphere_quality_of_indentations); 
				}
			}
if(36_indentations_cylinder == "true")
			{
			for (z = [0:cylinder_number_of_indentations]) 
				{
				rotate([0,0,cylinder_starting_rotation+((360/cylinder_number_of_indentations)*z)])
				
				translate([negative_knob_radius,0,knob_height])
				translate(translation_of_cylinder_indentations)
				cylinder(r1=radius_of_cylinder_indentations_bottom, r2=radius_of_cylinder_indentations_top, h=height_of_cylinder_indentations, center=true, $fn=cylinder_quality_of_indentations); 
				}
			}
		}

module pill()
{

if(00_pill_indicator == "true")
	{

	translate(pill_translate)

	rotate([0,0,90])
		{
		union()
			{
			cylinder(00_pill_height,00_pill_scale,00_pill_scale, $fn=40);
			translate([0,-00_pill_scale,0])
				{
					cube([(00_pill_scale*2)*00_pill_length,00_pill_scale*2,00_pill_height]);
				}
			translate([(00_pill_scale*2)*00_pill_length,0,0])
				{
					cylinder(00_pill_height,00_pill_scale,00_pill_scale, $fn=40);
				}
			}
		}
	}
}