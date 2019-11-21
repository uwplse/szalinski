include <PowerCase.scad>

// Make box
union() {
  difference() {
    translate([relay_translation_x, relay_translation_y, relay_translation_z])
      RelaySupport(relay_x, relay_y, relay_h, relay_distance, relay_support_size);
    translate([relay_translation_x, relay_translation_y, relay_translation_z])
      RelaySupportHoles(relay_x, relay_h, relay_hole_distance, relay_hole_size, relay_distance, screw_diameter, box_size_z);
  }

  difference() {
    difference() {
      cube([box_size_x, box_size_y, box_size_z]);
      translate([box_border_size, box_border_size, box_border_size*2])
        cube([box_size_x-(box_border_size*2), box_size_y-(box_border_size*2), box_size_z]);
        translate([-box_border_size/2, wire_hole_y_1, wire_hole_z_1])
            rotate(a=90, v=[0, 1, 0])
                cylinder(h=box_border_size*2, r=wire_hole_size_1);
        translate([-box_border_size/2, wire_hole_y_2, wire_hole_z_2])
            rotate(a=90, v=[0, 1, 0])
                cylinder(h=box_border_size*2, r=wire_hole_size_2);
        translate([-1, box_border_size/2+pi_translate_y, box_border_size*2+pi_support_h])
          cube([pi_hole_x, pi_hole_y, pi_hole_z]);
    }
    translate([switch_pos_x, switch_pos_y, switch_pos_z])
        cube([switch_size_x, switch_size_y, switch_size_z]);
    translate([relay_translation_x, relay_translation_y, relay_translation_z])
      RelaySupportHoles(relay_x, relay_h, relay_hole_distance, relay_hole_size, relay_distance, screw_diameter, box_size_z);
    translate([pi_usb_translate_x, box_size_y-box_border_size*2, box_border_size*3])
      cube([pi_usb_size_x, pi_usb_size_z, pi_usb_size_y]);
  }

  translate([box_border_size, box_border_size, box_border_size])
      Support(screw_diameterupport_s, screw_diameterupport_h);
  translate([box_size_x-box_border_size-screw_diameterupport_s, box_border_size, box_border_size])
      Support(screw_diameterupport_s, screw_diameterupport_h);

  translate([box_border_size, box_size_y-box_border_size-screw_diameterupport_s, box_border_size])
      Support(screw_diameterupport_s, screw_diameterupport_h);
  translate([box_size_x-box_border_size-screw_diameterupport_s, box_size_y-box_border_size-screw_diameterupport_s, box_border_size])
      Support(screw_diameterupport_s, screw_diameterupport_h);

  translate([box_border_size+pi_translate_x, box_border_size+pi_translate_y, box_border_size])
    PiSupport(pi_support_distance, pi_support_h_pin, box_border_size, pi_support_d, pi_support_d_pin);
}

// Module to create cover support
module Support(cube_size, cube_heigh) {
  difference() {
      cube([cube_size, cube_size, cube_heigh]);
      translate([cube_size/2, cube_size/2, cube_heigh-screw_height])
        cylinder(h=screw_height+2, r=screw_diameter);
  }
}

module RelaySupport(relay_x, relay_y, relay_h, relay_distance, relay_support_size) {
  relay_z = relay_distance+relay_h;

  difference() {
    cube([relay_x, relay_y, relay_z], center = true);

    translate([0, 0, relay_distance/2])
      cube([relay_x+1, relay_y-relay_support_size, relay_z], center = true);

    translate([0, 0, relay_distance/2])
      cube([relay_x-relay_support_size, relay_y+1, relay_z], center = true);
  }
}

module RelaySupportHoles(relay_x, relay_h, relay_hole_distance, relay_hole_size, relay_distance, screw_diameter, box_size_z) {
  relay_z = relay_distance+relay_h;
  relay_z = box_size_z*1.5;
  hole_x = relay_x/2-relay_hole_distance-relay_hole_size;
  hole_y = relay_y/2-relay_hole_distance-relay_hole_size;
  hole_z = -box_size_z*.5;

  union() {
    translate([hole_x, hole_y, hole_z])
      cylinder(h=relay_z+2, r=screw_diameter);

    translate([-hole_x, hole_y, hole_z])
      cylinder(h=relay_z+2, r=screw_diameter);

    translate([hole_x, -hole_y, hole_z])
      cylinder(h=relay_z+2, r=screw_diameter);

    translate([-hole_x, -hole_y, hole_z])
      cylinder(h=relay_z+2, r=screw_diameter);
  }
}

module PiSupport(pi_support_distance, pi_support_h_pin, box_border_size, pi_support_d, pi_support_d_pin) {
  translate([pi_support_distance, pi_support_distance, 0])
    PiSupportPin(pi_support_h_pin, box_border_size, pi_support_d, pi_support_d_pin);

  translate([pi_pin_distance_x+pi_support_distance*2, pi_support_distance, 0])
    PiSupportPin(pi_support_h_pin, box_border_size, pi_support_d, pi_support_d_pin);

  translate([pi_support_distance, pi_pin_distance_y+pi_support_distance*2, 0])
    PiSupportPin(pi_support_h_pin, box_border_size, pi_support_d, pi_support_d_pin);

  translate([pi_pin_distance_x+pi_support_distance*2, pi_pin_distance_y+pi_support_distance*2, 0])
    PiSupportPin(pi_support_h_pin, box_border_size, pi_support_d, pi_support_d_pin);
}

module PiSupportPin(pi_support_h_pin, box_border_size, pi_support_d, pi_support_d_pin) {
  union() {
    cylinder(h=pi_support_h_pin+box_border_size, r=pi_support_d_pin/2);
    cylinder(h=pi_support_h_pin-pi_support_h+box_border_size, r=pi_support_d/2);
  }
}