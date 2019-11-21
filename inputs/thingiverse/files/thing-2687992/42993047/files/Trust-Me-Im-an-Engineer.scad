/* 
Title:    Trust Me, I'm an Engineer Keyring
Author:   Jacob Edwards
Created:  11/15/2017
Modified: 12/04/2017
Web Address: https://www.thingiverse.com/thing:2687992
*/

// Library for gears, written by GregFrost, can be downloaded from http://www.thingiverse.com/thing:3575 I've left it commented here because it will break customizer, but if you download it you can delete everything after the keychain_hole module and replace it with the following line, though please note that I altered some of the default inputs to the gear function, so you'll either have to put them in every call, or update your own copy of his code for this thing to work.
//include <parametric_involute_gear_v5.0.scad>


/* [General] */

// Rounds the edges and corners, with a radius equal to half of "Thickness". Warning: "corners and edges" will increase the model's dimensions in the x and y dimensions beyond the chosen width and height, by an amount equal to the thickness, but "corners only" will not. Does NOT control the rounding on the inside of the hole. In fact, I don't recommend setting "Rounding" to "off" without also setting "Hole" to "no"
rounding = 2; // [0:off,1:corners only,2:corners and edges]

// Only works if the "Position of Small Gears" option is set to "right". With 5 gears it's meant to be read "I'm a five gear engineer" or "I'm a five star engineer"
number_of_small_gears = 1;  // [1:four,0:five]

// Right places the small gears to the right of the text in the second line. Left places them to the left of the text - just as it was in all three previous versions of this thing - but disables the option to have 5 gears.
position_of_small_gears = 0; //[0:right,1:left]

// Include a hole in the top left corner. Having the hole disables the "Design On Both Sides" option, and not having the hole adds an extra medium gear to fill in the white space, but disables the "Extra Rounding" option.
hole = 1; //[1:yes,0:no]

// Only works if "Hole" is set to "yes" and "Rounding" is set to "corners and edges". Adds extra rounding on the corner where the hole is, which should make it work better as a keychain. More specifically, it replaces a section of the corner with a section of the taurus used to create the hole. 
extra_rounding = 1; //[1:yes,0:no]

// Only works if the "Hole" option is set to "no". Puts a copy of the design on the bottom of the model as well as the top. Warning: my slicer handles this poorly, and the filament I print with can't bridge nearly well enough, so I can't test print it. It's possible your slicer and filament will have the same problems.
design_on_both_sides = 0; //[0:no,1:yes]

// Only works if the "Design On Both Sides" option is set to "no". Makes the detailing protrude from the model rather than being cut into it. Useful if you want to make a multi-colored print by swapping filament mid-print.
raised_detailing = 0; //[0:no,1:yes]



/* [Dimensions] */

// The thickness in the Z direction in millimeters. Disregard the rest of this description if "Raised Detailing" is set to "yes". If "Design On Both Sides" is set to "no", then this should be greater than "Detailing Depth", or less than it if you want the text and gears to go all the way through, but NOT equal to it, as that may cause non-manifold geometry in the final STL. If "Design On Both Sides" is set to "yes", then this should be greater than twice "Detailing Depth".
Thickness = 4; //[1:.5:10]

// The width in the X direction in millimeters. This will not change the size of the detailing, and the detailing will remain centered. If you wish to change the size of the detailing, use the "Scale Whole Model" option under "Advanced Settings", or scale the model in your slicer.
Width     = 70.5; //[70.5:.5:150]

// The height in the Y direction in millimeters. This will not change the size of the detailing, and the detailing will remain centered. If you wish to change the size of the detailing, use the "Scale Whole Model" option under "Advanced Settings", or scale the model in your slicer.
Height    = 47.5; //[47.5:.5:150]

// The depth that the detailing is cut into (or raised out of) the model in millimeters. Disregard the rest of this description if "Raised Detailing" is set to "yes". If "Design On Both Sides" is set to "no", then this should be less than "Thickness", or greater than it if you want the text and gears to go all the way through, but NOT equal to it, as that may cause non-manifold geometry in the final STL. If "Design On Both Sides" is set to "yes", then this should be less than half of "Thickness".
Detailing_depth = 1; // [.5:.5:7]

// Only works if the "Hole" option is set to "yes". The diameter of the hole in millimeters. Specifically the diameter of the actual hole, the rounding on the hole extends beyond this distance by half of "Thickness" in all directions. If you make this too large, it will cut into the detailing.
Hole_diameter = 8; // [2:.5:20]

// Only works if the "Rounding" option is set to "corners only". The radius of the corner rounding.
Corner_radius = 2; // [.5:.5:5]

/* [Advanced] */

// Leave this set to 0 and it won't do anything, otherwise it overrides the corresponding setting in the Dimensions tab. I hate Customizer's slider bars, so here's a text field in case you hate them too. Default is 4. Text and negative numbers will break it (in a mildly interesting way). 
thickness_advanced = 0;

// Leave this set to 0 and it won't do anything, otherwise it overrides the corresponding setting in the Dimensions tab. I hate Customizer's slider bars, so here's a text field in case you hate them too. Default is 70.5. Values below that may cut off the detailing (consider using "Scale Whole Model" or scaling in your slicer instead). Text and negative numbers will break it (in an interesting way). 
width_advanced     = 0;

// Leave this set to 0 and it won't do anything, otherwise it overrides the corresponding setting in the Dimensions tab. I hate Customizer's slider bars, so here's a text field in case you hate them too. Default is 47.5. Values below that may cut off the detailing (consider using "Scale Whole Model" or scaling in your slicer instead). Text and negative numbers will break it (in an interesting way). 
height_advanced    = 0;

// Leave this set to 0 and it won't do anything, otherwise it overrides the corresponding setting in the Dimensions tab. I hate Customizer's slider bars, so here's a text field in case you hate them too. Default is 1. Text and negative numbers will break it (in an almost interesting way). 
detailing_depth_advanced = 0;

// Leave this set to 0 and it won't do anything, otherwise it overrides the corresponding setting in the Dimensions tab. I hate Customizer's slider bars, so here's a text field in case you hate them too. Default is 8. Text and negative numbers will break it (in an uninteresting way). 
hole_diameter_advanced = 0;

// Leave this set to 0 and it won't do anything, otherwise it overrides the corresponding setting in the Dimensions tab.  I hate Customizer's slider bars, so here's a text field in case you hate them too. Default is 2. Large numbers may cut off the detailing (5 it about the max with the default width and height). Text and negative numbers will break it (in an uninteresting way). 
corner_radius_advanced = 0;

// Leave this set to 1 and it won't do anything. Scales the whole model in every direction by the input amount. Default is 1. Text won't do anything, and negatives actually won't break this one, though they will mirror the text. (congratulations, you found the hidden option!)
scale_whole_model = 1;


/* [Hidden] */

/*
// Test multiple renderings YOU NEED TO COMMENT OUT THE DECLARATIONS IN THE "GENERAL" SECTION FOR THIS TO WORK! (only affects toggleable settings, not continuous ones).

    // Option 1: Used to rapidly test all combinations of settings via animation (steps = 192), don't use this and option 2 below; one or both of them should be commented for the code to work
    animvar = round($t*192);
    echo(animvar);
    color("black") translate([-15,Height]) rotate([65,-3,20]) text(str(animvar),12);// set view to center and diagonal for best results
    tester6 = animvar%2;
    tester5 = floor((animvar%4)/2);
    tester4 = floor((animvar%8)/4);
    tester3 = floor((animvar%16)/8);
    tester2 = floor((animvar%32)/16);
    tester1 = floor((animvar%64)/32);
    tester0 = (animvar-(tester1*32+tester2*16+tester3*8+tester4*4+tester5*2+tester6))%3;
    tester = [tester0, tester1, tester2, tester3, tester4, tester5, tester6];
    echo(tester);
    
    
    // Option 2: Used to quickly test many specific combinations of settings, don't use this and option 1 above; one or both of them should be commented for the code to work
    // tester = [0,0,0,0,0,0,0]; // Use the assignments below as a key to populate this with the values you want for each preview

    // Sets the relevant variables
    rounding = tester[0];
    number_of_small_gears = tester[1];
    position_of_small_gears = tester[2];
    hole = tester[3];
    extra_rounding = tester[4];
    design_on_both_sides = tester[5];
    raised_detailing = tester[6];
    
    if(both_sides && !hole && !raised_detailing) color("black") translate([8,-Height]) rotate([50,0,25]) text("B",11); // Indicator for back side, set view to center and diagonal for best results

// end of test multiple renderings
*/


// This section is a result of changing the code so it works with customizer, and can be removed if you change all following occurances of the variables being set to the variable they're being set to. I'm sorry if this is annoying.
        four_gear = number_of_small_gears;
        flip_gears = position_of_small_gears;
        tube_round = extra_rounding;
        both_sides = design_on_both_sides;
// End of removable section, see above for details

// Set variables to advanced values if applicable, regular if not
thickness = thickness_advanced!=0 ? thickness_advanced : Thickness;
width = width_advanced!=0 ? width_advanced : Width;
height = height_advanced!=0 ? height_advanced : Height;
cut_depth = detailing_depth_advanced!=0 ? detailing_depth_advanced : Detailing_depth;
hole_diam = hole_diameter_advanced!=0 ? hole_diameter_advanced : Hole_diameter;
corner_radius = corner_radius_advanced!=0 ? corner_radius_advanced : Corner_radius;

// This will affect height of protruding text, I should have used cut_depth for both
overshoot = cut_depth;

// Resolution for small parts (larger -> longer render)
$fn=40;

// Text settings (Change these at your own risk! The X and Y positioning of the gears and text is mostly manual, not calculated, so you will need to fiddle with them to get everything right if you do change any of these.)
text_size_small = 7; // 7
text_size_large = 9; // 9
font_used = "Arial:style=Regular"; // "Arial:style=Regular"
text_spacing = 1.05; //1.05






// You are now entering a poorly commented abyss. I hope to update this in the future with a well-commented version, but to be honest I may never get to that. I wish you the best of luck as you attempt to traverse my code, and if you absolutely can't figure something out, feel free to message me on thingiverse by navigating to this url: http://www.thingiverse.com/messages/compose?username=rccajack 


// int main (void)?
scale(scale_whole_model) difference(){
    union() {// Block
        block();
        if(raised_detailing&&!design_on_both_sides) details();
    }
    {// Details
        if(!raised_detailing||design_on_both_sides) details();
        if(hole)
            keychain_hole();
    }
}

module block()
{
    union()
    {// Main body
        difference()
        {
            union(){
                translate([0, 0, thickness/2]) cube([width, height, thickness], center=true);
                // Rounded edges
                if(rounding==2)
                    rounded_edges();
            }
            if(rounding==1)
                rounded_corners();
        }
    }
}

module details()
{
    text_part();
    small_gears();
    concentric_gears();
    top_gear();
    if(both_sides && !hole && !raised_detailing)
    {
        translate([0, 0, thickness])rotate(180, [0, 1, 0])
        {
            text_part();
            small_gears();
            concentric_gears();
            top_gear();

        }
    }
}

module rounded_edges()
{
    translate([       0, -height/2, thickness/2]) rotate([ 0, 90])
        cylinder( width, d=thickness, center=true);
    translate([       0,  height/2, thickness/2]) rotate([ 0, 90])
        cylinder( width, d=thickness, center=true);
    translate([ width/2,         0, thickness/2]) rotate([90,  0])
        cylinder(height, d=thickness, center=true);
    translate([-width/2,         0, thickness/2]) rotate([90,  0])
        cylinder(height, d=thickness, center=true);
    translate([ width/2,  height/2, thickness/2]) sphere(thickness/2);
    translate([-width/2,  height/2, thickness/2]) sphere(thickness/2);
    translate([ width/2, -height/2, thickness/2]) sphere(thickness/2);
    translate([-width/2, -height/2, thickness/2]) sphere(thickness/2);
}

module rounded_corners()
{
    mirror([0,0,0]) one_corner_round();
    mirror([1,0,0]) one_corner_round();
    mirror([0,1,0]) one_corner_round();
    mirror([1,0,0]) mirror([0,1,0]) one_corner_round();
}

module one_corner_round()
{
    difference()
    {
        translate([ width/2,  height/2, thickness/2]) cube([corner_radius*2,corner_radius*2,thickness+2*overshoot], center=true);
        translate([ width/2-corner_radius,  height/2-corner_radius, thickness/2]) cylinder(thickness+4*overshoot, r = corner_radius, center=true);
    }
}
module text_part()
{
    translate([-34,-1,thickness-cut_depth]) linear_extrude(height=cut_depth+overshoot) text("TRUST ME,", text_size_small, font_used, spacing=text_spacing);
    if(!flip_gears)
    {
        if(four_gear)
            translate([-34,-10.5,thickness-cut_depth]) linear_extrude(height=cut_depth+overshoot) text("I M AN", text_size_small, font_used, spacing=text_spacing);
        else if(!four_gear)
            translate([-34,-10.5,thickness-cut_depth]) linear_extrude(height=cut_depth+overshoot) text("I M A", text_size_small, font_used, spacing=text_spacing);
        translate([-30.3,-5.875,thickness-cut_depth]) linear_extrude(height=cut_depth+overshoot) square([.75,2.1]);
    }
    else if(flip_gears) translate([36.5,0])
    {
        translate([-34,-10.5,thickness-cut_depth]) linear_extrude(height=cut_depth+overshoot) text("I M AN", text_size_small, font_used, spacing=text_spacing);
        translate([-30.3,-5.875,thickness-cut_depth]) linear_extrude(height=cut_depth+overshoot) square([.75,2.1]);
    }
    
    translate([-34,-22,thickness-cut_depth]) linear_extrude(height=cut_depth+overshoot) text("ENGINEER", text_size_large, font_used, spacing=text_spacing);
}
module small_gears()
{
    if(!flip_gears)
    {
        if(!four_gear)
            translate([-5,-7,thickness-cut_depth]) rotate([0,0,-10])
                gear (circular_pitch=120,
                gear_thickness = cut_depth+overshoot,
                number_of_teeth=9,
                bore_diameter=2.5);
            translate([3.75,-7,thickness-cut_depth]) rotate([0,0,10])
                gear (circular_pitch=120,
                gear_thickness = cut_depth+overshoot,
                number_of_teeth=9,
                bore_diameter=2.5);
            translate([12.5,-7,thickness-cut_depth]) rotate([0,0,-10])
                gear (circular_pitch=120,
                gear_thickness = cut_depth+overshoot,
                number_of_teeth=9,
                bore_diameter=2.5);
            translate([21.25,-7,thickness-cut_depth]) rotate([0,0,10])
                gear (circular_pitch=120,
                gear_thickness = cut_depth+overshoot,
                number_of_teeth=9,
                bore_diameter=2.5);
            translate([30,-7,thickness-cut_depth]) rotate([0,0,-10])
                gear (circular_pitch=120,
                gear_thickness = cut_depth+overshoot,
                number_of_teeth=9,
                bore_diameter=2.5);
    }
    else if(flip_gears) translate([-33.5,0])
    {
        translate([3.75,-7,thickness-cut_depth]) rotate([0,0,10])
            gear (circular_pitch=120,
            gear_thickness = cut_depth+overshoot,
            number_of_teeth=9,
            bore_diameter=2.5);
        translate([12.5,-7,thickness-cut_depth]) rotate([0,0,-10])
            gear (circular_pitch=120,
            gear_thickness = cut_depth+overshoot,
            number_of_teeth=9,
            bore_diameter=2.5);
        translate([21.25,-7,thickness-cut_depth]) rotate([0,0,10])
            gear (circular_pitch=120,
            gear_thickness = cut_depth+overshoot,
            number_of_teeth=9,
            bore_diameter=2.5);
        translate([30,-7,thickness-cut_depth]) rotate([0,0,-10])
            gear (circular_pitch=120,
            gear_thickness = cut_depth+overshoot,
            number_of_teeth=9,
            bore_diameter=2.5);
    }
}
module concentric_gears()
{
    intersection(){
        union(){
            // Big
            translate([14,2.5,thickness-cut_depth]) rotate([0,0,5])
                gear (circular_pitch=400,
                gear_thickness = cut_depth+overshoot,
                number_of_teeth=16,
                bore_diameter=28);
            // Little
            translate([14,2.5,thickness-cut_depth]) rotate([0,0,7])
                gear (circular_pitch=250,
                gear_thickness = cut_depth+overshoot,
                number_of_teeth=16,
                bore_diameter=15);

        }
        
        union(){ // Where I want the gears to show up
            translate([-7,8,thickness-(cut_depth+overshoot)]) cube([43,17,(cut_depth+overshoot)*2]);
            translate([19,-1.25,thickness-(cut_depth+overshoot)]) cube([17,13.75,(cut_depth+overshoot)*2]);
            //translate([19,6,thickness-(cut_depth+overshoot)]) rotate([0,0,45]) cube([6,9,(cut_depth+overshoot)*2]); // might be needed if the gears had been placed differently
        }
    }
}
module top_gear()
{
    translate([-12.5,15,thickness-cut_depth]) rotate([0,0,90])
        gear (circular_pitch=180,
        gear_thickness = cut_depth+overshoot,
        number_of_teeth=11,
        bore_diameter=5);
    if(!hole)
        translate([-27.5,15,thickness-cut_depth]) rotate([0,0,-90])
        gear (circular_pitch=180,
        gear_thickness = cut_depth+overshoot,
        number_of_teeth=11,
        bore_diameter=5);
}
module keychain_hole()
{
    mid_rad = (thickness+hole_diam)/2; // To center of revolved circle
    out_rad = hole_diam/2+thickness; // To outside of taurus
    translate([-(width/2-mid_rad), (height/2-mid_rad)]) difference()
    {
        union()
        {
            if(tube_round && rounding==2)
                translate([-(hole_diam/2+thickness+overshoot), 0, -overshoot]) cube([out_rad+overshoot, out_rad+overshoot, thickness+overshoot*2]);
            translate([0, 0, -overshoot]) cylinder(thickness+overshoot*2, mid_rad, mid_rad);
        }
        translate([0, 0, thickness/2]) rotate_extrude() translate([mid_rad, 0]) circle(thickness/2);
    }
}

// Code for the gears was taken from http://www.thingiverse.com/thing:3575

// Everything following this line, save for a few slight modifications by me (specifically updating the code to remove depreciated functions and modifications of a few of the default inputs to the gear module), was created by GregFrost. Many thanks to him for this, I couldn't have made this without his code.

// Parametric Involute Bevel and Spur Gears by GregFrost
// It is licensed under the Creative Commons - GNU GPL license.
// © 2010 by GregFrost
// http://www.thingiverse.com/thing:3575

pi=3.1415926535897932384626433832795;


module gear (
	number_of_teeth=15,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0,
	gear_thickness=5,
	rim_width=5,
	hub_diameter=15,
	bore_diameter=0,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=100)
{
    rim_thickness=gear_thickness;
	hub_thickness=gear_thickness;
	//if (circular_pitch==false && diametral_pitch==false) 
		//echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	//echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_curcumference=pi*circle_orbit_diameter;

	// Limit the circle size to 90% of the gear face.
	circle_diameter=
		min (
			0.70*circle_orbit_curcumference/circles,
			(rim_radius-hub_diameter/2)*0.9);

	difference ()
	{
		union ()
		{
			difference ()
			{
				linear_extrude (height=rim_thickness, convexity=10, twist=twist)
				gear_shape (
					number_of_teeth,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);

				if (gear_thickness < rim_thickness)
					translate ([0,0,gear_thickness])
					cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);
			}
			if (gear_thickness > rim_thickness)
				cylinder (r=rim_radius,h=gear_thickness);
			if (hub_thickness > gear_thickness)
				translate ([0,0,gear_thickness])
				cylinder (r=hub_diameter/2,h=hub_thickness-gear_thickness);
		}
		translate ([0,0,-1])
		cylinder (
			r=bore_diameter/2,
			h=2+max(rim_thickness,hub_thickness,gear_thickness));
		if (circles>0)
		{
			for(i=[0:circles-1])	
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				cylinder(r=circle_diameter/2,h=max(gear_thickness,rim_thickness)+3);
		}
	}
}

module gear_shape (
	number_of_teeth,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);

		for (i = [1:number_of_teeth])
		{
			rotate ([0,0,i*360/number_of_teeth])
			{
				involute_gear_tooth (
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);
			}
		}
	}
}

module involute_gear_tooth (
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	union ()
	{
		for (i=[1:res]){
		
			point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res);
			point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res);
		
			
				side1_point1=rotate_point (centre_angle, point1);
				side1_point2=rotate_point (centre_angle, point2);
				side2_point1=mirror_point (rotate_point (centre_angle, point1));
				side2_point2=mirror_point (rotate_point (centre_angle, point2));
			{
				polygon (
					points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1],
					paths=[[0,1,2,3,4,0]]);
			}
		}
	}
}

function mirror_point (coord) = 
[
	coord[0], 
	-coord[1]
];

function rotate_point (rotate, coord) =
[
	cos (rotate) * coord[0] + sin (rotate) * coord[1],
	cos (rotate) * coord[1] - sin (rotate) * coord[0]
];

function involute (base_radius, involute_angle) = 
[
	base_radius*(cos (involute_angle) + involute_angle*pi/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle)),
];

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;