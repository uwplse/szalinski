show_box = true;
show_lid = true;

use <MCAD/boxes.scad>

pad = 0.5;
pcb_x = 45.2 + 2*pad;
pcb_y = 37.2 + 2*pad;
pcb_z = 1.6 + 2*pad;
hole_off_y = 23 + pad;
hole_off_x = 2 + pad;
hole_dist_x = 41;
wall = 2;

vm_x = 37.7 + pad;
vm_outer_x = 40.5 + pad;
vm_h = 20.7 + pad;

banana_hole_d = 4.6;
banana_outer_hole_d = 11.6;
banana_outer_border_d = 12.4;
banana_hole_z = wall + pad + max(banana_outer_border_d/2, vm_h/2);

inppad_x = 14;
box_x = wall + inppad_x + pad + pcb_x + pad + vm_outer_x
  + pad + banana_outer_border_d + pad + wall;
box_y = wall + pcb_y + wall;

elem_h = 14;
under_pcb_h = 2.5;

height = wall+max(under_pcb_h+pcb_z+elem_h, vm_h);
echo("height:", height);
full_height = height+2+wall;
echo("full height:", full_height);

lid_x = box_x + (pad+wall)*2;
lid_y = box_y + (pad+wall)*2;
lid_h = 3;
lid_border_h = wall;
lid_ear_h = 8;
lid_ear_w = 8;
lid_hole_d = 4;

control_hole_lid_x = 43 + pad + wall;
//control_hole_lid_x = box_x + pad + wall;
//control_hole_lid_y = 34 + pad + wall;
control_hole_lid_y = box_y - 6.7 + pad + wall;
control_hole_lid_top_d = 10;
control_hole_lid_bottom_d = 5;
control_hole_lid_h_max = 16;
control_hole_lid_h_min = 6;

$fn = 50;
font = "Liberation Sans";

module switch_holes() {
  cube([9.5, 50, 5], center=true);
  translate([9.5, 0, 0]) {
    rotate([90, 0, 0]) {
      cylinder(d=2.5, h = 50, center=true);
    }
  }
  translate([-9.5, 0, 0]) {
    rotate([90, 0, 0]) {
      cylinder(d=2.5, h = 50, center=true);
    }
  }
}

module banana_jaycar_female_hole() {
  h = 20;
  rotate([90, 0, 0]) {
    difference() {
      cylinder(d=banana_hole_d, h=h);
      translate([-10, banana_hole_d/2-0.5, 0]) {
        cube([20, 5, h]);
      }
      translate([-10, -banana_hole_d/2-5+0.5, 0]) {
        cube([20, 5, h]);
      }
    }
  }
}

module banana_female_hole(border=false) {
  h = 20;
  rotate([90, 0, 0]) {
    union() {
      if(border) {
        translate([0, 0, h/2]) {
          difference() {
            cylinder(d=banana_outer_border_d + 4, h=2);
            cylinder(d=banana_outer_border_d, h=2);
          }
        }
      } else {
        cylinder(d=banana_hole_d, h=h);
        translate([0, 0, h/2]) {
          cylinder(d=banana_outer_hole_d, h=h);
        }
      }
    }
  }
}

module pcb_holes(border=false, h=20) {
    translate([hole_off_x, hole_off_y, -h/2]) {
      d = 1.9 + (border ? 4 : 0);
      color("blue") {
      cylinder(d=d, h=h);
      translate([hole_dist_x, 0, 0]) {
        cylinder(d=d, h=h);
      }
      }
    }
}

module high_volt_box() {
  difference() {
    union() {
      difference() {
        cube([box_x, box_y, full_height]);
        translate([wall, wall, wall]) {
          cube([box_x-wall*2, box_y-wall*2, 50]);
        }
      }
      translate([wall+inppad_x, wall, wall+under_pcb_h/2]) {
        pcb_holes(border=true, h=under_pcb_h);
      }
    }
    translate([wall+inppad_x, wall, wall]) {
      pcb_holes();
    }
  }
  translate([wall+inppad_x, wall, wall]) {
    cube([pcb_x, (box_y-pcb_y)/2, under_pcb_h]);
    translate([0, box_y-wall*2-(box_y-pcb_y)/2, 0]) {
      cube([pcb_x, (box_y-pcb_y)/2, under_pcb_h]);
    }
  }
}

module banana_holes(border=false) {
  translate([wall+pad+(inppad_x)/2, 10, banana_hole_z]) {
    banana_female_hole(border=border);
  }
  translate([wall+pad+inppad_x+pad+pcb_x+pad+vm_outer_x+pad+
      banana_outer_border_d/2, 0, 0]) {
    translate([0, 10, banana_hole_z]) {
      banana_female_hole(border=border);
    }
  }
}

module vmeter_hole() {
  cube([vm_x, 20, vm_h]);
}

module lid_holes() {
  rotate([0, 90, 0]) {
    translate([0, 10, 0]) {
      cylinder(d=3.2, h=box_x+20);
    }
    translate([0, box_y-10, 0]) {
      cylinder(d=3.2, h=box_x+20);
    }
  }
}

module high_volt_enclosure() {
  difference() {
    union() {
      high_volt_box();
      banana_holes(border=true);
    }
    // lid_holes
    translate([-10, 0, full_height-lid_ear_h/2-lid_border_h+pad]) {
      lid_holes();
    }
    // power hole
    translate([wall + inppad_x/2, box_y, banana_hole_z]) {
      rotate([90, 90, 0]) {
        cylinder(d=8.8, h=10);
      }
    }
    banana_holes(border=false);
    // power switch hole
    translate([0, pcb_x/2, banana_hole_z]) {
      rotate([0, 0, 90]) {
        switch_holes();
      }
    }
    // volt meter
    translate([wall+pad+inppad_x+pad+pcb_x, 0, wall+pad]) {
      vmeter_hole();
    }
  }
}

module control_hole() {
  translate([control_hole_lid_x, control_hole_lid_y, lid_h]) {
    cylinder(d=control_hole_lid_top_d, h=lid_h*2, center=true);
  }
}

module control_hole_tube() {
  translate([control_hole_lid_x, control_hole_lid_y, -control_hole_lid_h_max+lid_border_h]) {
    difference() {
//    union() {
      cylinder(d=control_hole_lid_top_d+wall*2, h=control_hole_lid_h_max);
      translate([0, 0, wall]) {
        cylinder(d=control_hole_lid_top_d, h=control_hole_lid_h_max);
      }
      translate([2, 2, 0]) {
        rotate([0, 0, 45]) {
          cube([10, 10, control_hole_lid_h_max], center=true);
        }
      }
      translate([2, -control_hole_lid_top_d, -control_hole_lid_h_min]) {
        cube([50, 30, control_hole_lid_h_max]);
      }
      translate([-control_hole_lid_x, box_y-2-pad-control_hole_lid_y, 0]) {
        cube([box_x, box_y, full_height]);
      }
    }
  }
}

module high_volt_lid() {
  difference() {
    cube([lid_x, lid_y, lid_h+lid_border_h]);
    translate([(lid_x-box_x)/2-pad, (lid_y-box_y)/2-pad, 0]) {
      cube([box_x+pad*2, box_y+pad*2, lid_border_h]);
//      cube([lid_x, lid_y, lid_border_h]);
    }
    translate([20, wall*2+pad+10, lid_h]) {
      linear_extrude(height = 2) {
        text("HIGH VOLTAGE", font = font, size = 7, direction = "ltr", spacing = 1 );
        translate([0, -10, 0]) {
          text("DC STEP UP", font = font, size = 7, direction = "ltr", spacing = 1 );
        }
      }
    }
    control_hole();
  }
  control_hole_tube();
  translate([0, 0, -lid_ear_h]) {
    translate([0, wall+pad-lid_ear_w/2, 0]) {
      for(x=[0, lid_x-wall]) {
        for(y=[10, box_y-10]) {
          translate([x, y, 0]) {
            difference() {
              cube([wall, lid_ear_w, lid_ear_h]);
              translate([-15, lid_ear_w/2, lid_ear_h/2]) {
                rotate([0, 90, 0]) {
                  cylinder(d=lid_hole_d, h=30);
                }
              }
            }
          }
        }
      }
    }
  }
}

if(show_box)
  high_volt_enclosure();
if(show_lid)
  color("blue")
    translate([-(lid_x-box_x)/2, -(lid_y-box_y)/2, full_height-lid_border_h+pad]) {
      high_volt_lid();
    }
