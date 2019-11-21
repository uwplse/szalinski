/**
 * Remix of hex bit holder by TBRIshtar on Thingiverse:
 * http://www.thingiverse.com/thing:241501
 *
 * This remix mimics the original as close as possible but has the following
 * features:
 *  - Any number of rows and columns, still keeping the edge rows open on the
 *    sides. This is nice if the hex shank has the bit size stamped on it.
 *  - Footer height can be adjusted
 *  - Height can be adjusted
 *  - Allows easy scaling in the X and Y directions if your printer causes
 *    the hex holes to be too tight, like mine does.
 *
 * Author: Fitzterra <fitz_subs@icave.net>  - July 2016
 *
 * License:
 * This work is licensed under the Creative Commons Attribution-ShareAlike 3.0
 * Unported License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
 * Commons, PO Box 1866, Mountain View, CA 94042, USA.
 **/

/**
 * This version is specifically for upload to Thingiverse and includes the
 * filleting function from jfhbrook's fillets (see below) library inline in
 * this file.
 * This is because on Thingiverse you can not use custom external scad files
 * when using the customizer.
 * 
 * The original source for this can be fount at:
 * https://github.com/fitzterra/3DP/tree/master/Things/Tools/Hex_Shank_Drill_Bit_Holder
 **/

// Fillets library from:
// https://github.com/jfhbrook/openscad-fillets/blob/master/fillets.scad
// Thanks jfhbrook!
//use <fillets.scad>;

// Number of rows
rows = 2;
// Number of columns
columns = 5;
// Height of the footer
foot = 0.5;
// Height above footer
height = 16;

/* [ Advanced ] */
// Gap between hole edges for rows
rowsGap = 1.1;
// Gap between hole edges for columns
colsGap = 1.25;
// How much space to leave on the columns edges - can be negative to open the hex hole edge.
colsEdge = 1.0;
// How much space on the row top and bottom.
rowsEdge = -0.8;
// Hole diameter
holeDia = 7.8;
// Hex or round hole?
holeShape = "hex"; //[hex, round]
// The corner fillet radius
fRad = 2.0;


/** Direct inclusion from fillets.scad **/
// 2d primitive for inside fillets.
module fil_2d_i(r, angle=90) {
  translate([r, r, 0])
  difference() {
    polygon([
      [0, 0],
      [0, -r],
      [-r * tan(angle/2), -r],
      [-r * sin(angle), -r * cos(angle)]
    ]);
    circle(r=r);
  }
}

/** Direct inclusion from fillets.scad **/
// 3d linear inside fillet.
module fil_linear_i(l, r, angle=90) {
  rotate([0, -90, 180]) {
    linear_extrude(height=l, center=false) {
      fil_2d_i(r, angle);
    }
  }
}

/**
 * Module to generate the bit holder
 *
 **/
module Holder() {
    // Nicely rounded fillets
    $fn=64;

    // Calculate the total width and depth
    w = columns*holeDia + (columns-1)*colsGap + colsEdge*2;
    d = rows*holeDia + (rows-1)*rowsGap + rowsEdge*2;

    // Apply a scaling if needed
    difference() {
        // The main block
        cube([w, d, foot+height]);
        // Sink the hex holes
        translate([colsEdge, rowsEdge, foot])
            for(x=[0:columns-1])
                for(y=[0:rows-1])
                    translate([x*(holeDia+colsGap)+holeDia/2, y*(holeDia+rowsGap)+holeDia/2, 0])
                        cylinder(d=holeDia, h=height+0.1, $fn=holeShape=="hex"?6:100);

        // Fillet the 4 corners
        translate([-0.1, -0.1, -0.1])
            rotate([0, -90, 180])
                fil_linear_i(foot+height+0.2, fRad);
        translate([-0.1, d+0.1, -0.1])
            rotate([0, -90, 90])
                fil_linear_i(foot+height+0.2, fRad);
        translate([w+0.1, -0.1, -0.1])
            rotate([0, -90, -90])
                fil_linear_i(foot+height+0.2, fRad);
        translate([w+0.1, d+0.1, -0.1])
            rotate([0, -90, 0])
                fil_linear_i(foot+height+0.2, fRad);
    }
}

Holder();
