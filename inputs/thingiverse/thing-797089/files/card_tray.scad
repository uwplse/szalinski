//
// Parametric card tray for board games
//
// Copyright 2015 Magnus Kvevlander <magu@me.com>
//
// Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/
//

// The width of the card stack cutout
w = 70;

// The height of the card stack cutout
h = 97;

// The depth of the card stack cutout
d = 70;

// The number of rows
rows = 1; // [1:10]

// The number of columns
cols = 2; // [1:10]

// Material thickness
thk = 2;

/* [Hidden] */

$fa = 3;
$fs = 0.5;

// draw code with sanity check if wider than tall, not to bork draw code
if ( w <= h )
    card_tray(x = w, y = h, z = d, thk = thk, rows = rows, cols = cols);
else
    rotate ([0, 0, 90]) mirror ([0, 1, 0])
        card_tray(x = h, y = w, z = d, thk = thk, rows = cols, cols = rows);

// Arcane Tinmen Small (red) 46 x 72
// Arcane Tinmen Standard (grey) 67 x 94
// Arcane Tinmen Medium (green) 59 x 93
// Arcane Tinmen Large (blue) 63 x 97
// FFG Square (Power Grid) 73 x 73
// FFG Yellow (Eldritch horror) 44 x 67.3
// Mayday War of the Ring 71 x 122

module card_tray (x = 50, y = 100, z = 50, thk = 2, rows = 1, cols = 2)
union ()
    for (i = [0:cols-1]) for (j = [0:rows-1])
        translate ([i * (x + thk), j * (y + thk), 0])
            card_holder (x, y, z, thk);

module card_holder (x, y, z, thk)
difference () {
    // body
	cube ([x + 2 * thk, y + 2 * thk, z + thk]);
    // card stack cutout
	translate ([thk, thk, thk])
		cube ([x, y, z + thk]);
    // slot cutouts
	for (i = [0, 1]) {
        // mid x cutouts
		translate ([(2 * thk + x) / 2, i * (2 * thk + y), -thk])
			cylinder ( r = (x + 2 * thk)/4, h = z + 3 * thk );
        // mid y cutouts' edges
		for ( j = [-1, 1] )
			translate ([i * (2 * thk + x), (2 * thk + y) / 2 + j * ((2 * thk + y)-(x + 2 * thk))/2, - thk])
				cylinder ( r = (x + 2 * thk)/4, h = z + 3 * thk );
        // mid y cutouts' center
		translate ([i * (2 * thk + x), (2 * thk + y) / 2, (z + 3 * thk)/2 - thk])
			cube ([2 * (x + 2 * thk)/4, ((2 * thk + y)-(x + 2 * thk)), z + 3 * thk], center = true);
	}
}

