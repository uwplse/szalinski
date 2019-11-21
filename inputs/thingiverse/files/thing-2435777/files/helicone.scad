// Shaft diameter. Measure diameter and allow an extra .3mm or so.
shaft_d = 5.2;

// Diameter of driving pins.
pin_d = 3;

// Slot in which pins sit. Allow a little extra to prevent binding.
slot_d = 3.2;

// Central disc diameter.
disc_d = 20;

// How far from the edge to inset the slot.
slot_inset = 1.2;

// Height of each disc.
height = 2;

// How far each pin should extend above the disc.
pin_height = 1;

// Allow a little extra to prevent binding.
slot_height = 1.2;

// Width of the arms.
arm_width = 3;

// Minor axis of ovals which define the petals.
petal_width = 10;

// Major axis of petals.
petal_length = 15;

// Label slices on the underside of one petal with the slice number.
markings = true; // [true, false]

part = "helicone_a"; // [helicone_a, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]

/* [Hidden] */
slices = 36;
angle_a = 68.75;
angle_b = 90 / slices;
$fa = 5;
$fs = 0.5;
slop = 0.1;

// p == -2: top cap
// p == -1: bottom cap
// p >= 0: slice
module slice(p) {
     r = disc_d/2 - slot_inset - pin_d/2; // radius of center of pin
     x = slice_r(p);
     difference() {
	  union() {
	       cylinder(h=height, d=disc_d); // main disc
	       if (p >= -1) { // no pin for top cap
		    translate([-r, 0]) cylinder(h=height + pin_height, d=pin_d); // pin
	       }

	       if (p >= 0) {
		    difference() {
			 linear_extrude(height - .2) {
			      // petals
			      translate([x, 0]) petal();
			      translate([-x, 0]) petal();
			      
			      // arms
			      square([x*2, arm_width], center=true);
			 }
			 // markings
			 if (markings) {
			      translate([x, 0]) rotate([180, 0, 90]) translate([0, 0, -.2]) 
				   linear_extrude(.2 + slop) text(str(p), halign="center", valign="center", size=5);
			 }
		    }
	       }
	  }
	  translate([0, 0, -slop]) cylinder(h=2*slop + height, d=shaft_d); // shaft hole
	  // additional angle to add to slot due to pin radius
	  additional_angle = asin(pin_d/2 / r);

	  // pin slot
	  if (p == -2) {
	       // top cap has full slot, bottom cap has no slot.
	       rotate_extrude()
		    translate([r - slot_d/2, -slop])
		    square([slot_d, slot_height + slop]);
	  } else if (p >= 0) {
	       rotate([0, 0, -angle_b - additional_angle])
		    rotate_extrude(angle=angle_a + angle_b + 2*additional_angle)
		    translate([r - slot_d/2, -slop])
		    square([slot_d, slot_height + slop]);
	  }
     }
}

module petal() {
     scale([1, petal_length/petal_width]) circle(d=petal_width);
}

// Complete ellipse with offset
// function slice_r(y) = (disc_d + petal_width)/2 + sqrt((1 - pow(y - slices/2, 2)/pow(slices/2 - 1, 2)) * pow(slices * .5, 2)) + 2;
// Truncated ellipse
function slice_r(y) = (disc_d + petal_width)/2 + sqrt((1 - pow(y - (slices - 1)/2, 2) / pow((slices + 1)/2, 2)) * pow(slices * .6, 2));

module helicone(i, theta=68.75) {
     for (j = [0:i]) {
	  translate([0, 0, j*height]) rotate([0, 0, j*theta]) slice(j);
     }
}

if (part == "helicone_a") {
     helicone(slices - 1, angle_a);
} else if (part == "helicone_b") {
     helicone(slices - 1, angle_b);
} else {
     slice(part);
}

