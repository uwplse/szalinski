// Plug cover (UK version)

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A cover for a UK plug, to prevent pins destroying your bag.

// Plug parameters. Primary width is at base of live/neutral pins, secondard
// width at base of earth pins.
max_w    = 50;
min_w    = 38;
max_h    = 43;
corner_r = 10;
ln_y_off = 12;   // Edge to center of pin
mink_r   =  5;

// Standard UK pin parameters (l = live, n = neutral, e = earth)
ln_x_sep = 22.23;   // center to center (range is 22.10 - 22.36)
e_y_sep  = 22.23;   // center to center (range is 22.10 - 22.36)
ln_x     =  6.48;   // max (range is 6.22 - 6.48)
ln_y     =  4.05;   // max (range is 3.90 - 4.05)
ln_z     = 18.20;   // max (range is 17.20 - 18.20)
e_x      =  4.05;   // max (range is 3.90 - 4.05)
e_y      =  8.05;   // max (range is 7.80 - 8.05)
e_z      = 23.23;   // max (range is 22.23 - 23.23)

// Spacing parameter in holes
gap_xy = 0.6;
gap_z = 1.0;

// Smooth the curves
$fn = 48;

// 2D outline of the plug
module block_2d () {
    // calculate offset of upper circles by similar triangles
    upper_x_off = ((max_w - min_w) / 2)
	 / (e_y_sep + ln_y)
	 * (max_h - 2 * corner_r);
    // Put circles at each corner
    hull () {
        translate (v = [max_w / 2 - corner_r - mink_r, corner_r + mink_r, 0])
            circle (r = corner_r);
        translate (v = [-max_w / 2 + corner_r + mink_r, corner_r + mink_r, 0])
            circle (r = corner_r);
        translate (v = [max_w/2 - corner_r - upper_x_off - mink_r,
			max_h - corner_r - mink_r, 0])
            circle (r = corner_r);
        translate (v = [-max_w/2 + corner_r + upper_x_off + mink_r,
			max_h - corner_r - mink_r, 0])
            circle (r = corner_r);
    }
}

// 3D plug block
module block_3d () {
    linear_extrude (height = e_z + 2 * gap_z - mink_r, slices = 1, convexity = 1)
        block_2d ();
}

// Round the top edges of the block
module rounded_block () {
    intersection () {
        translate (v = [0, 0, 200/2])
            cube (size = [200, 200, 200], center = true);
        minkowski () {
            block_3d ();
            sphere (r = mink_r);
        }
    }
}

// Remove holes for the pins
module uk_plug () {
    ln_gap_x = ln_x + 2 * gap_xy;
    ln_gap_y = ln_y + 2 * gap_xy;
    ln_gap_z = ln_z + gap_z;
    e_gap_x = e_x + 2 * gap_xy;
    e_gap_y = e_y + 2 * gap_xy;
    e_gap_z = e_z + gap_z;

    difference () {
        rounded_block ();
        translate (v = [ln_x_sep / 2 + gap_xy, ln_y_off, 0])
            cube (size = [ln_gap_x, ln_gap_y, ln_gap_z * 2], center = true);
        translate (v = [-ln_x_sep / 2 - gap_xy / 2, ln_y_off, 0])
            cube (size = [ln_gap_x, ln_gap_y, ln_gap_z * 2], center = true);
        translate (v = [0, ln_y_off + e_y_sep, 0])
            cube (size = [e_gap_x, e_gap_y, e_gap_z * 2], center = true);
    }
}

uk_plug ();
