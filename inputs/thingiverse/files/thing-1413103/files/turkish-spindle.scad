// Number of sides your stick has
side_count = 6;

// This is in mm, and must be measured at the largest diameter (corner-to-corner, not edge-to-edge).  My chopsticks are 5.5mm, pencils are 8mm.  
stick_diameter = 8;

// Length in mm
arm_length = 120;

// Width in mm - make sure it's greater than your stick's diameter!
arm_width = 13;

// Controls curvature of arms - higher numbers yield less curve.
radius_factor = 2; 

/* [Hidden] */
bevel = 2;
width = arm_width;
$fa = .5; // resolution: 3/3 is good for design, maybe use 0.5/0.5 for printing
$fs = .5;

module round_stick() { 
  length = 200;
  dia = stick_diameter;  // 5.5 seems to work for chopstick, trying 8 for pencil
  
  cylinder(h=length, r=dia/2, $fn=side_count); // $fn=6 gives hexagonal hole for pencil
}

module crossbar(width, thickness, bevel) {
  function loop_drop(arm_length=arm_length, radius_factor=radius_factor) = -cos(asin((arm_length/2)/(arm_length*radius_factor)))*arm_length*radius_factor; // calculates how far to lower the loop
  
  module loop() { // this module draws the big loop
    translate([-width/2, 0, loop_drop(arm_length, radius_factor)]) 
      rotate([0, 90, 0]) 
        rotate_extrude(angle=360, convexity=10, $fs=3, $fa=3)
          translate([bevel/2+radius_factor*arm_length-thickness/2, bevel/2, 0]) 
            minkowski() {
              square([thickness-bevel, width-bevel]);
              circle(r=bevel/2);
            }
  }  
  
  intersection() { // cuts the segment of the loop that we want
    loop();
    translate([-arm_length, -arm_length/2, 0]) cube([arm_length*2, arm_length, arm_length*2]);
  }
  
  intersection() { // makes the rounded ends
    loop();
    for (i=[1,-1])
      translate([0, i*arm_length/2, thickness/4])
        rotate([0, 90, 0])
          cylinder(h=width+2, r=thickness/4, center=true);
  }
}

module little_crossbar(template=false) { // set template true if using it to make a hole
  thickness = 6;
  clearance = .4;
  
  if (template==true) {
    crossbar(width=width+clearance, thickness=thickness+clearance, bevel=bevel);
  }
  else {
    difference() {
      crossbar(width=width, thickness=thickness, bevel=bevel);
      round_stick();
    }
  }
}

module big_crossbar() {
  difference() {
    crossbar(width=width, thickness=12, bevel=bevel);
    rotate([0,0,90]) little_crossbar(template=true);
    rotate([0,0,90]) round_stick(); // rotated to match other spindle in case the stick lacks 90* rotational symmetry
  }
}

translate([25, 0, width/2]) rotate([0, 90, 0]) // rotating may eliminate need for supports
  little_crossbar();
translate([0, 0, width/2]) rotate([0, 90, 0])
  big_crossbar();
