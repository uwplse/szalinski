// super simple feet for metal shelving
// Created 2017 Clinton Ebadi <clinton@unknownlamer.org>

// Released under the https://wiki.creativecommons.org/wiki/CC0
// To the extent possible under law, Clinton Ebadi has waived all
// copyright and related or neighboring rights to super simple feet
// for metal shelving.


// preview[view:east, tilt:top diagonal]

// Length of slot for shelving leg
slot_length = 32;
// Thickness of slot for shelving leg
slot_thickness = 1.8;

// Thickness of wall around slot
wall_thickness = 3;

// Depth of the base foot
base_depth = 4;
// Depth of the slot and walls around the length
slot_depth = 20;
// Offset for leg slot into the base
slot_offset = -1;

$fs = 0.1;

foot ();

module base () {
    side = slot_length + slot_thickness/2;
    offset (r = wall_thickness) polygon ([ [0, 0], [ side , 0], [0, side] ]);
}

module walls () {
     intersection () {
	  offset (r = wall_thickness) {
	       square ([slot_thickness, slot_length + slot_thickness/2]);
	       square ([slot_length + slot_thickness/2, slot_thickness]);
	  }
	  base ();
     }
}

module slot () {
     square ([slot_thickness, slot_length]);
     square ([slot_length, slot_thickness]);

     // tiny chamfer around bend
     x = 2;
     polygon ([ [0, 0], [ slot_thickness*2+x/2, 0], [0, slot_thickness*2+x/2] ]);
}


module foot () {
     difference () {
	  union () {
	       linear_extrude (base_depth) base ();
	       translate ([0, 0, base_depth+slot_offset]) linear_extrude (slot_depth+slot_offset) walls ();
	  }
	  translate ([0, 0, base_depth+slot_offset]) linear_extrude (slot_depth+slot_offset+0.1) slot ();
     }
}
