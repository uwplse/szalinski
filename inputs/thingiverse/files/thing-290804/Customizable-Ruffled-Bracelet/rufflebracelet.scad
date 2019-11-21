// Customizable Ruffled Bracelet
// preview[tilt:top];

/* [Bracelet] */

// Inner diameter of bracelet. Measure to fit your wrist.
inner_diameter = 53;

// A wider ruffle affords more flexibility. Outer diameter = inner diameter + (2 * ruffle width)
ruffle_width = 8;

// Height of the bracelet 
height = 10;

// With a curved outer surface, the bracelet is an equatorial slice of a sphere. With vertical outer surfaces, it is a slice of a cylinder.
surface_type = 1; // [0:Vertical, 1:Curved]

/* [Ruffle] */

// The ruffled band is comprised of this many instances of the cutout shape.
cutout_count = 32;

// Skew cutouts from vertical (0 tilt). Values between -30 and 30 are recommended.
cutout_tilt = 0;

// Width of rectangular passage between inner and outer cutouts. Set to 0 to disable.
passage_width = 1.25;

// Shape of inner cutout. Triangle/pentagon points face outward.
inner_cutout_shape = 5; // [3:Triangle, 4:Diamond, 5:Pentagon, 6:Hexagon, 8:Octagon, 32:Circle]

// Radius of inner cutout hole.
inner_cutout_radius = 2.25;

// Shape of outer cutout. Select None to disable. Triangle/pentagon points face inward.
outer_cutout_shape = 32; // [0:None, 3:Triangle, 4:Diamond, 5:Pentagon, 6:Hexagon, 8:Octagon, 32:Circle]

// Radius of outer cutout hole.
outer_cutout_radius = 1.5;

// Inset center of outer cutout towards center of bracelet.
outer_cutout_inset = 1.25;

/* [Hidden] */

inner_radius = inner_diameter / 2;
outer_radius = inner_radius + ruffle_width;
$fn=180;

carve_surface()  bracelet();

// Bracelet is formed by subtracted multiple instances
// of the cutout shape from a cylindrical stock.
module bracelet() {
	difference() {
		cylinder(r=outer_radius, h=height, center=true);
		for (i = [0:cutout_count-1]) {
			rotate([cutout_tilt, 0, 360 / cutout_count * i]) cutout();
		}
	}
}

// Trim child objects to spherical extent.
// Do nothing if no surface effects enabled.
module carve_surface() {
	if (surface_type == 1) {
		intersection() {
			child();
			sphere(r=outer_radius, center=true);
		}
	}
	else {
		child();
	}
}

//
module cutout() {
	union() {
		// Inner cutout
		translate([inner_radius + inner_cutout_radius, 0, 0])
		linear_extrude(height=height*2, center=true)
		circle(r=inner_cutout_radius, $fn=inner_cutout_shape);

		// Passage
		if (passage_width > 0) {
			translate([inner_radius + inner_cutout_radius + (outer_radius - inner_radius)/2, 0, 0])
			linear_extrude(height=height*2, center=true)
			square([outer_radius - inner_radius, passage_width], center=true);
		}

		// Outer cutout
		if (outer_cutout_shape > 0) {
		 	translate([outer_radius - outer_cutout_inset, 0, 0])
			rotate([0, 0, 180])
			linear_extrude(height=height*2, center=true)
			circle(r=outer_cutout_radius, $fn=outer_cutout_shape);
		}
	}
}

