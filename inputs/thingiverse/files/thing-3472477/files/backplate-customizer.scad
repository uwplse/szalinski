/* [Main] */

// Vector of move(x,y), size(x, y) pairs
cutouts = [ [ [ 1.5, 2.5 ],  [ 16.5, 32 ] ], [ [ 23, 0 ], [ 18.5, 8 ] ], [ [ 26, -0.5 ], [ 37.5, 11.5 ] ], [ [ 3, 17 ], [ 32, 15.5 ] ],[ [ 37, -17 ], [ 17.5, 17.5 ] ], [ [ 20, 0.5 ], [ 19, 30.5 ] ], [ [ 20.5, 0 ], [ 24.5, 34.5 ] ] ];

// Bottom of cutouts to bottom edge 
bottom_offset = 5;

/* [RarelyNeeded] */
// Size of backplate (x, y, z)
backbase = [ 156, 43, 1 ];
// Raised edge thickness
edge_thickness = 1;
// Raised edge height
edge_height = 3;
// Spacing around raised edge
edge_offset = 2;
// Snap-in dots per side
edge_dots = [ 9, 4 ];
// How far up the edge to start dots
dotzratio = .6; // [0:1]

/* [Hidden] */
// origin
origin = [0, 0, 0];
// Shift Dot Sphere
dotshift = .05;
// Dot Sphere Size
dotsize = .5;

backwithedge = [ backbase.x + 2 * (edge_offset + edge_thickness), backbase.y + 2 * (edge_thickness + edge_offset), backbase.z ];
fix_nonmanifold = .2;
backz = backbase.z + fix_nonmanifold;

module addCutouts(cutouts, n) {
    curcutnum = len(cutouts) - n;
    if (n > 0) {
        if (curcutnum == 0) {
          translate([cutouts[curcutnum][0][0], cutouts[curcutnum][0][1], -(fix_nonmanifold) / 2]) {
             cube([cutouts[curcutnum][1][0], cutouts[curcutnum][1][1], backz], false);
              addCutouts(cutouts, n - 1);
          }
        } else {
          translate([cutouts[curcutnum][0][0], cutouts[curcutnum][0][1], 0]) {
             cube([cutouts[curcutnum][1][0], cutouts[curcutnum][1][1], backz], false);
              addCutouts(cutouts, n - 1);
          }
      }
   }
}

module addEdges(edgetrfms, eoff, eheight) {
  for (edgetrfm = edgetrfms) {
     translate([edgetrfm[0][0] + eoff, edgetrfm[0][1] + eoff, edgetrfm[0][2] ]) {
        cube([edgetrfm[1][0], edgetrfm[1][1], eheight ], false);
        spacingx = floor(edgetrfm[1][0] / edgetrfm[2][0]);
        spacingy = floor(edgetrfm[1][1] / edgetrfm[2][1]);
        enddotx = edgetrfm[2][0];
        enddoty = edgetrfm[2][1];
        dshiftx = edgetrfm[0][0] ? dotshift + edge_thickness : dotshift;
        dshifty = edgetrfm[0][1] ? dotshift + edge_thickness : dotshift;
        shiftx = spacingy ? dshiftx: 0;
        shifty = spacingx ? dshifty: 0;
        for (dotoff = [1:((spacingx ? enddotx : enddoty) - 1)]) {
           translate([ spacingx * dotoff + shiftx, spacingy * dotoff + shifty, dotzratio * edge_height]) {
              sphere(dotsize);
            }
         }
     }
  }
}
 translate(origin) {
  union() {
      difference() {
        cube(backwithedge, false);
        translate([edge_offset + edge_thickness, edge_offset + edge_thickness, 0]) {
           addCutouts(cutouts, len(cutouts));
        }
    }
    union() {
      addEdges([ 
        [ [ 0, 0, backbase.z ], [ backbase.x + 2 * edge_thickness, edge_thickness, 0 ], edge_dots ],
        [ [ 0, 0, backbase.z ], [ edge_thickness, backbase.y + 2 * edge_thickness, 0 ], edge_dots ],
        [ [ 0, backbase.y + edge_thickness, backbase.z ], [ backbase.x + 2 * edge_thickness, edge_thickness, 0 ], edge_dots ],
       [ [ backbase.x + edge_thickness, 0, backbase.z ], [ edge_thickness, backbase.y + 2 * edge_thickness, 0 ], edge_dots ] 
      ], edge_offset, edge_height);
    }
  }
};