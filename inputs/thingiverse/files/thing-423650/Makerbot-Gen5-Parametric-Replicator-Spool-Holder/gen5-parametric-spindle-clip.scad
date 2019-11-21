/* Uses OpenSCAD 2012.04.04

Parametric Replicator Spool Holder
==================================

Based on http://www.thingiverse.com/thing:20710

Modified for the Makerbot Replicator 5th Generation.
Updated to allow re-use of the clip.

This program renders 2 parts which allow for the mounting of non-standard spools on the Makerbot Replicator 5th Generation.

Part 1 is a right hand side wall support panel which clips around the top support wall.

Part 2 is a mounting tube and base which slides into the wall support panel and allows for the mounting of
the spool.

Both Part 1 and 2 can be customised for spools by changing the value of variables below.

The main variables which need to be customised are:

	SpoolHoleDiameter
	SpoolDepth

The "Layout" variable can be set to "Both", "Wall" or "Spool" to render the parts required for printing.

The Part 1 wall support panel can be Mirrored in ReplicatorG or Makerware to print for the right hand side spool.

*/

/* [Global] */

// What do you want to print?
part = "Both";	  //  [Both:Both, Wall:Wall, Spool:Spool]

// Do you want an angled spool?
angled = "yes";  //  [yes, no]

// Diameter of Hole in Center of Spool (52.0 for Makerbot)?
SpoolHoleDiameter = 52.0;  // Settings for Makerbot Spools.

// Width of Spool (80.0 for Makerbot)?
SpoolDepth = 80.0;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

print_part();

module print_part() {
	if (part == "Both") {
       if (angled == "yes") {
         AngledWallSupport();
       } else {
		  WallSupport();
       }
		SpoolSupport();
	} else if (part == "Wall") {
		if (angled == true) {
         AngledWallSupport();
       } else {
		  WallSupport();
       }
	} else {
		SpoolSupport();
	}
}

/*
===========  OpenSCAD Shapes Library (www.openscad.at)
===========  Copyright (C) 2009  Catarina Mota <clifford@clifford.at>
*/


module tube(height, radius, wall) {
	difference(){
		cylinder(height, radius, radius,$fa=1);
		cylinder(height, radius-wall, radius-wall);
	}
}

module box(w,h,d) {
	scale ([w,h,d]) cube(1, true);
}

//-----------------------
//MOVES THE ROTATION AXIS OF A BOX FROM ITS CENTER TO THE BOTTOM LEFT CORNER
module dislocateBox(w,h,d){
	translate([w/2,h,0]){
		difference(){
			box(w, h*2, d+1);
			translate([-w,0,0]) box(w, h*2, d+1);
		}
	}
}


module rightTriangle(adjacent, opposite, depth) {
	difference(){
		translate([-adjacent/2,opposite/2,0]) box(adjacent, opposite, depth);
		translate([-adjacent,0,0]){
			rotate([0,0,atan(opposite/adjacent)]) dislocateBox(adjacent*2, opposite, depth);
		}
	}
}
/*
  ==============================================================================
   MAIN CODE
  ==============================================================================
*/

//--  Standard Build Variables.
SideTrackWidth = 3.0 * 1;
SideTrackHeight = 5.0 * 1;
SideTopHeight = 6.0 * 1;
TubeThickness = 4.0 * 1;
TubeCollarWidth = 5.0 * 1;
TubeCollarHeight = 2.0 * 1;
TubeBaseClearance = 3.0 * 1;									// Space between edge of baseplate and tube.
TubeBaseSlippage = 0.5 * 1;									// Slippage between tube base plate and side rail.


//--  Calculated Dimensions

SpoolPrintOffset = 30 * 1;									// Offset of Spool from Wall Support for print layout

SpoolBaseplateDepth = SideTrackHeight - 0.4;
SpoolBaseplateXorY = 52.0 + (TubeBaseClearance * 2);

//-- Wall Support Panel.

module WallSupport() {
  overhang_x = 48.1;
  overhang_z = 36;
  clip_x = 4;
  clip_y = 60;
  clip_z = 4;

  wall_thickness = 4;

  support_slider_gap = 5;
  support_slider_edge_thickness = 6;
  support_slider_edge_z = 3;
  support_slider_z = 59;
  support_z = support_slider_z + (wall_thickness * 2);

  translate([24,-3,0]) {
  rotate([90, 0, 0]) {
    cube([overhang_x + wall_thickness, clip_y, wall_thickness]);

    translate([0,0,wall_thickness])
      cube([wall_thickness, clip_y, overhang_z + wall_thickness]);

    translate([0,0,overhang_z + wall_thickness])
      cube([clip_x + wall_thickness, clip_y, wall_thickness]);

    translate([clip_x + wall_thickness, 0, overhang_z])
      cube([2, clip_y, clip_z + wall_thickness]);

    translate([overhang_x + wall_thickness, 0, 0])
      cube([wall_thickness, clip_y, support_z]);

    translate([overhang_x + (wall_thickness * 2), 0, 0])
      cube([support_slider_gap, clip_y, wall_thickness]);

    translate([overhang_x + (wall_thickness * 2) + support_slider_gap, 0, 0])
      cube([support_slider_edge_thickness, clip_y, support_slider_edge_z + wall_thickness]);

    translate([overhang_x + (wall_thickness * 2), 0, support_z - wall_thickness])
      cube([support_slider_gap, clip_y, wall_thickness]);

    translate([overhang_x + (wall_thickness * 2) + support_slider_gap, 0, support_z - (support_slider_edge_z + wall_thickness)])
      cube([support_slider_edge_thickness, clip_y, support_slider_edge_z + wall_thickness]);
  }}
}


module AngledWallSupport() {
  overhang_x = 48.1;
  overhang_z = 36;
  clip_x = 4;
  clip_y = 60;
  clip_z = 4;

  wall_thickness = 4;

  support_slider_gap = 5;
  support_slider_edge_thickness = 6;
  support_slider_edge_z = 3;
  support_slider_z = 59;
  support_z = support_slider_z + (wall_thickness * 2);

  rotate([90, 0, 0]) {
    cube([20 + wall_thickness, clip_y, wall_thickness]);

    translate([0,0,wall_thickness])
      cube([wall_thickness, clip_y, overhang_z + wall_thickness]);

    translate([0,0,overhang_z + wall_thickness])
      cube([clip_x + wall_thickness, clip_y, wall_thickness]);

    translate([clip_x + wall_thickness, 0, overhang_z])
      cube([2, clip_y, clip_z + wall_thickness]);

    translate([overhang_x + wall_thickness, 0, 33.5])
      cube([wall_thickness, clip_y, 20]);

    translate([-28.3, 0, 27]) {
      rotate([0,45,0]){
        translate([overhang_x + wall_thickness, 0, 0])
          cube([wall_thickness, clip_y, support_z]);

        translate([overhang_x + (wall_thickness * 2), 0, 0])
          cube([support_slider_gap, clip_y, wall_thickness]);

        translate([overhang_x + (wall_thickness * 2) + support_slider_gap, 0, 0])
          cube([support_slider_edge_thickness, clip_y, support_slider_edge_z + wall_thickness]);

        translate([overhang_x + (wall_thickness * 2), 0, support_z - wall_thickness])
          cube([support_slider_gap, clip_y, wall_thickness]);

        translate([overhang_x + (wall_thickness * 2) + support_slider_gap, 0, support_z - (support_slider_edge_z + wall_thickness)])
          cube([support_slider_edge_thickness, clip_y, support_slider_edge_z + wall_thickness]);
      }
    }
  }
}

module BasePlate() {

	color("red") translate([SpoolPrintOffset, SideTrackWidth, 0])
	cube([SpoolBaseplateXorY,SpoolBaseplateXorY,SpoolBaseplateDepth]);
  
}

module MainTube() {
	
 	difference(){ 
	
    	color("Yellow") 
		translate([SpoolPrintOffset + (SpoolBaseplateXorY /2.0),SideTrackWidth + (SpoolBaseplateXorY / 2.0),SpoolBaseplateDepth-0.01])
		tube(SpoolDepth + SideTopHeight + 1.0,SpoolHoleDiameter/2.0,TubeThickness);
		
		color("Orange") 
		//  Leave 15mm lower collar to strengthen printing.
    	translate([SpoolPrintOffset,0,15])
		cube([SpoolBaseplateXorY,(SpoolBaseplateXorY  + TubeBaseClearance)/2,SpoolDepth  + SideTopHeight + 1.0 + TubeCollarWidth ]);
  }
}

module UpperCollar() {

	difference(){ 
    	color("SkyBlue")
 		translate([SpoolPrintOffset + (SpoolBaseplateXorY /2.0),SideTrackWidth + (SpoolBaseplateXorY / 2.0),SpoolDepth  + SideTopHeight + 1.0])
		tube(TubeCollarWidth,(SpoolHoleDiameter + TubeCollarHeight)/2.0,TubeCollarHeight);
		
    	translate([SpoolPrintOffset,0,0])
		cube([SpoolBaseplateXorY,(SpoolBaseplateXorY  + TubeBaseClearance)/2,SpoolDepth + SideTopHeight + 1.0 +TubeCollarWidth]);
  }
}

module SupportTriangle() {

	color("pink");
    y_offset = (SpoolBaseplateXorY - SpoolHoleDiameter) / 2.0;
	translate([SpoolPrintOffset + (SpoolBaseplateXorY /2.0),SpoolBaseplateXorY - y_offset,SpoolBaseplateDepth-0.01]) rotate ([0,90,180])
	rightTriangle(SpoolDepth,SpoolHoleDiameter - TubeBaseClearance,TubeThickness);

}

//--	Spool Tube and support base.

module SpoolSupport() {

	BasePlate();
	MainTube();
	UpperCollar();
	SupportTriangle();
}

