include <MCAD/units.scad>
include <MCAD/shapes.scad>

// Created by frontier204 for Thingiverse
// July 2014

// Thickness of the walls between the holes and the item
wall_thickness = 5;			// [3:10]
// Diameter of the tube
tube_diam = 44.064;
// The diameter of the item to be mounted
mount_diam = 16.75;
// Air gap between the tube and the item to mount, in case there are things like cables to clear, in X
cable_clearance_x = 9.525;
// Air gap in y
cable_clearance_y = 22.225;
// The gap to make this into two pieces
gap_width = 1;
// How high the entire structure is
mount_height = 25.4;
// diameter of the screw holes if you want to be able to thread the screw
screw_hole_diam = 3.175;
// diameter of the screw holes for a free fit
screw_hole_diam_big = 4.365;
// diameter of the head of the screws
screw_head_diam = 6.35;
// big number to just clear everything
BIG_NUMBER = 10000*1;

// creates this, centred where the tube goes, and extends in +X

item();

module item() {
// where the screws closest to the tube will go
top_screws_offset = -(tube_diam/2 + wall_thickness*2 + screw_head_diam/2);
//where the mount goes
mount_offset = top_screws_offset - screw_head_diam/2 - wall_thickness - mount_diam/2;
// the size of the mount nearest the mount, which sticks in by one wall
// thickness
neartube_mount_size = wall_thickness*3+screw_head_diam;
// the size of the box between the tube and the mount
midway_box_x = wall_thickness*2+screw_head_diam + cable_clearance_x/2; 
// where the screws go near the cable clearance box
midway_screws_offset = tube_diam/2 + cable_clearance_x + wall_thickness + screw_head_diam/2;

difference() {
	union() {
		// main wall around the tube
		cylinder(r=tube_diam/2+wall_thickness, h=mount_height, $fn=256);
		// mount for screws closest to the tube
		translate([-(neartube_mount_size/2+tube_diam/2),0,mount_height/2])
		box(neartube_mount_size,wall_thickness*2,mount_height);
		// reinforcements
		translate([-(tube_diam/2+wall_thickness/2),0,mount_height/2])
		hexagon(wall_thickness*3,mount_height);
		// box between the gap and the thing to mount (midway mount)
		translate([tube_diam/2 + midway_box_x/2, 0, mount_height/2])
		box(midway_box_x, cable_clearance_y+wall_thickness*2, mount_height);
		// reinforcements
		translate([tube_diam/2-wall_thickness/2 + midway_box_x + screw_head_diam/2, 0, 0])
		scale([cable_clearance_y/tube_diam,1,1])
		cylinder(r=(wall_thickness*2+cable_clearance_y)/2, h=mount_height, $fn=16);
		// main wall around the thing to mount
		translate([mount_offset,0,0])
		cylinder(r=mount_diam/2+wall_thickness,h=mount_height, $fn=256);
	}
	// hole for the tube
	cylinder(r=tube_diam/2, h=BIG_NUMBER, $fn=256, center=true);
	// screw holes near the tube
	translate([top_screws_offset,0,0])
	alternating_screw_holes();
	// the cable clearance gap
	translate([tube_diam/2,0,0])
	box(wall_thickness, cable_clearance_y, BIG_NUMBER);
	translate([(tube_diam+cable_clearance_x)/2,0,0])
	box(cable_clearance_x, cable_clearance_y, BIG_NUMBER);
	// screw holes near the gap
	translate([midway_screws_offset,0,0])
	alternating_screw_holes(-1);
	// thing to mount hole
	translate([mount_offset,0,0])
	cylinder(r=mount_diam/2,h=BIG_NUMBER,center=true, $fn=256);
	// gap
	box(BIG_NUMBER, gap_width, BIG_NUMBER);
}

module alternating_screw_holes( alternate_factor = 1 ) {
	translate([0,0,mount_height*1/4]) {
		rotate([90,0,0])
		hexagon(screw_hole_diam, BIG_NUMBER);
		translate([0,alternate_factor*BIG_NUMBER/2,0])
		rotate([90,0,0])
		hexagon(screw_hole_diam_big, BIG_NUMBER);
	}
	translate([0,0,mount_height*3/4]) {
		rotate([90,0,0])
		hexagon(screw_hole_diam, BIG_NUMBER);
		translate([0,alternate_factor*-BIG_NUMBER/2,0])
		rotate([90,0,0])
		hexagon(screw_hole_diam_big, BIG_NUMBER);
	}
}

}