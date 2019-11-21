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
//		3) Insert the third spoke/bracket set into the spool of
//			filament and then tilting the hub up slightly insert
//			into the final plug hole on the hub.
//
//	You should print Brackets with support (for the plug).
//	You should print Hubs with support (for the plug holes). NO, non è necessario!
//	Print Spokes vertically at 100% - NO support is best. Horizontally
//		printed spokes will split.
// 
// Original Author: shaunp
// Url: https://www.thingiverse.com/thing:62710
//
// This version: https://www.thingiverse.com/thing:3079677

/* [Global] */

// Which part are you going to build?
part = "Bracket"; // [Hub:Hub, Spoke:Spoke, Bracket:Bracket]

/* [Hub] */

// Hub: Internal diameter
Centre_Hole_Diameter = 35; // [20:80]

// Hub: Thickness (width of surface with plug holes)
Hub_Thickness = 15; // [15:50]

/* [Spoke] */

// Use 20 as a starting point for replicator hub.
Spoke_Length =  30; // [10:100]

/* [Bracket] */

// Bracket: diameter of the (circumscribed circle of the) external decagon
Bracket_Diameter = 80;  // [40:100]

// Bracket:
Bracket_Arc = 165; // [36:324]

// Bracket: width of external surface
Bracket_Thickness = 10;

// Bracket: thickness (between internal and external surfaces)
Bracket_Depth = 8 ;

// Bracket: vertical prolong 
Bracket_Prong_Length = 3;

/* [Hidden] */
     
Angular_Resolution = 0.1;
Octagon_Resolution = 45 ;
Decagon_Resolution = 36 ;

Plug_Height = 10;  // plug height
Plug_Hole_Width = 10;  // plug hole width
Plug_Wall_Thickness = 3;   // plug wall thickness
Plug_Taper = 0.5; // Plug_Taper of plug in mm
Plug_Clearance = 0.10; // Difference between plug and plughole diameters

Filiament_Hole = 2.8;  // Hole in bracket when storing filament.

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
    // Add 1 to offset for Repg <<<<<<<<<<<<<
	Plug_Offset = ((Centre_Hole_Diameter/2) + Plug_Height+1)*-1;  

    // Main Hub	
	difference() {
        // Add 1 to radius for Repg <<<<<<<<<<<
		tube(Hub_Thickness,(Centre_Hole_Diameter + 1 + (Plug_Height*2))/2.0,Plug_Height);  

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
		cylinder(height, r=radius, $fa=Angular_Resolution);
		cylinder(height, r=radius-wall, $fa=Angular_Resolution);
	}
}

module octagontube(height, radius, wall) {
	difference(){
		cylinder(height, r=radius, $fa=Octagon_Resolution);
		cylinder(height, r=radius-wall, $fa=Octagon_Resolution);
	}
}

module decagontube(height, radius, wall) {
	difference(){
        // Crea un cilindro decagonale centrato nel piano XY, di altezza height
		cylinder(height, r=radius, $fa=Decagon_Resolution);
		cylinder(height, r=radius-wall, $fa=Decagon_Resolution);
	}
}

function decagonXoffset(radius, angle) =
    let(
        dAlpha = (angle - 18) % 36,
        d = radius * (1 - (tan(72) / (sin(dAlpha) + (cos(dAlpha)*tan(72))))),
        beta = (1 + floor((angle - 18) / 36)) * 36, // Angle of the current decagon side
        offset = d * (sin(angle) + cos(angle) / tan(beta))
    ) (radius * sin(angle)) - offset;

module plugHole() {
      cylinder(Plug_Height, Plug_Hole_Width/2, Plug_Hole_Width/2 - Plug_Taper, fa=Octagon_Resolution);
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

module Bracket_Build(diameter, height, thickness, arc, extend){
    if (diameter < 36) {
        diameter = 36;
    } else if (diameter > (360 - 36)) {
        diameter = 360 - 36;
    }
    radius = diameter / 2; // radius is guaranteed between 18 and 162
    
    // Magical math calculations!
    offsetY = radius * abs(cos(arc/2));
    offsetExt = decagonXoffset(radius, arc / 2);
    offsetInt = decagonXoffset(radius - thickness, acos(radius * cos(arc / 2) / (radius - thickness)));
    offsetMid = (offsetInt + offsetExt) / 2;
    
    difference() {
        union() {
            // Build an arc of a decagon tube as base for bracket.
            difference(){
                translate([0, offsetY, 0]) decagontube(height, radius, thickness);        
                translate([-radius, 0, 0]) cube([diameter, diameter, height]);
            } 
            
            // Extend Forks.
            if (extend > 0 ) {
                translate([offsetInt, 0, 0]) cube([offsetExt - offsetInt, extend, height]);
                translate([-offsetExt, 0, 0]) cube([offsetExt - offsetInt, extend, height]);
            }
            
            // Add rounded top to forks.
            translate([offsetMid, extend, 0]) cylinder(height, r=thickness*0.55, $fn=36);
            translate([-offsetMid, extend, 0]) cylinder(height, r=thickness*0.55, $fn=36);
            
            // Add Plug.	
            translate([-height, offsetY - radius, 0]) cube([height*2, height/4, height]);
            translate([0, offsetY - radius, height/2]) rotate([90, 0, 0]) plug();
        } // union
        
        // Insert filament holes.
        union() {
            translate([offsetMid, extend, 0]) cylinder(height, r=Filiament_Hole/2, $fn=36);
            translate([-offsetMid, extend, 0]) cylinder(height, r=Filiament_Hole/2, $fn=36);
        }
    } // difference
}

module Bracket(){
	Bracket_Build(Bracket_Diameter, Bracket_Thickness, Bracket_Depth, Bracket_Arc, Bracket_Prong_Length);
}

