/*
FourOhFour
2018-03-08

License: http://creativecommons.org/licenses/by-sa/4.0/

A can dispenser for your fridge. Print two sides (mirror one in your slicer), one set of supports for the bottom, and a top shelf. Half sides and top provided if, like me, you don't have a large printer. If you aren't going to place items on top of the dispenser, you can save some plastic and replace the top shelf with another set of supports.

*/

/* [Can Dimensions] */
// Diameter of the can, mm
can_diameter = 67;

// Height of the can, mm
can_height = 123;

// How far from the edge should the can be supported, mm
can_support_height = 30;

/* [Dispenser Dimensions] */
// depth of dispenser, mm
depth = 341;

// height of dispenser, mm
height=160;

// how far from the front does the top shelf begin, mm
shelf_y = 100;

// which object?
part = "fullside"; // [fullside:Entire side piece, frontside:Front half of side, rearside:Rear half of side, supports, top, halftop:Half of top, topcutout:STL for slic3r to make top for full top mesh, halftopcutout:STL for top mesh for half top]

/* [Rear Notch] */
//notch out the bottom rear corner to avoid a rim on the fridge shelf?
should_notch_rear = false;
rear_notch_height = 33;
rear_notch_depth = 9;


/* [Nitpicky Details] */
// min wall thickness, mm
wall_thickness = 2.2;

// top shelf thickness, mm
top_thickness = 2;

// size of the bottom braces, mm
bottom_brace_width = 15;

// bottom brace thickness, mm
bottom_brace_thickness = 1.4;

// slope of ramps, percent
slope_angle = .026;

// extra space in assembly slots, mm
assembly_slack = .10;

// extra thickness for the middle of bottom braces and top, mm
brace_middle_addl_thickness = 1;

// how much should the thicker middle overlap the sides, mm
brace_middle_extra_width = 2;

// ammount to add to the size of the can, mm
slack = 2;

// render quality, lower better, min 0.01 def 12
$fa = 3;

track_radius = (can_diameter + slack) / 2;

module can_track(slope_dir) {
  y = depth - 3*track_radius - 2*wall_thickness;
  hull() {
    cylinder(h=can_support_height, r=track_radius);
    translate(
      [y * slope_angle * slope_dir,
      y,
      0]
    ) {
      cylinder(h=can_support_height+.1, r = track_radius);
      // adding some to height to make the preview render better
    }
  }
}

module support_inset(y, face) {
  thickness = (face==1 ? top_thickness : bottom_brace_thickness);
  translate([(face==1 ? 0 : -.1),0,-1]) cube(
    [thickness + assembly_slack+.1,
    y,
    can_support_height + wall_thickness+2]
  );
  translate([
    -face * assembly_slack - (face==1 ? brace_middle_addl_thickness : -thickness),
    0,
    can_support_height + wall_thickness - brace_middle_extra_width - assembly_slack
  ]) {
    cube([
      assembly_slack + brace_middle_addl_thickness,
      y,
      assembly_slack + brace_middle_extra_width
    ]);
  }
}

module support_piece(width, thickness) {
  support_length = can_height + slack;
  union() {
    cube([support_length + 2*wall_thickness, width, thickness]);
    translate([wall_thickness + can_support_height - brace_middle_extra_width, 0, thickness]) {
      cube([support_length - 2*can_support_height + 2*brace_middle_extra_width, width, brace_middle_addl_thickness]);
    }
  }
}

module finger_cutout() {
  translate([track_radius, -track_radius, -wall_thickness - .2]) {
    hull() {
      cylinder(h=can_support_height + 2*wall_thickness, r=track_radius);
      translate([height, 0, 0])
        cylinder(h=can_support_height + 2*wall_thickness, r=track_radius);
    }
  }
}

module can_path() {
  can_track(1); // lower track, slope up towards rear

  // cutout for can removal
  translate([0, -track_radius-wall_thickness,0]) {
    intersection() {
      cube([2*track_radius, 2*track_radius, can_support_height+.1]);
      cylinder(h=can_support_height + .1, r=2*track_radius);
    }
  }

  translate(
    [(depth - 3*track_radius - 2*wall_thickness) * slope_angle * 2 + 2*track_radius + wall_thickness,
    0,
    0]
  ) {
    /*translate([-(depth-track_radius)*slope_angle,track_radius,0])
      finger_cutout();*/
    can_track(-1); // upper track, slope down towards rear
  }

  // switchback
  translate(
    [(depth-2*track_radius-2*wall_thickness)*slope_angle+track_radius,
    depth-3*track_radius-2.5*wall_thickness,
    0]
  ) {
    difference() {
      // additional height so preview renders better
      cylinder(h=can_support_height+.1, r=2*track_radius + wall_thickness/2);
      translate([-2*track_radius,-2*track_radius-wall_thickness,-5]) {
        cube([4*track_radius,2*track_radius+wall_thickness,can_support_height+5],false);
      }
    }
  }
}

module dispenser_splitter() {
  translate([-1,-1,-1]) { // move away from origin so preview doesn't flicker
    midpoint_x = height/2 + 1; // account for the previous line
    midpoint_y = depth/2 + 1;
    linear_extrude(height = can_support_height + wall_thickness + 2) polygon(
      points = [
        [0,           0         ],
        [0,           midpoint_y],
        [midpoint_x,  midpoint_y],
        [midpoint_x,  midpoint_y - bottom_brace_width],
        [height+2,    midpoint_y - bottom_brace_width],
        [height+2,    0]
      ]
    );
  }
}

module can_dispenser() {
  difference() {
    cube([height,depth,can_support_height + wall_thickness]);

    // rear notch
    if(should_notch_rear) {
      translate([0, depth - rear_notch_depth,0]) {
        cube([rear_notch_height,rear_notch_depth,can_support_height+wall_thickness]);
      }
    }

    // slot for top shelf
    translate(
      [height - top_thickness - assembly_slack,
      track_radius + wall_thickness - .01,
      0]
    ) {
      support_inset(depth - track_radius - wall_thickness + .02, 1); //facing right
    }

    // slots for bottom braces
    translate(
      [0,
      depth - bottom_brace_width - assembly_slack - (should_notch_rear ? rear_notch_depth : 0),
      0]
    ) {
      support_inset(bottom_brace_width + assembly_slack+.1, -1);
    }
    translate(
      [0,
      depth / 2 - bottom_brace_width,
      0]
    ) {
      support_inset(2*bottom_brace_width + assembly_slack, -1);
    }

    // can path
    translate([track_radius+wall_thickness,track_radius+wall_thickness,wall_thickness]) {
      finger_cutout();
      can_path();

      // rounded lower corner
      translate([0,0,-wall_thickness])
        intersection() {
          translate([-2*track_radius,-2*track_radius,0])
            cube([track_radius*2,track_radius*2,can_support_height+wall_thickness]);
          difference() {
            cylinder(h=can_support_height+wall_thickness, r=2*track_radius);
            cylinder(h=can_support_height+wall_thickness, r=track_radius+wall_thickness);
          }
        }
    }
  }
}

if(part == "fullside" || part == "frontside" || part == "rearside") {
  // printing only half?
  if(part == "fullside") {
    can_dispenser();
  } else if(part == "frontside") {
    intersection() {
      can_dispenser();
      dispenser_splitter();
    }
  } else {
    difference() {
      can_dispenser();
      dispenser_splitter();
    }
  }
} else if(part == "supports") {
  support_piece(bottom_brace_width, bottom_brace_thickness);

  translate([0,bottom_brace_width + 5,0])
    support_piece(2*bottom_brace_width, bottom_brace_thickness);
} else if(part == "top") {
  support_piece(depth - track_radius - wall_thickness, top_thickness);
} else if(part == "halftop") {
  support_piece((depth - track_radius - wall_thickness)/2, top_thickness);
} else if(part=="topcutout") {
  translate([can_support_height + wall_thickness,0,0])
    cube([can_height + slack - 2*can_support_height, depth - track_radius - wall_thickness, top_thickness + brace_middle_addl_thickness]);
} else if(part=="halftopcutout") {
  translate([can_support_height + wall_thickness,0,0])
    cube([can_height + slack - 2*can_support_height, (depth - track_radius - wall_thickness)/2, top_thickness + brace_middle_addl_thickness]);
} else {
  translate([track_radius+wall_thickness,track_radius+wall_thickness,-(can_support_height/2)])
    can_path();
}
