// Customizable RAM Mount Phone Clip

/* [Options] */

// Select which part to display.
part = "both"; // [horizontal:Horizontal Clip, vertical:Vertical Clip, both:Complete Assembly]

// Cutouts for iPhone 5c sleep button, flash, and power connector. Assumes default dimensions.
iphone_tweaks = 1; // [0:Disabled, 1:Enabled]

// Wavy cutouts in vertical clip to increase flexibility for insertion and removal. Assumes default dimensions.
flex_ridges = 1; // [0:Disabled, 1:Enabled]

/* [Phone] */

// Controls size of horizontal clip. (mm)
phone_width = 60;

// Controls size of vertical clip. (mm)
phone_height = 125;

// Phone thickness; controls size of arms on both clips. (mm)
phone_depth = 9;

/* [Clips] */

// Minimum thickness of clips. Clips are twice as thick where they cross. (mm)
clip_thickness = 4;

// Clip height, as oriented for printing. (mm)
clip_width = 20;

// Size of grips on front face of phone. Top grip is rounded to ease phone insertion and removal. (mm)
grip_width = 3;

// Enable grips on horizontal cross clip. This holds the phone more securely but makes insertion and removal more difficult.
cross_grips = 0; // [0:Disabled, 1:Enabled]

// Location of horizontal cross clip relative to center of vertical clip. Also controls location of mounting holes. (mm)
cross_offset = -10;

// Sandwich horizontal cross clip between vertical clip and which object?
cross_side = 1; // [0:Phone, 1:Mounting Bracket]

// Fudge factor added to size of assembly notches on each clip. (mm)
cross_tolerance = 0.5;

/* [Mount] */

// Spacing between center of mounting holes. Holes are centered where clips cross. (mm)
bolt_spacing = 48;

// Diameter of bolt holes. (mm)
bolt_diameter = 4.8;

// Diameter of recess for bolt heads. (mm)
head_diameter = 10;

/* [Hidden] */

bolt_radius = bolt_diameter/2;
head_radius = head_diameter/2;
bolt_offset = bolt_spacing/2;
$fn = 30;


SelectPart();

module SelectPart() {
	if (part == "horizontal") {
		translate([0, 0, clip_width/2-cross_offset])
		HorizontalClip();
	}
	else if (part == "vertical") {
		translate([0, 0, clip_width/2])
		rotate([0, -90, 0])
		VerticalClip();
	}
	else {
		VerticalClip();
		HorizontalClip();
	}
}

function hnotch_depth(side) = (side == 0 ? clip_thickness*2 - cross_tolerance : cross_tolerance);
function vnotch_depth(side) = (side == 0 ? cross_tolerance : clip_thickness*2 - cross_tolerance);

// clip that spans the phone's width; sandwiched between vertical clip and RAM socket.
module HorizontalClip() {
	translate([0, 0, cross_offset])
	difference() {
		
		hull() {
			// main clip
			cube([phone_width + (2 * clip_thickness), phone_depth + (2 * clip_thickness), clip_width], center=true);
			
			// back plate (x width *2 is arbitrary!)
			translate([0, phone_depth/2 + clip_thickness*3/2, 0])
			cube([(clip_width + phone_width) / 2, clip_thickness, clip_width], center=true);
		}
		
		PhoneBlock();
		FacePlate(cross_grips);
		
		// notch for vertical clip - not a clean cut in preview
		translate([0, phone_depth/2 + hnotch_depth(cross_side), 0])
		cube([clip_width+ (cross_tolerance*2), clip_thickness*2, clip_width*2], center=true); // y*2, z*2 for clean cut
	}
}

// clip that spans the phone's height; has bolt holes for RAM socket.
module VerticalClip() {
	
	// rounded nubbin for top attachment
	translate([0, -phone_depth/2 - clip_thickness/2, phone_height/2 - grip_width + clip_thickness/2])
	rotate([0, 90, 0])
	cylinder(h=clip_width, r=clip_thickness/2, center=true);
	
	difference() {
		
		hull() {
			// main clip
			cube([clip_width, phone_depth + (2 * clip_thickness), phone_height + (2 * clip_thickness)], center=true);
			// back plate
			translate([0, phone_depth/2 + clip_thickness*3/2, cross_offset]) cube([clip_width, clip_thickness, bolt_spacing + clip_width], center=true);
		}

		PhoneBlock();
		FacePlate();
		BoltHoles();
		
		// trim a bit from the top grip - we'll use the rounded nubbin instead
		translate([0, -phone_depth/2-clip_thickness/2, phone_height/2-grip_width])
		cube([clip_width + 2, clip_thickness+1, clip_thickness], center=true);
		
		// notch for horizontal clip
		translate([0, phone_depth/2 + vnotch_depth(cross_side), cross_offset])
		cube([clip_width*2, clip_thickness*2, clip_width + (cross_tolerance*2)], center=true); // x*2, y*2 for clean cut
		
		
		if (iphone_tweaks == 1) {
			PlugHole();
			ButtonHole();
			FlashHole();
		}
		
		if (flex_ridges == 1) {
			FlexCuts();
		}
	}
}

module FlexCuts() {
	FlexCut();
	translate([0, 0, 8]) FlexCut();
	translate([0, 0, 16]) FlexCut();
	translate([0, clip_thickness*2, 4]) FlexCut();
	translate([0, clip_thickness*2, 12]) FlexCut();
	translate([0, clip_thickness*2, 20]) FlexCut();
}

module FlexCut() {
	translate([0, phone_depth/2, cross_offset + (bolt_spacing/2) + (clip_width/2)])
	rotate([0, 90, 0])
	cylinder(h=clip_width+2, r=3, center=true);
}

module BoltHoles() {
	translate([0, 0, cross_offset + bolt_offset]) BoltHole();
	translate([0, 0, cross_offset - bolt_offset]) BoltHole();
}

module BoltHole() {
	union() {
		// bolt hole
		translate([0, phone_depth/2 + clip_thickness, 0])
		rotate([90, 0, 0])
		cylinder(r=bolt_radius, h=clip_thickness*3, center=true);
		
		// recess for bolt head
		translate([0, phone_depth/2, 0])
		rotate([90, 0, 0])
		cylinder(r=head_radius, h=clip_thickness*2, center=true);
	}
}

// cutout for sleep/power button at top of vertical clip
module ButtonHole() {
	assign(button_width=14, button_depth=6, button_x=14.5) {
		translate([button_x, 0, phone_height/2 + clip_thickness/2])
		linear_extrude(height=clip_thickness * 2, center=true) // *2 for clean cut
		hull() {
			translate([-(button_width - button_depth) / 2, 0, 0]) circle(r=button_depth/2);
			translate([(button_width - button_depth) / 2, 0, 0]) circle(r=button_depth/2);
		}
	}
}

// cutout for power connector, assumed to be centered at bottom of phone
module PlugHole() {
	assign(plug_width=12, plug_depth=6) {
		translate([0, 0, -phone_height/2-clip_thickness/2])
		linear_extrude(height=clip_thickness * 2, center=true) // *2 for clean cut
		hull() {
			translate([-(plug_width - plug_depth) / 2, 0, 0]) circle(r=plug_depth/2);
			translate([(plug_width - plug_depth) / 2, 0, 0]) circle(r=plug_depth/2);
		}
	}
}

// cutout for flash on top back of vertical clip
module FlashHole() {
	assign(innerd = 7, outerd = 14, offset_x = 11, inset_y = 7.5) {
		
		// just for clean cut
		translate([offset_x, phone_depth/2, phone_height/2 - inset_y])
		rotate([90, 0, 0])
		cylinder(h = clip_thickness, r = innerd/2, center=true);

		translate([offset_x, phone_depth/2 + clip_thickness, phone_height/2 - inset_y])
		rotate([-90, 0, 0])
		cylinder(h = clip_thickness * 2, r1 = innerd/2, r2 = outerd/2, center=true);
	}
}

// mockup model of phone used to delete space from clips
module PhoneBlock() {
	cube([phone_width, phone_depth, phone_height], center=true);
}

// area in front of phone that is deleted from clips for front opening
module FacePlate(grips=1) {
	translate([0, -phone_depth/2 - clip_thickness/2, 0])
	cube([	phone_width - (grips == 1 ? (2 * grip_width) : 0 /*- clip_thickness*3*/),
			clip_thickness * 2, // *2 is excess for clean cut
			phone_height - (grips == 1 ? (2 * grip_width) : 0 /*- clip_thickness*3*/)], center=true);
}
