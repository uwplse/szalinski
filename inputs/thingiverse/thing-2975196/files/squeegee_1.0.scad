/**
* A parametric, customizable squeegee head and blade
* 
* @author Brian Alano
* @version 1.0
* @serial (or @serialField or @serialData)
* @license Creative Commons - Attribution - Non-Commercial 4.0 https://creativecommons.org/licenses/by-nc/4.0/legalcode
* @copyright 2018 Green Ellipsis LLC. www.greenellipsis.org. 

Included Libraries
------------------
dotSCAD libraries are licensed under the LGPL. [![license/LGPL](https://img.shields.io/badge/license-LGPL-blue.svg)](https://github.com/JustinSDK/lib-openscad/blob/master/LICENSE)
 
 Fscrew.stl from https://www.thingiverse.com/thing:8478/files licensed under CC-BY-NC https://creativecommons.org/licenses/by-nc/4.0/legalcode

The squeegee head uses the female screw thread from [Zydac](https://www.thingiverse.com/thing:8478/files) to fit a 3/4-5 ACME broom handle screw. Squeegee blade should be printed from flexible filament. Using 3D Solutech Flexible filament, 3 mm thick was just a little too thick for wiping windows.

Features include:
* Customizable blade thickness, width, handle length and handle angle
* Works in Makerbot/Thingiverse Customizer
* Works in OpenSCAD Customizer
* Parametric design

To design your own thing in OpenSCAD
-------------------------------
1. Download and extract the .zip file.
2. Install the Development version of OpenSCAD (http://www.openscad.org/downloads.html#snapshots)
3. Enable the Customizer according to https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/WIP#Customizer
4. Open the .scad file
5. Preview the model (Design-->Preview)
6. Pick your preset or set your customizations 
7. Render (Design-->Render)
8. Export as an STL file (File-->Export)

Get more Customizer help from DrLex: https://www.thingiverse.com/thing:2812634.

*/

use <utils/build_plate.scad>;

/* [Build Plate] */
//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Parts] */
show_build_plate="yes"; //[yes,no]
//parts to show
show="both"; // [all,blade,head] 

/* [Blade] */
width=60;
length=200;
height=5;

/* [Head] */
angle=30;
head_width=40;
handle_length=25;
// how much the blade extends beyond the head on the sides
overhang=2;
// proportion of head_width to make into a notch
notch=0.5;
// tolerance between the blade and the head
gap=0.2;

/* [Hidden] */
EPSILON=0.01;
build_plate_rotate = 45; //[0:360]
holder_length=length-overhang*2;

show_assembled=(show_build_plate=="yes");
show_blade=(show=="all" || show=="blade");
show_head=(show=="all" || show=="head");

// positioning of blade in assembled model. Also used to cut notch
blade_translation=[width/2+head_width/2-head_width*notch,0,height*3/2];

module channel(cut, length) {
	cylinder(d=cut, h=length+EPSILON*2, $fn=3, center=true);
}
	

module channels(extra=false) {
	Cut=height/3;
	Increment=height/2; 
	Start=height;
	translate([-width/2, 0, 0]) {
		for (i=[Start:Increment:Start+Increment*2]) {
			translate([i, 0, height*0.43]) rotate([90,-30,0]) 
				channel(cut=Cut, length=length);
			translate([i+Increment/2, 0, -height*0.43]) rotate([90,30,0]) 
				channel(cut=Cut, length=length);
		}
		if (extra) translate([Start-Increment/2, 0, -height*0.43]) rotate([90,30,0]) 
				channel(cut=Cut, length=length);
	}
}

module blade(length, width, height, extra=true) {
	module additive() cube([width, length, height], center=true);
	
	module subtractive() channels(extra);

	difference() { additive(); subtractive(); }
}


module shaft() {
	StudLength=26;
	StudR=13;
	HandleLength=max(StudLength, handle_length); 
	StudInset=StudLength-3;
	Translation=[-head_width/2+abs(sin(angle))*height*3, 0, abs(sin(angle))*height];
	module additive() {
		hull() {
			cube([head_width, holder_length, height*3], center=true);
			translate(Translation) rotate([0, -angle, 180]) 
				translate([HandleLength, 0, 0]) rotate([0,-90,0]) cylinder(r=StudR, h=EPSILON);
		}
		hull() {
			cube([head_width, holder_length, height*3], center=true);
			translate(Translation) rotate([0, -angle, 180]) 
			translate([HandleLength-StudLength, 0, 0]) rotate([0,-90,0]) cylinder(r=StudR, h=EPSILON);
		}
	}

	module subtractive() {
		Height=height+gap*2;
		// use the blade profile to cut the notch
		translate([blade_translation.x, blade_translation.y]) blade(length*2, width, Height, extra=false);
		// then cut a little deeper to give some room
		translate([(1/2-notch)*head_width-Height/2+EPSILON,0,0]) rotate([90,0,0]) cube([Height, Height, length*2], center=true);
		translate(Translation) 
			rotate([0, -angle, 180]) 
			translate([HandleLength+EPSILON, 0, 0]) rotate([0,-90,0]) 
			cylinder(r=11, h=StudInset);
	}
	
	module additive2() {
		translate(Translation) 
			rotate([0, -angle, 180]) 
		translate([HandleLength, 0, 0]) rotate([0,-90,0]) 
			stud();
	}
	
	difference() { additive(); subtractive(); }
	additive2();
}
	
module stud() {
	import("Fscrew.stl");
}

module head() {
	module additive() {
			shaft(HandleLength);
	}
	
	module intersect() {
		Height=handle_length+height*5;
		translate([0, 0, Height/2-(height*3)/2]) cube([holder_length, holder_length, Height], center=true);
	}
	
	intersection() {
		additive();
		if (angle>=20) intersect();
	}
}

module main() {
	//translate([0, 0, length/2]) rotate([90,0,0]) 
	{
		if (show_blade) {
			color("gray") 
//			if (show_assembled) {
				translate(blade_translation) blade(length, width, height);
//			} else {
//				translate([0, 0, height/2]) blade(length, width, height);
//			}
		}
		if (show_head) {
//			if (show_assembled) {
				translate([0,0,height*3/2]) rotate([0,0,0]) head();
//			} else {
//				head();
//			}
		}
		if (show_assembled) {
			rotate([0, 0, build_plate_rotate]) 
				build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
		}
	}
}

main();


