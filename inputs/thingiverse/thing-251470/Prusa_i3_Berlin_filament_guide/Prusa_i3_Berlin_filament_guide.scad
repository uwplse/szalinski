// Customizable filament guide designed for Prusa i3 Berlin (solid metal frame)

// Michael Ang
// @mangtronix
// 16.02.2014

// Copyright (C) 2014 Michael Ang
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// Additionally:
// This work by Michael Ang is licensed under a Creative Commons
// Attribution-ShareAlike 4.0 International License.

/* [Basic] */
// Adjust to get a tight fit.
frame_thickness = 6;
// Horizontal distance in mm.
guide_x = 45;
// Vertical distance in mm.
guide_y = 35;
// Diameter of the guide opening.
inner_diameter = 15;
// Which side is your spool on?
side = 0; // [0:Left,1:Right]

/* [Advanced] */
grip_depth = 18;
grip_opening_height = 20;
grip_wall_thickness = 4;
filament_guide_depth = 4;
filament_guide_wall_width = 3;
filament_guide_notch_width = 2;
arm_width = 8;
arm_depth = 4;

// Thingiverse customizer
// preview[view:south, tilt:top]
use <utils/build_plate.scad>
build_plate(0);

module filament_guide(inner_diameter, wall_thickness, depth)
{
	cylinder(h = depth, r = inner_diameter / 2 + wall_thickness);
}

module filament_guide_cutout(inner_diameter, wall_thickness, depth)
{
	cut_overlap = 100;
	notch_overlap = depth + 4;

	union() {
		// Inner opening of filament guide
		translate([0,0,-cut_overlap/2]) {
			cylinder(h = depth + cut_overlap, r = inner_diameter / 2);
		}

		// Cutout to get filament into guide
		translate([0, inner_diameter/2 + wall_thickness/2, 0]) {
			cube([filament_guide_notch_width, wall_thickness + notch_overlap, depth + notch_overlap], center=true);
		}
	}
}

module frame_holder(frame_thickness, grip_opening_height, grip_depth, wall_thickness)
{
	grip_thickness = frame_thickness + 2*wall_thickness;
	grip_height = grip_opening_height + wall_thickness;

	// Grip main shape
	translate([-grip_thickness / 2, -grip_opening_height,0]) {
		cube	([grip_thickness, grip_height, grip_depth]);
	}
}

module frame_holder_cutout(frame_thickness, grip_opening_height, grip_depth)
{
	// Grip opening cutout
	cut_overlap = 2;
	translate([0,-cut_overlap,-cut_overlap]) // offset for cutting
	translate([-frame_thickness/2,-grip_opening_height,0]) { // Make top of opening centered at 0,0	
		cube([frame_thickness, grip_opening_height + cut_overlap, grip_depth + 2*cut_overlap]);
	}
}

module arm(guide_x, guide_y, width, thickness)
{
	arm_angle = atan(guide_x / guide_y);
	arm_length = sqrt(guide_y*guide_y + guide_x*guide_x);

	echo("Arm: angle", arm_angle, " length", arm_length);
	rotate(arm_angle, [0,0,-1]) { // Rotate for right-side guide - thick part towards spool
		translate([-width/2,0,0]) {
			cube([width,arm_length,thickness]);
		}
	}
}

module guide(frame_thickness, guide_x, guide_y, inner_diameter) {
	difference() {
		union() {
			frame_holder(frame_thickness, grip_opening_height = grip_opening_height, grip_depth = grip_depth, wall_thickness = grip_wall_thickness);
			arm(guide_x, guide_y, width = arm_width, thickness = arm_depth);
		
			translate([guide_x, guide_y, 0]) {
				filament_guide(inner_diameter, wall_thickness = filament_guide_wall_width, depth = filament_guide_depth);
			}
		}
	
		union() {
			frame_holder_cutout(frame_thickness, grip_opening_height, grip_depth);
			translate([guide_x, guide_y, 0]) {
				filament_guide_cutout(inner_diameter, grip_wall_thickness, filament_guide_depth);
			}
		}
	}
}

// Put arm close to the spool depending on which side the spool is on
if (side == 0) { // Left
	guide(frame_thickness = frame_thickness, guide_x = -guide_x, guide_y = guide_y, inner_diameter = inner_diameter);
} else {
	guide(frame_thickness = frame_thickness, guide_x = guide_x, guide_y = guide_y, inner_diameter = inner_diameter);	
}