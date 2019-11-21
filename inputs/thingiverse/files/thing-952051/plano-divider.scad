/*
 * Author:  Jean Philippe Neumann
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     http://www.thingiverse.com/thing:952051
 */

// MakerBot customizer settings:
// preview[view:south east, tilt:top diagonal]

// width of the whole divider in mm.
DIVIDER_WIDTH = 34;
// height of the whole divider in mm.
DIVIDER_HEIGHT = 28.5;
// thickness of the divider (without the side rails) in mm.
DIVIDER_THICKNESS = 1.5;

// height of the rounded bottom part in mm.
DIVIDER_BOTTOM_HEIGHT = 5.5;
// height of the rails on the side in mm.
RAIL_HEIGHT = 1.0;
// width of the rails on the side in mm.
RAIL_WIDTH = 1.5;

// cutouts for lid guide rails in some plano models (e.g. 3500) in mm. Set to 0 to disable.
CUTOUT_RADIUS = 2.75;

DIVIDER_TOP_HEIGHT = DIVIDER_HEIGHT - DIVIDER_BOTTOM_HEIGHT;

createAll();

module createAll() {
  difference() {
    createBody();
    createCutouts();
  }
}

module createBody() {
  union() {
    // main body
    color([1,1,0])
    cube([DIVIDER_WIDTH, DIVIDER_TOP_HEIGHT, DIVIDER_THICKNESS]);

    // rounded bottom
    color([0,0,1])
    hull() {
      translate([DIVIDER_BOTTOM_HEIGHT, 0, 0])
      cylinder(r=DIVIDER_BOTTOM_HEIGHT, h=DIVIDER_THICKNESS, $fn=100);

      translate([DIVIDER_WIDTH - DIVIDER_BOTTOM_HEIGHT, 0, 0])
      cylinder(r=DIVIDER_BOTTOM_HEIGHT, h=DIVIDER_THICKNESS, $fn=100);
    }

    // left rail
    createRail();

    // right rail
    translate([DIVIDER_WIDTH,DIVIDER_TOP_HEIGHT, 0])
    rotate([0,0,180])
    createRail();
  }
}

module createRail() {
  color([0,1,0])
  translate([0,DIVIDER_TOP_HEIGHT,DIVIDER_THICKNESS])
  rotate([90,0,0])
  linear_extrude(height = DIVIDER_TOP_HEIGHT)
  polygon(points = [[0, 0], [RAIL_WIDTH, 0], [0, RAIL_HEIGHT] ], paths = [[0, 1, 2]]);
}

module createCutouts() {
    translate([0, DIVIDER_TOP_HEIGHT, -1])
    cylinder(h = 100, r=CUTOUT_RADIUS, $fn=100);

    translate([DIVIDER_WIDTH, DIVIDER_TOP_HEIGHT, -1])
    cylinder(h = 100, r=CUTOUT_RADIUS, $fn=100);
}
