// ////////////////////////////////////////////////////
// File: plug.scad
// Description:  Plug for hot tub jets.  Use with a Harbor 
//               Frieght P16 (20.6mm OD x 15.8mm ID x 2.4mm Thickness) O-Ring.
//               All units in MM!
// Author: Dang Vang 01/2016
// ////////////////////////////////////////////////////
$fn=40;   // Fragment setting.  No need to change
include <MCAD/shapes.scad>;

tol=0.5;  // Tolerance for o-ring groove fit

shrinkage = 0; // My 3dr machine seems to shrink parts by 1mm on XY axis, Z is fine

nut_size_mm=25;
pluglen_mm=24;
plugdia_mm=19;
handlelen_mm=20; 
handleradius_mm=15;
handlewidth_mm=3;
handlenutShoulder_mm=6;
oringID_mm=15.8;
oring_thickness_mm=2.4;
oring_offset_mm=8;

module Plug()
{
	difference(){ // cut out for handle
		union(){
			translate([0,0,pluglen_mm/2])
				cylinder(r=(plugdia_mm-shrinkage)/2, h=pluglen_mm, center=true);

			// Nut driver
			translate([0,0,pluglen_mm + (handlelen_mm/2) ])
				hexagon( nut_size_mm-shrinkage, handlelen_mm);

			//fillet
			translate([0,0,pluglen_mm-4])
				cylinder(h=4, r1=(plugdia_mm-shrinkage)/2, r2=(nut_size_mm-shrinkage)/2, center=false);
		}

		union(){
			//o-ring cutout
			translate([0,0,oring_offset_mm-oring_thickness_mm/2])
				rotate_extrude(convexity=10) translate([(oringID_mm-oring_thickness_mm/2)/2,0,0]) square([oring_thickness_mm+tol, 3],center=false);
	
			//handle cutouts
			translate([handleradius_mm+handlewidth_mm, 0, pluglen_mm + handleradius_mm + handlenutShoulder_mm])
				rotate([90,0,0]) cylinder(r=handleradius_mm, h=50, center=true);
			translate([-(handleradius_mm+handlewidth_mm), 0, pluglen_mm + handleradius_mm + handlenutShoulder_mm])
				rotate([90,0,0]) cylinder(r=handleradius_mm, h=50, center=true);
		}
	}
}


Plug();

//o-ring.  Uncomment for Visual Aide only
//translate([0,0,oring_offset_mm]) rotate_extrude(convexity=10) {translate([(oringID_mm+oring_thickness_mm/2)/2,0,0]) circle(r=oring_thickness_mm/2,center=false);}

