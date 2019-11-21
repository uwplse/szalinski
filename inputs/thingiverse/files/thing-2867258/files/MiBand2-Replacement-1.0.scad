/* 
LICENSE
-------
Licensed under Creative Commons Attribution 4.0 International License (CC BY) 
<https://creativecommons.org/licenses/by/4.0> by Green Ellipsis LLC. This 
license lets you distribute, remix, tweak, and build upon this work, even 
commercially, as long as you credit me for the original creation. 

Copyright 2018 Green Ellipsis LLC. www.greenellipsis.org

Written by ALittleSlow
   
Included Libraries
------------------
MCAD libraries (https://github.com/openscad/MCAD):
This library was created by various authors as named in the individual files' comments. All the files except those ThingDoc are licensed under the LGPL 2.1 (see http://creativecommons.org/licenses/LGPL/2.1/ or the included file lgpl-2.1.txt), some of them allow distribution under more permissive terms (as described in the files' comments).

This MiBand2 Replacement is intended to be a close but customizable replacement to the 
original Xiomi Mi Band 2 band. Re-use the original stud. Print it with flexible filament. 
	
Features include:
* Customizable band length
* Cusomizable hole pattern in the band.

Version 1.0
------------
* Initial release

Version 0.3
------------
* Allow band to be rotated downward as far as 90 degrees where it attaches to watch.
* Add a radius to the interface between the watch and the band for comfort.

Version 0.2
------------
* Set "watch_face_depth" to 0 and reduced watch_max_depth by 1.7 accordingly, in the MiBand 2 replacement preset.
* Added curvature to the band near the watch holder. Needs more.

To customize your band
-------------------------------
1. Download and extract the .zip file.
2. Install the Development version of OpenSCAD (http://www.openscad.org/downloads.html#snapshots)
3. Enable the Customizer according to https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/WIP#Customizer
4. Open the .scad file
5. Preview it the model (Design-->Preview)
5. Pick your preset or set your customizations in the Customizer tab
6. Render (Design-->Render)
7. Export as an STL file (File-->Export)

Get more Customizer help from DrLex: https://www.thingiverse.com/thing:2812634.

TO DO
-----
* This the band at the radius tangential to the build plate so that when bent the other way it isn't so thick.
* Create a version that can be printed on its side so it prints with the desired curvature.
*/
//use <GreenEllipsis/convenience.scad>;
include <MCAD/constants.scad>;
use <MCAD/2Dshapes.scad>;

/* [Customize] */
// from the tip to the watch
snap_band_length = 94.70; // [50:0.1:150]
// from the tip to the watch
hole_band_length = 118.00; // [50:0.1:175]
// width of the band
band_width = 15.00; // [5:30]
// thickness of the band
band_thickness = 2.95; // [1.00:0.05:5.00]
// radius of curvature of the band
band_radius = 20; // [5:50]
// how many degrees to curve band
band_angle = 60; // [0:90]
// center-to-center distance between holes
hole_spacing=6.92; // [3.00:0.04:12.00]
// maximum number of holes
hole_count = 9; // [0:20]
// distance from very end of strap to start holes
hole_start = 16.30; // [13:0.1:100]
// how far down strap to make the transition
holder_blend_length=0.4;
/* [Advanced] */
hole_diameter = 2.60;
hole_seat_diameter = 3.10;
ring_diameter = 2.80;
ring_inner_width= 16.82;
ring_inner_length= 7.75;
watch_holder_thickness = 2.00;
watch_max_length=40.20;
watch_max_width=15.80;
watch_max_depth=8.70;
watch_face_width=13.70;
watch_face_depth=0.00;
snap_base_diameter=8.36;
snap_base_thickness=0.90;
snap_post_diameter=1.75;
snap_ring_diameter=2.98;
snap_ring_top_height=1.89;
snap_ring_depth=0.50; //estimated

/* [Rendering ] */
$fs = 0.1;
$fa = 5;
EPSILON=0.01;
debug=true;
/* [Hidden] */
PI=3.1415926;
watch_max_radius=watch_max_width/2; // assume its circular
watch_face_radius=watch_face_width/2;
snap_ring_distance=band_width/2;

curve_y_length = sin(band_angle)*band_radius;
curve_z_height = (1-cos(band_angle))*(band_radius+band_thickness/2);
end_length=band_width/2;
snap_straight_length = snap_band_length - band_radius*GE_radians(band_angle) - end_length;
hole_straight_length = hole_band_length - band_radius*GE_radians(band_angle) - end_length;
if (snap_straight_length<0) echo(str("Error! Can't fit curve in snap band length of ", snap_band_length));
if (hole_straight_length<0) echo(str("Error! Can't fit curve in hole band length of ", hole_band_length));

// convert degrees to radians
function GE_radians(degrees) = TAU*(degrees/360);

module bandProfile() {
	translate([band_width/4,0,0]) complexRoundSquare([band_width/2,band_thickness],rads3=[1,1],rads2=[1,1]);
}

// create a curved strap segment center is on the origin and
module bandCurve(r=band_radius, angle=band_angle) {
		// curved part
	rotate([0,90,0]) translate([-r,0,0])
	rotate_extrude(angle=angle) 
		translate([r,0,0]) rotate([0,0,90]) 
		{
		bandProfile();
		mirror([1,0,0]) bandProfile();
	}
}
		
//make the side of the band with the snap,
//and position it at the origin
//FIXME translations are wrong
module snapBand() {
	translate([0, curve_y_length, 0]) difference() {
		union() {
			// curved part
			//translate([0, -0, -band_radius+curve_z_height*2]) rotate([0,-90,0]) bandCurve();
			translate([0, 0, 0]) rotate([0,0,180]) bandCurve();
			// straight part
			translate([0, snap_straight_length, 0]) 
				rotate([90,0,0]) linear_extrude(snap_straight_length) 	{
				bandProfile();
				mirror([1,0,0]) bandProfile();
			}
			// rounded end
			translate([0, snap_straight_length, 0]) rotate_extrude(angle=180)
				bandProfile();
		}
		// through hole for snap
		translate([0, snap_straight_length, 0]) {
			cylinder(d=snap_post_diameter,h=band_thickness*2,center=true);
			// hole for base
			translate([0,0,band_thickness/2-snap_base_thickness+EPSILON]) cylinder(d=snap_base_diameter,h=snap_base_thickness+EPSILON);
			// hole for ring
			translate([0,0,-band_thickness/2-EPSILON]) cylinder(d=snap_ring_diameter,h=snap_ring_depth+EPSILON);
		}
	}
	
}

// half of the strap loop
module halfRing(ringstraight_length) {
	ringMajorRadius =ring_inner_length/2+ring_diameter/2;
	rotate_extrude(angle=180) translate([ringMajorRadius,0]) circle(d=ring_diameter);
	translate([ringMajorRadius,0]) rotate([90,0,0]) cylinder(d=ring_diameter,h=ringstraight_length);
}

// strap loop
module ring() {
	ringOuterRadius = ring_inner_length/2 + ring_diameter;
	ringstraight_length = ring_inner_width-ring_inner_length;
	translate([-ringstraight_length/2,ringOuterRadius]) rotate([0,0,90]) halfRing(ringstraight_length);
	translate([+ringstraight_length/2,ringOuterRadius]) rotate([0,0,-90]) halfRing(ringstraight_length);
}

//make the side of the band with the holes,
//and position it at the origin
module holeBand() {
	ringOuterLength=ring_diameter*3/2+ring_inner_length;
	linearLength=hole_band_length-ringOuterLength;
	translate([0, curve_y_length, 0]) {
		// curved part
		rotate([0,0,180]) bandCurve();
		// straight part
		difference() {
			translate([0, hole_straight_length, 0]) 
				rotate([90,0,0]) linear_extrude(hole_straight_length) 	{
				bandProfile();
				mirror([1,0,0]) bandProfile();
			}
			// through holes
			HoleCount=min(hole_count, floor(hole_straight_length/hole_spacing));
			if (HoleCount < hole_count) echo("Warning! Unable to put holes on the curved part (yet)");
			for(i=[0:HoleCount-1]) {
				translate([0, hole_straight_length-(hole_start+hole_spacing*i-ringOuterLength)]) {
					cylinder(d=hole_diameter,h=band_thickness*2, center=true);
					translate([0,0,-band_thickness/2-EPSILON]) 
						cylinder(d=hole_seat_diameter,h=snap_ring_depth+EPSILON);
				}
			}
		}
		// ring. Overlap the ring with the band by 1/2 ring diameter
		translate([0, hole_straight_length-ring_diameter/2]) ring();
	}
	
}

// define holder profile
module watchHolderProfile() {
	WatchHolderRadius = watch_max_radius + watch_holder_thickness;
	ContactAngle=asin((watch_max_depth/2-watch_face_depth)/watch_max_radius);
	intersection () {
		difference() {
			pieSlice(WatchHolderRadius, -85, 85);
			pieSlice(watch_max_radius, -90, 90);
		}
		translate([0,-watch_max_depth/2]) 
		square([WatchHolderRadius,watch_max_depth]);
	}
	//FIXME There isn't supposed to be a raised lip. Don't know what's wrong with my math
	translate([watch_max_radius*cos(ContactAngle)-(watch_max_radius-watch_face_radius),watch_max_depth/2-watch_face_depth]) square([watch_max_radius-watch_face_radius,watch_face_depth]);
}

//FIXME hull needs to follow curvature
module watchHolderEnd(SideWallLength) {
	difference () {
		hull() 
		{
			// extrude the ends
			rotate_extrude(angle=180) watchHolderProfile();
			// extrude a bid of strap
			
			#translate([0, watch_max_radius-band_thickness/2+holder_blend_length*cos(band_angle), -watch_max_depth/2]) 
			rotate([90+band_angle,0,180]) 
				translate([0,watch_holder_thickness,0]) linear_extrude(holder_blend_length) 	
				scale([1,0.3,1]) {
					bandProfile();
					mirror([1,0,0]) bandProfile(); 
				}
		}
		// subtract the part of hull() we didn't want
		rotate_extrude(angle=360) pieSlice(watch_max_radius,-90,90);
	}
}

// make the watch holder part,
// and position it at the origin
module watchHolder() {
	SideWallLength=watch_max_length-watch_max_width;
	translate([0,SideWallLength+watch_max_width/2+watch_holder_thickness]) {
		// extrude the side walls
		rotate([90,0,0]) linear_extrude(SideWallLength) 	watchHolderProfile();
		mirror([1,0,0]) rotate([90,0,0]) linear_extrude(SideWallLength) watchHolderProfile();
		watchHolderEnd(SideWallLength);
		translate([0,-SideWallLength,0]) mirror([0,1,0]) watchHolderEnd(SideWallLength);
	}	
}
//bandProfile();
//snapBand();
//watchHolderProfile();
//watchHolderEnd();
//ring();
//holeBand();
//bandCurve();
			

translate([0, -watch_holder_thickness, watch_max_depth/2]) watchHolder();
// overlap the band with the blend area
color("green") translate([0, watch_max_length, -curve_z_height+band_thickness/2]) snapBand();
color("green") translate([0, 0, -curve_z_height+band_thickness/2]) rotate([0,0,180]) holeBand();
