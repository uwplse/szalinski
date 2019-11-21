include <sg90.scad>
include <fillet.scad>
include <holes.scad>

wall = 1.32;
e = 0.01; // added to prevent coplanar difference

function inch(i) = i * 25.4;

// Base block
block_w = inch(1.75);
block_d = inch(0.25);
block_h = inch(1.125);

module switch_arm(h) {
  arm_w = 17; // arm radius
  arm_d = 3.8;  // arm center circle radius
  arm_h = 3.7; //3.5 // arm total depth
  arm_inset_h = 1.7;

  switch_h = 8.5;
  switch_w = 20;
  switch_d = arm_h;

  // Required area is that which holds the servo arm
  required_h = arm_d + arm_w + 2*wall;
  difference() {
    // stick bit
    cube_fillet([2*(arm_d+wall),h-switch_h,arm_h], vertical=[0,0,arm_d,arm_d], $fn=24);
    // servo arm inset
    translate([arm_d+wall,arm_d+wall,-e]) {
      cylinder_poly(r=arm_d, h=arm_h+2*e);
      translate([0,0,arm_inset_h+e])
        linear_extrude(arm_h-arm_inset_h+e)
          polygon(points=[[-arm_d*0.90,0], [-arm_d*0.5,arm_w+0.01], [arm_d*0.5, arm_w+0.01], [arm_d*0.90, 0]]);
    }
  } // difference

  // Holder of the microswitch
  color("orange")
  translate([0,h-switch_h,0]) {
    difference() {
      cube([13,switch_h,switch_d]);

      // Holder screwholes
      translate([switch_w-11,switch_h/1.6,-e])
        cylinder_poly(r=M2p5_clear/2, h=switch_d+2*e);
      translate([switch_w-17,switch_h/1.6,-e])
        cylinder_poly(r=M2p5_clear/2, h=switch_d+2*e);
    } // diff
  } // translate+rotate
}



translate([-25,0,0])
    switch_arm(31);
