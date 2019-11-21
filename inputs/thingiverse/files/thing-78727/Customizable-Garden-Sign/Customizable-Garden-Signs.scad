// Customizable Garden Sign v1.0
// by TheNewHobbyist 2013 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:78727
//
// This is a derivative of paulhoover's (http://www.thingiverse.com/paulhoover)
// Vegetable garden signs (http://www.thingiverse.com/thing:78340).
//
// This doesn't have quite as much style as Paul's but it seemed like something
// that would bennifit from being customizer enabled. 
//
// Change Log:
//
// v1.0
// Initial Release
//

/////////////////////////
//  Customizer Stuff  //
///////////////////////

/* [Let's grow something awesome] */

// What are we planting?
label_text = "Seeds";

font = "write/Letters.dxf"; // ["write/BlackRose.dxf":Black Rose,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]

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

translate([len(label_text) * 14.5/-2,0,0]) {
	difference() {
	union() {
		write(label_text,h=20,t=3,font=font, space=.9);
		translate([0,-1.5,0]) cube([len(label_text) * 12, 3, 3]);
		translate([5,-35,0]) cube([2, 35, 3]);
		translate([len(label_text) * 12 - 7.5,-35,0]) cube([2, 35, 3]);
		}
	translate([-1,-35,0]) rotate([45,0,0]) cube([10, 10, 10]);
	translate([len(label_text) * 12 - 14,-35,0]) rotate([45,0,0]) cube([10, 10, 10]);
	}
}