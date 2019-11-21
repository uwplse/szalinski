// Total width of the holder including the tabs
cross_length = 74;

// The width of the tabs the screws go into
cross_width = 10;

// The diameter of the round part
holder_diameter = 66;

// The speaker diameter; include some padding
speaker_diameter = 58;

// The size of the screw hole
screw_radius = 1;

// The depth of the part holding the speaker flange
flange_depth = 2;

// The width of the flange
flange_width = 3;

// The total height of the holder
height = 4;

// The size of the bounding box
bounding_size = cross_length + cross_width;

// The body
module drawclip() {
  circle(holder_diameter / 2);
  for (angle = [0, 90]) {
    rotate(angle) {
      difference() {
        hull() {
          translate([-cross_length/2, 0]) circle(cross_width/2);
          translate([cross_length/2, 0]) circle(cross_width/2);
        }
        union() {
          translate([-cross_length/2, 0]) circle(screw_radius);
          translate([cross_length/2, 0]) circle(screw_radius);
        }
      }
    }
  }
}

// The holes in the middle which hold the speaker
module  drawinside()  {
  difference() {
    difference() {
      translate([-bounding_size/2, -bounding_size/2, 0]) {
        cube([bounding_size, bounding_size, height*2]);
      }
      translate([0, 0, -0.0001])
        cylinder(h=flange_depth, r=speaker_diameter/2);
      cylinder(h=height, r = speaker_diameter/2 - flange_width);
    }
  }
}

// Flip it over so it prints without support
rotate([-180, 0, 0]) {
  intersection() {
    drawinside();
    linear_extrude(height=height) {
      drawclip();
    }
  }
}

