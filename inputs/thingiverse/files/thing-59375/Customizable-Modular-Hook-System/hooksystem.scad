//
// Modular hook/storage system
// gearworks <myown.email@gmx.com>
// copyright 2013
//

use <utils/build_plate.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2, 1: Replicator, 2:Thingomatic, 3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

component_type = "Middle"; // [Start, Middle, End, Solo]

// Height in millimeters: 
height = 50; // [20:80]

// Number of units
units = 3; // [1,2,3,4,5,6]

unit_1 = "Blank"; // [Blank, Gravity Clamp, Hook, Twin Hook, Ring]
unit_2 = "Blank"; // [Blank, Gravity Clamp, Hook, Twin Hook, Ring] 
unit_3 = "Blank"; // [Blank, Gravity Clamp, Hook, Twin Hook, Ring]
unit_4 = "Blank"; // [Blank, Gravity Clamp, Hook, Twin Hook, Ring]
unit_5 = "Blank"; // [Blank, Gravity Clamp, Hook, Twin Hook, Ring]
unit_6 = "Blank"; // [Blank, Gravity Clamp, Hook, Twin Hook, Ring]

// preview [view:north, tilt:top diagonal]

// ignore variable values
scale_factor = height/50;
thk = 10*scale_factor;
length = 80*scale_factor;
x_shift = length*units/2;
y_shift = height/2;

smooth = 50/scale_factor;

union () {
	makeblank ();
	
	if (units > 5) {
		if (unit_6 == "Blank") {
			// do nothing
		} else if (unit_6 == "Gravity Clamp") {
			gravity_clamp (5.5*length-x_shift);
		} else if (unit_6 == "Hook") {
			single_hook (5.5*length-x_shift);
		} else if (unit_6 == "Twin Hook") {
			twin_hook (5.5*length-x_shift);
		} else {
			make_loop (5.5*length-x_shift);
		}
	}
	if (units > 4) {
		if (unit_5 == "Blank") {
			// do nothing
		} else if (unit_5 == "Gravity Clamp") {
			gravity_clamp (4.5*length-x_shift);
		} else if (unit_5 == "Hook") {
			single_hook (4.5*length-x_shift);
		} else if (unit_5 == "Twin Hook") {
			twin_hook (4.5*length-x_shift);
		} else {
			make_loop (4.5*length-x_shift);
		}
	}
	if (units > 3) {
		if (unit_4 == "Blank") {
			// do nothing
		} else if (unit_4 == "Gravity Clamp") {
			gravity_clamp (3.5*length-x_shift);
		} else if (unit_4 == "Hook") {
			single_hook (3.5*length-x_shift);
		} else if (unit_4 == "Twin Hook") {
			twin_hook (3.5*length-x_shift);
		} else {
			make_loop (3.5*length-x_shift);
		}
	}
	if (units > 2) {
		if (unit_3 == "Blank") {
			// do nothing
		} else if (unit_3 == "Gravity Clamp") {
			gravity_clamp (2.5*length-x_shift);
		} else if (unit_3 == "Hook") {
			single_hook (2.5*length-x_shift);
		} else if (unit_3 == "Twin Hook") {
			twin_hook (2.5*length-x_shift);
		} else {
			make_loop (2.5*length-x_shift);
		}
	}
	if (units > 1) {
		if (unit_2 == "Blank") {
			// do nothing
		} else if (unit_2 == "Gravity Clamp") {
			gravity_clamp (1.5*length-x_shift);
		} else if (unit_2 == "Hook") {
			single_hook (1.5*length-x_shift);
		} else if (unit_2 == "Twin Hook") {
			twin_hook (1.5*length-x_shift);
		} else {
			make_loop (1.5*length-x_shift);
		}
	}
	if (unit_1 == "Blank") {
		// do nothing
	} else if (unit_1 == "Gravity Clamp") {
		gravity_clamp (.5*length-x_shift);
	} else if (unit_1 == "Hook") {
		single_hook (.5*length-x_shift);
	} else if (unit_1 == "Twin Hook") {
		twin_hook (.5*length-x_shift);
	} else {
		make_loop (.5*length-x_shift);
	}
}


//
// make the base plate
//
module makeblank() {
	difference() {
		translate ([-x_shift, -y_shift, 0]) cube ([length*units, height, thk]);

		//
		// screw holes
		//
		screw_hole (thk-x_shift, 3*height/4-y_shift);
		if ((component_type == "Solo") || (component_type == "End")) {
			screw_hole (length*units-thk-x_shift, height/4-y_shift);
			screw_hole (length*units-thk-x_shift, 3*height/4-y_shift);
		}
		if ((component_type == "Solo") || (component_type == "Start")) {
			screw_hole (thk-x_shift, height/4-y_shift);
		}
		if (component_type == "Middle") {
			screw_hole (length*units-2*thk-x_shift, 3*height/4-y_shift);
		}
		//
		// plus one between each unit
		//
		if (units > 1) {
			for (i = [1 : units-1] ) {
				screw_hole (i*length-x_shift, height/2-y_shift);
			}
		}

		//
		// alignment pin & pin hole
		//
		if ((component_type == "Middle") || (component_type == "End")) {
			//
			// pin
			//
			difference() {
				translate ([-x_shift, -y_shift, 0]) cube ([thk, height/2, thk]);
				translate ([thk/2-x_shift, height-y_shift, .28*thk/2]) rotate ([90, 0, 0]) cylinder (h=3*height/4-2*scale_factor, r=.28*thk, center=false, $fn=smooth);
				translate ([thk/2-x_shift, height/4+3*scale_factor-y_shift, .28*thk/2]) rotate ([90, 0, 0]) cylinder (h=3*scale_factor, r1=.28*thk+scale_factor/2, r2=.28*thk-scale_factor, center=false, $fn=smooth);
				translate ([thk/2-x_shift, height/4+3*scale_factor-y_shift, .28*thk/2]) rotate ([90, 0, 0]) rotate_extrude (convexity=10, $fn=smooth) translate ([2.5*scale_factor, 0, 0]) circle (r=.87*scale_factor, $fn=smooth);
			}
			translate ([thk/2-scale_factor/2-x_shift, -y_shift, 0]) cube ([scale_factor, height/2-2*scale_factor, thk]);
		}
		if ((component_type == "Middle") || (component_type == "Start")) {
			//
			// pin hole
			//
			translate ([length*units-thk-x_shift, height/2-y_shift, 0]) cube ([thk, height/2, thk]);
			translate ([length*units-thk/2-x_shift, height/4-scale_factor-y_shift, .28*thk/2]) rotate ([-90, 0, 0]) cylinder (h=2*height/4+2*scale_factor, r=.30*thk, center=false, $fn=smooth);
			translate ([length*units-thk/2-x_shift, height/4+3*scale_factor-y_shift, .28*thk/2]) rotate ([-90, 0, 0]) rotate_extrude (convexity=10, $fn=smooth) translate ([2.5*scale_factor, , 0]) circle (r=scale_factor, $fn=smooth);
			translate ([length*units-thk/2-x_shift, height/2-3*scale_factor-y_shift, .28*thk/2]) rotate ([-90, 0, 0]) cylinder (h=3*scale_factor, r1=.28*thk/2, r2=.28*thk+2*scale_factor, center=false, $fn=smooth);
		}
	
		//
		// round all the edges
		//
		if (component_type == "Middle") {
			difference() {
				translate ([-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
				translate ([-thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units+thk, r=thk/2, center=false, $fn=smooth);
			}
			difference() {
				translate ([-thk/2-x_shift, height-thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
				translate ([-thk/2-x_shift, height-thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units+thk, r=thk/2, center=false, $fn=smooth);
			}
		} else if (component_type == "Start") {
			difference() {
				union() {
					translate ([-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
					translate ([-thk/2-x_shift, -thk/2-y_shift, 0]) cube ([thk, thk, thk]);
					translate ([-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([thk, height+thk/2, thk]);
					translate ([-thk/2-x_shift, height-thk/2-y_shift, 0]) cube ([thk, thk, thk]);
					translate ([-thk/2-x_shift, height-thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
				}
				translate ([thk/2-x_shift, thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([thk/2-x_shift, height-thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units+thk/2, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([-90, 0, 0]) cylinder (h=height-thk, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, height-thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units+thk/2, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, height-thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
			}
		} else if (component_type == "End") {
			difference() {
				union() {
					translate ([-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
					translate ([length*units-thk/2-x_shift, -thk/2-y_shift, 0]) cube ([thk, thk, thk]);
					translate ([length*units-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([thk, height+thk/2, thk]);
					translate ([length*units-thk/2-x_shift, height-thk/2-y_shift, 0]) cube ([thk, thk, thk]);
					translate ([-thk/2-x_shift, height-thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
				}
			
				translate ([length*units-thk/2-x_shift, thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([length*units-thk/2-x_shift, height-thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([-thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units, r=thk/2, center=false, $fn=smooth);
				translate ([length*units-thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([-90, 0, 0]) cylinder (h=height-thk, r=thk/2, center=false, $fn=smooth);
				translate ([-thk/2-x_shift, height-thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units, r=thk/2, center=false, $fn=smooth);
				translate ([length*units-thk/2-x_shift, thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
				translate ([length*units-thk/2-x_shift, height-thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
			}
		} else {
			difference() {
				union() {
					translate ([-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
					translate ([-thk/2-x_shift, height-thk/2-y_shift, thk/2]) cube ([length*units+thk, thk, thk]);
					translate ([-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([thk, height+thk/2, thk]);
					translate ([length*units-thk/2-x_shift, -thk/2-y_shift, thk/2]) cube ([thk, height+thk/2, thk]);
					translate ([-thk/2-x_shift, -thk/2-y_shift, 0]) cube ([thk, thk, thk]);
					translate ([-thk/2-x_shift, height-thk/2-y_shift, 0]) cube ([thk, thk, thk]);
					translate ([length*units-thk/2-x_shift, -thk/2-y_shift, 0]) cube ([thk, thk, thk]);
					translate ([length*units-thk/2-x_shift, height-thk/2-y_shift, 0]) cube ([thk, thk, thk]);
				}
				translate ([thk/2-x_shift, thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([thk/2-x_shift, height-thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([length*units-thk/2-x_shift, thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([length*units-thk/2-x_shift, height-thk/2-y_shift, thk/2]) sphere (r=thk/2, $fn=smooth);
				translate ([thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units-thk, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, height-thk/2-y_shift, thk/2]) rotate ([0, 90, 0]) cylinder (h=length*units-thk, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([-90, 0, 0]) cylinder (h=height-thk, r=thk/2, center=false, $fn=smooth);
				translate ([length*units-thk/2-x_shift, thk/2-y_shift, thk/2]) rotate ([-90, 0, 0]) cylinder (h=height-thk, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
				translate ([thk/2-x_shift, height-thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
				translate ([length*units-thk/2-x_shift, thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
				translate ([length*units-thk/2-x_shift, height-thk/2-y_shift, 0]) cylinder (h=thk/2, r=thk/2, center=false, $fn=smooth);
			}
		}
	}
}


//
// screw holes
//
module screw_hole (x_loc, y_loc) {
	if (height < 25) { 
		//
		// M2 screw
		//
		translate ([x_loc, y_loc, 0]) cylinder (h=thk, r=2/2, center=false);
		translate ([x_loc, y_loc, thk-1.2]) cylinder (h=1.2+.1, r1=2/2, r2=3.8/2+.05, center=false);
	} else if (height < 30) {
		//
		// M2.5 screw
		//
		translate ([x_loc, y_loc, 0]) cylinder (h=thk, r=2.5/2, center=false);
		translate ([x_loc, y_loc, thk-1.5]) cylinder (h=1.5+.1, r1=2.5/2, r2=4.7/2+.05, center=false);
	} else if (height < 35) {
		//
		// M3 screw
		//
		translate ([x_loc, y_loc, 0]) cylinder (h=thk, r=3/2, center=false);
		translate ([x_loc, y_loc, thk-1.65]) cylinder (h=1.65+.1, r1=3/2, r2=5.6/2+.05, center=false);
	} else if (height < 40) {
		//
		// M3.5 screw
		//
		translate ([x_loc, y_loc, 0]) cylinder (h=thk, r=3.5/2, center=false);
		translate ([x_loc, y_loc, thk-2.3]) cylinder (h=2.3+.1, r1=3.5/2, r2=6.5/2+.05, center=false);
	} else if (height < 50) {
		//
		// M4 screw
		//
		translate ([x_loc, y_loc, 0]) cylinder (h=thk, r=4/2, center=false);
		translate ([x_loc, y_loc, thk-2.7]) cylinder (h=2.7+.1, r1=4/2, r2=7.5/2+.05, center=false);
	} else if (height < 60) {
		//
		// M5 screw
		//
		translate ([x_loc, y_loc, 0]) cylinder (h=thk, r=5/2, center=false);
		translate ([x_loc, y_loc, thk-2.5]) cylinder (h=2.5+.1, r1=5/2, r2=9.2/2+.05, center=false);
	} else {
		//
		// M6 screw
		//
		translate ([x_loc, y_loc, 0]) cylinder (h=thk, r=6/2, center=false);
		translate ([x_loc, y_loc, thk-3]) cylinder (h=3, r1=6/2+.1, r2=11/2+.05, center=false);
	}
}


//
// single hook option
//
module single_hook (x_loc) {
	union () {
		translate ([x_loc, height/2-y_shift, thk]) sphere (r=thk/2, $fn=smooth);
		translate ([x_loc, height/2-y_shift, thk]) rotate ([90, 0, 0]) cylinder (h=height/4, r=thk/2, $fn=smooth);
		difference () {
			translate ([x_loc, height/4-y_shift, 2.5*thk]) rotate ([0, -90, 0]) rotate_extrude (convexity=10, $fn=smooth) translate ([1.5*thk, 0, 0]) circle (r=thk/2, $fn=smooth);
			translate ([x_loc-thk, height/4-y_shift, 0]) cube ([2*thk, 2.5*thk, 5*thk]);
		}
		translate ([x_loc, height/4-y_shift, 4*thk]) sphere (r=thk/2, $fn=smooth);
	}
}


//
// twin hook option
//
module twin_hook (x_loc) {
	//
	// angle between hooks
	//
	theta = 90;

	union () {
		translate ([x_loc, height/2-y_shift, thk]) sphere (r=thk/2, $fn=smooth);
		translate ([x_loc, height/2-y_shift, thk]) rotate ([90, 0, 0]) cylinder (h=height/4, r=thk/2, $fn=smooth);
		//
		// hook on the right
		//
		difference () {
			translate ([x_loc+(1.5*thk*cos(theta/2)), height/4-y_shift, 2.5*thk-(1.5*thk-1.5*thk*sin(theta/2))]) rotate ([0, -theta/2, 0]) rotate_extrude (convexity=10, $fn=smooth) translate ([1.5*thk,0,  0]) circle (r=thk/2, $fn=smooth);
			translate ([x_loc, height/4-y_shift, -thk/2]) rotate ([0, -theta/2, 0]) cube ([5*thk, 2.5*thk, 2*thk]);
		}
		translate ([x_loc+(3*thk*cos(theta/2)), height/4-y_shift, 4*thk-2*(1.5*thk-1.5*thk*sin(theta/2))]) sphere (r=thk/2, $fn=smooth);
		//
		// hook on the left
		//
		difference () {
			translate ([x_loc-(1.5*thk*cos(theta/2)), height/4-y_shift, 2.5*thk-(1.5*thk-1.5*thk*sin(theta/2))]) rotate ([0, theta/2, 0]) rotate_extrude (convexity=10, $fn=smooth) translate ([1.5*thk, 0, 0]) circle (r=thk/2, $fn=smooth);
			translate ([x_loc, height/4-y_shift, -thk/2]) rotate ([0, -theta/2, 0]) cube ([2*thk, 2.5*thk, 5*thk]);
		}
		translate ([x_loc-(3*thk*cos(theta/2)), height/4-y_shift, 4*thk-2*(1.5*thk-1.5*thk*sin(theta/2))]) sphere (r=thk/2, $fn=smooth);
	}
}


//
// loop option
//
module make_loop (x_loc) {
	translate ([x_loc, height/2-y_shift, 2*thk]) rotate ([90, 0, 0]) rotate_extrude (convexity=10, $fn=smooth) translate ([1.5*thk, 0, 0]) circle (r=thk/2, $fn=smooth);
}


//
// gravity clamp option
//
module gravity_clamp (x_loc) {

	xone = x_loc+2.5*thk;
	yone = height/2-thk/2-y_shift;
	xtwo = x_loc+2.5*thk-sqrt(pow(1.63*thk, 2)/2)+.3*thk/2*sin(30)+1.63*thk*cos(30);
	ytwo = height/2-thk/2-y_shift-sqrt(pow(1.63*thk, 2)/2)-.3*thk/2*cos(30)+1.63*thk*sin(30);
	cam_rad = sqrt(pow(xtwo-xone, 2) + pow(ytwo-yone, 2));
	
	union () {
		//
		// boss
		//
		difference () {
			translate ([x_loc-2.5*thk, height/4-y_shift, thk/2]) cube ([thk, height/2, 2.5*thk]);
			difference () {
				union () {
					translate ([x_loc-2.5*thk-thk/4, height/4-y_shift+thk/4, 3*thk-thk/4]) cube ([2*thk/4, height/2-2*thk/4, 2*thk/4]);
					translate ([x_loc-1.5*thk-thk/4, height/4-y_shift+thk/4, 3*thk-thk/4]) cube ([2*thk/4, height/2-2*thk/4, 2*thk/4]);
					translate ([x_loc-2.5*thk-thk/4, height/4-y_shift-thk/4, 3*thk-thk/4]) cube ([thk+2*thk/4, 2*thk/4, 2*thk/4]);
					translate ([x_loc-2.5*thk-thk/4, 3*height/4-y_shift-thk/4, 3*thk-thk/4]) cube ([thk+2*thk/4, 2*thk/4, 2*thk/4]);
					translate ([x_loc-2.5*thk-thk/4, height/4-y_shift-thk/4, thk/2]) cube ([2*thk/4, 2*thk/4, 2.5*thk+thk/4]);
					translate ([x_loc-1.5*thk-thk/4, height/4-y_shift-thk/4, thk/2]) cube ([2*thk/4, 2*thk/4, 2.5*thk+thk/4]);
					translate ([x_loc-2.5*thk-thk/4, 3*height/4-y_shift-thk/4, thk/2]) cube ([2*thk/4, 2*thk/4, 2.5*thk+thk/4]);
					translate ([x_loc-1.5*thk-thk/4, 3*height/4-y_shift-thk/4, thk/2]) cube ([2*thk/4, 2*thk/4, 2.5*thk+thk/4]);
				}
				translate ([x_loc-2.5*thk+thk/4, height/4-y_shift+thk/4, 3*thk-thk/4]) sphere (r=thk/4, $fn=smooth);
				translate ([x_loc-1.5*thk-thk/4, height/4-y_shift+thk/4, 3*thk-thk/4]) sphere (r=thk/4, $fn=smooth);
				translate ([x_loc-2.5*thk+thk/4, 3*height/4-y_shift-thk/4, 3*thk-thk/4]) sphere (r=thk/4, $fn=smooth);
				translate ([x_loc-1.5*thk-thk/4, 3*height/4-y_shift-thk/4, 3*thk-thk/4]) sphere (r=thk/4, $fn=smooth);
				translate ([x_loc-2.5*thk+thk/4, height/4-y_shift+thk/4, 3*thk-thk/4]) rotate ([-90, 0, 0]) cylinder (h=height/2-thk/2, r=thk/4, center=false, $fn=smooth);
				translate ([x_loc-1.5*thk-thk/4, height/4-y_shift+thk/4, 3*thk-thk/4]) rotate ([-90, 0, 0]) cylinder (h=height/2-thk/2, r=thk/4, center=false, $fn=smooth);
				translate ([x_loc-1.5*thk-thk/4, height/4-y_shift+thk/4, 3*thk-thk/4]) rotate ([0, -90, 0]) cylinder (h=thk-thk/2, r=thk/4, center=false, $fn=smooth);
				translate ([x_loc-1.5*thk-thk/4, 3*height/4-y_shift-thk/4, 3*thk-thk/4]) rotate ([0, -90, 0]) cylinder (h=thk-thk/2, r=thk/4, center=false, $fn=smooth);
				translate ([x_loc-2.5*thk+thk/4, height/4-y_shift+thk/4, thk/2]) rotate ([0, 0, 90]) cylinder (h=2.5*thk-thk/4, r=thk/4, center=false, $fn=smooth);
				translate ([x_loc-1.5*thk-thk/4, height/4-y_shift+thk/4, thk/2]) rotate ([0, 0, 90]) cylinder (h=2.5*thk-thk/4, r=thk/4, center=false, $fn=smooth);
				translate ([x_loc-2.5*thk+thk/4, 3*height/4-y_shift-thk/4, thk/2]) rotate ([0, 0, 90]) cylinder (h=2.5*thk-thk/4, r=thk/4, center=false, $fn=smooth);
				translate ([x_loc-1.5*thk-thk/4, 3*height/4-y_shift-thk/4, thk/2]) rotate ([0, 0, 90]) cylinder (h=2.5*thk-thk/4, r=thk/4, center=false, $fn=smooth);
			}
		}
		//
		// cam
		//
		difference () {
			union () {
				translate ([x_loc+2.5*thk-sqrt(pow(1.63*thk, 2)/2), height/2-thk/2-y_shift+sqrt(pow(1.63*thk, 2)/2), thk+scale_factor/2]) cylinder (h=2*thk-scale_factor/2, r=.3*thk/2, $fn=smooth);
				for (n = [30:10:60]) {
					translate ([x_loc+2.5*thk-sqrt(pow(1.63*thk, 2)/2)-.3*thk/2*sin(n), height/2-thk/2-y_shift+sqrt(pow(1.63*thk, 2)/2)-.3*thk/2*cos(n), thk+scale_factor/2]) rotate ([0, 0, -n]) cube ([1.63*thk, .3*thk, 2*thk-scale_factor/2]);
				}
				translate ([x_loc+2.5*thk, height/2-thk/2-y_shift, thk+scale_factor/2]) cylinder (h=2*thk-scale_factor/2, r=cam_rad, $fn=smooth);
			}
			translate ([x_loc+2.5*thk, height/2-thk/2-y_shift, thk]) cylinder (h=2*thk+scale_factor, r=thk/4+scale_factor/4, $fn=smooth);
		}
		//
		// pin
		//
		translate ([x_loc+2.5*thk, height/2-thk/2-y_shift, thk/2]) cylinder (h=2.5*thk+scale_factor, r=thk/4, $fn=smooth);
		difference () {
			translate ([x_loc+2.5*thk, height/2-thk/2-y_shift, 3*thk+scale_factor/2]) sphere (r=3*thk/8, $fn=smooth);
			translate ([x_loc+2.5*thk, height/2-thk/2-y_shift, 0]) rotate ([0, 0, 90]) cylinder (h=3*thk+scale_factor/2, r=3*thk/8, $fn=smooth);
		}
	}
}