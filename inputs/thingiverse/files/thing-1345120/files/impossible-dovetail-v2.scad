/**
  "Impossible" dovetail joint.
  Inspired by http://www.thingiverse.com/thing:172827.
 */

/* [Dimensions] */

// Each piece will be a cube with this dimension
SIZE = 20;

// Increase for a looser fit
SLACK = 0.4;

// Set this to ASSEMBLED, SEPARATE, PRINT1, or PRINT2.
STYLE = "SEPARATE";  // ["ASSEMBLED":Assembled, "SEPARATE":Separate, "PRINT1":First piece for printing, "PRINT2":Second piece for printing]
 
/* [Hidden] */

EPSILON = 0.1;

/* This function from:
 *  Dovetail parametric generator for OpenScad
 *  Générateur de queue d'aronde pour OpenScad
 *
 *  Copyright (c) 2012 Charles Rincheval.  All rights reserved.
 *  https://github.com/hugokernel/OpenSCAD_Dovetail
 *  http://www.digitalspirit.org/
 * 
 *  Create one tooth
 *  @param int width        Tooth width
 *  @param int height       Tooth height
 *  @param int thickness    Tooth thickness
 */
module dovetail_tooth(width, height, thickness, slack) {
    offset = width / 3 + slack / 2;
    translate([- width / 2, - height / 2, 0]) {
        linear_extrude(height = thickness) {
            polygon([[0, 0], [width, 0], [width - offset, height], [offset, height]]);
        }
    }
}

/* Makes two halves of a prism assembled by an "impossible" dovetail joint.
  Each piece will be a cube with dimension d; assembled they are 3/2 * d long.
  (That is, they overlap by 50% of their length.)
  'slack' is the sliding tolerance in mm.
  'part' is 1 for the first part, 2 for the second.
*/
module impossible(d, slack, part) {
  h = d * sqrt(2);
  big = 10;
  
  if (part == 1)
    translate([-d/4,0,0])
      color("GREEN") 
        difference() {
          cube(size = d, center = true);
          for (i=[-1, 1])
            translate([d/4 + slack, i * d/2, 0])  // orient on the edge and centered on the face
              rotate([-45,0,0])  // the trick: 45-degree rotation
                rotate([180,90,90])  // cutting orientation
                  translate([0, 0, -big * d / 2])  // center
                    dovetail_tooth(h / 3.5, d/2 + slack + EPSILON, big * d, -slack / sqrt(2));
        }

  if (part == 2)
    translate([+d/4 + slack/2,0,0])
      color("RED") 
        union() {
          translate([d/4, 0, 0])
            cube(size = [d/2, d, d], center = true);
          intersection() {
            translate([0, 0, 0])
              cube(size = d, center = true);
            for (i=[-1, 1])
              translate([-d/4 + slack, i * d/2, 0])  // orient on the edge and centered on the face
                rotate([-45,0,0])  // the trick: 45-degree rotation
                  rotate([180,90,90])  // cutting orientation
                    translate([0, 0, -big * d / 2])  // center
                      dovetail_tooth(h / 3.5 - slack * 2, d/2 + slack + EPSILON, big * d, slack / sqrt(2));
          }
        }
}

// Presentation

if (STYLE == "SEPARATE") {
  translate([-SIZE/2, 0, 0])
    impossible(SIZE, SLACK, 1);
  
  translate([SIZE/2, 0, 0])
    impossible(SIZE, SLACK, 2);
} else if (STYLE == "ASSEMBLED") {
  impossible(SIZE, SLACK, 1);
  impossible(SIZE, SLACK, 2);
} else if (STYLE == "PRINT1") {
  rotate([0,-90,0])
    impossible(SIZE, SLACK, 1);
} else if (STYLE == "PRINT2") {
  rotate([0,90,0])
    impossible(SIZE, SLACK, 2);
}