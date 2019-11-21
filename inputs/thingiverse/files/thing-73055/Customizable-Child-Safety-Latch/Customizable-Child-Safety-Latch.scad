$fn=30*1;

// Just for the customizer

use <utils/build_plate.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// The real thing

// knob_diameter = the diameter of the knob bases
knob_diameter=10; //[8:16]

// knob_distance = the distance between the knob bases measured from the nearest edges
knob_distance=80; //[50:120]

translate([0,0,2.5]) safety_clip(length=knob_distance, knob_d=knob_diameter);

module safety_clip(length, knob_d=9) {
  knob_r=(knob_d+1)/2;

  difference() {
    union() {
      // The frame
      difference(){
        linear_extrude(height=5,center=true)
            polygon(points=[[-length/2-knob_r,-knob_d],[-length/2-knob_r,knob_d-1],[length/2+knob_r,knob_d+1],[length/2+knob_r,-(knob_d+2)]]);
        hull(){
          translate([-(length/2-knob_d),-(knob_d-6),-4]) cylinder(r=2,h=8);
          translate([-(length/2-knob_d/1.58),knob_d-6,-4]) cylinder(r=2,h=8);
          translate([length/2-knob_d/1.465,knob_d-6,-4]) cylinder(r=2,h=8);
          translate([length/2-knob_d,-(knob_d-6),-4]) cylinder(r=2,h=8);
        }
      }

      // The latching end
      translate([-length/2-knob_r,0,0]) cylinder(r=knob_d,h=5,center=true);

      // The slightly larger pivoting end
      translate([length/2+knob_r,0,0]) cylinder(r=knob_d+2,h=5,center=true);
    }

    // The hole for the latching end
    translate([-length/2-knob_r,0,0]) cylinder(r=knob_r,h=7,center=true);
    translate([-length/2-knob_r,5,0]) linear_extrude(height=9,center=true)
        polygon(points=[[-knob_r,-5],[knob_r,-5],[knob_r/1.58,knob_r+3],[-knob_r/1.58,knob_r+3]]);

    // The slightly narrower hole for the pivoting end
    translate([length/2+knob_r,0,0]) cylinder(r=knob_r,h=7,center=true);
    translate([length/2+knob_r,5,0]) linear_extrude(height=9,center=true)
        polygon(points=[[-knob_r,-5],[knob_r,-5],[knob_r/1.465,knob_r+5],[-knob_r/1.465,knob_r+5]]);
  }
        
}