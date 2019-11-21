/*----------------------------------------------------------------------------
 * Spiralised filament guide.
 * 
 * Created by FeNi64
 * Version 2.0, 2018-05-22
 * Inspired by http://www.thingiverse.com/thing:1418581
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License,
 * LGPL version 2.1, or (at your option) any later version of the GPL.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 *		2018. License, GPL v2 or later
 *----------------------------------------------------------------------------*/

// Spiralised filament guide.

// Thickness of arm and spiral.  PETG flexes well with 2mm.
arm_height=2.0; // [1:0.1:5]

// Thickness of mount plate.  Thick enough to not break at the join during normal flex.
mount_height=1.0; // [1:0.1:5]
// Width of mount plate
mount_x=55.0; // [30:100]
// Depth of mount plate
mount_y=48.0; // [30:100]

// Mount Arm.  From the edge of the mount plate
spiral_arm_length=45.0; // [40:99]
// Spiral Arm.  From the back of the mount arm to the start of the spiral
mount_arm_length=36.0; // [30:99]

// Holes in Mount plate are this far from the right edge.
hole_x=15; // [5:40]
// Front hole is this far from the front.
hole1_y=10; // [5:40]
// Rear hole is this far from the front.
hole2_y=40; // [5:40]
// Hole size.
hole_d=5.2; // [2:0.1:8]

// Width of the arms
arm_width=10; // [10:20]

/* [Hidden] */
spiral_arm_thickness=2.0;
spiral_loops=3;
spiral_zoom=1.5;
spiral_x_adj=-11.5; // Match the spiral end with the arm



module spiral(){
	// From http://forum.openscad.org/2dgraph-equation-based-2-D-shapes-in-openSCAD-td15722.html

	start_angle = 90;
	end_angle = 360 * spiral_loops;

	function spiral(r, t) = let(r = (r + t / 90)) [r * sin(t), r * cos(t)];

	inner = [for(t = [start_angle : end_angle]) spiral(spiral_zoom - spiral_arm_thickness, t) ];

	outer = [for(t = [end_angle : -1 : start_angle]) spiral(spiral_zoom, t) ];

	polygon(concat(inner, outer));

}

// Spiral.
translate([spiral_x_adj,0,arm_height]) rotate([180,0,90]) linear_extrude(arm_height) spiral();

// Spiral Arm
hull() {
	translate([0,0,0]) cube([2,2,arm_height]);
	translate([-arm_width/2,spiral_arm_length,0]) cube([arm_width,arm_width,arm_height]);
}

// Mount Arm
hull() {
	translate([-arm_width/2,spiral_arm_length,0])cube([arm_width,arm_width,arm_height]);
	translate([mount_arm_length-arm_width,spiral_arm_length,0])cube([arm_width,arm_width,mount_height]);
}

// Mount plate
translate([mount_arm_length,spiral_arm_length,0]) {
	difference() {
		cube([mount_x,mount_y,mount_height]);

		// Mount holes
		translate([mount_x-hole_x,hole1_y,-1]) cylinder(h=arm_height+2,d=hole_d,$fn=30);
		translate([mount_x-hole_x,hole2_y,-1]) cylinder(h=arm_height+2,d=hole_d,$fn=30);
	}
}
