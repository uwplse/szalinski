// Customizable X-axis leveling tool designed for Prusa i3 Berlin.  Used to
// make sure that each side of the X-axis is at the same height.  Necessary
// since there's a stepper motor on each side and they can get out of step.
//
// To use:
// Place "forked" end of tool on Y smooth rod and use Z control to bring the X axis
// just above the flat part of the top of the tool.  Manually rotate the Z rod
// for that side so the X smooth rod just touches the bottom of the "L" at the top
// of the tool.  Adjust the other side the same way.  Go back and forth to each
// side a few times to get the X-axis rod level.
//
// IMPORTANT: Don't squish the tool between the rods by using the Z motor control -
// this could put pressure on the smooth rods and possibly bend them.  Doing the
// final adjustment by hand works best.
//
// Successfully printed using 0.2mm layer height, 1.0mm shell width and 30% infill
// density.  Square or triangular shapes might be more accurate than the curves
// that touch the smooth rods.  Happy to see a remix!

// Michael Ang
// http://michaelang.com
// 25.03.2014

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

// Distance between centers of claws
z_distance = 60;

// Diameter of smooth rods, plus a little extra so the claw sits flat
rod_diameter = 8.2;

// How deep to make claws
claw_depth = 25;

// How tall to make claws
claw_height = 15;

// Thickness of walls
wall_thickness = 3;

// Width of T-beam
beam_width = 10;

// Height of T-beam
beam_height = 10;


module claw(inner_radius, height, depth, wall_thickness, with_entry = false) {
	total_width = (inner_radius + wall_thickness) * 2;

	difference() {
		// outer part
		union() {
			cylinder(r = inner_radius + wall_thickness, h = depth, center = true);
			translate([-total_width/2, -(height - inner_radius - wall_thickness), -depth/2]) cube([(inner_radius + wall_thickness) * 2, height - inner_radius - wall_thickness, depth]);
			if (with_entry) {
				translate([0,0,-depth/2]) cube([inner_radius + wall_thickness, inner_radius + wall_thickness, depth]);
			}
		}
		
		claw_inner(inner_radius, height, depth, wall_thickness, with_entry);
	}
}

module claw_inner(inner_radius, height, depth, wall_thickness, with_entry) {
	cut_overlap = 1;
	
	cube_cutout_height = height - inner_radius - wall_thickness + cut_overlap;
	entry_cutout_height = height - wall_thickness + cut_overlap;

	// inner part
	union() {
		cylinder(r = inner_radius, h = depth + cut_overlap, center = true);
		translate([-inner_radius, -cube_cutout_height, -(depth + cut_overlap)/2]) cube([inner_radius * 2, cube_cutout_height, depth + cut_overlap]);
		if (with_entry) {
			// Chop off part of claw so rod can enter from side
			translate([-(inner_radius+wall_thickness+cut_overlap/2), -entry_cutout_height + inner_radius, -(depth + cut_overlap)/2]) cube([inner_radius * 2, entry_cutout_height, depth + cut_overlap]);
		}
	}
}

module t_beam(length, width, height, thickness) {
	translate([-width/2, 0, 0]) cube([width, length, thickness]);
	translate([-thickness/2, 0, 0]) cube([thickness, length, height]);
}


module x_leveler(z_distance, rod_radius, claw_depth, claw_height, wall_thickness, beam_width, beam_height) {
	translate([0, 0, claw_depth/2]) claw(rod_radius, claw_height, claw_depth, wall_thickness);
	translate([0, z_distance, rod_radius + wall_thickness]) rotate([180,90,0]) claw(rod_radius, claw_height, claw_depth, wall_thickness, with_entry = true);

	difference() {
		t_beam(z_distance, beam_width, beam_height, wall_thickness);
		translate([0, 0, claw_depth/2]) claw_inner(rod_radius, claw_height, claw_depth, wall_thickness);
		translate([0, z_distance, rod_radius + wall_thickness]) rotate([180,90,0]) claw_inner(rod_radius, claw_height, claw_depth, wall_thickness, with_entry = true);
	}
}

x_leveler(z_distance, rod_diameter / 2, claw_depth, claw_height, wall_thickness, beam_width, beam_height);