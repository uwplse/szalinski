/******************************************************************************************
* Nose Generator for RC model planes                                                      *
* by Thomas Rößler, http://www.geekair.at                                                 *
*                                                                                         *
* This work is licensed under the Creative Commons Attribution 4.0 International License. *
* To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.      *
*                                                                                         *
* Please attribute to www.geekair.at                                                      *
******************************************************************************************/
use <utils/build_plate.scad>
use <write/Write.scad>
//use <../../lib/write.scad/write.scad>
// preview[view:north, tilt:bottom diagonal]

/* [Sizes] */
// Diameter of the nose on rc plane side
diameterPlane = 128;
// Diameter of the nose on propeller side
diameterProp = 80;
// Diameter of the propeller hole
diameterMotorHole = 40;
// length of wide side
heightSocket = 55;
// Total length of the nose
heightTotal = 110;
// thickness of the walls
thickness = 1;

/* [Decoration] */
// number of ellipses on propeller side
ellipses = 54;
// thickness of the ellipse layer
thicknessEllipses = 1;
// scale factor for ellipse width
scaleEllipses = 0.13;
// text on socket
text = "www.geekair.at";

/* [Build Plate] */
//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Hidden] */
$fn = 120;
effectiveThicknessEllipses = ellipses > 0 ? thicknessEllipses : 0;

module noseShape(dPlane, dProp, extraHeight) {
	cylinder(r=dPlane/2, h=heightSocket+extraHeight);
	
	translate([0, 0, heightSocket])
	cylinder(r1=dPlane/2, r2=dProp/2, h=(heightTotal-heightSocket)+extraHeight);
}

module nose() {
	width = (diameterProp - diameterMotorHole) / 2;

	color("orange")
	translate([0, 0, heightTotal]) {
		for(i = [1 : ellipses]) {
			rotate([0, 0, 360/ellipses * i])
			translate([0, (width + diameterMotorHole) / 2, 0])
			scale([scaleEllipses, 1, 1])
			cylinder(r=width/2, h=effectiveThicknessEllipses);
		}
	}

	color("orange")
	writecylinder(text=text,where=[0,0,0],font="orbitron.dxf",h=10,radius=(diameterPlane+thickness)/2,height=heightSocket);

	difference() {
		noseShape(diameterPlane+thickness, diameterProp+thickness, 0);
		
		translate([0, 0, -thickness])
		noseShape(diameterPlane, diameterProp, 0.1);
		
		translate([0, 0, heightTotal])
		cylinder(r=diameterMotorHole/2, h=thickness*2, center=true);
	}
}


translate([0, 0, heightTotal+effectiveThicknessEllipses])
rotate([180, 0, 0])
nose();

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);