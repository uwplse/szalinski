//
// Nut Holder for 3mm nuts
//

//General Settings:

$fn = 50;

//Global variables:

nh_NutDiameter = 6;
nh_BoltDiameter = 3;
nh_NutHeight = 2;

nh_GripDiameter = nh_NutDiameter*1.5;
nh_GripHeight = nh_NutHeight+2;
nh_GripRilsDiameter = 2;


//Modules:
// module nut(){
// 	difference(){
// 		cylinder(d=nh_NutDiameter, h=nh_NutHeight, $fn = 6, center = true);
// 		cylinder(d=nh_BoltDiameter+0.5, h=nh_NutHeight*1.1, center=true);
// 	}
// }

module Grip(){

	cylinder(d=nh_GripDiameter, h=nh_GripHeight, center=true);
	for(i=[0:nh_GripDiameter]){
		rotate([0, 0, i*360/nh_GripDiameter]) translate([nh_GripDiameter/2, 0, 0]) cylinder(d=nh_GripRilsDiameter, h=nh_GripHeight, center=true, $fn = 6);
	}
}

module GriCarve(){
	cylinder(d=nh_NutDiameter, h=nh_NutHeight, $fn = 6, center = true);
	translate([0,nh_GripDiameter/2,0]) cube([nh_NutDiameter, nh_GripDiameter, nh_NutHeight], center=true);
}

difference() {
	Grip();
	GriCarve();
	cylinder(d=nh_BoltDiameter+0.5, h=nh_GripHeight*1.1, center=true);
}