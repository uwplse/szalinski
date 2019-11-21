//
//  Variable size box retainer for mounting
//  on a wall.
//
//  The main intention of this Thing is
//  to provide mounting for a Linksys Hub
//
//	  R. Lazure, February 16, 2014
//
//
//  ------------------------
//  inputs
//
/* [Box] */

//  Holding a box with a height of ...
box_ht = 32;  // [10:50]
//  Bottom of the holder has a block height of
block_ht= 6; // [0:45]
//  Top of the holder has a tab 
top_tab= 0;  // [0:45]
//  Side of the holder has a tab
side_tab = 0; // [0:30]
//  Length of the holder
length= 38; // [20:100]
//	 Holder width
box_wd = 19; // [10:50]
//
/* [Holding tab] */
//  Width of the tab that holds the screw
tab_width = 25;  // [15:75]
//  screw diameter
screw_dia=5; // [3:15]
//  center to center play in slot
slot_sp=5; // [0:15]
//  wall thickness  
thickness = 3; // [2:5]

/* [Hidden] */
$fn=20;
//
//   -------------------------
//		Module:  Housing
//	  -------------------------
//
module housing() {
difference()
	{
	difference ()
	{
//  outer block
	cube([thickness+box_wd,length,box_ht+thickness]);
	translate([thickness+side_tab,0,block_ht]) cube([box_wd+2, length+2,box_ht-block_ht-top_tab]);
	}
translate ([thickness,thickness,0]) cube([box_wd,length,box_ht]);
	}
}
//
//   -------------------------
//		Module:  tab
//	  -------------------------
// 
module tab() {
//
difference() {
// bottom plate
translate ([-tab_width,0,0]) cube([tab_width,length,thickness]);
//
//  slot position
translate([-tab_width/2-slot_sp/2,length/2,0])
//   slot
union(){
translate([0,0,-1])
cylinder(h=thickness+2,r=screw_dia/2);
translate([slot_sp,0,-1])
cylinder(h=thickness+2,r=screw_dia/2);
translate([0,-screw_dia/2,-1])
cube([slot_sp,screw_dia,thickness+2]);
		}
	}
}
//
//		-------------------
//		Module: box holder
//		-------------------
//
module box_holder() {
housing();
difference() {
difference() {
tab();
//     chamfer 1
// create a large cube rotated 45 degrees to cut the corner
translate([-tab_width-2.5,-tab_width+4,-1])
rotate([0,0,45])
cube([tab_width,tab_width,thickness+2]);
             }
//		 chamfer 2
// create a large cube rotated 45 degrees to cut the corner
translate([-tab_width*1.9,length+1,-1])
rotate([0,0,-45])
cube([tab_width,tab_width,thickness+2]);
              }
}
//		-------------
//   			Main
//		-------------
//
//  for Thingiverse Customizer
//  two clamps are made

//   rotate for proper orientation
//  in MakerWare for slicing
//
rotate([90,0,180]) {
//	  original clamp
translate([-box_wd-thickness-3,0,0])
box_holder();
//   mirror copy of the same clamp
mirror([1,0,0])
translate([-box_wd-thickness-3,0,0])
box_holder();
				}