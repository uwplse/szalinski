// Tool/Pen Organizer
// V1.1 by DonJuanito

// Width/Length of a 2 cells square (with one border)
cellWidth = 55; // [10:200]
// Number of rows
numRows = 2; // [1:15]
// Number of cells
numCols = 3; // [1:15]
// Radius of the vertical filets
cellRadius = 3; // [0:10]
// Width of the walls
width = 2.5; // [0.5:0.5:8]
// Heigth of the box
height = 130; // [10:200]
// Rotate the  mirrored cells ?
cellsRotation = 1; // [0, 1]

/* [Hidden] */

$fn=15;


// ### MAIN ########################################

Box(cellsRotation);

// ### MODULES #####################################

module TriUnit(ra, cl, h) {
    linear_extrude(height = h, center = false, convexity = 10) hull() {
    
        polygon(points = [[ra, cl], [ra, ra], [cl, ra]]);
        translate([ra, ra, 0]) circle(r = ra);
        translate([ra, cl, 0]) circle(r = ra);
        translate([cl, ra, 0]) circle(r = ra);
    }
}
module TriCell(l , h, m, ra, rot) {
    cd = 2*ra+m;
    co = sqrt((cd*cd)/2);
    cl = l - co - ra;

    translate([rot ? l : 0,0,0]) rotate([0,0,rot ? 90 : 0]) {
        TriUnit(ra, cl, h);
        translate([l,l,0]) rotate([0,0,180]) TriUnit(ra, cl, h);
    }
}

module Box(rotate) {
cw = (width+cellWidth)*numCols+width;
cl = (width+cellWidth)*numRows+width;
    difference() {
//        cube([cw, cl, height+width], center=false);
        linear_extrude(height = height, center = false, convexity = 10) hull() {
            translate([cellRadius,cellRadius,0]) square([cw - 2 * cellRadius, cl - 2 * cellRadius], center = false);
            translate([cellRadius, cellRadius, 0]) circle(r = cellRadius);
            translate([cellRadius, cl - cellRadius, 0]) circle(r = cellRadius);
            translate([cw - cellRadius, cl - cellRadius, 0]) circle(r = cellRadius);
            translate([cw - cellRadius, cellRadius, 0]) circle(r = cellRadius);
        }
        union() for (ro = [0 : numRows-1])
            for (co = [0 : numCols-1]) {
                translate([width+(cellWidth+width)*co,width+(cellWidth+width)*ro,width]) TriCell(l = cellWidth, h= height, m = width, ra = cellRadius, rot = rotate ? (((ro+co)%2) ? false : true) : false );
        }
    }
}
