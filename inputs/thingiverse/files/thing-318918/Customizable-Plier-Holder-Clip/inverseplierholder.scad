// Customizable Plier Holder Clip

// Height of clip from top to bottom (not including mounting screw tab).
clip_height = 5;

// Width of clip arms (width of buffer around top edge of cutout).
clip_thickness = 6;

// Tool handle diameter (set slightly larger than actual diameter for easy fit).
handle_diameter = 12;

// Width of handle holder cutout at top surface of clip.
cutout_top_width = 45;

// Width of handle holder cutout at bottom surface of clip. Set less than top width to match slope to tool handle angle.
cutout_bottom_width = 38.2549;

// Width of opening in the front of the clip. Should typically be less than cutout width.
notch_width = 32;

// Diameter of mounting screw hole.
screw_diameter = 3.5;

// Width of tab surrounding mounting screw hole. 
screw_border = 4;

/* [Hidden] */

handle_radius = handle_diameter/2;
screw_radius = screw_diameter/2;
$fn = 60;

difference() {
	union() {
		difference() {
			Lozenge(clip_height, cutout_top_width, handle_radius + clip_thickness);

			HandleCutout();
			NotchOpening();
		}
		ScrewMount();
	}
	ScrewHole();
}

module ScrewMount() {
	translate([0, handle_radius+clip_thickness, screw_border + screw_radius])
	rotate([90, 0, 0])
	linear_extrude(height=clip_thickness)
	circle(r=screw_radius + screw_border);
}

module ScrewHole() {
	translate([0, handle_radius + clip_thickness + 1, screw_border + screw_radius])
	rotate([90, 0, 0])
	linear_extrude(height=clip_thickness+2)
	circle(r=screw_radius);
}

module NotchOpening() {
	translate([0, -(clip_thickness + handle_radius)/2, clip_height/2])
	cube([notch_width, clip_thickness + handle_radius, clip_height], center=true);
}

module HandleCutout() {
	hull() {
		translate([0, 0, clip_height])
		Lozenge(1, cutout_top_width, handle_radius);		
		Lozenge(1, cutout_bottom_width, handle_radius);
	}
}

module Lozenge(height, width, radius) {
	linear_extrude(height=height)
	hull() {
		translate([-width/2 + handle_radius, 0, 0]) circle(r=radius);
		translate([ width/2 - handle_radius, 0, 0]) circle(r=radius);
	}
}


