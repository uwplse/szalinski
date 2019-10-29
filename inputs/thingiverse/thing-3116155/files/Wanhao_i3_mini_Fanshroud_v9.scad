// setup

nozzle_height_finetuning = 3; // moves top screw holes up or down, negative value raises the shroud, positive lowers it - if you look through the shroud exit hole when mounted you should see the tip of the nozzle


// do not change anything after this point

shroud_angle = 30;
shroud_height = 2;

module shroud_diff_sides() {
  // cut side to make it sexy
  translate([23, -24 + shroud_height, 10]) rotate([0, 30, 0]) cube([30, 24, 8], center = true);
  translate([-23, -24 + shroud_height, 10]) rotate([0, -30, 0]) cube([30, 24, 8], center = true);

  // cut bottom to make it sexy
  translate([22, -31.6 + shroud_height, 10]) rotate([0, 0, 15]) cube([30, 8, 60], center = true);
  translate([-22, -31.6 + shroud_height, 10]) rotate([0, 0, -15]) cube([30, 8, 60], center = true);
}    

module shroud() {
  difference() {
    union() {
      // fan shroud top slope
      translate([0, -15 + shroud_height, 3.2]) rotate([-shroud_angle, 0, 0]) cube([40, 34, 8], center = true);

      // fan shroud extension
      //translate([0, -24, 4]) cube([40, 4, 10], center = true);
    }
    
    // cut top towards nozzle flush
    translate([0, shroud_height, 24]) cube([40 + 10, 50 + 10, 20], center = true);

    shroud_diff_sides();
  }

}

difference() {
  union () {
    // baseplate
    translate([0, 0, 0]) cube([40, 52, 2], center = true);

    // create 2 fan shrouds, subtract the smaller, inner one to make the construct hollow
    difference() {
      shroud();
      translate([0, -4, -1]) scale([0.9, 0.8, 0.9]) shroud();
    } 
    // fix hole in bottom
    translate([0, -25 + shroud_height, 2]) rotate([-shroud_angle, 0, 0]) cube([40, 20, 6], center = true);
  }

  // cut side towards printbed flush again (for fix hole above)
  translate([0, -35 + shroud_height, 5]) cube([40 + 10, 10, 20], center = true);

  // mounting holes on top
  translate([-10, 18 + nozzle_height_finetuning, 0]) cylinder(20, 1.7, 1.7, true, $fn = 50);
  translate([+10, 18 + nozzle_height_finetuning, 0]) cylinder(20, 1.7, 1.7, true, $fn = 50);

  // smooth top edges
  translate([20 + 4, 25 + 4, 0]) rotate([0, 0, 45]) cube([20, 20, 10], center = true);
  translate([-20 - 4, 25 + 4, 0]) rotate([0, 0, -45]) cube([20, 20, 10], center = true);

  difference() {  
    // opening for the main fan
    translate([0, -4 - 1.0, 0]) cylinder(10, 18, 18, true, $fn = 50);
  
    // cut the opening in half
    translate([0, -16 - 1.0, 0]) cube([40, 30, 20], center = true);
  }
  
  // cut the rear of the shroud open for the fan to blow air through
  translate([0, -20, 0]) cube([36, 10, 11], center = true);
  translate([0, -24, 1.12]) cube([36, 2, 11], center = true);

  // cut the slope again for the bottom
  translate([0, -10, -3]) rotate([-shroud_angle +9, 0, 0]) cube([36, 18, 10], center = true);
  translate([0, -10, 2]) rotate([-shroud_angle + 4, 0, 0]) cube([18, 28, 3], center = true);
  translate([-9.8, -10, 1.8]) rotate([-shroud_angle + 4, 0, 0]) rotate([0, 60, 0]) cube([2, 24, 3], center = true);
  translate([+9.8, -10, 1.8]) rotate([-shroud_angle + 4, 0, 0]) rotate([0, -60, 0]) cube([2, 24, 3], center = true);

  // cut slope entry flush
  translate([0, -5.9, 0]) rotate([-10, 0, 0]) cube([36, 10, 2], center = true);

  // cut sides again
  shroud_diff_sides();

  // cut a slope above opening
  translate([0, -26 + shroud_height, 11.22]) rotate([45, 0, 0]) cube([16, 2, 4], center = true);


  // front opening towards nozzle (2 stages)
  translate([0, -28 + shroud_height, 13]) rotate([20, 0, 0]) cube([16, 3, 10], center = true);
  translate([0, -30 + shroud_height, 12.5]) rotate([45, 0, 0]) cube([10, 1.5, 7], center = true);

  // cut bottom towards fan flush
  translate([0, 0, -10.95]) cube([40 + 10, 50 + 10, 20], center = true);
}

// add sides
difference() {
  union() {
    // add additional side walls to keep the air in and add stability
    translate([-19.5, -1.1, 2]) cube([1, 40, 3.5], center = true);
    translate([+19.5, -1.1, 2]) cube([1, 40, 3.5], center = true);
  }
  // make the walls sexy
  translate([0, 18.5, 3.5]) rotate([-shroud_angle, 0, 0]) cube([40 + 2, 10, 4], center = true);
}

// add angled fan mount...
difference() {
  union() {
    // baseplate
    translate([0, -5, -5]) rotate([15, 0, 0]) cube([40, 40, 4.3], center = true);
    // sides left / right
    translate([19.5, -7, 0.2]) rotate([15, 0, 0]) translate([-0.5, 0, 0]) cube([2, 50, 14], center = true);
    translate([-19.5, -7, 0.2]) rotate([15, 0, 0]) translate([+0.5, 0, 0]) cube([2, 50, 14], center = true);
    // sides towards print plate
    translate([0, -25.75, -5.2]) cube([40, 4.5, 14], center = true);
  }
  
  // opening for the main fan
  translate([0, -5, -5]) rotate([15, 0, 0]) cylinder(30, 18.6, 18.6, true, $fn = 50);

  // inner slope to lead towards the bottom
  translate([0, -22.5, -3]) rotate([15, 0, 0]) cube([37, 4, 9], center = true);

  // mounting holes for the fan (top)
  translate([-16, 11, 0]) rotate([15, 0, 0]) cylinder(20, 1.43, 1.43, true, $fn = 50);
  translate([+16, 11, 0]) rotate([15, 0, 0]) cylinder(20, 1.43, 1.43, true, $fn = 50);

  // mounting holes for the fan (bottom)
  translate([-16, 11 - 31, -10]) rotate([15, 0, 0]) cylinder(10, 1.43, 1.43, true, $fn = 50);
  translate([+16, 11 - 31, -10]) rotate([15, 0, 0]) cylinder(10, 1.43, 1.43, true, $fn = 50);

  // cut top towards the original shroud flush again
  translate([0, 3, 7.99]) cube([40 + 10, 50 + 10, 14], center = true);
  
  shroud_diff_sides();

  // cut bottom again
  translate([0, -33, 0]) cube([40 + 10, 10, 40 + 10], center = true);
  translate([0, -25.75, -5.2 - 10]) cube([42, 5, 6], center = true);
}