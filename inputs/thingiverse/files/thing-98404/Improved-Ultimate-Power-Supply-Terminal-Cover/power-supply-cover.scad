/*************************************************************************************************
Power Supply Terminal Cover for the power supply commonly used with the Bukobot and other 3d printers
Author: Mike Thompson (thingiverse: mike_linus)
Modified by: Will Winder (thingiverse: Winder)
Date Last Modified: June 1, 2013
Description: simply change the cutout parameters and depth to suit. 
Note: do not change length, height and thickness parameters for the base unless you want to change the core dimensions.
**************************************************************************************************/

//***************************************************************
//don't change these base parameters unless you want to change the core dimensions.
//***************************************************************
/* [Enclosue Size] */
// Long edge of enclosure.

base_length=110;
// Height of enclosure.
base_height=41;

// Deptch of enclosure. Increase this to create more room for your electronics.
base_depth=26;

// Surface thickness of part. 2mm seems to be pretty good.
base_thickness=2;

// Size of hole for cover retaining screws.
mounting_screw_hole_cutout_radius=1;

// Size of hole for power plug screws.
power_screw_hole_cutout_radius=1;

//***************************************************************
//change these cutout parameters to suit you own switch size etc.
//***************************************************************
/* [Cutouts] */
// Square switch cutout - long edge. Set to zero if using a round cutout.
switch_cutout_length=27;
// Square switch cutout - short edge. Set to zero if using a round cutout.
switch_cutout_width=12;

// Round switch cutout radius. Set to zero to use a square cutout. Base depth must be increased depending on the size of your switch.
switch_cutout_radius=0;

// Radius of cutout for LED.
led_cutout_radius=4;
// Radius of cutout for 12v wires.
grommet_cutout_radius=6;

// Square power plug cutout - long edge.
power_plug_cutout_length=28;
// Square power plug cutout - short edge.
power_plug_cutout_width=20;

/* [Hidden] */
hole_resolution=50;
$fn=hole_resolution;

module base(){
union() {
	// 5 sides of the box.
	cube([base_length,base_height,base_thickness]);
	cube([base_thickness,base_height,base_depth]);
	cube([base_length,base_thickness,base_depth]);
	translate([base_length-base_thickness,0,0])cube([base_thickness,base_height,base_depth]);
	// Bottom wall has an 18mm gap at the rear for the terminal area.
	translate([0,base_height-base_thickness,0])cube([base_length,base_thickness,base_depth-18]);

	// (square) Original slot retainers
	//translate([-1,13,base_depth-5])cube([1.5,23,3]);
	//translate([base_length+base_thickness,13,base_depth-5])cube([1.5,23,3]);

	// (cylindrical) New slot retainers.
	translate([0.5,23+13,base_depth-3.6])rotate([90,0,0])
		cylinder(r=1.5, h=23);
	translate([base_length-0.5,23+13,base_depth-3.6])rotate([90,0,0])
		cylinder(r=1.5, h=23);

}
}

safety_margin = base_thickness/2;
difference(){
	base();
	//(square) switch cutout. 9mm away from one side.
	translate([base_length-9-switch_cutout_length,-safety_margin,3])
		cube([switch_cutout_length,base_thickness*2,switch_cutout_width]);

	//(round) switch cutout. Centered 18mm from one side.
	translate([base_length-18, base_thickness+safety_margin, 6+switch_cutout_radius])rotate([90,0,0])
		cylinder(r=switch_cutout_radius, h=base_thickness*2);

	//240v plug cutout. Centered 28mm from one side.
	translate([28-(power_plug_cutout_length/2),3,-safety_margin])
		cube([power_plug_cutout_length,power_plug_cutout_width,base_thickness*2]);

	//led cutout. Centered 8mm from one side.
	translate([8,base_thickness+safety_margin,9])rotate([90,0,0])
		cylinder(r=led_cutout_radius,h=base_thickness*2);

	//12v lead cutout. Shifted 3/5 of the way to one side.
	translate([base_length/5*3,base_height/2,-safety_margin])
		cylinder(r=grommet_cutout_radius,h=base_thickness*2);

	//2x 240v plug screw holes. Hard coded, deal with it!
	translate([7.5,12.75,-safety_margin])
		cylinder(r=power_screw_hole_cutout_radius,h=base_thickness*2);
	translate([48,12.75,-safety_margin])
		cylinder(r=power_screw_hole_cutout_radius,h=base_thickness*2);

	//4x retainer screw holes. 3.5mm away from the top.
	translate([base_length-safety_margin,15,base_depth-3.5])rotate([0,90,0])
		cylinder(r=mounting_screw_hole_cutout_radius,h=base_thickness*3);
	translate([base_length-safety_margin,34,base_depth-3.5])rotate([0,90,0])
		cylinder(r=mounting_screw_hole_cutout_radius,h=base_thickness*3);
	translate([-1-safety_margin,15,base_depth-3.5])rotate([0,90,0])
		cylinder(r=mounting_screw_hole_cutout_radius,h=base_thickness*3);
	translate([-1-safety_margin,34,base_depth-3.5])rotate([0,90,0])
		cylinder(r=mounting_screw_hole_cutout_radius,h=base_thickness*3);
}