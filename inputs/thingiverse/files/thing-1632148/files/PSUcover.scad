/*************************************************************************************************
Power Supply Terminal Cover for the power supply commonly used with the Bukobot and other 3d printers
Author: Mike Thompson (thingiverse: mike_linus)
Date Last Modified: 11/03/2013 4:19pm
Description: simply change the cutout parameters to suit. Note: do not change length, height, depth and thickness parameters for the base unless you want to change the core dimensions.
**************************************************************************************************/


//***************************************************************
//change these cutout parameters to suit you own switch size etc.
//***************************************************************

// Length of a cutout for a switch on top
switch_cutout_length=0;
// Width of the same cutout
switch_cutout_width=0;
// Allowed thickness for the snap in switch to mount propperly
switch_cutout_thickness=1.4;

// Radius of hole for power LED 
led_cutout_radius=0;
// Radius of gromet for cables on the front.
grommet_cutout_radius=6;

// Length of snapin power plug cutout
power_plug_cutout_length=48;
// Widht of the same cutout
power_plug_cutout_width=27.5;
// Allowed thickness for the snap in panel to mount propperly
power_plug_cutout_thickness=1.4;
// Radius of screw holes in the side
screw_hole_cutout_radius=1;

// The inside distance between the two sides of the psu
base_length=110;
// The height of the gap in the PSU. Meassure from the PCB up
base_height=43;
// The depth you want your cover to be. More depth = more space for cables
base_depth=50;
// The thickness of all walls, except for around the cutouts.
base_thickness=2;
// Meassure from the end of the PSU to where the top shroud starts.
base_overlap=19;


/* [hidden] */
//***************************************************************
//don't change these base parameters unless you want to change the core dimensions.
//***************************************************************
hole_resolution=50;
$fn=hole_resolution;
cutout_flange_width=2;



module base(){
cube([base_length,base_height,base_thickness]);
cube([base_thickness,base_height,base_depth]);
cube([base_length,base_thickness,base_depth]);
translate([0,base_height-base_thickness,0])cube([
  base_length,
  base_thickness,
  base_depth-base_overlap
  ]);//Bottom plate for extended covers
translate([base_length-base_thickness,0,0])cube([
  base_thickness,
  base_height,
  base_depth]);
translate([-1,13,base_depth-6])cube([1.5,23,3]);//slot retainer
translate([base_length,13,base_depth-6])cube([1.5,23,3]);//slot retainer
}

difference(){
base();
#translate([base_length-switch_cutout_length-5,0,5])cube([
  switch_cutout_length,
  base_thickness,
  switch_cutout_width]);  //switch cutout
 
#translate([base_length-switch_cutout_length-5-cutout_flange_width,switch_cutout_thickness,5-cutout_flange_width]) cube([
  switch_cutout_length+cutout_flange_width*2,
  base_thickness,
  switch_cutout_width+cutout_flange_width*2]);

translate([8,3,9])rotate([90,0,0])cylinder(r=led_cutout_radius,h=5);  //led cutout
#translate([10+grommet_cutout_radius,10+grommet_cutout_radius,0])cylinder(r=grommet_cutout_radius,h=5);  // Power out cutout
  
#translate([base_length-power_plug_cutout_length-5,5,0])cube([
  power_plug_cutout_length,
  power_plug_cutout_width,
  base_thickness]);//240v plug cutout

#translate([base_length-power_plug_cutout_length-5-cutout_flange_width,5-cutout_flange_width,power_plug_cutout_thickness]) cube([
  power_plug_cutout_length+cutout_flange_width*2,
  power_plug_cutout_width+cutout_flange_width*2,
  base_thickness-power_plug_cutout_thickness]);  

//translate([7.5,12.75,0])cylinder(r=screw_hole_cutout_radius,h=5);  //240v plug screw hole
//translate([48,12.75,0])cylinder(r=screw_hole_cutout_radius,h=5);  //240v plug screw hole
translate([base_length,15,base_depth-6+1.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
translate([base_length,34,base_depth-6+1.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
translate([-1,15,base_depth-6+1.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
translate([-1,34,base_depth-6+1.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
}