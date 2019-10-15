$fn = 50;
cover_thickness = 6;
tube_thickness = 2;
pcb_disk_r = 53.5/2;
cover_disk_r = 54.5/2;
cover_r = pcb_disk_r+tube_thickness;
low_tube_pegs_h = 3;
pcb_support_h = 2.6;

module stick_with_holes() {
  clen = 5;
  cwidth = 8;
  translate([-cwidth/2, -pcb_disk_r-clen, 0]) {
   difference() {
      union() {
        translate([1, 0, 0]) {
          cube([cwidth-2, (pcb_disk_r + clen) * 2, cover_thickness]);
        }
        translate([cwidth/2, 0,  0]) {
          cylinder(r=cwidth/2, h=cover_thickness);
        }
        translate([cwidth/2, (pcb_disk_r+clen)*2,  0]) {
          cylinder(r=cwidth/2, h=cover_thickness);
        }
      }
      translate([cwidth/2, 0,  0]) {
        cylinder(r=1.8, h=cover_thickness);
      }
      translate([cwidth/2, (pcb_disk_r+clen)*2,  0]) {
        cylinder(r=1.8, h=cover_thickness);
      }
    }
  }
}


translate([0, 0, 0]) {
  union() {
    difference() {
      union() {
        cylinder(h=cover_thickness, r=cover_r);
        stick_with_holes();
        rotate(90) {
          stick_with_holes();
        }
      }
      cylinder(h=cover_thickness, r=pcb_disk_r-1);
    }
    translate([0, 0, cover_thickness-low_tube_pegs_h]) {
      rotate([0, 0, 45]) {
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
  }
}


module pcb_support() {
  translate([-5.5, -3, 0]) {
    difference() {
      union() {
        cube([11, 6, low_tube_pegs_h]);
        translate([4, 3, low_tube_pegs_h]) {
          cylinder(r=2.5, h=pcb_support_h);
        }
      }
      translate([4, 3, 0]) {
        cylinder(r=1.4, h=50);
      }
    }
  }
}

