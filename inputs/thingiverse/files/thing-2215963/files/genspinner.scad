/* Generic Customizable Fidget Spinner */
/* Re-written to use the Write library. */

use <write/Write.scad>

/* Customizer App Setup: */

/* [Main Body] */
bearing_distance = 0; // [0:20]
arms             = 3; // [2,3,4,5,6,7]
arm_width        = 18; // [14:29]
chamfer          = 5; // [0:18]
engrave_word     = 0; // [0:No,1:Yes]
// Text to engrave on the sides.
spin_text        = "SPIN"; 
spin_text_angle  = 90; // [0:10:180]
notches          = 0; // [0:No,1:Yes]

/* [Outer Ring] */
outer_ring       = 1; // [0:No,1:Yes]
engrave_outer_ring  = 0; // [0:No,1:Yes]
// Text to engrave on the outer ring.
outer_ring_text  = "SPIN";



/* [Hidden] */
// Higher Res Rendering.
// $fa=.5; $fs=.5;


chamfer_r = chamfer / 10;

module bearing_holder(no_decor=0) {
  difference() {
    intersection() {
      cylinder(r=15,h=7,center=true);
      scale([1,1,0.5]) sphere(15.1+chamfer_r);
    }
    if (! no_decor) {
      if (engrave_word) {
        rotate([0,0,spin_text_angle]) writecylinder(spin_text,[0,0,0],15,5,t=2,center=true);
      }
      if (notches) {
        for(r=[-50:25:50]) rotate([0,0,r]) translate([15,0,0]) cylinder(r=2,h=8,center=true);
      }
    }
  }
}

module spoke() {
  intersection() {
    translate([bearing_distance / 2 + 13,0,0]) 
      cube([bearing_distance+22,arm_width,7], center=true);
    scale([1,1,0.575]) 
      translate([bearing_distance / 2 + 13,0,0]) 
        rotate([0,90,0]) 
          cylinder(h=bearing_distance+22,r=arm_width/2+0.1+chamfer_r,center=true);
  }
}
difference() {
  deg = 360/arms;
  union() {
    if (outer_ring) {
      difference() {
        intersection() {
          rotate_extrude() 
            translate([bearing_distance + 26,0,0]) 
              scale([.5,1,1]) 
                square(7,center=true);
          rotate_extrude() 
            translate([bearing_distance + 26,0,0]) 
              scale([.5,1,1]) 
                circle(3.7+chamfer_r/1.4);
        }
        if (engrave_outer_ring) 
          for(r=[deg/2-deg/4:deg:359+deg/2]) 
                rotate([0,0,r]) writecylinder(outer_ring_text,[0,0,0],bearing_distance + 27.75,5,t=2,center=true);
      }
    }
    for(r=[0:deg:359]) {
      rotate([0,0,r]) spoke();
      rotate([0,0,r]) translate([bearing_distance + 26,0,0]) bearing_holder();
    }
    bearing_holder(1);
  }
  union() {
    cylinder(r=11,h=8,center=true);
    for(r=[0:deg:359]) 
      rotate([0,0,r]) translate([bearing_distance + 26,0,0]) cylinder(r=11,h=8,center=true);
  }
}
