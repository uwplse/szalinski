/*  Pocket flashlight hi-visibility cone.
    For best effect, print in translucent orange material.

    Copyright (C) 2012  Peter-Paul van Gemerden <pp@van.gemerden.nl>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.*/


/** Settings **/

test = false;
    // generates just a small ring
    // to test with flashlight diameter

head_diameter = 34.5;
base_height = 16;
base_wall = 1.6;

cone_height = 90;
cone_wall = 0.8;
cone_tip_diameter = 14;

closed_tip = false;

gaps = false;
    // mimic the shape of my flashlight;
    // disable if they annoy you or
    // influence printing quality


/** More settings **/

xy_space = 0.6; // extra room on the inside of the base

num_grips = 5;
grip_height = 0.3;
grip_width = 2;
grip_slope = 0.15 * base_height;
grip_runup = 0.05 * base_height;

num_gaps = 5;
gap_radius = 10;
gap_height = 3;

ridge = 1.2; // the ridge keeps the flashlight from overshooting the base


/****    (End of settings)      *****/


/** Runtime variables **/

// (You shouldn't need to change these)

base_inner_radius = head_diameter/2 + xy_space;
base_outer_radius = base_inner_radius + base_wall;
grip_cutout_radius = base_inner_radius - grip_height;
grip_rotation = 360 / num_grips;


/** Code **/

if (test) {
	scale([1, 1, 0.5])
	base();
} else {
	union() {
		base();
		translate([0, 0, base_height])
		cone();
	}
}


/** Modules **/

module base() {
	union() {
		base_wall();
		base_grips();
		if (!test) {
			translate([0, 0, base_height - ridge])
			base_ridge();
		}
	}
}

module base_wall() {	
	difference() {
		cylinder(h=base_height, r=base_outer_radius, $fn=90);
		cylinder(h=base_height, r=base_inner_radius, $fn=45);
		if (gaps) {
			base_gaps();
		}
	}
}

module base_gaps() {
	rotation = 360 / num_gaps;
	for (i = [0 : num_gaps]) {
		rotate([0, 0, i * rotation])
		base_gap();
	}
}

module base_gap() {
	translate([0, 0, gap_height-gap_radius])
	rotate([90, 0, 0])
	cylinder(h=base_outer_radius, r=gap_radius, $fn=45);
}

module base_grips() {	
	translate([0, 0, grip_runup])
	difference() {
		base_grip_stubs();
		cylinder(h=base_height-grip_runup, r=grip_cutout_radius);
		cylinder(h=grip_slope, r1=base_inner_radius, r2=grip_cutout_radius);
	}
}

module base_grip_stubs() {
	for (i = [0 : num_grips]) {
		rotate([0, 0, i * grip_rotation])
		base_grip();
	}
}

module base_grip() {
	translate([-grip_width/2, 0, 0])
	cube([grip_width, (head_diameter/2)+xy_space, base_height-grip_runup]);
}

module base_ridge() {
	$fn = 45;
	difference() {
		cylinder(h=ridge, r=base_inner_radius);
		cylinder(h=ridge, r1=base_inner_radius, r2=base_inner_radius-ridge);
	}
}

module cone() {
	h = cone_height;
	r1 = base_outer_radius;
	r2 = cone_tip_diameter/2;
	
	h2 = closed_tip ? (h - cone_wall) : h;

	difference() {
		cylinder(h=h, r1=r1, r2=r2, $fn=90);
		cylinder(h=h2, r1=r1-cone_wall, r2=r2-cone_wall, $fn=45);
	}
}
