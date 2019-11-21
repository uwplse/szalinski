/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   21 April 2019
 * =====================================
 *
 * I didn't like to have to print 2 parts and glue them together.
 * Inspired from MattWheeler:
 *     https://www.thingiverse.com/thing:2933252
 *
 * Unit: millimetres.
 */

// Level of details. $fn = 80 for smooth rendering
$fn = 20;

cover_width = 84.5;
cover_height = 30.2;
cover_depth = 1.5;

knob_foot_height = 4.5;

knob_dia = 11;
knob_height = 5;
knob_fillet_dia = 2;


// Kappa: Constant used to make circle using bezier
// http://whizkidtech.redprince.net/bezier/circle/kappa/
kappa = 4 * ((sqrt(2) - 1)/3);


cover();

module cover() {
	base();

	translate([0, 0, cover_depth]) {
		knob();
	}
}

module base() {
	cover_fillet_dia = 1;

	_cover_width = cover_width - cover_fillet_dia;
	_cover_height = cover_height - cover_fillet_dia;
	_cover_depth = (cover_depth - cover_fillet_dia > 0.01 ? cover_depth - cover_fillet_dia : 0.01) + 0.01;
	translate([-_cover_width/2, -_cover_height/2, cover_fillet_dia/2]) {
		minkowski() {
			cube([_cover_width, _cover_height, _cover_depth]);
			sphere(d = cover_fillet_dia);
		}
	}
}

module knob() {
	knob_groove_dia = 2;

	difference() {
		rotate_extrude() {
			translate([0, knob_foot_height]) {
				knob_2D();
			}
			knob_foot_2D();
		}

		// Grooves in knob

		translate([0, 0, knob_foot_height]) {
			for (angle = [0 : 360/12 : 360]) {
				rotate([0, 0, angle]) {
					translate([knob_dia/2 + knob_groove_dia/4, 0, 0]) {
						cylinder(d = knob_groove_dia, h = knob_height);
					}
				}
			}
		}
	}
}

module knob_2D() {
	knob_recess = 1;

	/*
	polygon([
		[0, 0],
		[knob_dia/2 - knob_fillet_dia/2, 0],
		[knob_dia/2, knob_fillet_dia/2],
		[knob_dia/2, knob_height - knob_fillet_dia/2],
		[knob_dia/2 - knob_fillet_dia/2, knob_height],
		[0, knob_height - knob_recess]
	]);
	*/

	bezier_polygon([
		[
			[0, 0],
			[0, 0],
			[knob_dia/2 - knob_fillet_dia/2, 0],
			[knob_dia/2 - knob_fillet_dia/2, 0]
		],
		[
			[knob_dia/2 - knob_fillet_dia/2, 0],
			[knob_dia/2 - knob_fillet_dia/2, 0],
			[knob_dia/2, knob_fillet_dia/2],
			[knob_dia/2, knob_fillet_dia/2]
		],
		[
			[knob_dia/2, knob_fillet_dia/2],
			[knob_dia/2, knob_fillet_dia/2],
			[knob_dia/2, knob_height + knob_fillet_dia/2 * (kappa - 1)],
			[knob_dia/2, knob_height - knob_fillet_dia/2]
		],
		[
			[knob_dia/2, knob_height - knob_fillet_dia/2],
			[knob_dia/2, knob_height + knob_fillet_dia/2 * (kappa - 1)],
			[knob_dia/2 + knob_fillet_dia/2 * (kappa - 1), knob_height],
			[knob_dia/2 - knob_fillet_dia/2, knob_height]
		],
		[
			[knob_dia/2 - knob_fillet_dia/2, knob_height],
			[knob_dia/2 - knob_fillet_dia/2 - knob_fillet_dia/2, knob_height],
			[knob_dia/2 * 3/4, knob_height - knob_recess],
			[0, knob_height - knob_recess]
		],
		[
			[0, knob_height - knob_recess],
			[0, knob_height - knob_recess],
			[0, 0],
			[0, 0]
		]
	]);

	// Bottom rounded corner drawn using a circle
	// because kappa doesn't draw perfect circles
	translate([knob_dia/2 - knob_fillet_dia/2, knob_fillet_dia/2]) {
		circle(d = knob_fillet_dia);
	}
}

module knob_foot_2D() {
	knob_foot_dia = 5.5;
	knob_foot_fillet_dia = 1;

	knob_height_adjust = knob_fillet_dia/2 - knob_fillet_dia/2 / sqrt(2);
	knob_junction = knob_dia/2 - knob_foot_dia/2 - knob_height_adjust;

/*
	polygon([
		[0, 0],
		[knob_foot_dia/2 + knob_foot_fillet_dia/2, 0],
		[knob_foot_dia/2, knob_foot_fillet_dia/2],
		[knob_foot_dia/2, knob_foot_height + knob_height_adjust - knob_junction],
		[knob_foot_dia/2 + knob_junction, knob_foot_height + knob_height_adjust],
		[0, knob_foot_height + knob_height_adjust]
	]);
*/

	bezier_polygon([
		[
			[0, 0],
			[0, 0],
			[knob_foot_dia/2 + knob_foot_fillet_dia/2 * kappa, 0],
			[knob_foot_dia/2 + knob_foot_fillet_dia/2, 0]
		],
		[
			[knob_foot_dia/2 + knob_foot_fillet_dia/2, 0],
			[knob_foot_dia/2 + knob_foot_fillet_dia/2 * kappa, 0],
			[knob_foot_dia/2, knob_foot_fillet_dia/2 * kappa],
			[knob_foot_dia/2, knob_foot_fillet_dia/2]
		],
		[
			[knob_foot_dia/2, knob_foot_fillet_dia/2],
			[knob_foot_dia/2, knob_foot_fillet_dia/2 * kappa],
			[knob_foot_dia/2, knob_foot_height + knob_height_adjust - knob_junction],
			[knob_foot_dia/2, knob_foot_height + knob_height_adjust - knob_junction - knob_junction/2]
		],
		[
			[knob_foot_dia/2, knob_foot_height + knob_height_adjust - knob_junction - knob_junction/2],
			[knob_foot_dia/2, knob_foot_height + knob_height_adjust - knob_junction],
			[knob_foot_dia/2 + knob_junction, knob_foot_height + knob_height_adjust],
			[knob_foot_dia/2 + knob_junction, knob_foot_height + knob_height_adjust]
		],
		[
			[knob_foot_dia/2 + knob_junction, knob_foot_height + knob_height_adjust],
			[knob_foot_dia/2 + knob_junction, knob_foot_height + knob_height_adjust],
			[0, knob_foot_height + knob_height_adjust],
			[0, knob_foot_height + knob_height_adjust]
		],
		[
			[0, knob_foot_height + knob_height_adjust],
			[0, knob_foot_height + knob_height_adjust],
			[0, 0],
			[0, 0]
		]
	]);
}


/**
 * Stripped down version of "bezier_v2.scad".
 * For full version, see: https://www.thingiverse.com/thing:2170645
 */

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function bezier_2D_point(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]
];

function bezier_coordinates(points, steps) = [
	for (c = points)
		for (step = [0:steps])
			bezier_2D_point(c[0], c[1], c[2],c[3], step/steps)
];

module bezier_polygon(points) {
	steps = $fn <= 0 ? 30 : $fn;
	polygon(bezier_coordinates(points, steps));
}
