$fn = 50;
pcb_disk_thickness = 1.5;
cover_disk_thickness = 1.5;
tube_thickness = 2;
interdisk_h = 10 + pcb_disk_thickness + cover_disk_thickness;
low_tube_pegs_h = 3;
pcb_disk_r = 53.5/2;
cover_disk_r = 54.5/2;
peg_thickness = 2;

module stick_with_holes() {
  clen = 5;
  cwidth = 8;
  translate([-cwidth/2, -pcb_disk_r-clen, 0]) {
   difference() {
      union() {
        cube([cwidth, (pcb_disk_r + clen) * 2, 3]);
        translate([cwidth/2, 0,  0]) {
          cylinder(r=cwidth/2, h=3);
        }
        translate([cwidth/2, (pcb_disk_r+clen)*2,  0]) {
          cylinder(r=cwidth/2, h=3);
        }
      }
      translate([cwidth/2, 0,  0]) {
        cylinder(r=1.8, h=3);
      }
      translate([cwidth/2, (pcb_disk_r+clen)*2,  0]) {
        cylinder(r=1.8, h=3);
      }
    }
  }
}


translate([0, 0, 0]) {
  rotate(45) {
    difference() {
      union() {
        difference() {
          union() {
            cylinder(h=interdisk_h, r=pcb_disk_r+tube_thickness);
            stick_with_holes();
            rotate(90) {
              stick_with_holes();
            }
          }
          // hole to insert pcb
          cylinder(h=interdisk_h, r=pcb_disk_r);
        }
        translate([-pcb_disk_r, -peg_thickness/2, 0]) {
          cube([peg_thickness, peg_thickness, interdisk_h]);
        }
        translate([-peg_thickness/2, -pcb_disk_r, 0]) {
          cube([peg_thickness, peg_thickness, interdisk_h]);
        }
        translate([pcb_disk_r-peg_thickness, -peg_thickness/2, 0]) {
          cube([peg_thickness, peg_thickness, interdisk_h]);
        }
        translate([-peg_thickness/2, pcb_disk_r-peg_thickness, 0]) {
          cube([peg_thickness, peg_thickness, interdisk_h]);
        }
      }
      // hole to insert cover disk
      cylinder(h=cover_disk_thickness, r=cover_disk_r);
    }
  }
}

module pcb_support() {
  translate([-5.5, -3, 0]) {
    difference() {
      union() {
        cube([11, 6, low_tube_pegs_h]);
      }
      translate([4, 3, 0]) {
        cylinder(r=1.4, h=50);
      }
    }
  }
}


// low support tube
translate([0, 0, interdisk_h]) {
  rotate(45) {
    difference() {
      union() {
        cylinder(h=low_tube_pegs_h, r=pcb_disk_r+tube_thickness);
        rotate(45) {
          stick_with_holes();
        }
        rotate(135) {
          stick_with_holes();
        }
      }
      cylinder(h=low_tube_pegs_h, r=pcb_disk_r-1);
    }
    translate([-pcb_disk_r, -peg_thickness/2, 0]) {
      cube([peg_thickness, peg_thickness, low_tube_pegs_h]);
    }
    translate([-peg_thickness/2, -pcb_disk_r, 0]) {
      cube([peg_thickness, peg_thickness, low_tube_pegs_h]);
    }
    translate([pcb_disk_r-peg_thickness, -peg_thickness/2, 0]) {
      cube([peg_thickness, peg_thickness, low_tube_pegs_h]);
    }
    translate([-peg_thickness/2, pcb_disk_r-peg_thickness, 0]) {
      cube([peg_thickness, peg_thickness, low_tube_pegs_h]);
    }
    translate([-pcb_disk_r+5.5, 0, 0]) {
      rotate(180) {
        pcb_support();
      }
    }
    translate([pcb_disk_r-5.5, 0, 0]) {
      pcb_support();
    }
    rotate(90) {
      translate([-pcb_disk_r+5.5, 0, 0]) {
        rotate(180) {
          pcb_support();
        }
      }
      translate([pcb_disk_r-5.5, 0, 0]) {
        pcb_support();
      }
    }
  }
}


