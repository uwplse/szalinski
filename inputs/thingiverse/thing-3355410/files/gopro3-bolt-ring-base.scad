// Circular base plate with a 3 prong goPro mount that can be bolted
// or screwed down. Mounting holes allow the base plate to be rotated to
// different positions. Thanks to
// https://www.thingiverse.com/thing:3088912 for providing the building
// blocks of building custom goPro mounts. You can use an 20 mm M5 bolt
// (or longer) and nut for the goPro hinge. You can customize the holes
// in the mounting plate based on the hardware you have.

// How much to raise the 3 prong goPro mount above the base plate (mm).
Extra_Mount_Depth = 3;

// Radius from center of base plate to drill holes for mounting (mm).
bolt_hole_radius = 18;

// Number of holes to drill in base plate (evenly spread).
bolt_hole_cnt = 24;

// Diameter of holes to drill in base plate (mm). I typically use 3 mm
// for 2.5 mm bolts.
bolt_hole_diameter = 3;

// How thick to make the base plate (mm)
plate_thick = 3;


plate_radius = bolt_hole_radius + bolt_hole_diameter * 1.5;
bolt_hole_r = bolt_hole_diameter / 2;

$fa = 2;
$fs = 0.25;

// Creates the circular base plate.
module base_plate() {
  r = plate_radius;
  numAngles = bolt_hole_cnt;
  angles=[ for (i = [0:numAngles]) i*(360/numAngles) ];
  rotation_ofs = 0;
  
  translate([0, 0, -plate_thick]) difference() {
    union() {
      cylinder(plate_thick, r, r);
    }
    for (a = angles) {
      x = sin(a + rotation_ofs) * bolt_hole_radius;
      y = cos(a + rotation_ofs) * bolt_hole_radius;
      translate([x, y, 0])
      cylinder(plate_thick, bolt_hole_r, bolt_hole_r);
    }
  }  
}

// Used to create nut hole for M5 nut in 3 prong goPro mount prong.
module nut_hole() {
  rotate([90, 90, 0])
  for(i = [0:(360 / 3):359]) {
    rotate([0, 0, i])
    cube([4.6765, 8.1, 5], center = true);
  }
}

// Single flap (prong) in goPro mount connector.
module flap(Width) {
  rotate([90, 0, 0])
  union()	{
    translate([3.5, (-7.5), 0])
    cube([4 + Extra_Mount_Depth, 15, Width]);

    translate([0, (-7.5), 0])
    cube([7.5 + Extra_Mount_Depth, 4, Width]);

    translate([0, 3.5, 0])
    cube([7.5 + Extra_Mount_Depth, 4, Width]);

    difference() {
      cylinder(h = Width, d = 15);

      translate([0, 0, (-1)])
      cylinder(h = Width + 2, d = 6);
    }
  }
}

// Creates 2 narrow mounting tabs.
module mount2() {
  union() {
    translate([0, 4, 0])
    flap(3);

    translate([0, 10.5, 0])
    flap(3);
  }
}

// Creates full 3 prong connector with hex nut cut out.
module mount3() {
  union() {
    difference() {
      translate([0, (-2.5), 0])
      flap(8);

      translate([0, (-8.5), 0])
      nut_hole();
    }

    mount2();
  }
}

//* GoPro Mount - 3 flap w/nut hole
translate([0, 0, 7.5 + Extra_Mount_Depth]) rotate([0, 90, 0]) mount3();
base_plate();
