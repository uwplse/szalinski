/* [General] */
layout = "mount"; // [mount, clamptest]
wall_thickness = 3;

/* [Clamp Dimensions] */
// Extra clearance for the clamp. Print off the clamp test first to see what is right for you.
clamp_clearance = .1;
// X axis is front to back on the M2.
clamp_x_length = 50;
// Z is left to right across the M2. 40mm is about as far as you can go before the extruder carriage will clonk into the mount at the end of its travel.
clamp_z_length = 40;
// How far the clamp should extend inward from the edge. 5mm is about as far as you can go before contacting the V rail.
lip_depth = 5;
// Thickness of the gantry platform. You should not have to change this; edit clamp_clearance instead.
clamp_gap = 6.5;


/* [Fan Dimensions] */
// Exterior width of the fan.
fan_width = 80;
// How far off from the front face of the clamp you want to offset the fan by.
fan_offset = 2;
fan_screw_diameter = 4.3;
fan_screw_clearance = .2;
fan_depth = 25;
// Extra length for the fan pegs to extend beyond the face of the fan.
fan_depth_extra = 2;
fan_screw_centers_length = 71.5;

/* [Hidden] */
fan_screw_border = (fan_width - fan_screw_centers_length - fan_screw_diameter) / 2;
fan_screw_center_offset = fan_screw_border + fan_screw_diameter/2;
slop = .1; // for avoiding coincident faces

module clamp(h, c = clamp_clearance) {
  linear_extrude(height = h)
  difference() {
    translate([-wall_thickness, -wall_thickness])
    square([clamp_gap + c + 2*wall_thickness, lip_depth + wall_thickness]);

    square([clamp_gap + c, lip_depth + slop]);
  }
}

module screw_insert() {
  rotate([180, 0, 0])
  cylinder(h = fan_depth + fan_depth_extra, r = fan_screw_diameter/2 - fan_screw_clearance);
}


module mount() {
  right_screw_x = -wall_thickness - fan_offset - fan_screw_center_offset;
  screws_y = wall_thickness - fan_screw_center_offset;

  difference() {
    union() {
      // x clamp (front to back)
      rotate([-90, 0, -90])
      translate([0, 0, -wall_thickness])
      clamp(clamp_x_length + wall_thickness);

      // y clamp (left to right)
      rotate([180, 0, 90])
      translate([-(clamp_gap + clamp_clearance), 0, -wall_thickness])
      clamp(clamp_z_length + wall_thickness);

      // fan mount
      translate([-wall_thickness - fan_offset - fan_width, -clamp_gap - clamp_clearance - wall_thickness])
      cube([fan_offset + fan_width, clamp_gap + clamp_clearance + 2 * wall_thickness, wall_thickness]);


      /*
      translate([right_screw_x, screws_y, 0])
      screw_insert();

      translate([right_screw_x - fan_screw_centers_length, screws_y, 0])
      screw_insert();
      */
    }
    // Use 6-32 or 8-32 1 1/4" screws instead of printed holders
    translate([right_screw_x, screws_y, -slop])
    cylinder(h = wall_thickness + 2*slop, r = fan_screw_diameter/2, $fn = 20);

    translate([right_screw_x - fan_screw_centers_length, screws_y, -slop])
    cylinder(h = wall_thickness + 2*slop, r = fan_screw_diameter/2, $fn = 20);
  }
}

module clamp_test() {
  for (i = [0 : 3]) {
    translate([15 * i, 0]) clamp(10, -.1 + i * .1);
  }
}

if (layout == "clamptest") clamp_test();
else mount();

/*
module fan() {
  difference() {
    cube([fan_width, fan_width, fan_depth]);

    translate([fan_screw_center_offset, fan_screw_center_offset + fan_screw_centers_length, -slop])
    cylinder(h = fan_depth + 2 * slop, r = fan_screw_diameter/2);

    translate([fan_screw_center_offset + fan_screw_centers_length, fan_screw_center_offset + fan_screw_centers_length, -slop])
    cylinder(h = fan_depth + 2 * slop, r = fan_screw_diameter/2);
  }
}

%translate([-wall_thickness - fan_offset - fan_width, wall_thickness - fan_width, -fan_depth])
fan();
*/