/*

double-walled flower pot

LICENSE
-------
Licensed under Creative Commons Attribution-NonCommercial 4.0 International  
License (CC BY-NC) <https://creativecommons.org/licenses/by-nc/4.0>. This 
license lets you remix, tweak, and build upon this work non-commercially, 
and although your new works must also acknowledge me and be non-commercial, 
you don’t have to license your derivative works on the same terms.

Copyright 2018 Green Ellipsis LLC. www.greenellipsis.org

Written by ALittleSlow
   
This "Designer/Customizer/Thing" is for creating any kind of vessel, really, 
but the original intention was a double-walled flower pot so that the plant
could be watered from the bottom up.
	
Features include:
* Double-wall is optional
* Customizable height and and basic diameter
* Simple factors to customize slenderness and top diameter
* Customizable number of curves and starting position of curve
* Customizable number of drain holes between wall
* Customizable rendering parameters

Want a feature added? Let me know.

To design your own thing
-------------------------------
1. Download and extract the .zip file.
2. Install the Development version of OpenSCAD (http://www.openscad.org/downloads.html#snapshots)
3. Enable the Customizer according to https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/WIP#Customizer
4. Open the .scad file
5. Pick your preset or set your customizations
6. Render
7. Export as an STL file

Get more Customizer help from DrLex: https://www.thingiverse.com/thing:2812634.

Version 1.0
-----------
* Updated for library changes
* Allowed a slenderness down to 0.5
* Included LICENSE info
* Updated comment header to markdown format
* Add presets

Version 0.3
-----------
* Double-wall is now optional.
* Rename model

TODO
----
* cut the bottom gap for supportless printing
* use a path and rotational extrude vs shells for efficiency
* Redo using splines or Bezeir curves for efficiency.
*/

use <GreenEllipsis/shells.scad>;
/* [Size and Features] */
// unchecked renders faster
double_walled=false; 
height = 120; // [10:400]
diameter = 120; // [10:400]
/* [Profile] */
// use a small value for the final render
slenderness=0.75; // [0.5:0.01:1]
// multiply radius of top part of curve by top_factor
top_factor=1; //[-1.5:0.1:10]
start_angle=0; // [0:360]
stop_angle=450; 
/* [Structure] */
// ideally a multiple of nozzle diameter
shell_thickness = 1.2; 
//number of braces
braces = 12;// [3:64]
//number of drain holes
holes = 24; // [3:64]
/* [Rendering] */
// use 10 or less for the final render
dTheta = 45;
// use 36 or more for the final render
$fn=12;
/* [Hidden] */
EPSILON = 0.01;
dz = height*dTheta/(stop_angle-start_angle);
ShellGap = diameter/20;
GapHeight = height/10;
// r is radius to use
// s is offset (in positive r direction) to add to cone's radius
module cones(r, s=0, shell=false,t) {
	for(Theta=[start_angle:dTheta:stop_angle]) {
		z = (Theta-start_angle)/dTheta*dz;
		slenderness = slenderness ;
		Factor = (Theta < 270 ? 1 : top_factor);
		boost = (Theta < 270 ? 0: (top_factor-1)*(2*slenderness-1));
		R = (((1-slenderness)*sin(Theta)+slenderness)*Factor - boost)*r + s;
		RNext = (((1-slenderness)*sin(Theta+dTheta)+slenderness)*Factor - boost )*r + s;
		taper = (R-RNext)/dz;
		translate([0,0,z]) {
			if (shell) {
				if (t==undef) { echo("Error in cones():t is undefined"); }
				echo(str("braces():cone_shell top_factor=",top_factor));
				echo(str("braces():Theta=",Theta," z=",z," R=",R," RNext=",RNext));
				GE_cone_shell(t,dz+EPSILON,R,taper, top=false, bottom=false);
			} else {
				GE_cone(r1=R, r2=RNext,h=dz+EPSILON);
			}
		}
	}
}

module braces(n, h, r,t) {
	difference() {
		// some slats
		for (i=[1:n]) {
			rotate([0,0,360/n*i]) 
				cube([r,t,h]);
		}
		// cut gaps
		for (i=[0:3]) {
			translate([0,0,i*h/4]) cylinder(r=r*1.25,h=GapHeight);
		}
		// hollow out the inside
		cones(r=r,s=-ShellGap);
	}
	difference() {
		// inner shell
		cones(r=r,s=-ShellGap,shell=true,t=t);
		// drain holes at the bottom
		drain_holes(holes,diameter/2);
	}
 }

module drain_holes(n,r) {
	for(Theta=[360/n/2:360/n:360+360/n/2]) {
		translate([0,0,GapHeight/2]) rotate([0,90,Theta]) scale([1,0.5]) cylinder(d=GapHeight,h=r+EPSILON);
//		cylinder(r=GapHeight,h=r+EPSILON);
	}
}
if (double_walled) {
	difference() {
		// draw shell braces
		braces(n=braces,h=height,r=diameter/2,t=shell_thickness);
		// subtract outer flanges
		cones(t=diameter,r=diameter/2,shell=true);
	}
}
// outer shell
cones(t=shell_thickness,r=diameter/2,shell=true);
// draw bottom
R = ((1-slenderness)*sin(start_angle)+slenderness)*diameter/2;
cylinder(r=R,h=shell_thickness);
