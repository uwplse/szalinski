/************************************************************************
  Long bobbin case for vintage Singer sewing machines
    by Radiofan @ thingiverse, 2019
************************************************************************/

// Number of bobbins
n_bobbins = 7; // [4:12]

/* [Hidden] */

// Bobbin dimensions
bobbin_length = 35;
bobbin_diameter = 10;

// Case printing parameters
inner_wall = 0.8;
outer_wall = 1.2;

// Circle/curve rendering accuracy
$fa = 1;    // Angle of slice
$fs = 0.15; // Minimum step

// Internal vars
bobbin_r = bobbin_diameter / 2;
bobbin_outer = bobbin_r + inner_wall;

module bobbin_half() {
  translate([bobbin_length, 0, bobbin_outer]) rotate([0,-90,0]) difference() {
    // Tube
    difference() {
      cylinder(bobbin_length, bobbin_outer, bobbin_outer);
      translate([0,0,-0.1]) cylinder(bobbin_length+0.2, bobbin_r, bobbin_r);
    }
    // Cun in half
    translate([0,-bobbin_outer,-0.1]) cube([bobbin_outer,2*bobbin_outer,bobbin_length+0.2]);
  }
}

module bobbin_rack() {
  translate([0,bobbin_outer,0]) for(i = [0:1:n_bobbins-1]) {
    translate([0,i*(bobbin_diameter + inner_wall), 0]) bobbin_half();
  }
}

module finger_grip() {
  cube([15, 0.4, 0.5]);
  translate([0,0, 1]) cube([15, 0.4, 0.5]);
  translate([0,0, 2]) cube([15, 0.4, 0.5]);
  translate([0,0, 3]) cube([15, 0.4, 0.5]);
}

module bobbin_tray() {
  bobbin_rack();
  // Outer case
  difference() {
    translate([-outer_wall,0,0]) cube([bobbin_length +  2 * outer_wall, n_bobbins * (bobbin_diameter + inner_wall) + inner_wall, bobbin_outer]);
    translate([0,inner_wall,inner_wall]) cube([bobbin_length, n_bobbins * (bobbin_diameter + inner_wall) - inner_wall, bobbin_outer]);
  }
  // Finger grip
  translate([-outer_wall-inner_wall,n_bobbins*(bobbin_diameter+inner_wall)-15,4]) rotate([0,0,90]) finger_grip();
}

module tooth() {
  translate([inner_wall, inner_wall + bobbin_r/2,bobbin_r + 1]) rotate([0,-90,0]) {
    cylinder(inner_wall,bobbin_r/2,bobbin_r/2,$fn=3);
    translate([0,bobbin_r,0]) cylinder(inner_wall,bobbin_r/2,bobbin_r/2,$fn=3);
  }
  translate([0,inner_wall,2.8]) cube([0.4,bobbin_diameter, 2]);
}

module gripper() {
  for(i = [0:1:n_bobbins-1]) {
    translate([0,i*(bobbin_diameter + inner_wall), 0]) tooth();
  }
  translate([-outer_wall-inner_wall, 0, 2.5]) cube([inner_wall, n_bobbins * (bobbin_diameter + inner_wall) + inner_wall, 6]);
  translate([-outer_wall-0.4, 0, 1.2]) cube([0.4, n_bobbins * (bobbin_diameter + inner_wall) + inner_wall, 1.5]);
}

module front_edge() {
  translate([-inner_wall-outer_wall, -inner_wall, 2.5]) cube([bobbin_length + 2 * (inner_wall+outer_wall), inner_wall, 6]);
  translate([-inner_wall-outer_wall, -0.4, 1.2]) cube([bobbin_length + 2 * (inner_wall+outer_wall), 0.4, 1.5]);
  translate([bobbin_length - 15,-inner_wall-0.4, 4]) finger_grip();
}

module side1() {
  bobbin_tray();
  gripper();
  front_edge();
}

module side2() {
  bobbin_tray();
  gripper();
  translate([bobbin_length, n_bobbins * (bobbin_diameter + inner_wall) + inner_wall, 0]) rotate([0,0,180]) front_edge();
}

translate([5,0,0]) side1();
translate([-bobbin_length -  2 * outer_wall-5,0,0]) side2();
