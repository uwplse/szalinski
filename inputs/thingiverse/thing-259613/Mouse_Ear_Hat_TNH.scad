// Customizable Mouse Ear Hat v1.0
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:259613
//
// "Customizable Mouse Ear Hat" is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// Description: 
// I took my my favorite theme park related hat and made it customizable.
//
// Usage: 
// Using Makerbot Customizer (or editing this OpenSCAD file directly) you
// enter a desired hat diameter and select a "Mouse" or "Rabbit" version
// of the hat.
// 

/* [Hat Diameter] */

//Enter the inner diameter of your hat in mm:
Hat_Diameter = 30; // [5:140]

//Mouse or Rabbit ears?
Ears = "mouse"; // [mouse:Mouse, rabbit:Rabbit]

//Pick hat resolution (increases export time)
Resolution = 120; // [12:8-bit,60:Low,120:Medium,240:High]

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
	
/* [Hidden] */

$fn=Resolution;
// preview[view:south, tilt:top diagonal]

// Libraries
use <utils/build_plate.scad>
use <write/Write.scad>

// The most magical OpenSCAD on earth.

module solid_mouse(){
	sphere(r=(Hat_Diameter/2)*1.1);
	translate([0,Hat_Diameter/2*.8,Hat_Diameter/2]) rotate([0,90,0]) cylinder(r=Hat_Diameter/2*.6, h=Hat_Diameter/2*.1, center=true);
	translate([0,-Hat_Diameter/2*.8,Hat_Diameter/2]) rotate([0,90,0]) cylinder(r=Hat_Diameter/2*.6, h=Hat_Diameter/2*.1, center=true);
}

module solid_rabbit(){
	sphere(r=(Hat_Diameter/2)*1.1);
	translate([0,Hat_Diameter/3*.8,Hat_Diameter/2]) {
		rotate([0,90,0]) {
			hull(){
				translate([-Hat_Diameter/1.5,Hat_Diameter/5,0]) cylinder(r=Hat_Diameter/3*.6, h=Hat_Diameter/2*.1, center=true);
				cylinder(r=Hat_Diameter/4*.6, h=Hat_Diameter/2*.1, center=true);
			}
		}
	}
	
	translate([0,-Hat_Diameter/3*.8,Hat_Diameter/2]) {
		rotate([0,90,0]) {
			hull(){
				translate([-Hat_Diameter/1.5,-Hat_Diameter/5,0]) cylinder(r=Hat_Diameter/3*.6, h=Hat_Diameter/2*.1, center=true);
				cylinder(r=Hat_Diameter/4*.6, h=Hat_Diameter/2*.1, center=true);
			}
		}
	}
}

if (Ears == "mouse") {
	rotate([0,0,90]){
		difference(){
			solid_mouse();
			sphere(r=Hat_Diameter/2);
			translate([0,0,-Hat_Diameter/2]) cube([Hat_Diameter/2*3, Hat_Diameter/2*3, Hat_Diameter/2*2], center=true);
		}
	}
}

if (Ears == "rabbit") {
	rotate([0,0,90]){
		difference(){
			solid_rabbit();
			sphere(r=Hat_Diameter/2);
			translate([0,0,-Hat_Diameter/2]) cube([Hat_Diameter/2*3, Hat_Diameter/2*3, Hat_Diameter/2*2], center=true);
		}
	}
}

