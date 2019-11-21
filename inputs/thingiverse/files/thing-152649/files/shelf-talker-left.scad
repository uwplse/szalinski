//Modified to put the bracket on the left of the lettering
// RLazure Sept 18, 2013

// Customizable Shelf Talker v1.0
// by TheNewHobbyist 2013 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:78727
//
// Explanation here
//
// Change Log:
//
// v1.0
// Initial Release
//

/////////////////////////
//  Customizer Stuff  //
///////////////////////

/* [Fit_and_Finish] */

// What would you like to label?
label_text = "fiction";

// How big?
font_size = 20; //[10:40]

// Want to space out that text?
letter_spacing = 1; // // [0.9:Tight,1:Default,1.5:Wide]

// Make it pretty
font = "write/Letters.dxf"; // ["write/BlackRose.dxf":Black Rose,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]

// Shelf thickness in mm
shelf_thickness = 20;

//For display only, not part of final model
build_plate_selector = 0; //[0:Replicator 2/2X,1: Replicator,2:Thingomatic,3:Manual]

// "Manual" build plate X dimension
build_plate_manual_x = 100; //[100:400]

// "Manual" build plate Y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south, tilt:top]

/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

use <write/Write.scad>
use <utils/build_plate.scad>	

width = (.6875*font_size*letter_spacing); // Find width of each character
totalwidth = width * (len(label_text) - 1); // Find total width of text

/////////////////////////
// Build Shelf Talker //
///////////////////////

module full_talker() {
	union() {
		translate([-3,0,0]) write(label_text,h=font_size,t=3,font=font, space=letter_spacing);
		translate([0,-1.5,0]) cube([totalwidth+15, 3, 3]);
		rotate([0,180,0]) translate([-20,shelf_thickness * -1 - 3,-20]) cube([2, shelf_thickness + 3, 20]);
		rotate([0,180,0]) translate([-20,shelf_thickness * -1 - 3,-20]) rotate([0,0,5]) cube([25, 2, 20]);
		rotate([0,180,0]) translate([-20,-1.5,-20]) cube([20, 3, 20]);
		}
}

//totalwidth - 5
//////////////////////////////
// Center part on platform //
////////////////////////////

translate([totalwidth / -2,font_size + shelf_thickness / -2,0]) full_talker();
