// file: hyperbolic_pencil_holder.scad
// author: clayb.rpi@gmail.com
// date: 2013-11-24
// units: mm
//
// description: a ring to hold a bunch of pencils at an angle
// so the lean on each other.
//
// derived from: http://www.thingiverse.com/thing:8433

//-------------
// User input 
//-------------

// The number of pencils the stand should hold.
NUM_PENCILS = 13;

// The diameter of each pencil
PENCIL_DIAMETER = 8;

// The length of each pencil
PENCIL_LENGTH = 190;

// The angle the pencils should stand at
LEAN_ANGLE = 30;

// The height of the base
BASE_HEIGHT = 10;

// The width of walls around the base.
WALL_WIDTH = 1;

// Shift the intersetion point from the center of the pencils.
PENCIL_SHIFT = 30;

/* [Hidden] */
$fn = 64;


//--------------------------
// Calculated values.
//--------------------------
leanAngle = min(80, max(-80, LEAN_ANGLE));
numPencils = max(2, NUM_PENCILS);
baseHeight = max(0, BASE_HEIGHT);
wallWidth = max(0, WALL_WIDTH);

rodRadius = max(0, PENCIL_DIAMETER) / 2;
rodCutLength = max(BASE_HEIGHT, PENCIL_LENGTH) + 2 * rodRadius * tan(leanAngle);
rodLength = rodCutLength / 2 - PENCIL_SHIFT;

// An offset from the center of the pencils (where they are closet) to their bottoms.
bottom = sin(leanAngle) * rodRadius - cos(leanAngle) * rodLength;

// An approximation of how wide the pencils are when leaning.
a = rodRadius / cos(leanAngle);
b = rodRadius;
theta = 90 / numPencils;

// average of the elliptical angle and the maximal radii to account overlap.
effectiveRodRadius = ((a * b) / sqrt(pow(b * cos(theta), 2) + pow(a * sin(theta), 2)) + a) / 2;

function xRodOffset(h) = effectiveRodRadius / sin(360 / (2 * numPencils));
function yRodOffset(h) = (h - effectiveRodRadius) / tan(90 - leanAngle);
function zRodRadius(h) = sqrt(pow(xRodOffset(h), 2) + pow(yRodOffset(h), 2));

// Debugging output.
echo("base outer diameter", 2 * (zRodRadius(bottom) + effectiveRodRadius + wallWidth));

difference() {
  // the actual base.
  cylinder(r1=zRodRadius(bottom) + effectiveRodRadius + wallWidth,
           r2=zRodRadius(bottom + baseHeight) + effectiveRodRadius + wallWidth,
           h=baseHeight);

  // cut out a hole in the center.
  translate([0, 0, -1])
  cylinder(r1=zRodRadius(bottom - 1) - effectiveRodRadius - wallWidth,
           r2=zRodRadius(bottom + baseHeight + 1) - effectiveRodRadius - wallWidth,
           h=baseHeight + 2);

  #
  // cut out the pencils.
  for (i = [0 : numPencils- 1 ]) {
    rotate([0, 0, i * 360 / numPencils])
    translate([xRodOffset(bottom), yRodOffset(bottom), 0])
    rotate([-leanAngle, 0, 0])
    translate([0, 0, -rodRadius * tan(leanAngle)])
    cylinder(r=rodRadius, h=rodCutLength, $fn=16);
  }
}
