/////////////////////////////////////////////////////////////////////////
//  
//  'Customizable Phone Steering Wheel' by http://brknfngr.com/
//  
//  Released under Creative Commons - Attribution - Share Alike licence
//  
/////////////////////////////////////////////////////////////////////////

phone_thickness = 12;
phone_width = 72;
phone_height = 140;

/* [Hidden] */
$fn = 50;
torus_radius = (max(phone_width, phone_height) / 2) + 5;

union() {
  difference() {
    translate([0, 0, phone_thickness]) {
      rotate_extrude(convexity = 10) { // wheel
        translate([torus_radius, 0, 0]) {
          circle(r = phone_thickness);
        }
      }
      hullBox(dims = [phone_width + 10, phone_height + 10, phone_thickness + 5], cornerRadius = 5, squareTop = false);
    }
    translate([0, 0, phone_thickness + 7.5]) { // phone cut-out
      cube([phone_width, phone_height, phone_thickness + 10], center = true);
    }
    translate([0, 0, 5]) { // rear cut-out
      cube([phone_width - 20, phone_height - 20, phone_thickness + 10], center = true);
    }
  }
  translate([(phone_width / 2) + 7, 0, (phone_thickness * 1.5) + 2]) { // tab
    difference() {
      cylinder(r = 10, height = 2.5, center = true);
      translate([3, 0, 0]) {
        cube([18, 22, 3.5], center = true);
      }
    }
  }
  translate([-((phone_width / 2) + 7), 0, (phone_thickness * 1.5) + 2]) { // tab
    difference() {
      cylinder(r = 10, height = 2.5, center = true);
      translate([-3, 0, 0]) {
        cube([18, 22, 3.5], center = true);
      }
    }
  }
}

module hullBox(dims, cornerRadius, squareTop = false) {
  x = dims[0] / 2;
  y = dims[1] / 2;
  z = dims[2] / 2;
  r = cornerRadius / 2;

  hull() {
    if (squareTop) {
      translate([x - cornerRadius, y - cornerRadius, z - r]) {
        cylinder(h = cornerRadius, r = cornerRadius, center = true);
      }
      translate([-(x - cornerRadius), y - cornerRadius, z - r]) {
        cylinder(h = cornerRadius, r = cornerRadius, center = true);
      }
      translate([x - cornerRadius, -(y - cornerRadius), z - r]) {
        cylinder(h = cornerRadius, r = cornerRadius, center = true);
      }
      translate([-(x - cornerRadius), -(y - cornerRadius), z - r]) {
        cylinder(h = cornerRadius, r = cornerRadius, center = true);
      }
    } else {
      translate([x - cornerRadius, y - cornerRadius, z - cornerRadius]) {
        sphere(r = cornerRadius);
      }
      translate([-(x - cornerRadius), y - cornerRadius, z - cornerRadius]) {
        sphere(r = cornerRadius);
      }
      translate([x - cornerRadius, -(y - cornerRadius), z - cornerRadius]) {
        sphere(r = cornerRadius);
      }
      translate([-(x - cornerRadius), -(y - cornerRadius), z - cornerRadius]) {
        sphere(r = cornerRadius);
      }
    }
    translate([x - cornerRadius, y - cornerRadius, -(z - cornerRadius)]) {
      sphere(r = cornerRadius);
    }
    translate([-(x - cornerRadius), y - cornerRadius, -(z - cornerRadius)]) {
      sphere(r = cornerRadius);
    }
    translate([x - cornerRadius, -(y - cornerRadius), -(z - cornerRadius)]) {
      sphere(r = cornerRadius);
    }
    translate([-(x - cornerRadius), -(y - cornerRadius), -(z - cornerRadius)]) {
      sphere(r = cornerRadius);
    }
  }
}

