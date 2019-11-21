// Width of multi-tool towards the bottom (narrow end), with included clearance.
narrow_end_width = 33;

// Width of multi-tool towards the top (wider end), with included clearance.
wide_end_width = 35;

// How high up to start transitioning from narrow to wide.
transition_start_height = 55;

// How high up to finish transitioning to the wider width.
transition_end_height = 62.5;

// Full height of the hole for the holster (may be shorter than the multi tool).
full_height = 100;

// Leave enough room to account for sagging bridges.
multitool_thickness = 18.5;

slot_width = 20;

// How much should the slot cut into the bottom?
slot_depth = 10;

// Leave a connected strip across the top of the finger gap for strength.
slot_strip_height = 5;

// An integer multiple of your perimeter width is a good idea.
wall_thickness = 1.6;

belt_loop_width = 20;
belt_loop_height = 50;

// Thickness of your belt, plus a little.
belt_loop_clearance = 6.3;

// The angle from vertical the belt loop top and bottom walls will slant out at. Keep this under 45 degrees if you want to print without supports.
belt_loop_wall_angle = 30;

// Height of the center of the belt loop.
belt_loop_center_height = 50;

/* [Hidden] */
slop = 0.1;

module hole() {
  translate([0, 0, transition_start_height/2 + wall_thickness])
  cube([narrow_end_width, multitool_thickness, transition_start_height], center = true);

  translate([0, 0, transition_end_height + (full_height - transition_end_height)/2 + wall_thickness])
  cube([wide_end_width, multitool_thickness, full_height - transition_end_height], center = true);

  hull() {
    translate([0, 0, transition_start_height + wall_thickness + 1])
    cube([narrow_end_width, multitool_thickness, 2], center = true);

    translate([0, 0, transition_end_height + wall_thickness + 1])
    cube([wide_end_width, multitool_thickness, 2], center = true);
  }
}

module my_sphere(r) {
  rotate_extrude()
  intersection() {
    circle(r, $fn = 4);
    translate([0, -r]) square(2*r);
  }
}

module outside() {
  minkowski() {
    hole();
    my_sphere(wall_thickness, $fn = 8);
  }
}

module outline() {
  polygon(points = [
    [narrow_end_width/2, 0], 
    [narrow_end_width/2, transition_start_height],
    [wide_end_width/2, transition_end_height],
    [wide_end_width/2, full_height],
    [-wide_end_width/2, full_height],
    [-wide_end_width/2, transition_end_height],
    [-narrow_end_width/2, transition_start_height],
    [-narrow_end_width/2, 0]]);
}

module hole() {
  translate([0, wall_thickness, wall_thickness])
  linear_extrude(height=multitool_thickness, convexity = 5) outline();
}


module slot() {
  slot_height = full_height + 2*wall_thickness - slot_strip_height;
  translate([0, slot_height/2 - slop, 0])
  cube([slot_width, slot_height + 2*slop, 2*slot_depth], center = true);
}

module belt_loop_outline() {
  s = sin(belt_loop_wall_angle);
  c = cos(belt_loop_wall_angle);
  x = belt_loop_height/2;
  y = belt_loop_clearance;
  polygon(points=[
    [-x - s*y, 0],
    [-x, y],
    [x, y],
    [x + s*y, 0],
    [x + s*y + wall_thickness/c, 0],
    [x + s*wall_thickness, y + wall_thickness],
    [-(x + s*wall_thickness), y + wall_thickness],    
    [-(x + s*y + wall_thickness/c), 0]]);
}

module belt_loop() {
  translate([0, belt_loop_center_height, 2*wall_thickness + multitool_thickness])
  rotate([90, 0, 90])
  translate([0, 0, -belt_loop_width/2])
  linear_extrude(height = belt_loop_width)
  belt_loop_outline();
}

  
difference() {
  outside();
  hole();

  translate([0, full_height + wall_thickness, multitool_thickness/2 + wall_thickness])
  cube([wide_end_width, 3*wall_thickness, multitool_thickness], center = true);

  slot();
}

belt_loop();

