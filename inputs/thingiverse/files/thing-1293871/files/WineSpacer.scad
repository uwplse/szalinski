// Remember to render (F6) before exporting!!

// This file contains definition for both cradle and connector,
// as there are dependencies between definitions of both parts.

// Parameters, in Makerbot's Customizer format:

// (mm)
bottle_spacing = 100;

// The gap/tolerance between connector pegs and the cradle (mm)
connector_cradle_tolerance = 0.5;

// The space between connector and cradle when rendering for multi-part printing (mm)
connector_cradle_spacing = 30;

/* [Hidden] */
$fs=.1;
$fa=1;

base_height = 2; // z thickness of the base plate
cradle_length = 100; // x length of the base plate and wedges
wedge_height = 5.8; // z height of each wedge above the top of the base plate
wedge_width = 11;
wedge_separation = 18; // y distance between the inner wedge tips
connector_peg_width = 12; // x size, needs to be less than cradle_length
connector_peg_depth = 3; // y size, needs to be less than wedge_width
connector_peg_xs = [20, cradle_length-20]; // x locations of the connector pegs' centres
connector_bridge_height = 3; // z height, needs to be less than the connector peg's max height

// Cache some oft-used calculations
cradle_height = base_height + wedge_height;
cradle_width = (2*wedge_width) + wedge_separation; // along y axis
peg_inner_y = (wedge_width-connector_peg_depth)/2 +connector_peg_depth; // y coord of peg's inner face

module non_connectable_cradle() {
	// Create the cradle as a linear extrusion of a profile polygon.
	// It is 2 opposing wedges, with a flat platform to join them.
	// This does not include slots for joining cradles together.
	total_width = (2*wedge_width) + wedge_separation;
	rotate([0,90,0])
	linear_extrude(height=cradle_length, center=false, convexity=10, twist=0)
	polygon(points=[[0,0],[0,total_width],[-cradle_height,total_width],[-base_height,total_width-wedge_width],[-base_height,wedge_width],[-cradle_height,0]], convexity=4);
}

module slot_pegs_side1(offset) {
	peg_y = (wedge_width-connector_peg_depth)/2 - offset;
	rod_len = peg_y + connector_cradle_tolerance + 0.2; // add .2 so rod protrudes into peg and connector
	rod_height = connector_bridge_height + offset;
	
	for(x=connector_peg_xs)
	union() {
		// Rod that will join the connector to the slot peg.
		// It's triangular (vs square or spherical) so that the overhang
		// on the cradle part is printable via FDM.
		translate([0, -connector_cradle_tolerance-0.1, 0])
		rotate([-90, 0, 0])
		linear_extrude(height=rod_len, center=false, convexity=10, twist=0)
		polygon(points=[[x-rod_height,0], [x,-rod_height], [x+rod_height,0], [x+rod_height,offset], [x-rod_height,offset]], convexity=1);
		
		// Intersect with cradle to prevent the peg from protruding higher than the wedge surface.
		slot_x = x - (connector_peg_width/2) - offset;
		translate([slot_x, peg_y, -offset]) 
		cube([connector_peg_width + 2*offset, connector_peg_depth + 2*offset, cradle_height + 2*offset]);
	}
}

module slot_pegs_side2(offset) {
	y_trans =
		peg_inner_y + offset // move to x axis after mirror operation
		+ cradle_width - (peg_inner_y + offset);
	translate([0,y_trans,0])
	mirror([0,1,0]) // mirror about x/z axis (y=0)
	slot_pegs_side1(offset);
}

module connector() {
	jbh = connector_bridge_height; // abbreviate
	cradle_separation = bottle_spacing - cradle_width;
	bridge_length = cradle_separation - (2*connector_cradle_tolerance); // y size
	bridge_width = max(connector_peg_xs) - min(connector_peg_xs) + (2*jbh); // x size
	bridge_x = min(connector_peg_xs) - jbh;
	
	// Trim pegs down to the same height as the bridge,
	// because FDM printing can't neatly print the 4 protrusions.
	difference() {
		slot_pegs_side1(0);
		translate([0,0,jbh]) cube([cradle_length, cradle_width, cradle_height]);
	}
	
	translate([0, -bottle_spacing, 0]) 
	difference() {
		slot_pegs_side2(0);
		translate([0,0,jbh]) cube([cradle_length, cradle_width, cradle_height]);
	}
	
	translate([bridge_x, -bridge_length-connector_cradle_tolerance, 0]) 
	// Remove inner, creating 4 walls to the connector, to save material.
	difference() {
		cube([bridge_width, bridge_length, jbh]);
		
		translate([2*jbh, 2*jbh, -1])
		cube([bridge_width - 4*jbh, bridge_length - 4*jbh, jbh+2]);
	}
}

module connectable_cradle() {
	difference(){
		non_connectable_cradle();
		
		// Expand the connector shape to allow the printed shapes to fit
		// in the event of sloppy printing.
		slot_pegs_side1(connector_cradle_tolerance);
		slot_pegs_side2(connector_cradle_tolerance);
	}
}



// Render cradle and connector with sufficient spacing that permits sequential printing.
connectable_cradle();

translate([0, -peg_inner_y-connector_cradle_spacing, 0])
connector();