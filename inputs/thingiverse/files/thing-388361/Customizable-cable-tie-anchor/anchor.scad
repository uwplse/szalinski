// Parameterizable cable tie anchor
// Ned Konz, ned@bike-nomad.com

// max. diameter of wire bundle, mm
wire_diameter = 10;
// width of cable tie, mm
tie_width = 3.4;
// thickness of cable tie, mm
tie_thickness = 1.5;
// wire to slot ID, mm
slot_spacing = 4;
// additional space on top and bottom of tie, mm
vertical_tolerance = 1.5;
// additional space at sides of tie, mm
horizontal_tolerance = 0.5;

/* [Hidden] */
// width of slot for cable tie
slot_width = tie_width + 2 * horizontal_tolerance;
// height of slot for cable tie
slot_height = tie_thickness + 2 * vertical_tolerance;
slot_id = wire_diameter + slot_spacing * 2;
slot_od = slot_id + 2 * slot_height;
block_side = wire_diameter * 2.5;
block_height = slot_od * 0.8;

$fn = 32;

module slot(diameter,height,width) {
	difference() {
		cylinder(h=width, d=diameter + height, center=true);
		cylinder(h=width, d=diameter, center=true);
	}
}

module block(side,height) {
	s2 = side / 2;
	polyhedron(
  points=[ [s2,s2,0],[s2,-s2,0],[-s2,-s2,0],[-s2,s2,0], // the four points at base
           [0,0,height]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );
}

difference() {
	translate([0,0,-block_height/2])
		block(block_side, block_height);
	rotate([90,0,0])
		slot(slot_id, slot_height, slot_width);
	rotate([90,0,0])
		cylinder(h=block_side, d=wire_diameter, center=true);
	translate([0,0,block_side/2])
		cube(block_side * 1.1, center=true);
	
}