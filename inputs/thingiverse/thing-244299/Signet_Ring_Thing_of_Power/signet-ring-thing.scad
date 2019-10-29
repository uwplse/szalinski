use <MCAD/bitmap/bitmap.scad>;

// preview[view:south east, tilt:top diagonal]

/* [Symbol] */

// Symbols are generated with the MCAD bitmap library.
SYMBOL = "G";

// Symbol offset above or below ring edge. 0 is flush with edge.
SYMBOL_OFFSET = 0;

// Counterclockwise rotation of symbol. 0 is aligned with finger.
SYMBOL_TWIST = 0; // [0:360]

// A mirrored symbol will appear correctly when stamped in Plah-Doh or wax or the forehead of your enemy.
MIRRORED = 0; // [0:No, 1:Yes]

/* [Size] */

// US ring size. Specify diameter explicity if ring size is outside 0-16 range.
RING_SIZE = 11.5;

// If nonzero, overrides ring size. Inner ring diameter (finger diameter) in millimeters.
RING_DIAMETER = 0;

/* [Setup] */

// Ring orientation. Upright is 0. Tilt around 66 suitable for printing on side without supports.
TILT = 66.2;

// Segments per circle. Higher values yield smoother surfaces but take longer to process.
$fn = 50;

Ring(	RING_DIAMETER == 0 ? RingSizeToFingerDiameter(RING_SIZE) : RING_DIAMETER,
		TILT,
		SYMBOL,
		SYMBOL_OFFSET,
		SYMBOL_TWIST,
		MIRRORED);

module Ring(diameter, tilt, character, offset, twist, mirrored) {
		
	// Scale default 25 mm diameter to match requested diameter.
	s = diameter / 25;

	scale([s, s, s]) rotate([0, tilt, 0]) {
		union() {
			intersection() {
				difference() {
					
					// Cylindrical ring stock
					cylinder(h=35,r=20);
					
					// Finger hole
					translate([-20,0,15]) rotate([0,90,0]) cylinder(h=60,r=12.5);
					
					// Finger hole beveled edges
					translate([-25,0,9]) sphere(21);
					translate([25,0,9]) sphere(21);
					
					// Symbol socket indentation
					translate([0, 0, 50]) sphere(20);
				}
				
				// Clip ring to spherical extent
				translate([0,0,20]) sphere(20);
			}
			
			// Put symbol in socket
			translate([0, CenterSymbol(character), 30]) Symbol(character, offset, twist, mirrored);
		}
	}
}

/*
 * The MCAD bitmap library centers all but a few characters.
 * Apply a Y offset to manually such those wide load letters.
 */
function CenterSymbol(symbol) = search(symbol, "MWmw") == [] ? 0 : -1.5;

/*
 * Symbol should be xy centered at 0,0 with bottom at z 0.
 */
module Symbol(character, offset, twist, mirrored) {
	scale([2.8, 2.8, 1]) rotate([0, 0, twist]) mirror([0, mirrored ? 1 : 0, 0]) 8bit_char(character, 1, 5 + offset);
}

/*
 * Input: US ring size in range [0, 16]
 * Output: ring inner (finger) diameter in millimeters
 * Lookup table derived from https://en.wikipedia.org/wiki/Ring_size
 */
function RingSizeToFingerDiameter(ringsize) = lookup(ringsize, [
	[0, 11.63],
	[0.25, 11.84],
	[0.5, 12.04],
	[0.75, 12.24],
	[1, 12.45],
	[1.25, 12.65],
	[1.5, 12.85],
	[1.75, 13.06],
	[2, 13.26],
	[2.25, 13.46],
	[2.5, 13.67],
	[2.75, 13.87],
	[3, 14.07],
	[3.25, 14.27],
	[3.5, 14.48],
	[3.75, 14.68],
	[4, 14.88],
	[4.25, 15.09],
	[4.5, 15.29],
	[4.75, 15.49],
	[5, 15.7],
	[5.25, 15.9],
	[5.5, 16.1],
	[5.75, 16.31],
	[6, 16.51],
	[6.25, 16.71],
	[6.5, 16.92],
	[6.75, 17.12],
	[7, 17.32],
	[7.25, 17.53],
	[7.5, 17.73],
	[7.75, 17.93],
	[8, 18.14],
	[8.25, 18.34],
	[8.5, 18.54],
	[8.75, 18.75],
	[9, 18.95],
	[9.25, 19.15],
	[9.5, 19.35],
	[9.75, 19.56],
	[10, 19.76],
	[10.25, 19.96],
	[10.5, 20.17],
	[10.75, 20.37],
	[11, 20.57],
	[11.25, 20.78],
	[11.5, 20.98],
	[11.75, 21.18],
	[12, 21.39],
	[12.25, 21.59],
	[12.5, 21.79],
	[12.75, 22],
	[13, 22.2],
	[13.25, 22.4],
	[13.5, 22.61],
	[13.75, 22.81],
	[14, 23.01],
	[14.25, 23.22],
	[14.5, 23.42],
	[14.75, 23.62],
	[15, 23.83],
	[15.25, 24.03],
	[15.5, 24.23],
	[15.75, 24.43],
	[16, 24.64]
]);
