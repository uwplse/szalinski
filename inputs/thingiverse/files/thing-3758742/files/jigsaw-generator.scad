/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   20 July 2019
 * =====================================
 *
 * Jigsaw puzzle piece cutter generator.
 * Inspired from:
 *     https://www.thingiverse.com/thing:490384
 *
 * Unit: millimetres.
 */

// Precision
$fn = 10;

// Random seed, for repeatable results. Change the number to get a different puzzle.
random_seed = 42; // [0:100]

// Size of the puzzle pieces, in mm
piece_size = 20; // [10:100]

// Space between puzzle pieces
thickness = 0.2; // [0.1:0.1:2]

// Number of rows
rows = 5; // [1:10]

// Number of columns
columns = 6; // [1:10]

// Height of the puzzle, in mm
height = 10;

linear_extrude(height) {
	puzzle(random_seed);
}

module puzzle(seed) {
	// Frame
	difference() {
		translate([-thickness, -thickness]) {
			square([
				piece_size * columns + thickness*2,
				piece_size * rows + thickness*2,
			]);
		}
		square([
			piece_size * columns,
			piece_size * rows,
		]);
	}

	if (rows > 1) {
		for (row = [1 : rows-1]) {
			translate([0, piece_size * row]) {
				puzzle_row(seed + row);
			}
		}
	}

	if (columns > 1) {
		for (column = [1 : columns-1]) {
			translate([piece_size * column, 0]) {
				puzzle_column(seed + rows + column);
			}
		}
	}
}

module puzzle_row(seed) {
	side_random_vect=rands(0, 1, columns, seed);
	flip_random_vect=rands(0, 1, columns, seed+1);

	for (index = [0 : columns-1]) {
		translate([piece_size * index, 0]) {
			mirror([0, flip_random_vect[index] > 0.5 ? 1 : 0]) {
				puzzle_side(piece_size, side_random_vect[index]);
			}
		}
	}
}

module puzzle_column(seed) {
	side_random_vect=rands(0, 1, rows, seed);
	flip_random_vect=rands(0, 1, rows, seed+1);

	for (index = [0 : rows-1]) {
		translate([0, piece_size * index]) {
			rotate([0, 0, 90]) {
				mirror([0, flip_random_vect[index] > 0.5 ? 1 : 0]) {
					puzzle_side(piece_size, side_random_vect[index]);
				}
			}
		}
	}
}

module puzzle_side(s, seed) {
	random_vect=rands(0, 1, 6, seed);

	_h = random_vect[0] * 0.2;  // height [0, 0.2]
	_t = random_vect[1] * 0.1;  // top [0, 0.1]
	_rh = random_vect[2] * 0.05; // right height [0, 0.05]
	_ro = random_vect[3] * 0.1; // right offset [0, 0.1]
	_lh = random_vect[4] * 0.05; // left height [0, 0.05]
	_lo = random_vect[5] * 0.1; // left offset [0, 0.1]

	bezier_stroke([
		[
			[0, 0],
			[0, 0],
			[(0.45+_ro)*s, (-0.05-_h+_rh)*s],
			[(0.35+_ro)*s, (0.07-_h+_rh)*s]
		],
		[
			[(0.35+_ro)*s, (0.07-_h+_rh)*s],
			[(0.25+_ro)*s, (0.15-_h+_rh)*s],
			[0.40*s, (0.25-_h+_t)*s],
			[0.50*s, (0.25-_h+_t)*s]
		],
		[
			[0.50*s, (0.25-_h+_t)*s],
			[0.60*s, (0.25-_h+_t)*s],
			[(0.75-_lo)*s, (0.15-_h+_lh)*s],
			[(0.65-_lo)*s, (0.07-_h+_lh)*s]
		],
		[
			[(0.65-_lo)*s, (0.07-_h+_lh)*s],
			[(0.55-_lo)*s,  (-0.05-_h+_lh) *s],
			[s, 0],
			[s, 0]
		]
	], thickness);
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
			bezier_2D_point(c[0], c[1], c[2], c[3], step/steps)
];

module bezier_stroke(points, width) {
	steps = $fn <= 0 ? 30 : $fn;
	bezier_points = bezier_coordinates(points, steps);
	for (index = [0 : len(bezier_points) - 2]) {
		hull() {
			translate(bezier_points[index]) circle(d = width);
			translate(bezier_points[index + 1]) circle(d = width);
		}
	}
}

module bezier_polygon(points) {
	steps = $fn <= 0 ? 30 : $fn;
	polygon(bezier_coordinates(points, steps));
}
