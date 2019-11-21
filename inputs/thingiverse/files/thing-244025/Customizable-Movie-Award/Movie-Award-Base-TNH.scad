// Customizable Movie Award Base
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:244025
//
// "Customizable Movie Award Base" is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// Description: 
// 
// Here's something for all the party planning committees getting 
// ready for the upcoming movie awards. For those of you also hosting parties,
// print the included sculpture from cerberus333 (thanks for the excellent award
// statue sculpt! I'm not sure if I would have started this project if I didn't
// have access to your awesome sculpture) to stand on top. Or make your own 
// award statue, this could be great re-purposed for birthdays, graduations, 
// fathers day, etc (best maker anyone?).
//
//
// Usage: 
//
// Using Makerbot Customizer (or editing this OpenSCAD file directly. 
// you can add two lines of custom text to the base of this statue. 
// This can be printed using a single extruder or with dual extruders. 
// When exporting the model from Customizer pick your desired extruder 
// configuration. "Single Extruder" will output a model with inset lettering.
// "Dual Extruder" will give you two models, print these in two different 
// colors.
//

// Libraries
use <utils/build_plate.scad>
use <write/Write.scad>

// Customizer Stuff

/* [Inscription] */

// Label your award!
Top_Label = "#1 Coolest";
Bottom_Label = "Maker";

// Select your printer type before exporting
Printer_Type = "preview"; // [preview:Preview,single:Single Extruder,dual1:Dual Extruder (Extruder 1), dual2:Dual Extruder (Extruder 2)]

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//
// GO AWAY CUSTOMIZER
//

/* [Hidden] */

// preview[view:south, tilt:top diagonal]

$fn = 180;

c1 = [56.2,1.6];
c2 = [52.5,1.5];
c3 = [46.7,21.5];
c4 = [40,3.1];

module label() {
	translate([0,0,0+c1[1]+c2[1]+c3[1]]) cylinder(r=c4[0]/2, h=c4[1], center=false);
		difference(){	
			translate([0,0,0+c1[1]+c2[1]-.1+2]) cylinder(r=c3[0]/2+.1, h=c3[1]-5, center=false);
			translate([0,0,0+c1[1]+c2[1]-.1+2]) cylinder(r=c3[0]/2-3, h=c3[1]-5, center=false);
			translate([8,0,0]) cube([50, 100, 100], center=true);
			writecylinder(Top_Label,[0,0,10],c3[0]/20,east=-90,up=6,t=15,center=true); 
			writecylinder(Bottom_Label,[0,0,10],c3[0]/20,east=-90,up=0,center=true); 
	}
}

module base() {
	difference(){
		union(){
			translate([0,0,0]) cylinder(r=c1[0]/2, h=c1[1], center=false);
			translate([0,0,0+c1[1]-.1]) cylinder(r=c2[0]/2, h=c2[1], center=false);
			translate([0,0,0+c1[1]+c2[1]-.1]) cylinder(r=c3[0]/2, h=c3[1], center=false);
		}
		label();
		rotate([0,0,270]) translate([0,0,10]) write("TNH",h=10,t=5,font="write/orbitron.dxf", space=1, center=true);
	}
}

if (Printer_Type == "preview") {
	rotate([0,0,90]) {
		color("DimGrey") base();
		color("silver") label();
		color("DimGrey") writecylinder(Top_Label,[0,0,10],c3[0]/2-0.4,0,east=-90,up=6,center=true); 
		color("DimGrey") writecylinder(Bottom_Label,[0,0,10],c3[0]/2-0.4,0,east=-90,up=0,center=true); 
	}
}

else if (Printer_Type == "single") {
	rotate([0,0,90]) {
		difference(){

		union(){
		color("DimGrey") base();
		color("silver") label();
		}
		writecylinder(Top_Label,[0,0,10],c3[0]/2,0,east=-90,up=6,center=true); 
		writecylinder(Bottom_Label,[0,0,10],c3[0]/2,0,east=-90,up=0,center=true); 
	}
	}
}

else if (Printer_Type == "dual1") {
	rotate([0,0,90]) {
		color("silver") label();
	}
}

else if (Printer_Type == "dual2") {
	rotate([0,0,90]) {
		color("DimGrey") base();
		color("DimGrey") writecylinder(Top_Label,[0,0,10],c3[0]/2-0.4,0,east=-90,up=6,center=true); 
		color("DimGrey") writecylinder(Bottom_Label,[0,0,10],c3[0]/2-0.4,0,east=-90,up=0,center=true); 
	}
}
