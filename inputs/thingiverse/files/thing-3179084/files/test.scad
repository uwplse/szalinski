JOINT_SIZE_X = 10;
JOINT_SIZE_Y = 6;
JOINT_SIZE_Z = 5;

include <chain-joint.scad>

BASE_SIZE = 2;

module base_m() {
    translate([0-JOINT_SIZE_X/2, -BASE_SIZE, 0]) cube([JOINT_SIZE_X, BASE_SIZE, JOINT_SIZE_Z]);
    joint_m();
}

module base_f() {
    translate([0-JOINT_SIZE_X/2, -BASE_SIZE, 0]) cube([JOINT_SIZE_X, BASE_SIZE, JOINT_SIZE_Z]);
    joint_f();
}

render() {
  translate([JOINT_SIZE_X * 0.75, 0, 0])
    base_f();
  translate([-JOINT_SIZE_X * 0.75, 0, 0])
    base_m();
}
