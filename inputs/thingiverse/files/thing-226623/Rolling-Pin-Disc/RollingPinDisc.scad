// Rolling Pin Disc
// for the Joseph Adjustable Rolling Pin
//
// This rolling pin comes with interchangable discs that let you roll exactly
// a desired thickness. Notoriously, it doesn't come with a 1/8" disc, the size
// we always seem to need! This is that disc, though you can customize it to
// make other sizes.
//
// Remember to print two!

use <write/Write.scad>

/* [Size] */

// Dough thickness is this times the unit below
count = 1; // [1:16]

// for Thickness
base_unit = 80; // [ 254:mm, 160:16th inch, 80:8th inch ]


/* [Rolling Pin] */

// Wooden pin diameter, in mm
pin_diameter = 45;

// Disc hold diameter, in mm
hole_diameter = 18;

// Disc thickness, in mm
thickness = 5;

/* [Hidden] */
bevel = 1/2;
ten_inches_in_mm = 254;
unit = ten_inches_in_mm / base_unit;
dough = count * unit;


module disc_text(n_mm, num_inch, denom_inch) {
	text_height = 7;
	text_depth = 1/4;
	spacer = 2;
	baseline = hole_diameter / 2 + spacer + text_height / 2;

	translate([0, baseline, thickness])
		write(str(n_mm, "mm"),
			  t=text_depth*2,h=text_height,center=true);

	rotate(a=[0,180,0])
		translate([0, baseline, 0])
			write(str(num_inch,"/",denom_inch,"\""),
				  t=text_depth*2,h=text_height,center=true);

}

module nice_disc_text(depth) {
	n_mm = round(depth);
	d = 16;
	u = ten_inches_in_mm / (d*10);
	n = round(depth/u);
	if (n % 8 == 0) {
		disc_text(n_mm, n / 8, d / 8);
	} else if (n % 4 == 0) {
		disc_text(n_mm, n / 4, d / 4);
	} else if (n % 2 == 0) {
		disc_text(n_mm, n / 2, d / 2);
	} else {
		disc_text(n_mm, n / 1, d / 1);
	}
}

module rolling_disc(depth) {
	width = (pin_diameter - hole_diameter) / 2 + depth;
	height = thickness;

	difference() {
		rotate_extrude($fn=150) {
  			translate([hole_diameter / 2 + bevel, bevel, 0]) {
				minkowski() {
					circle(r=bevel, $fn=24);
					square([width - 2 * bevel, height - 2 * bevel]);
    				}
			}
		}

		nice_disc_text(depth);
	}
}

rolling_disc(dough);



// Debugging code //

/*
for ( i = [ 2 : 4 : 10 ] ) {
	translate([0,0,thickness*i/4])
		rolling_disc(i);
}
*/

/*
rolling_disc(10);
color([0, 1, 0, 0.25]) {
	cylinder(h=20,r=10+45/2,center=true,$fn=150);
}
color([1, 0, 0, 0.25]) {
	cylinder(h=30,r=18/2,center=true,$fn=150);
}
*/