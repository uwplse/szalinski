/**
 * Bracket for mounting a device (e.g. small external hard drive) to a wall. The top bracket slides on 
 * and the bottom bracket sits below
 * 
 * @license GPL
 * @author Alex Kazim
 */


/* [Main] */
// width of the device
device_width = 82.5;

// thickness of the device
device_height = 11.3;

// thickness of the bracket
wall_thickness = 3;

// rendering quality
$fn = 50;

// build in two pieces
Top();
Bottom();

/**
 * Draw the top bracket
 */
module Top() {
	back_l = device_width + (2 * wall_thickness) + 2;	// + 2 for clearance
	back_w = 15;
	side_h = device_height;
	front_l = 15;
	
	rotate([90,0,0]) {
		difference() {
			union() {
				// back
				translate([-back_l/2,-back_w/2,0]) {
					color("blue") cube([back_l,back_w,wall_thickness]);
				}
				
				// sides
				translate([-back_l/2,-back_w/2,wall_thickness]) {
					color("yellow") cube([wall_thickness,back_w,side_h]);
				}
				translate([back_l/2 - wall_thickness,-back_w/2,wall_thickness]) {
					color("yellow") cube([wall_thickness,back_w,side_h]);
				}
				
				// fronts
				translate([-back_l/2,-back_w/2,side_h + wall_thickness]) {
					RadiusEdge(front_l,back_w,wall_thickness,0,1);
				}
				translate([back_l/2 - front_l,-back_w/2,side_h + wall_thickness]) {
					RadiusEdge(front_l,back_w,wall_thickness,2,1);
				}
			}
			
			// screwholes
			translate([-back_l/5,0,0]) {
				Screwhole(8,wall_thickness);
			}
			translate([back_l/5,0,0]) {
				Screwhole(8,wall_thickness);
			}
		}
	}
}	// Top

/**
 * Draw the bottom bracket
 */
module Bottom() {
	back_l = device_width - 30;
	back_w = 15;
	side_h = device_height;
	
	translate([0,-back_w * 2,0]) {
		rotate([90,0,0]) {
			difference() {
				union() {
					// back
					translate([-back_l/2,-back_w/2,0]) {
						color("blue") cube([back_l,back_w,wall_thickness]);
					}
					// sides
					translate([-back_l/2,-back_w/2,wall_thickness]) {
						color("yellow") cube([back_w,wall_thickness,side_h]);
					}
					translate([back_l/2 - back_w,-back_w/2,wall_thickness]) {
						color("yellow") cube([back_w,wall_thickness,side_h]);
					}
					
					// fronts
					translate([-back_l/2,-back_w/2,side_h + wall_thickness]) {
						RadiusEdge(back_w,back_w,wall_thickness,3,1);
					}
					translate([back_l/2 - back_w,-back_w/2,side_h + wall_thickness]) {
						RadiusEdge(back_w,back_w,wall_thickness,3,1);
					}
				}
				
				// screwholes
				translate([-back_w/2,0,0]) {
					Screwhole(8,wall_thickness);
				}
				translate([back_w/2,0,0]) {
					Screwhole(8,wall_thickness);
				}
			}	
		}
	}
}	// Bottom

/**
 * Render a screwhole with a countersink. Meant to be called 
 * within a difference()
 * @param d - diam of the screwhead
 * @param h - height of the screwhole
 */
module Screwhole(d,h) {
	sink_h = 3;
	inner_d = d - 5;	// assume a 5mm change in diam for the screwhead
	cylinder(d1=inner_d,d2=d,h=h);			// countersink
	cylinder(d1=inner_d,d2=inner_d,h=h);	// rest of the screwhole
}	// Screwhole

/**
 * Radius an edge of the top face of a cube; uses the edge to pre-determine the 
 * coordinates and dimensions and calls a common module; have to call the module 
 * each time within the if scope or the variables won't be accessible
 * @param c_v - vector [length,width,height]
 * @param e - edge to radius; 0 = left, 1 = top, 2 = right, 3 = bottom
 * @param r - radius of the edge
 */
module RadiusEdge(l,w,h,e,r) {
	if (e == 0) {
		cutout_loc = [0,0,h-r];
		cutout_size = [r,w,r];
		corner_loc = [r,0,h-r];
		corner_rot = [-90,0,0];
		corner_l = w;
		doEdge([l,w,h],r,cutout_loc,cutout_size,corner_loc,corner_rot,corner_l);
	}
	else if (e == 1) {
		cutout_loc = [0,w-r,h-r];
		cutout_size = [l,r,r];
		corner_loc = [0,w-r,h-r];
		corner_rot = [-90,0,-90];
		corner_l = l;
		doEdge([l,w,h],r,cutout_loc,cutout_size,corner_loc,corner_rot,corner_l);
	}
	else if (e == 2) {
		cutout_loc = [l-r,0,h-r];
		cutout_size = [r,w,r];
		corner_loc = [l-r,0,h-r];
		corner_rot = [-90,0,0];
		corner_l = w;
		doEdge([l,w,h],r,cutout_loc,cutout_size,corner_loc,corner_rot,corner_l);
	}
	else if (e == 3) {
		cutout_loc = [0,0,h-r];
		cutout_size = [l,r,r];
		corner_loc = [0,r,h-r];
		corner_rot = [-90,0,-90];
		corner_l = l;
		doEdge([l,w,h],r,cutout_loc,cutout_size,corner_loc,corner_rot,corner_l);
	}
}	// RadiusEdge

/**
 * Draw a cube with a radiused edge. Does this by first removing the edge and 
 * then adding a cylinder
 * 
 * @param c_v - cube dimensions (vector)
 * @param r - radius of the corner
 * @param cutout_loc - location where to start the cutout (vector)
 * @param cutout_size - size of the cube (vector)
 * @param corner_loc - location for the cylinder (vector)
 * @param corner_rot - rotation to put cylinder in right place (vector)
 * @param corner_l - length of the corner; depends on the orientation
 */
module doEdge(c_v,r,cutout_loc,cutout_size,corner_loc,corner_rot,corner_l) {
	difference() {
		color("white") cube(c_v);
		translate(cutout_loc) {
			color("red") cube(cutout_size);
		}
	}
	translate(corner_loc) {
		rotate(corner_rot) {
			color("pink") cylinder(r=r,h=corner_l);
		}
	}
}	// doEdge
