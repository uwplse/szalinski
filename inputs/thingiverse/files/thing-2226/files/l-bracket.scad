// l-bracket.scad
//
// generates an l-bracket from the given parameters


// Copyright (c) 2015, Patrick Barrett
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

wall_thickness = 2;
internal_width = 12;
slot_width = 4;
side_length = 20;

// customizable variables end here

head_annulus = (internal_width/2) - (slot_width/2);

abit = 0.0001 * 1; //use for making overlap to get single manifold stl

module stadium3d(a, r, z, center = false){
	offset_x = center ? -(r + (a / 2)) : 0;
	offset_y = center ? -(r) : 0;
	offset_z = center ? -(z / 2) : 0;

	translate([offset_x, offset_y, offset_z])
	union() {
		translate([r, 0, 0])
			cube([a, 2*r, z]);
		translate([r, r, 0])
			cylinder(h = z, r = r, center = false);
		translate([r + a, r, 0])
			cylinder(h = z, r = r);
	}
}

union() {
	// horizontal wall
	difference() {
		cube([side_length + wall_thickness,
		      internal_width + 2*wall_thickness,
		      wall_thickness]);
		translate([wall_thickness + head_annulus,
		           wall_thickness + head_annulus,
		           -1])
			stadium3d(side_length - (2*head_annulus) - slot_width,
 			          slot_width / 2,
 			          wall_thickness + 2);
	}

	// verticle wall
	translate([wall_thickness, 0, 0])
	rotate([0,-90,0])
	difference() {
		cube([side_length + wall_thickness,
		      internal_width + 2*wall_thickness,
		      wall_thickness]);
		translate([wall_thickness + head_annulus,
		           wall_thickness + head_annulus,
		           -1])
			stadium3d(side_length - (2*head_annulus) - slot_width,
 			          slot_width / 2,
 			          wall_thickness + 2);
	}

	// bracer 1
	translate([wall_thickness - abit,
	           wall_thickness,
	           wall_thickness - abit])
	rotate([90,0,0])
	linear_extrude(height = wall_thickness) {
		polygon([[0,0],
		        [side_length,0],
		        [0,side_length]]);
	}

	// bracer 2
	translate([wall_thickness - abit,
	           2*wall_thickness + internal_width,
	           wall_thickness - abit])
	rotate([90,0,0])
	linear_extrude(height = wall_thickness) {
		polygon([[0,0],
		        [side_length,0],
		        [0,side_length]]);
	}
}
