// Sillcock Mount and Repair Frame --  Version 1.0
// (C) 2016 by Matthew Nielsen
// Home page: https://github.com/xunker/sillcock_mount_repair
// License: "Creative Commons -- Attribution -- Non-Commercial -- Share Alike"

// Thickness of the spacer. The default of 10mm is about 3/8th inch.
thickness = 10.0;

// Diameter of the main pipe opening. NOTE: since this spacer slides length-wise down the pipe, this opening must be big enough to pass anything else on the pipe like the integrated nut. The default of 29mm gives clearance for a 26mm pipe, the integrated nut.
pipe_diameter = 29.0;

// Many sillcocks have welds around the flange. Set a opening taper to make the pipe opening be a cone so the spacer can go around the welds and set flush with the flange. If
opening_taper_diameter = 37.0;

// Diameter of the mounting screw holes around the corners
mount_screw_hole_diameter = 5.5;

// Postion of the mounting screw holes in the corner as a ratio of the width and height. Larger numbers will place them closer to the center.
mount_screw_position_ratio = 2.1;

// Diameter of the screw channels on either side of the opening. This is where the sillcock will attach to the frame and so it should be kept small to give your screws more "bite".
screw_channel_diameter = 2.0;

// The beginning offset of the screw channel *from the center of the object*.
screw_x_offset = 20.0;

// To create an elongated screw screw channel (recommended), use this to specify how wide it will be.
screw_x_width = 11.0;

// Length of the spacer. You should not need to change this.
length = 67.0;

// Width of the spacer. You should not need to change this.
width = 87.0;

// Rounder corner radius. This will be added to the width and height of the plate.
rounded_corner_radius = 6;

// Facets: Increasing this will make for smoother circles but will also increase the rendering time. You should not need to change this.
facets = 24;

module screw_channel() {
  hull() {
    translate([screw_x_offset, 0, -0.1]) cylinder(d=screw_channel_diameter, h=thickness+0.2, $fn=facets);
    translate([screw_x_offset+screw_x_width, 0, -0.1]) cylinder(d=screw_channel_diameter, h=thickness+0.2, $fn=facets);
  }
}

module mounting_hole() {
  translate([width/mount_screw_position_ratio,length/mount_screw_position_ratio,-0.1]) cylinder(d=mount_screw_hole_diameter, h=thickness+0.2, $fn=facets);
}

difference() {
  // create rounded edges
  hull() {
    translate([-width/2, -length/2, 0]) cube([width, length, thickness]);
    translate([-width/2, -length/2, 0]) cylinder(r=rounded_corner_radius, h=thickness);
    translate([width/2, -length/2, 0]) cylinder(r=rounded_corner_radius, h=thickness);
    translate([-width/2, length/2, 0]) cylinder(r=rounded_corner_radius, h=thickness);
    translate([width/2, length/2, 0]) cylinder(r=rounded_corner_radius, h=thickness);
  }

  translate([0,0,-0.1]) cylinder(d1=pipe_diameter, d2=opening_taper_diameter, h=thickness+0.2, $fn=facets);
  screw_channel();
  mirror([1,0,0]) screw_channel();

  mounting_hole();
  mirror([1,0,0]) mounting_hole();

  mirror([0,1,0]) {
    mounting_hole();
    mirror([1,0,0]) mounting_hole();
  }
}
