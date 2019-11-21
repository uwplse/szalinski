// Author: GrAndAG
// This is a remix of Stepper Shaft Key (http://www.thingiverse.com/thing:567784),
// redesigned for customizer


/* [Size] */
// Length of the handle (mm)
length = 60;
// Diameter of central ring (mm)
center_diameter = 18;
// Height og the thing (mm)
height = 13;
// Diameter of two rings at the ends (mm)
rings_diameter = 14;
// Diameter of hole for shaft (mm)
hole_diameter = 5.3;

/* [Thickness] */
// Thickness of handle (mm)
thickness = 3;
// Width of frames (mm)
frame_width = 2.5;
// Thickness of walls around shaft (mm)
hole_wall_thickness = 3;

/* [Hidden] */
$fn = 64;
eps = 0.05;
depth = height - thickness;

module key(size) {
	key_size = hole_diameter - (hole_diameter*4.7/5);
	
	// center
	union() {
		cylinder(d = center_diameter, h = thickness);
		difference() {
  			translate([ 0, 0, thickness]) 
				cylinder(d=hole_diameter+hole_wall_thickness*2,h=depth);
  			translate([ 0, 0, thickness+2]) 
				cylinder(d=hole_diameter, h=depth-2+eps);
	  		translate([-(hole_diameter+hole_wall_thickness*2)/2, hole_diameter/2+hole_wall_thickness-key_size, thickness]) 
				cube([hole_diameter+6 ,2 ,depth+eps]);
		}
		translate([-hole_diameter/2+key_size, hole_diameter/2-key_size, thickness]) 
			cube([hole_diameter-key_size*2, hole_wall_thickness/2, depth]);
	}

	module ring() {
		difference() {
  			cylinder(d=rings_diameter, h=thickness);
			translate([0,0,-eps/2]) 
				cylinder(d=rings_diameter-2*frame_width, h=thickness+eps);
		}
	}

	// two ringz
	translate([+(size-rings_diameter)/2, 0, 0]) 
		ring();
	translate([-(size-rings_diameter)/2, 0, 0]) 
		ring();

	// central frame
	c_len = size-2*(rings_diameter-frame_width/2);
	translate([-c_len/2, -frame_width/2, 0]) 
		cube([c_len, frame_width, thickness]);

	// walls
	w_len = size-rings_diameter;
	module obj() {
		hull() {
			translate([+(size-rings_diameter)/2, 0, 0]) 
				ring();
			translate([-(size-rings_diameter)/2, 0, 0]) 
				ring();
			cylinder(d = center_diameter, h = thickness);
		}
	}
	difference() {
		obj();
		translate([0, 0,-eps/2]) 
			resize([size-frame_width*2, center_diameter-frame_width*2, thickness + eps]) 
				obj();
	}
}

key(length);