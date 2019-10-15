// author: clayb.rpi@gmail.com
// date: 2014-04-06
// description: A customizable spheroid pot.

// The overall diameter.
DIAMETER = 80;

// How thick the walls are.
WALL_THICKNESS = 1;

// How tall the pot should be in proportion to the diameter.
HEIGHT_RATIO = 1;

// How much pot versus flat area there is.
POT_FLAT_RATIO = 0.66;

// How detailed the sphere rendering should be.
$fn=23;

//-----------------------------------
// Calculated parameters for brevity.
r = DIAMETER / 2;

scale([1, 1, HEIGHT_RATIO])
difference() {
  sphere(r=DIAMETER / 2);

  difference() {
    sphere(r=DIAMETER / 2 - WALL_THICKNESS);
    
    translate([-r - 1, -r - 1, r * (-1 - POT_FLAT_RATIO) + WALL_THICKNESS])
    cube([DIAMETER + 2, DIAMETER + 2, r]);
  }

  // flatten the bottom.
  translate([-r - 1, -r - 1, r * ( -1 - POT_FLAT_RATIO)])
  cube([DIAMETER + 2, DIAMETER + 2, r]);

  // flatten the top.
  translate([-r - 1, -r - 1, r * POT_FLAT_RATIO])
  cube([DIAMETER + 2, DIAMETER + 2, r]);
}