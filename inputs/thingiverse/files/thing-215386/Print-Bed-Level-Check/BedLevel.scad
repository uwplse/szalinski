// Print bed level test

use <utils/build_plate.scad>

//Select your build plate size
build_plate_selector = 1; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//Width of outline (mm)
thick = 1;

//Height (mm).
height = 0.2;

if(build_plate_selector == 0){
	outline(285,153,height,thick);
	}
if(build_plate_selector == 1){
	outline(225,145,height,thick);
	}
if(build_plate_selector == 2){
	outline(120,120,height,thick);
 	}
if(build_plate_selector == 3){
	outline(build_plate_manual_x,build_plate_manual_y,height,thick);
	}

module outline(x,y,z,thick) {
	translate([0,0,z/2]) {
		difference() {
			cube([x,y,z], center=true);
			cube([x-2*thick,y-2*thick,z+2], center=true);
			}
		cube([x,thick,z], center=true);
		cube([thick,y,z], center=true);
		}
	}

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);