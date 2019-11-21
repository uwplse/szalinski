// author: clayb.rpi@gmail.com
// date: 2013-01-27
// units: mm
//
// description: A small plastic piece to hold a magnet cube
//   and a whiteboard marker together.

// The diameter (mm) of the pen to hold. This should be a tight fit.
PEN_DIAMETER = 11;

// The side length (mm) of the magnet cube (assumed to be equal on all sides).
MAGNET_CUBE_SIZE = 6.55;

// The minimum wall thickness (mm).
MIN_WALL_THICKNESS = 1;

// How detailed the print should be.
$fn=32 + 0; // the '+ 0' prevents customizer from displaying this variable.

// The main unit of height
TOTAL_H =  MAGNET_CUBE_SIZE + 2 * MIN_WALL_THICKNESS;

difference() {
  union() {
  	cylinder(r=PEN_DIAMETER/2 + MIN_WALL_THICKNESS, h=MAGNET_CUBE_SIZE + 2 * MIN_WALL_THICKNESS);

    translate([-TOTAL_H / 2, 0, 0])
    cube([TOTAL_H, PEN_DIAMETER / 2 + TOTAL_H, TOTAL_H]);
  }

  // cut away a place for the pen.
  translate([0, 0, -1])
	cylinder(r=PEN_DIAMETER/2, h=MAGNET_CUBE_SIZE + 2 * MIN_WALL_THICKNESS + 2);

  // cut away a place for the magnet.
  translate([-MAGNET_CUBE_SIZE / 2, PEN_DIAMETER /2 + MIN_WALL_THICKNESS, MIN_WALL_THICKNESS])
  cube([MAGNET_CUBE_SIZE,
        MAGNET_CUBE_SIZE,
        MAGNET_CUBE_SIZE + MIN_WALL_THICKNESS + 1]);
}
