show_tube = true;
show_rpi_plate = true;
show_back_lid = true;

use <pcb_protect.scad>;

$fn = 50;
cover_thickness = 3;
tube_thickness = 2;
pcb_disk_r = 53.5/2;
cover_disk_r = 54.5/2;
cover_r = pcb_disk_r+tube_thickness;

tube_height = 64;
tube_width = 64;
tube_length = 105;
tube_wall = 2;


module stick_with_holes(extra_len=0) {
  clen = 5;
  cwidth = 8;
  translate([-cwidth/2, -pcb_disk_r-clen-extra_len, 0]) {
   difference() {
      union() {
        cube([cwidth, (pcb_disk_r +extra_len + clen) * 2, cover_thickness]);
        translate([cwidth/2, 0,  0]) {
          cylinder(r=cwidth/2, h=cover_thickness);
        }
        translate([cwidth/2, (pcb_disk_r+extra_len+clen)*2,  0]) {
          cylinder(r=cwidth/2, h=cover_thickness);
        }
      }
      translate([cwidth/2, 0,  0]) {
        cylinder(r=1.8, h=cover_thickness);
      }
      translate([cwidth/2, (pcb_disk_r+extra_len+clen)*2,  0]) {
        cylinder(r=1.8, h=cover_thickness);
      }
    }
  }
}


module morphed() {
  hull() {
    translate([-32, -32, 17]) {
      cube([64, 64, cover_thickness]);
    }
    cylinder(r=cover_r, h=cover_thickness);
  }
}

module top_cover_holes() {
  rotate(0) {
    translate([15, 0, 17]) {
      stick_with_holes(5);
    }
    translate([-15, 0, 17]) {
      stick_with_holes(5);
    }
    rotate(90) {
      translate([0, 0, 17]) {
        stick_with_holes(5);
      }
    }
  }
}

module power_hole() {
  rotate([0, 270, 0]) {
    translate([12, -10, 20]) {
      cylinder(r=4, h=15);
    }
  }
}

module top_cover() {
  translate([0, 0, 0]) {
    rotate(0) {
      difference() {
        union() {
          cylinder(h=cover_thickness*4, r=cover_r);
          stick_with_holes();
          rotate(90) {
            stick_with_holes();
          }
          translate([0, 0, 10]) {
            difference() {
              union() {
                difference() {
                  morphed();
                  power_hole();
                }
                top_cover_holes();
              }
              scale([0.9, 0.9, 1]) {
                morphed();
              }
            }
          }
        }
        cylinder(h=cover_thickness*4, r=pcb_disk_r-1);
      }
    }
  }
}

module rpi_holes(r=1.8, h=3) {
  cylinder(r=r, h=h);
  translate([49, 0, 0]) {
    cylinder(r=r, h=h);
  }
  translate([49, -58.5, 0]) {
    cylinder(r=r, h=h);
  }
  translate([0, -58.5, 0]) {
    cylinder(r=r, h=h);
  }
}

module rpi_plate() {
  difference() {
    union() {
  
      translate([0, 65, 0]) {
        rotate([90, 90, 0]) {
          top_cover();
        }
      }
    
      translate([5, 0, 0]) {
        difference() {
          union() {
            // one board
            translate([14, -48, -5]) {
              // triangle
              translate([0, 85, 0]) {
                hull() {
                  translate([9, 11, 0]) {
                    cube([1, 1, 5]);
                  }
                    cube([13, 1, 5]);
                }
              }
              cube([13, 85, 5]);
            }
            // another board
            translate([-37, -48, -5]) {
              // triangle
              translate([0, 85, 0]) {
                hull() {
                  translate([2, 11, 0]) {
                    cube([1, 1, 5]);
                  }
                    cube([13, 1, 5]);
                }
              }
              cube([13, 85, 5]);
            }
            translate([-29, 21.5, -1]) {
              rpi_holes(r=3.5, h=3);
            }
          }
          translate([-29, 21.5, -10]) {
            rpi_holes(r=1.8, h=20);
          }
        }
      }
    }
    // to remove excessive walls
    // side walls
    translate([29, -50, -15]) {
      cube([5, 85, 80]);
    }
    translate([-34, -50, -15]) {
      cube([5, 85, 80]);
    }
//    translate([-35, 23, 6]) {
//      cube([70, 5, 25]);
//    }
//    translate([-35, -44.5, 3]) {
//      cube([70, 5, 30]);
//    }
  }
  pcb_power();
}


module tube_with_ears() {
  y_offset = -17.5;
  difference() {
    union() {
      translate([0, y_offset, 0]) {
        cube([tube_width, tube_length, tube_height], center=true);
      }
      translate([0, tube_length/2-0.5, 0]) {
        rotate([90, 90, 0]) {
          top_cover_holes();
        }
      }
      translate([0, -tube_length/2+2.5, 0]) {
        rotate([90, 90, 0]) {
//          top_cover_holes();
        }
      }
      connector();
    }
    translate([0, y_offset, 0]) {
      cube([tube_width-2*tube_wall, tube_length*2, tube_height-2*tube_wall], center=true);
    }
    translate([0, -tube_length/2-17+8, 0]) {
      translate([-tube_width/4, 0, 0])
        cylinder(r=1.8, h=100, center=true);
      translate([tube_width/4, 0, 0])
        cylinder(r=1.8, h=100, center=true);
      rotate([0, 90, 0]) {
        translate([-tube_height/4, 0, 0])
          cylinder(r=1.8, h=100, center=true);
        translate([tube_height/4, 0, 0])
          cylinder(r=1.8, h=100, center=true);
      }
    }
  }
}

module gopro_like_attach() {
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

module connector() {
  translate([10, 0, -31]) {
    rotate([0, -90, 90]) {
      gopro_like_attach();
    }
  }
}

module pcb_power() {
  translate([0, -10, -2.5]) {
    rotate([0, 180, -90]) {
      pcb_holder(pcb_height=11, pcb_width=20.5);
      translate([-5, -25, -2.4]) {
        cube([13, 50, 2]);
      }
    }
  }
}

module back_lid() {
  difference() {
    union() {
      union() {
        translate([0, -tube_length/3*2-1, 0]) {
          cube([tube_width, 2, tube_height], center=true);
          translate([0, 7, tube_height/2-1-tube_wall-0.5]) {
            cube([tube_width-tube_wall*2-1, 12, 2], center=true);
          }
          translate([0, 7, -tube_height/2+1+tube_wall+0.5]) {
            cube([tube_width-tube_wall*2-1, 12, 2], center=true);
          }
          translate([tube_width/2-1-tube_wall-0.5, 7, 0]) {
            cube([2, 12, tube_height-tube_wall*2-1], center=true);
          }
          translate([-tube_width/2+1+tube_wall+0.5, 7, 0]) {
            cube([2, 12, tube_height-tube_wall*2-1], center=true);
          }
        }
      }
//      latch_size = 61;
      translate([0, -tube_length/2-17+8, 0]) {
        translate([-tube_width/4, 0, 0]) {
//          cylinder(r=1.8, h=latch_size, center=true);
          translate([0, 0, tube_width/2-2.5]) {
            sphere(r=1.8, center=true);
          }
          translate([0, 0, -tube_width/2+2.5]) {
            sphere(r=1.8, center=true);
          }
        }
        translate([tube_width/4, 0, 0]) {
//          cylinder(r=1.8, h=latch_size, center=true);
          translate([0, 0, tube_width/2-2.5]) {
            sphere(r=1.8, center=true);
          }
          translate([0, 0, -tube_width/2+2.5]) {
            sphere(r=1.8, center=true);
          }
        }
        rotate([0, 90, 0]) {
          translate([-tube_height/4, 0, 0]) {
//            cylinder(r=1.8, h=latch_size, center=true);
            translate([0, 0, tube_height/2-2.5]) {
              sphere(r=1.8, center=true);
            }
            translate([0, 0, -tube_height/2+2.5]) {
              sphere(r=1.8, center=true);
            }
          }
          translate([tube_height/4, 0, 0]) {
//            cylinder(r=1.8, h=latch_size, center=true);
            translate([0, 0, tube_height/2-3]) {
              sphere(r=1.8, center=true);
            }
            translate([0, 0, -tube_height/2+3]) {
              sphere(r=1.8, center=true);
            }
          }
        }
      }
    }
    translate([0, -tube_length/3*2+7, 0]) {
      cube([tube_width-tube_wall*4-1, 10, tube_height-tube_wall*4-1], center=true);
      translate([-tube_width/2+28.5, 0, -tube_height/2+24]) {
        rotate([90, 0, 0]) {
          cylinder(r=3.5, h=100, center=true);
          translate([0, 0, 12.5]) {
            cylinder(r=5.5, h=10, center=true);
          }
        }
      }
    }
  }
  
}

if(show_rpi_plate)
  rpi_plate();
if(show_tube)
  tube_with_ears();
if(show_back_lid)
  back_lid();

