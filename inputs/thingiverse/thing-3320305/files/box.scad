// to show box set to true
show_box = true;
// to show box lid set to true
show_lid = true;
// to show button holder set to true
show_bh = true;

use <ear.scad>

$fn = 50;
wall = 2;
pcb_hole_width = 21;
pcb_hole_length = 45;
stand_length = 5;
stand_width = 5;
box_main_height = 18;
stand_height = 4;
lid_height = 3;
hole_d = 1.6;

module stand() {
  cube([stand_length, stand_width, stand_height]);
}

module hole() {
  translate([2.5, 2.5, -10]) {
    cylinder(d=hole_d, h=20);
  }
}

module cones_with_holes(upside_down=false, height_extra=7) {
  x_rotate = upside_down ? 180 : 0;
  translate([pcb_hole_length+0.5, 0, 0]) {
    rotate([x_rotate, 0, 90]) {
      bolt_hole_cone(wall_extra=0, height_extra=height_extra);
    }
  }
  translate([6, 0, 0]) {
    rotate([x_rotate, 0, 90]) {
      bolt_hole_cone(wall_extra=0, height_extra=height_extra);
    }
  }
  translate([pcb_hole_length+0.5, pcb_hole_width+wall*2, 0]) {
    rotate([x_rotate, 0, -90]) {
      bolt_hole_cone(wall_extra=0, height_extra=height_extra);
    }
  }
  translate([6, pcb_hole_width+wall*2, 0]) {
    rotate([x_rotate, 0, -90]) {
      bolt_hole_cone(wall_extra=0, height_extra=height_extra);
    }
  }
}

module m5box() {
  difference() {
    union() {
      difference() {
        union() {
          cube([pcb_hole_length+wall*2,
            pcb_hole_width+wall*2, box_main_height]);
          translate([7.5+wall, 27+wall, -7.5+wall]) {
            rotate([270, 180, 90]) {
              connector();
            }
          }
          translate([0, 0, box_main_height]) {
            cones_with_holes();
          }
        }
        translate([wall, wall, wall]) {
          cube([pcb_hole_length, pcb_hole_width, 20]);
        }
        // side hole
        translate([pcb_hole_length, 4.5 + wall, wall+stand_height-4]) {
          cube([20, 13, 20]);
        }
        // top wall bolts hole
        translate([pcb_hole_length, wall, box_main_height-4]) {
          translate([0, 1.5, 0]) {
            rotate([0, 90, 0]) {
              cylinder(d=hole_d, h=20);
            }
          }
          translate([0, pcb_hole_width-1.5, 0]) {
            rotate([0, 90, 0]) {
              cylinder(d=hole_d, h=20);
            }
          }
        }
        // hole for reset
        translate([pcb_hole_length-8.5,
            pcb_hole_width+wall-3, stand_height+wall]) {
          cube([5, 10, 3]);
        }
        // hole for on/off button
        translate([pcb_hole_length-22-wall,
            pcb_hole_width+wall+5, box_main_height-4.5]) {
          rotate([90, 0, 0]) {
            cylinder(d=4, h=10);
            translate([8, 0, 0]) {
              cylinder(d=2.6, h=10);
            }
            translate([-8, 0, 0]) {
              cylinder(d=2.6, h=10);
            }
          }
        }
      
      }
      
      translate([wall, wall, wall]) {
        stand();
      }
      translate([wall, pcb_hole_width-stand_width+wall, wall]) {
        stand();
      }
      translate([pcb_hole_length-stand_length+wall, wall, wall]) {
        stand();
      }
      translate([pcb_hole_length-stand_length+wall,
          pcb_hole_width-stand_width+wall, wall]) {
        stand();
      }
    }

    translate([pcb_hole_length-stand_length+wall, wall, 0]) {
      hole();
    }
    translate([pcb_hole_length-stand_length+wall, 16+wall, 0]) {
      hole();
    }
    // camera hole
    translate([13, pcb_hole_width/2+wall, -5]) {
      cylinder(r=4, h=10);
    }
  }
}

module m5lid() {
  cones_with_holes(upside_down=true, height_extra=0, hole_d=3.2);
  cube([pcb_hole_length+wall*2, pcb_hole_width+wall*2, lid_height]);
  translate([38, wall-0.5, -6.9]) {
    rotate([90, 0, 0]) {
      import("single-cell-charger.stl");
    }
  }
}

module m5flat_holes_lid() {
  cones_with_holes(upside_down=true, height_extra=0, hole_d=3.2);
  lid_length = 60;
  extra = (lid_length - (pcb_hole_length+wall*2))/2;
  translate([-extra/2, 0, 0]) {
    difference() {
      cube([lid_length, pcb_hole_width+wall*2, lid_height]);
      // hole for wires
      translate([lid_length-15, pcb_hole_width/2+wall, 0]) {
        cylinder(d=5, h=10);
      }
      translate([4.5, pcb_hole_width/2+wall, 0]) {
        translate([0, 6.25, 0]) {
          cylinder(d=hole_d, h=10);
        }
        translate([0, -6.25, 0]) {
          cylinder(d=hole_d, h=10);
        }
        translate([51.5, 6.25, 0]) {
          cylinder(d=hole_d, h=10);
        }
        translate([51.5, -6.25, 0]) {
          cylinder(d=hole_d, h=10);
        }
      }
    }
  }
}

module connector() {
  translate([7, 5.5, 7.5]) {
    cube([19, 15, wall]);
  }
  translate([26.5, 5.4, 5.4]) {
    rotate([0, 90, 90]) {
      for(y=[0, 6.4]) {
        translate([-10.2, 6.9+y, 7.6]) {
          rotate([90, 0, 0]) {
            difference() {
              union() {
                cylinder(d=14.7, h=2.6, center=true);
                translate([5, 0, 0]) {
                  cube([10, 14.7, 2.6], center=true);
                }
              }
              translate([-1.4, 0.1, 0]) {
                cylinder(d=6, h=3, center=true);
              }
            }
          }
        }
      }
    }
  }
}

module button_hold() {
  difference() {
    union() {
      cube([12, 1.5, 2]);
      translate([-4, 0, -1]) {
        difference() {
          cube([4, wall+2, 4]);
          translate([2, 5, 2]) {
            rotate([90, 0, 0]) {
              cylinder(d=2, h=10);
            }
          }
        }
      }
      translate([12, 0, -1]) {
        difference() {
          cube([4, wall+2, 4]);
          translate([2, 5, 2]) {
            rotate([90, 0, 0]) {
              cylinder(d=2, h=10);
            }
          }
        }
      }
    }
    translate([4, 1, 0]) {
      cube([4, 1.5, 3]);
    }
  }
}

if(show_box)
  m5box();
if(show_lid)
  translate([0, 0, 25]) { 
    m5flat_holes_lid();
  }
if(show_bh)
  translate([0, 0, 50]) { 
    button_hold();
  }
