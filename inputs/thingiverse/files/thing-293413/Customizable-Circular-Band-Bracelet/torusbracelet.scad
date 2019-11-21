// Customizable Circular Band Bracelet
// preview[tilt:top];

/* [Bracelet] */

// Inner diameter of bracelet.
wrist_diameter = 51;

// Cross sectional diameter of bracelet band.
band_diameter = 8;

// Sides of band are trimmed flat to this width; must be less than diameter.
band_width = 7;

// Number of notches to cut in band for flexibility.
notch_count = 36;

// Width of outer notch openings. Ensure large enough to avoid fusing.
notch_gap = 1.5;

/* [Hidden] */

$fn=60;
pi = 3.1415926535;

inner_radius = wrist_diameter / 2;
band_radius = band_diameter / 2;
torus_radius = inner_radius + band_radius;
outer_radius = torus_radius + band_radius;
notch_angle = 360/notch_count;
half_gap = notch_gap / 2;

inner_gap_angle = (notch_angle/2) - ((180 * half_gap) / (pi * inner_radius));
outer_gap_angle = (180 * half_gap) / (pi * outer_radius);
inner_gap_x = inner_radius * sin(inner_gap_angle);
inner_gap_y = inner_radius * cos(inner_gap_angle);
outer_gap_x = outer_radius * sin(outer_gap_angle);
outer_gap_y = outer_radius * cos(outer_gap_angle);
notch_tip_y = outer_gap_y + ((outer_gap_x * (outer_gap_y - inner_gap_y)) / (inner_gap_x - outer_gap_x));

translate([0, 0, band_width/2]) Bracelet();

/*
 *	Cut notches from disc to form final bracelet model.
 *	(Intended to be printed without top or bottom surfaces.)
 */
module Bracelet() {
	difference() {
		OuterEdge();
		Notches();
	}
}

/*
 *	Clips a circular array of wedges out of the InnerEdge ring,
 *	forming the notches that will be cut from the OuterEdge disc.
 */
module Notches() {
	intersection() {
		InnerEdge();
		for (i = [0:notch_count-1]) {
			rotate([0, 0, notch_angle*i]) Wedge();
		}
	}
}

/*
 *	Makes a triangular prism. Sized such that when subtracted
 *	from bracelet band an appropriate gap will be left between
 *	neighboring cuts, both on the inner and outer surfaces.
 */
module Wedge() {
	linear_extrude(height=band_diameter, center=true) {
		polygon(points=[
				[0, notch_tip_y],
				[inner_gap_x, inner_gap_y],
				[-inner_gap_x, inner_gap_y]]);
	}
}

/*
 *	Makes a disc like this, defining the outer edge of the band.
 *	  _______________
 *	 /               \
 *	|        +        |
 *	 \_______________/
 *
 *	Notches are subtracted from this disk to form the final bracelet.
 *
 */
module OuterEdge() {
	intersection() {
		rotate_extrude() {
			translate([torus_radius, 0, 0]) circle(r=band_radius);
			translate([torus_radius/2, 0, 0]) square([torus_radius, band_diameter], center=true);
		}
		// if band width is not less than band diameter, force an arbitrary value less than diameter
		cylinder(r=outer_radius, h=(band_width < band_diameter ? band_width : band_diameter - 1), center=true);
	}
}

/*
 *	Makes a torus like this, defining the inner edge of the band.
 *	 ____         ____
 *	|    \-------/    |
 *	|     |  +  |     |
 *	|____/-------\____|
 *
 * Wedge is cut out of this torus to form curved notch pattern.
 *
 */
module InnerEdge() {
	union() {
		rotate_extrude() {
			translate([torus_radius, 0, 0]) circle(r=band_radius);
		}
		difference() {
			cylinder(r=outer_radius+1, h=band_diameter, center=true);
			cylinder(r=torus_radius, h=band_diameter, center=true);
		}
	}
}
