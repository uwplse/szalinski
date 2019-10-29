// setup

nozzle_height_finetuning = 3; // moves top screw holes up or down, negative value raises the shroud, positive lowers it - if you look through the shroud exit hole when mounted you should see the tip of the nozzle




// do not change anything after this point

shroud_angle = 30;
shroud_height = 2;

module shroud() {
  difference() {
    union() {
      // fan shroud top slope
      translate([0, -15 + shroud_height, 3]) rotate([-shroud_angle, 0, 0]) cube([40, 34, 8], center = true);

      // fan shroud extension
      //translate([0, -24, 4]) cube([40, 4, 10], center = true);
    }
    
    // cut top towards nozzle flush
    translate([0, shroud_height, 24]) cube([40 + 10, 50 + 10, 20], center = true);

    // cut side to make it sexy
    translate([25, -24 + shroud_height, 10]) rotate([0, 30, 0]) cube([30, 20, 8], center = true);
    translate([-25, -24 + shroud_height, 10]) rotate([0, -30, 0]) cube([30, 20, 8], center = true);
  }

}

difference() {
  union () {
    // baseplate
    translate([0, 0, 0]) cube([40, 52, 2], center = true);

    // mounting bumps for the fan (top)
    translate([-16, 10, 1]) cylinder(2, 2.5, 2.5, true, $fn = 50);
    translate([+16, 10, 1]) cylinder(2, 2.5, 2.5, true, $fn = 50);
 
    // create 2 fan shrouds, subtract the smaller, inner one to make the construct hollow
    difference() {
      shroud();
      translate([0, -5, -1]) scale([0.9, 0.8, 0.9]) shroud();
    } 
    // fix hole in bottom
    translate([0, -25 + shroud_height, 2]) rotate([-shroud_angle, 0, 0]) cube([40, 20, 6], center = true);
  }

  // cut side towards printbed flush again (for fix hole above)
  translate([0, -35 + shroud_height, 5]) cube([40 + 10, 10, 20], center = true);

  // mounting holes on top
  translate([-10, 18 + nozzle_height_finetuning, 0]) cylinder(20, 1.7, 1.7, true, $fn = 50);
  translate([+10, 18 + nozzle_height_finetuning, 0]) cylinder(20, 1.7, 1.7, true, $fn = 50);

  // mounting holes for the fan (top)
  translate([-16, 10, 0]) cylinder(20, 1.47, 1.47, true, $fn = 50);
  translate([+16, 10, 0]) cylinder(20, 1.47, 1.47, true, $fn = 50);

  // smooth top edges
  translate([20 + 4, 25 + 4, 0]) rotate([0, 0, 45]) cube([20, 20, 10], center = true);
  translate([-20 - 4, 25 + 4, 0]) rotate([0, 0, -45]) cube([20, 20, 10], center = true);

  difference() {  
    // opening for the main fan
    translate([0, -4, 0]) cylinder(10, 18, 18, true, $fn = 50);
  
    // cut the opening in half
    translate([0, -20, 0]) cube([40, 30, 20], center = true);
  }
  
  // cut the rear of the shroud open for the fan to blow air through
  translate([0, -20, 0]) cube([36, 10, 11], center = true);
  translate([0, -24, 1.12]) cube([36, 2, 11], center = true);

  // cut the slope again for the bottom
  translate([0, -13, 0]) rotate([-shroud_angle +9, 0, 0]) cube([36, 23, 10], center = true);
  
  // front opening towards nozzle (2 stages)
  translate([0, -27.8 + shroud_height, 13]) rotate([20, 0, 0]) cube([16, 3, 10], center = true);
  translate([0, -28.5 + shroud_height, 12]) rotate([45, 0, 0]) cube([8, 3, 10], center = true);

  // cut bottom towards fan flush
  translate([0, 0, -10.95]) cube([40 + 10, 50 + 10, 20], center = true);
}

// add additional mounting spots for the fan on the bottom
difference() {
  union() {
    // mounting bumps for the fan (bottom)
    translate([-16, 10 - 32, 1]) cylinder(4, 2.75, 2.75, true, $fn = 50);
    translate([+16, 10 - 32, 1]) cylinder(4, 2.75, 2.75, true, $fn = 50);

    // support for the mounting bumps
    translate([+16, 10 - 32 - 2, 0]) cube([5.25, 2.5, 2], center = true);
    translate([-16, 10 - 32 - 2, 0]) cube([5.25, 2.5, 2], center = true);
  }

  // mounting holes for the fan (bottom)
  translate([-16, 10 - 32, 0]) cylinder(20, 1.47, 1.47, true, $fn = 50);
  translate([+16, 10 - 32, 0]) cylinder(20, 1.47, 1.47, true, $fn = 50);

  // cut bottom towards fan flush
  translate([0, 0, -10.95]) cube([40 + 10, 50 + 10, 20], center = true);
}

difference() {
  union() {
    // add additional side walls to keep the air in and add stability
    translate([-19.5, -1.1, 2]) cube([1, 40, 3.5], center = true);
    translate([+19.5, -1.1, 2]) cube([1, 40, 3.5], center = true);
  }
  // make the walls sexy
  translate([0, 18.5, 3.5]) rotate([-shroud_angle, 0, 0]) cube([40 + 2, 10, 4], center = true);
}
