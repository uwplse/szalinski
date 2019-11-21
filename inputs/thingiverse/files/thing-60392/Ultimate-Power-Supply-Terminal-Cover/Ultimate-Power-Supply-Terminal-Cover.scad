/*************************************************************************************************
Power Supply Terminal Cover for the power supply commonly used with the Bukobot and other 3d printers
Author: Mike Thompson (thingiverse: mike_linus)
Date Last Modified: 11/03/2013 4:19pm
Description: simply change the cutout parameters to suit. Note: do not change length, height, depth and thickness parameters for the base unless you want to change the core dimensions.
**************************************************************************************************/

//***************************************************************
//don't change these base parameters unless you want to change the core dimensions.
//***************************************************************
hole_resolution=50;
base_length=108;
base_height=41;
base_depth=18;
base_thickness=2;
$fn=hole_resolution;

//***************************************************************
//change these cutout parameters to suit you own switch size etc.
//***************************************************************
switch_cutout_length=27;
switch_cutout_width=12;

led_cutout_radius=4;
grommet_cutout_radius=6;

power_plug_cutout_length=28;
power_plug_cutout_width=20;

screw_hole_cutout_radius=1;

module base(){
cube([base_length,base_height,base_thickness]);
cube([base_thickness,base_height,base_depth]);
cube([base_length,base_thickness,base_depth]);
translate([base_length,0,0])cube([base_thickness,base_height,base_depth]);
translate([-1,13,13])cube([1.5,23,3]);//slot retainer
translate([base_length+base_thickness,13,13])cube([1.5,23,3]);//slot retainer
}

difference(){
base();
translate([72,0,3])cube([switch_cutout_length,base_thickness,switch_cutout_width]);  //switch cutout
translate([8,3,9])rotate([90,0,0])cylinder(r=led_cutout_radius,h=5);  //led cutout
translate([60,20,0])cylinder(r=grommet_cutout_radius,h=5);  //12v lead cutout
translate([14,3,0])cube([power_plug_cutout_length,power_plug_cutout_width,base_thickness]);  //240v plug cutout
translate([7.5,12.75,0])cylinder(r=screw_hole_cutout_radius,h=5);  //240v plug screw hole
translate([48,12.75,0])cylinder(r=screw_hole_cutout_radius,h=5);  //240v plug screw hole
translate([base_length,15,14.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
translate([base_length,34,14.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
translate([-1,15,14.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
translate([-1,34,14.5])rotate([0,90,0])cylinder(r=screw_hole_cutout_radius,h=5);  //retainer screw hole
}