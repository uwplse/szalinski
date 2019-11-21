// Height of dampener, mm:
height = 0.8; // [0.1:0.05:2]

// Motor outer diameter, mm:
motor_size = 22; // [1:1:100]

// Motor minimum mount diameter, mm:
motor_min_diameter = 16; // [1:1:50]

// Motor maximum mount diameter, mm:
motor_max_diameter = 19; // [1:1:50]

// Inner diameter, mm:
inner_diameter = 6; // [0:1:50]

// Mounting screw diameter, mm:
mount_screw_diameter = 3; // [1:1:10]

module dummy() {};

/* [Hidden] */
screw_hole_diameter = mount_screw_diameter + 0.1;
$fn = 1000;

difference() {
  base_plate();
  inner_hole();
  screw_holes();
}

module base_plate() {
  cylinder(r = motor_size / 2.0, h = height);
}

module inner_hole() {
  translate([0, 0, -0.1]) {
    cylinder(r = inner_diameter / 2.0, h = height + 1);
  };
}

module screw_holes() {
  union() {
    screw_hole(motor_min_diameter, motor_max_diameter, screw_hole_diameter);
    rotate(90, [0, 0, 1]) { screw_hole(motor_min_diameter, motor_max_diameter, screw_hole_diameter); };
    rotate(180, [0, 0, 1]) { screw_hole(motor_min_diameter, motor_max_diameter, screw_hole_diameter); };
    rotate(270, [0, 0, 1]) { screw_hole(motor_min_diameter, motor_max_diameter, screw_hole_diameter); };
  };
}

module screw_hole() {
  translate([0,0, -0.1]) {
      linear_extrude(height = height + 1) {
        flat_screw_hole(motor_min_diameter, motor_max_diameter, screw_hole_diameter);
      };
  };
}

module flat_screw_hole() {
  translate([(motor_min_diameter) / 2, 0, 0]) {
    hull() {
      circle(r = screw_hole_diameter / 2.0);
      translate([(motor_max_diameter - motor_min_diameter - screw_hole_diameter/2) / 2, 0, 0]) {
        circle(r = screw_hole_diameter / 2.0);
      };
    };
  };
}

