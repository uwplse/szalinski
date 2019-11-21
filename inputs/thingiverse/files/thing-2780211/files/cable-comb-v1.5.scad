/*
Created by Carl Calderon 2019 (v1.5)
Original part page: https://www.thingiverse.com/thing:2780211

Licensed under Creative Commons Attribution 3.0 Unported (CC BY 3.0)
https://creativecommons.org/licenses/by/3.0/

CHANGELOG

v1.5 - 2019-02-09
- IS_CLIP_ON=1 with negative HORIZONTAL_SEPARATION now span across the whole part

v1.4 - 2018-12-08
- TYPE="demo" introduced to demonstrate all other types
- Each type is now separated into it's own module
- SIZE is now automatically calculated based on WIRE_DIAMETER and EXTRA_STRENGTH

v1.3 - 2018-12-05
- TYPE="slim" with extreme VERTICAL_SEPARATION produced separated meshes
- Assertion added for IS_CLIP_ON=1 with more than 2 rows
- ROWS=1 and IS_CLIP_ON=1 now has a single open side rather than two
- Assertion warnings may now be switched off using IGNORE_ASSERTS=1
- Wires can now be spaced apart using HORIZONTAL_SEPARATION and VERTICAL_SEPARATION
- TYPE="cut-away" introduced which can be cut to size after printing
*/

/* [Basic] */
// Type
TYPE = "slim"; // ["squared":"Squared","rounded":"Rounded", "slim":"Slim", "cut-away":"Cut away", "demo":"Demo"]

// Open ends for clipping on wires?
IS_CLIP_ON = 0; // [1:"Yes",0:"No"]

// Number of columns
COLUMNS = 6; // [1:1:24]

// Number of rows
ROWS = 2; // [1:1:3]

// Thickness of the comb
THICKNESS = 3; // [1:0.1:10]

// Wire diameter
WIRE_DIAMETER = 1.9; // [0.5:0.1:5]

// Distance between rows
VERTICAL_SEPARATION = 0; // [-10:0.1:10]

// Distance between columns
HORIZONTAL_SEPARATION = 0; // [-10:0.1:10]

/* [Advanced] */
// Increase or decrease strength of the part
EXTRA_STRENGTH = 0.5; // [-3:0.1:3]

// Clipping opening size
CLIP_ON_OPENING = 0.25; // [0:0.05:1]

// Tolerances
TOLERANCE = 0.1; // [0:0.05:1]

// Quality
$fn = 32; // [8:"Coarse",16:"Low",32:"Medium",64:"High",128:"Godlike (slow)"]

// Nozzle size (to prevent invalid values)
NOZZLE_SIZE = 0.4; // [0.1:0.1:2]

// Ignore warnings and render anyway? (not recommended)
IGNORE_ASSERTS = 0; // [1:"Ignore warnings",0:"Show warnings"]

SIZE = WIRE_DIAMETER + 1.1 + EXTRA_STRENGTH * 2;

_assert(SIZE - (WIRE_DIAMETER + TOLERANCE * 2) + EXTRA_STRENGTH * 2 >= NOZZLE_SIZE, "Walls thinner than your nozzle")
_assert(WIRE_DIAMETER + TOLERANCE * 2 < SIZE - NOZZLE_SIZE * 2, "The wire will not fit within the tolerances")
_assert((SIZE - WIRE_DIAMETER) + VERTICAL_SEPARATION >= NOZZLE_SIZE, "Vertical separation is less than your nozzle size")
_assert((SIZE - WIRE_DIAMETER) + HORIZONTAL_SEPARATION >= NOZZLE_SIZE, "Horizontal separation is less than your nozzle size")
_assert(IS_CLIP_ON * ROWS <= 2, "Middle row(s) will not be able to clip on")
_assert(!(TYPE == "cut-away" && ((VERTICAL_SEPARATION + EXTRA_STRENGTH + 1) < 1 || (HORIZONTAL_SEPARATION + EXTRA_STRENGTH + 1) < 1)), "Wire separation is too short to be cut off")

main();

module squared () {
  difference () {
    translate([
      -EXTRA_STRENGTH,
      -EXTRA_STRENGTH,
      0
    ])
    cube([
      SIZE * COLUMNS + HORIZONTAL_SEPARATION * (COLUMNS - 1) + EXTRA_STRENGTH * 2,
      SIZE * ROWS + VERTICAL_SEPARATION * (ROWS - 1) + EXTRA_STRENGTH * 2,
      THICKNESS
    ]);

    wires();
    clip_on();
  }
}

module rounded () {
  difference () {
    hull() {
      wires(SIZE + EXTRA_STRENGTH * 2, h=THICKNESS, center=false);
    }

    wires();
    clip_on();
  }
}

module slim () {
  difference () {
    union() {
      translate([EXTRA_STRENGTH, EXTRA_STRENGTH, 0])
      cube([
        (SIZE + HORIZONTAL_SEPARATION) * COLUMNS - HORIZONTAL_SEPARATION - EXTRA_STRENGTH * 2,
        (SIZE + VERTICAL_SEPARATION) * ROWS - VERTICAL_SEPARATION - EXTRA_STRENGTH * 2,
        THICKNESS
      ]);
      wires(SIZE + EXTRA_STRENGTH * 2, h=THICKNESS, center=false);
    }

    wires();
    clip_on();
  }
}

module cut_away () {
  hSeparation = EXTRA_STRENGTH + 1 + HORIZONTAL_SEPARATION;
  vSeparation = EXTRA_STRENGTH + 1 + VERTICAL_SEPARATION;
  difference () {
    union() {
      for (x = [0:COLUMNS - 1]) {
        translate([(SIZE + hSeparation) * x + SIZE * 0.25, SIZE - EXTRA_STRENGTH, 0])
        cube([SIZE * 0.5, (ROWS - 1) * (SIZE + vSeparation), THICKNESS]);
      }
      for (y = [0:ROWS - 1]) {
        translate([SIZE - EXTRA_STRENGTH, (SIZE + vSeparation) * y + SIZE * 0.25, 0])
        cube([(COLUMNS - 1) * (SIZE + hSeparation), SIZE * 0.5, THICKNESS]);
      }
      wires(SIZE + EXTRA_STRENGTH * 2, h=THICKNESS, hSeparation=hSeparation, vSeparation=vSeparation, center=false);
    }

    wires(hSeparation=hSeparation, vSeparation=vSeparation);
    clip_on(hSeparation=hSeparation, vSeparation=vSeparation);
  }
}

module clip_on(hSeparation=HORIZONTAL_SEPARATION, vSeparation=VERTICAL_SEPARATION) {
  if (IS_CLIP_ON) {
    translate([
      -EXTRA_STRENGTH - 1,
      -(SIZE - WIRE_DIAMETER) * 0.5 - WIRE_DIAMETER * (1 - CLIP_ON_OPENING * 0.5) - EXTRA_STRENGTH,
      -THICKNESS * 0.5
    ])
    cube([SIZE * COLUMNS + hSeparation * (COLUMNS - 1) + EXTRA_STRENGTH * 2 + 2, SIZE + EXTRA_STRENGTH, THICKNESS * 2]);
    translate([
      -EXTRA_STRENGTH - 1,
      (SIZE + vSeparation) + (SIZE - WIRE_DIAMETER) * 0.5 + WIRE_DIAMETER * (1 - CLIP_ON_OPENING * 0.5),
      -THICKNESS * 0.5
    ])
    cube([SIZE * COLUMNS + hSeparation * (COLUMNS - 1) + EXTRA_STRENGTH * 2 + 2, SIZE + EXTRA_STRENGTH, THICKNESS * 2]);
  }
}

module main () {
  if (TYPE == "squared") {
    color("GreenYellow") squared();
  } else if (TYPE == "rounded") {
    color("DeepPink") rounded();
  } else if (TYPE == "slim") {
    color("Aquamarine") slim();
  } else if (TYPE == "cut-away") {
    color("Khaki") cut_away();
  } else if (TYPE == "demo") {
    color("GreenYellow") translate([0, 0 * (ROWS * SIZE + 5), 0]) squared();
    color("DeepPink")    translate([0, 1 * (ROWS * SIZE + 5), 0]) rounded();
    color("Aquamarine")  translate([0, 2 * (ROWS * SIZE + 5), 0]) slim();
    color("Khaki")       translate([0, 3 * (ROWS * SIZE + 5), 0]) cut_away();
  }
}

module wires (wd=WIRE_DIAMETER + TOLERANCE * 2, h=THICKNESS * 2, hSeparation=HORIZONTAL_SEPARATION, vSeparation=VERTICAL_SEPARATION, center=true) {
  for (x = [0:COLUMNS - 1]) {
    for (y = [0:ROWS - 1]) {
      translate([
        (SIZE + hSeparation) * x + SIZE * 0.5,
        (SIZE + vSeparation) * y + SIZE * 0.5,
        center ? -THICKNESS * 0.5 : 0
      ])
      cylinder(d=wd, h);
    }
  }
}

module _assert (condition, message, visualize=true) {
  if (condition || IGNORE_ASSERTS == 1) {
    children();
  } else {
    echo("<b>Assertion:</b>", message);
    if (visualize) {
      mod_message = str("Assertion: ", message);
      box_width = 13 + len(mod_message) * 5;
      translate([-box_width * 0.5, -2, 6]) {
        color("crimson") {
          rotate([0, 45, 0]) translate([0, 0.9, 0]) cube([10, 1, 2], center=true);
          rotate([0, -45, 0]) translate([0, 0.9, 0]) cube([10, 1, 2], center=true);
        }
        color("black") {
          rotate([90, 0, 0]) translate([6, 0, -0.9]) text(mod_message, 6, valign="center", font="monospace:style=Bold");
        }
        color("snow") {
          translate([-6, 1, -6]) cube([box_width, 1, 12]);
        }
      }
    }
  }
}
