// A parametric guard for the Trym beard trimmer. The largest guard it comes with is 9mm which is
// not enough mms. This lets to have as many mms as you desire.
//
// First OpenSCAD project. Kind of a mess.

// The length to cut the hair in millimeters (measure twice, cut once though)
guard_height = 18;

/* Hidden */

base_width = 38.32;
base_length = 27.70+9.18;
base_thickness = 1.77;

base_notch_width= 11;
base_notch_length = 2.88;

root_width = 26.95;
root_height = 7.95-1.77+base_thickness;

module base_chamfer(dir) {
  translate([dir * (base_width/2), base_length/2, 0])
    rotate(a=dir*40, v=[0,0,1])
    cube([10.25, 10.25*2, base_thickness*2], center=true);
}


// Trym Guard Base
module trym_guard_base() {
  module base_core() {

    difference() {
      cube([base_width, base_length, base_thickness], center=true);
      union() {
        base_chamfer(1);
        base_chamfer(-1);
        translate([0, base_length/2, 0])
          cube([base_notch_width, base_notch_length*2, base_thickness*2], center=true);
      }
    }
  }

  module lock_tab() {
    lock_tab_offset = 1.97;
    lock_tab_width = 9.4;
    riser_length = 1.4;
    riser_height = 6.0;
    latch_sides = 1.25;

    translate([lock_tab_width/2, base_length/2+lock_tab_offset, -base_thickness/2])
      rotate(a=180, v=[0, 0, 1]) {
        cube([lock_tab_width, base_length, base_thickness]);
        difference() {
          translate([lock_tab_width/2, 0, 0]) cylinder(h=riser_height, d=lock_tab_width);
          union() {
            //translate([0, riser_length, base_thickness])
            //  cube([lock_tab_width, lock_tab_width, riser_height*2]);
            translate([0, -lock_tab_width-0.7, 0])
              cube([lock_tab_width, lock_tab_width, riser_height-riser_length]);
          }
        }
      }
  }

  module teeth_guard() {
    difference() {
      translate([0, -base_length/2 + root_width/2 - 8, -base_thickness/2+root_height/2])
        cube([base_width, root_width, root_height], center=true);
      union() {
        translate([0, -base_length/2-2, base_thickness/2+root_height/2+3.5])
          rotate(a=45, v=[1, 0, 0])
          cube([base_width, root_width, root_height], center=true);
      }
    }
  }

  translate([0, 0, base_thickness/2]) {
    difference() {
      union() {
        base_core();
        lock_tab();
        teeth_guard();
      }
      union() {
        for(i=[0:6]) {
          tooth_area_width = base_width-4;
          translate([tooth_area_width/2 - tooth_area_width/7*i - tooth_area_width/7/2, -base_length/2, root_height/2-base_thickness/2]) 
            cube([tooth_area_width/9, 9.18*2, 50], center=true);
        }
      }
    }
  }
}

head_length = 34.6;
head_width = 34.6;
head_thickness = 2.65;
module trym_head() {
  difference() {
    union() {
      translate([0, 1.1/4, 0]) cube([head_width, head_length-1.1/2, head_thickness], center=true);
      difference() {
        translate([0, 0.25, head_thickness/2+1/2])
          cube([head_width, head_length-0.5, 1], center=true);
        translate([-head_width/2, -head_length/2+0.5, head_thickness/2])
          rotate(a=45, v=[1, 0, 0])
          cube([head_width, 3, 3]);
      }
      translate([0, 0.75, head_thickness/2+1+10]) cube([head_width, head_length-1.5, 20], center=true);
      translate([0, -head_length/2 + 1, 0.15]) rotate(a=90, v=[0, 1, 0]) cylinder(d=2.6, h=head_width, center=true, $fn=20);
    }
    union() {
      translate([0, -head_length/2-0.3, 0])
        rotate(a=-10, v=[1, 0, 0])
        translate([-head_width/2, 0, -head_thickness-0.2])
        cube([head_width, 8.47+0.4, 3]);
      notch_depth = 0.9;
      notch_width = 9.5;
      translate([0, head_width/2-notch_depth/2, head_thickness/2+1]) cube([notch_width, notch_depth, 1], center=true);
    }
  }
}

module trym_base() {
  difference() {
    trym_guard_base();
    translate([0, 1.7, base_thickness + head_thickness/2])
      scale([1.02, 1.02, 1]) // wiggle room on the sides
      trym_head();
  }
}

module trym_teeth(height) {
  adjusted_height=height-2.4;
  rotate(a=180, v=[1, 0, 0])
    difference() {
      union() {
        difference() {
          union() {
            guard_base_length = 32;
            translate([0,5,0])
              rotate(a=90, v=[0, 0, 1])
              rotate(a=90, v=[1, 0, 0]) 
              translate([0,0,-base_width/2])
              linear_extrude(height=base_width) {
                // The "0.7" is the skew value; pushed along the y axis
                M = [ [ 1, 0.7, 0],
                  [ 0, 1, 0],
                  [ 0, 0, 1] ] ;
                multmatrix(M)
                  polygon([[0,0],
                      [-guard_base_length+2.45,0],
                      [-guard_base_length,-adjusted_height+5.5],
                      [-guard_base_length*0.75,-adjusted_height+3],
                      [-guard_base_length*0.50,-adjusted_height+1],
                      [-guard_base_length*0.25,-adjusted_height],
                      [-guard_base_length*0.08,-adjusted_height],
                      [-guard_base_length*0.06,-adjusted_height+0.3],
                      [-guard_base_length*0.04,-adjusted_height+0.7],
                      [0,-adjusted_height+3]]);

              }
            translate([0, 0, -1/2]) {
              difference() {
                cube([base_width, base_length, 1], center=true);
                union() {
                  base_chamfer(1);
                  base_chamfer(-1);
                  translate([0, base_length/2, 0])
                    cube([base_notch_width, base_notch_length*2, base_thickness*2], center=true);
                }
              }
            }
          }
          union() {
            for(i=[0:6]) {
              tooth_area_width = base_width-4;
              translate([tooth_area_width/2 - tooth_area_width/7*i - tooth_area_width/7/2, -base_length/2 - (9.18*18/2), root_height/2-base_thickness/2]) 
                cube([tooth_area_width/9, 9.18*20, 100], center=true);
              translate([tooth_area_width/2 - tooth_area_width/7*i - tooth_area_width/7/2, 0, -height/2-1]) 
                cube([tooth_area_width/9, height*2, height], center=true);
            }
          }
        }
        // text
        rotate(a=180, v=[0, 1, 0])
          translate([0, 10, 0])
          linear_extrude(height=base_thickness)
          rotate(a=180, v=[0, 0, 1])
          text(text = str(height, "mm"), font="Impact:style=Bold", size=7, halign="center", valign="center");
      }
      trym_base();
    }
}

trym_base();
translate([0, 50, 0]) trym_teeth(guard_height);
