// Customizable Plier Holder
// preview[view:south]

// Thickness of hangar, base, and brace (if enabled).
plate_thickness = 4;

// Diameter of hole in hangar.
hole_diameter = 3.3;

// Size of border around hangar hole.
top_margin = 5;

// Size of border in front of handle hole.
front_margin = 3;

// Height from bottom of base to top of hangar.
total_height = 35;

// Handle hole diameter. Set slightly larger than actual tool handle diameter.
handle_diameter = 12;

// Distance between handle holes. Measured from inner edges.
handle_spacing = 25; 

// Distance between hangar and handle holes. Increase to permit more clearance between tool and hangar.
handle_clearance = 2;

// If enabled, include a brace between the hangar and the base.
reinforce = 1; // [0:Disabled, 1:Enabled]

/* [Hidden] */

hole_radius = hole_diameter / 2;
handle_radius = handle_diameter / 2;
base_width = handle_diameter + handle_spacing;
base_depth = handle_diameter + front_margin + handle_clearance;
hole_height = total_height - top_margin - hole_radius;
$fn = 30;


union() {
	Hangar();
	Base();
	if (reinforce == 1) {
		Brace();
	}
}

module Brace() {
	assign(
			size = min(hole_height - hole_radius - plate_thickness - top_margin,
			base_depth)) {
		// - 0.0001 is a stupid fudge to circumvent some coincident plane issue
		translate([plate_thickness / 2, 0, plate_thickness - 0.0001])
		rotate([0, -90, 0])
		linear_extrude(height=plate_thickness)
		difference() {
			square([size, size]);
			translate([size, size]) circle(r=size, $fn=36);
		}	
	}
}

module Hangar() {
	rotate([90, 0, 0])
	linear_extrude(height=plate_thickness)
	difference() {

		hull() {
			translate([0, hole_height, 0])
			circle(r=hole_radius + top_margin);
	
			translate([-base_width/2, 0, 0])
			square([base_width, plate_thickness]);
		}
	
		translate([0, hole_height, 0])
		circle(r=hole_radius);
	}
}

module Base() {
	linear_extrude(height=plate_thickness)
	difference() {	
		translate([-base_width/2, 0, 0])
		square([base_width, base_depth]);	

		translate([-base_width/2, handle_clearance + handle_radius, 0])
		circle(r=handle_diameter / 2);

		translate([base_width/2, handle_clearance + handle_radius, 0])
		circle(r=handle_diameter / 2);
	}
}