/*************************************************************************************************/
/* SportsWatchMount - Copyright 2014 by ohecker                                                  */
/* Mounts a Garmin 910xt sports watch to a bicycle stem                                          */
/* This file is licensed under CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0/deed) */
/*************************************************************************************************/
use <utils/build_plate.scad>

/* [Basic] */

// Diameter of the stem (mm)
stem_diameter = 36;

// Height of the opening for the cable tie (mm)
binder_cutout_height = 2.5;

// Width of the opening for the cable tie (mm)
binder_cutout_width = 7;

// To which side of the stem should it be mounted?
orientation = 1.0; // [1.0:mounts to the left side of the stem, 2.0:mounts to the right side of the stem]

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


/* [Hidden] */

width = 50;
epsilon = 0.01;
big = 100;
stem_pos = 38 - (18-stem_diameter/2);

module shape_z() {
	intersection() {
		hull() {
			cylinder(r=57/2,h=big,center=true,$fn=50);
			translate([0,20,0])cylinder(r=27/2,h=big,center=true,$fn=50);
		}
		cube([width,big,big],center=true);
	}
}

module top() {
	difference() {
		translate([0,0,5])cube([width,47,10], center=true);
		watch_cut();
	}
}

module watch_cut() {
	union() {
		translate([0,0,5+4])cube([40,50+epsilon,10], center=true);
		sidecut();
		mirror([1,0,0])sidecut();
		frontbackcut();
		mirror([0,1,0])frontbackcut();
	}
}

module sidecut() {
	translate([20,0,4])rotate([0,-35,0])translate([40,0,40])cube([80,80,80], center=true);
}

module frontbackcut() {
	translate([0,35/2-1.5,4])rotate([-40,0,0]) difference() {
		translate([0,0,40])cube([80,80,80], center=true);
		translate([0,9,-12.1])rotate([0,90,0])cylinder(r=15,h=80,center=true,$fn=100);
	}
}

module main() {
	intersection() {
		union() {
			top();
			bottom();
			bracket();
		}
		shape_z();
	}
}

module bottom() {
	translate([0,0,epsilon])
	hull() {
		difference() {
			union() {
				translate([0,-8.6,0])rotate([0,90,0])cylinder(r=15,h=80,center=true,$fn=100);
				translate([0,4.7,-7])rotate([0,90,0])cylinder(r=20,h=80,center=true,$fn=100);
			}
			translate([0,0,big/2])cube(big,center=true);
		}
		translate([0,18.5,-7.3])rotate([0,90,0])cylinder(r=10,h=80,center=true,$fn=100);
	}
}

module bracket() {
	translate([0,0,epsilon])
	difference() {
		intersection() {
			translate([0,4.7,-7])rotate([0,90,0])cylinder(r=20+12,h=80,center=true,$fn=100);
			translate([0,4.7,-30])cube([100,10,20], center=true);
		}
		translate([0,4.7,-7])rotate([0,90,0])cylinder(r=20+8.5,h=33,center=true,$fn=100);
	}
}

module complete() {
	difference() {
		main();
		stemcut();
		bindercut();
	}
}

module bindercut() {
	difference() {
		translate([-stem_pos,5,-12])rotate([90,0,0])cylinder(r=(stem_diameter+3+binder_cutout_height*2)/2,h=binder_cutout_width,center=true,$fn=100);
		translate([-stem_pos,5,-12])rotate([90,0,0])cylinder(r=(stem_diameter+3)/2,h=binder_cutout_width+1,center=true,$fn=100);
	}
}

module stemcut() {
	translate([-stem_pos,0,-12])rotate([90,0,0])cylinder(r=stem_diameter/2,h=100,center=true,$fn=100);
}


if (orientation == 1)
{
	translate([0,0,width/2])rotate([0,90,0])complete();
} else {
	translate([0,0,width/2])rotate([0,-90,0])mirror([1,0,0])complete();
}
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 


