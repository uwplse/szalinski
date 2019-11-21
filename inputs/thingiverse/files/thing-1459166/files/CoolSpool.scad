// -----------------------------------------------------------------------------------------
// Spool to hold filament
// Units are in mm
// Marshall Huss
// -----------------------------------------------------------------------------------------

// Cylinder fragments
$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

// Choose what you want to generate
enable_spool			= 1;
enable_supports			= 1;

// Outer spool
spool_height 			= 43;
spool_diameter 			= 90;	
spool_thickness 		= 1;

// Inner spool
spool_inner_diameter	= 54;

// Support pieces
//
// How many supports on each side, they'll be placed equidistance around the spool
num_supports			= 3;
// How wide the support should be
support_width			= 10;
// Size of the screw hole, default of 1.9mm fits a #2 screw. Change to 0 for no hole.
screw_size				= 1.9;
// Slot width
slot_height				= 2;
// Slot tolerance for push-to-fit
tolerance				= 0.25;

// Support arms
// How long the support arms should be
support_arm_length		= 50;

// Convienance vars
spool_height_with_tolerance = spool_height + tolerance;

// How long the support should be to connect to both the inner and outer spools
support_length 				=  (spool_diameter - spool_inner_diameter) / 2;

// How far the support should be away from the origin
support_x_offset			= spool_inner_diameter/2 + support_length/2 - spool_thickness/2;

// -----------------------------------------------------------------------------------------
// Center Spool
// This is designed to be two cylinders that are connected via some support pieces
// -----------------------------------------------------------------------------------------

// Cylinder with center removed
module spool(height, width, thickness) {
	difference() {
		radius = width / 2;
		cylinder(height, radius, radius);
		translate([0, 0, -1]) {
			cylinder(height + 2, radius - thickness, radius - thickness);
		}
	}
}

// Support piece
module support() {
	difference() {
		width = support_length;
		
		// Support triangle, generates a 45deg angle
		linear_extrude(support_width) {
			polygon(points=[[-width/2, 0], [width/2, 0], [width/2, width]]);
		}
		
		// Screw hole
		translate([0, width/2, support_width/2]) {
			rotate([0, 90, 90]) {
				cylinder(30, screw_size, screw_size, center = true);
			}
		}
		
		// Slot for the supports
		slot_size = slot_height + tolerance;
		translate([width/2 - slot_size - spool_thickness, -1, support_width/2]) {
			cube([slot_size + 1, width + 1, support_width], center = false);
		}
	}
}

// Create and orient support piece
module create_support() {
	translate([0, -support_width/2, 0]) {
		rotate([90, 0, 180]) {
			support();
		}
	}
}

// Supports for the bottom of the spool
module bottom_supports(num = num_supports) {
	for (i = [1:num]) {
		rotate([0, 0, 360/num * i]) {
			translate([-support_x_offset, 0, 0]) {
				create_support();
			}
		}
	}
}

// Mirror bottom supports and orient for the top of the spool
module top_supports() {
	translate([0, 0 , spool_height]) {
		mirror([0, 0, 45]) {
			bottom_supports();
		}
	}
}

// Build the spool with supports
module generate_spool() {
	// Build the entire spool
	union() {
		// Outer spool
		spool(spool_height, spool_diameter, spool_thickness);
		// Inner spool
		spool(spool_height, spool_inner_diameter, spool_thickness);
		// Bottom supports
		bottom_supports();
		// Top support
		top_supports();
	}	
}


// -----------------------------------------------------------------------------------------
// Support arms
// These are push-to-fit arms that keep the filament from sliding off the spool
// -----------------------------------------------------------------------------------------

module support_base() {
	cube([slot_height, spool_height_with_tolerance, support_width], center = false);
}

module support_arm() {
	cube([support_arm_length, slot_height, support_width], center = false);
}

module support_slot() {
	width = spool_height - tolerance*2;
	translate([-1, tolerance, support_width/2]) {
		cube([slot_height+2, width, support_width], center = false);
	}
}

module support_complete() {
	union() {
		support_base();
		translate([0, -slot_height, 0]) {
			support_arm();
		}
		translate([0, spool_height_with_tolerance, 0]) {
			support_arm();
		}
	}	
}

module generate_supports() {
	difference() {
		support_complete();
		support_slot();
	}	
}


// -----------------------------------------------------------------------------------------
// Put it all together
// -----------------------------------------------------------------------------------------


// Geneate the spool
if (enable_spool) {
	echo("Generating spool...");
	generate_spool();	
}

// Generate supports
if (enable_supports) {
	echo("Generating supports...");
	translate([(enable_spool ? 50 : 0), 0, 0]) {
		generate_supports();
	}
}
