/////////////////////////////////////////////////////////////////////////
//  
//  'Tiffin Carrier Handle' by Chris Molloy (http://chrismolloy.com/)
//  
//  Released under Creative Commons - Attribution - Share Alike licence
//  
/////////////////////////////////////////////////////////////////////////

// Inner diameter of handle tube
pipe_id = 18;

// Wall thickness of handle tube
pipe_wall = 2.5;

/* Hidden */
pipe_od = pipe_wall + pipe_id + pipe_wall;
peg_radius = pipe_id / 2;
$fn = 100;

union() {
  translate([0, 0, pipe_od / 2]) {
    difference() {
      cube([28, 80, pipe_od], center = true);
      translate([0, 0, 4]) {
        cube([20, 90, pipe_od], center = true);
      }
    }
  }
  translate([29, 0, peg_radius + pipe_wall]) {
    rotate([0, 90, 0]) {
      cylinder(h = 30, r1 = peg_radius, r2 = peg_radius - 1, center = true);
    }
    translate([-14.5, 0, 0]) {
      rotate([0, 90, 0]) {
        cylinder(h = 1, r1 = peg_radius + pipe_wall, r2 = peg_radius, center = true);
      }
    }
    translate([14, 0, 0]) {
      rotate([0, 90, 0]) {
        rotate_extrude(convexity = 10)
        translate([peg_radius - 1, 0, 0])
        circle(r = 1);
      }
    }
  }
}