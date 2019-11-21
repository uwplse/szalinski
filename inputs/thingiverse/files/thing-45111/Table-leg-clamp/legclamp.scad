//
//	Filename:	legclamp.scad
//	Author:		Robert H. Morrison
//	Date:		24 Jan 2013
//
//	A clamp to hold two 3 wheeled tables together to make them stable.
//

use <utils/build_plate.scad>

//Diameter of the Leg
leg_d = 34;
//Length of the outside of two legs
leg_l = 84;
//Gap to use for fitting
gap = 0.5;
//Height of the clamp
clamp_h = 6;//[2:10] 
//Width of the clamp
clamp_w = 6;//[2:10]

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
 
x = leg_l - leg_d; 

module ring(r,w) {
	rotate([0,0,-45])
		intersection() {
			difference() {
				cylinder(clamp_h, r+w, r+w, true, $fn=100);
				cylinder(clamp_h+1, r+gap, r+gap, true, $fn=100);
			}
			translate([0,0,-(clamp_h+1)/2]) {
				cube([r+w+1,r+w+1,clamp_h+1]);
				rotate([0,0,45])
					cube([r+w+1,r+w+1,clamp_h+1]);
			}
		}
}

module legclamp() {
	translate([0,0,clamp_h/2]) {
		translate([x/2,0,0])
			ring(leg_d/2,clamp_w);
		translate([-x/2,0,0])
			rotate([0,180,0])
				ring(leg_d/2,clamp_w);
		translate([0,(leg_d+clamp_w+gap)/2,0])
			cube([x+.002,clamp_w-gap,clamp_h], true);
	}
}

legclamp();
