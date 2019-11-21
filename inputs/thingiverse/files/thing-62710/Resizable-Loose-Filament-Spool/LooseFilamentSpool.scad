// Loose filament spindle.
// ======================
//
// This spindle is designed to insert into a loose spool of filament and spin
// around a provided axis either on the back of a Replicator or externally.
//
// Terminology:
//
//	Hub - centre support for the spindle - has embedded spokes.
//	Centre Hole - the hole in the centre of the hub.
//	Spoke - the spoke connecting the hub to the bracket.
//	Bracket - the outer support structure designed to hold the spool of filament.
//	Plug - the nub of plastic which inserts into plug holes in the spindle
// 		or the spokes.
//
// Notes:
//
//	Check that you can assemble a full set of 3 spokes and brackets which
//	will fit loosely inside the spool of filament.
//
//	The idea is to NOT stretch the filament inserting the full hub.   There
///  is a need for loose filament to have some room to move as it unwinds. 
//
//	Use the following sequence for insertion:
//
//		1) Insert one spoke/bracket set into the hub and insert this
//			into the spool of filament.
//		2) Insert the second spoke/bracket set into the spool of
//			filament and then into the hub.
//		3) Insert the second spoke/bracket set into the spool of
//			filament and then tilting the hub up slightly insert
//			into the final plug hole on the hub.
//
//	You should print Brackets with support (for the plug).
//	You should print Hubs with support (for the plug holes).
//	Print Spokes vertically at 100% - NO support is best. Horizontally
//		printed spokes will split.

/* [Global] */

// Which part are you going to build?
part = "Hub"; // [Hub:Hub, Spoke:Spoke, Bracket:Bracket]

/* [Hub] */

// Use External if you are not printing for the back of a Replicator.
Hub_Type = "Replicator"; // [Replicator, External]

// Use 52 for Replicator.
Centre_Hole_Diameter = 52; // [20:80]

// Use 15 for Replicator.
Hub_Thickness = 15; // [15:50]

/* [Spoke] */

// Use 20 as a starting point for replicator hub.
Spoke_Length =  20; // [10:100]

/* [Bracket] */

// Use 50 for Replicator.
Bracket_Diameter = 50;  // [20:50]

// Use 10 for Replicator.
Bracket_Thickness = 10;

// Use 8 for Replicator.
Bracket_Depth = 8 ;

// in units of Bracket_Thickness. Use 1 for Replicator.
Bracket_Prong_Length = 1.0;  // [1,2,3,4]

/* [Hidden] */
     
Angular_Resolution = 0.1;
Octagon_Resolution = 45 ;
Decagon_Resolution = 36 ;

Plug_Height = 10;  // plug height
Plug_Hole_Width = 10;  // plug hole width
Plug_Wall_Thickness = 3;   // plug wall thickness
Plug_Taper = 0.5; // Plug_Taper of plug in mm
Plug_Clearance = 0.15; // Difference between plug and plughole diameters

Filiament_Hole = 4;  // Hole in bracket when storing filament.

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

print_part();

module print_part() {	
	if (part == "Hub") {
		Hub();
	} else if (part == "Spoke") {
		Spoke();
	} else {
		Bracket();
	}
}

module highlight(this_tab) {
  if (preview_tab == this_tab) {
    color("red") child(0);
  } else {
    child(0);
  }
}

module Hub() {

	Hole_Offset = Hub_Thickness*.5*-1;
	Plug_Offset = ((Centre_Hole_Diameter/2) + Plug_Height+1)*-1;  // Add 1 to offset for Repg <<<<<<<<<<<<<
	
// Spacer for Replicator.
	if (Hub_Type == "Replicator") {
		translate([0,0,Hub_Thickness-1]) tube(44,(Centre_Hole_Diameter+2)/2.0,1); // For inside ring.
	}

// Main Hub	
	difference() {
		tube(Hub_Thickness,(Centre_Hole_Diameter + 1 + (Plug_Height*2))/2.0,Plug_Height);  // Add 1 to radius for Repg <<<<<<<<<<<

// Radial Holes.
		union(){
			rotate([0,90,0]) translate([Hole_Offset,0,Plug_Offset])   plugHole();
			rotate([120,90,0]) translate([Hole_Offset,0,Plug_Offset])   plugHole();
			rotate([240,90,0]) translate([Hole_Offset,0,Plug_Offset])   plugHole();
		}
	}
}

module tube(height, radius, wall) {
	difference(){
		cylinder(height, radius, radius, $fa=Angular_Resolution);
		cylinder(height, radius-wall, radius-wall, $fa=Angular_Resolution);
	}
}

module octagontube(height, radius, wall) {
	difference(){
		cylinder(height, radius, radius, $fa=Octagon_Resolution);
		cylinder(height, radius-wall, radius-wall, $fa=Octagon_Resolution);
	}
}

module decagontube(height, radius, wall) {
	difference(){
		cylinder(height, radius, radius, $fa=Decagon_Resolution);
		cylinder(height, radius-wall, radius-wall, $fa=Decagon_Resolution);
	}
}

module plugHole() {
      cylinder(Plug_Height,Plug_Hole_Width/2,Plug_Hole_Width/2 - Plug_Taper,$fa=Octagon_Resolution);
}

module plug() {
      cylinder(Plug_Height,(Plug_Hole_Width-Plug_Clearance)/2,(Plug_Hole_Width-Plug_Clearance)/2 - Plug_Taper,$fa=Octagon_Resolution);
}

module Spoke() {
	difference() {
		union() {
  			octagontube(Spoke_Length,(Plug_Hole_Width+Plug_Wall_Thickness)/2,Plug_Wall_Thickness*2/2,$fa=Octagon_Resolution);
  			translate([0,0,Spoke_Length*0.99]) plug();
		}
		plugHole();
	}
}

module Bracket_Build(diameter, thickness, depth, length){

	difference() {

		union() {

// Build half a decagon tube as base for bracket.
			rotate([90,0,0])
			difference(){
				decagontube(thickness, diameter, depth) ;
				translate([diameter*-1,diameter*-1,0]) cube([diameter*2,diameter,thickness]);
			} 

// Extend Forks.
    			if (length > 1 ) {
				translate([diameter*-0.99,thickness*-1,thickness*(length-1)*-0.99]) cube([thickness*0.75,thickness,thickness*(length-1)]);
   	 			translate([diameter-(thickness*0.75),thickness*-1,thickness*(length-1)*-0.99]) cube([thickness*0.75,thickness,thickness*(length-1)]);
    			}

// Add rounded top to forks.
			rotate([90,0,0]) translate([diameter*-0.91,(thickness*(length-1)*-1) + (thickness*-0.10),0]) cylinder(thickness,thickness/2,thickness/2,$fa=Angular_Resolution);
			rotate([90,0,0]) translate([diameter*0.91,(thickness*(length-1)*-1) + (thickness*-0.10),0]) cylinder(thickness,thickness/2,thickness/2,$fa=Angular_Resolution);

// Add Plug to top.	
     		translate([thickness*-1,thickness*-1,diameter*0.95])cube([thickness*2,thickness,thickness/4]);
			translate([0,thickness/2*-1,diameter])plug();
		} // Union

// Insert filament holes.
		union() {
          	rotate([90,0,0]) translate([diameter*-0.91,(thickness*(length-1)*-1) + (thickness*-0.10),0]) cylinder(thickness,Filiament_Hole/2,Filiament_Hole/2,$fa=Angular_Resolution);
			rotate([90,0,0]) translate([diameter*0.91,(thickness*(length-1)*-1) + (thickness*-0.10),0]) cylinder(thickness,Filiament_Hole/2,Filiament_Hole/2,$fa=Angular_Resolution);
		}
	} //difference
}

module Bracket(){

	rotate([90,0,0]) translate([0,Bracket_Thickness,0]) Bracket_Build(Bracket_Diameter, Bracket_Thickness, Bracket_Depth, Bracket_Prong_Length);
}

