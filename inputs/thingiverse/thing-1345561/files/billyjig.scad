// Jig for drilling holes into BILLY sides.
// By JI <jayeye@gmail.com>
// The latest version of this file can always be found at
// https://github.com/jayeye/jum/tree/master/src/scad/billyjig

/* [Jig parameters] */ 

// Thickness of template
thickness = 2;

// How much the drill protrudes from the chuck
bit_protrusion = 50;

// How many holes to use as guides
guide_holes = 2;

// How many holes to drill
jig_holes = 3;

// Fudge factor to account for printer tolerances (mine: twice the nozzle size)
slack = .8;

/* [Billy parameters -- you should probably not change these] */

// Spacing between holes
pitch = 32.1;

// Diameter of support pins
diameter = 4.9;

// Depth of pin hole
depth = 9;

$fn = 60;

module billy_jig(
  diameter=diameter,
  pitch=pitch,
  depth=depth,
  thickness=thickness,
  bit_protrusion=bit_protrusion,
  guide_holes=guide_holes,
  jig_holes=jig_holes,
  slack=slack) {
  slack_dia = diameter + slack;
  big_r = 3 * slack_dia / 2;
  r = slack_dia / 2;
  n_holes = guide_holes + jig_holes;
  difference() {
    union() {
      hull() {
        for (o = [1 : n_holes]) {
          translate([pitch * (o - .5), pitch * .5, 0]) { 
             cylinder(r=(2 * big_r), h=thickness);
          }
        }
      }
      for (o = [1 : jig_holes]) {
        translate([pitch * (o - .5), pitch * .5, 0]) { 
          cylinder(r=big_r, h=(bit_protrusion - depth));
        }
      }
    }
    for (o = [1 : n_holes]) {
      translate([pitch * (o - .5), pitch * .5, 0]) {
          cylinder(r=r, h=bit_protrusion);
      }
    }
  }
}
  
billy_jig();