$fn = 50;
cover_thickness = 3;
tube_thickness = 2;
pcb_disk_r = 53.5/2;
cover_disk_r = 54.5/2;
cover_r = pcb_disk_r+tube_thickness;

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
  difference() {
    union() {
      difference() {
        cylinder(h=cover_thickness, r=cover_r);
        cylinder(h=cover_thickness, r=pcb_disk_r-1);
      }
      stick_with_holes();
      rotate(90) {
        stick_with_holes();
      }
      translate([-17.5, -7, 0]) {
        cube([35, 30, cover_thickness]);
      }
      translate([0, 6, 0]) {
        CameraMount(5);
      }
    }
    translate([0, 6, 0]) {
      CameraMount(2.8);
    }
  }
}


module CameraHole() {
  translate([-(12)/2, -10, 0]) {
    linear_extrude(3) {
      offset(0) {
        square([12, 18], 0);
      }
    }
  }
}


module CameraMount(d) {
  
  CameraHole();
  translate([-21/2, -6, 0]) {
    linear_extrude(cover_thickness+1) {
      circle(d=d);
    }
  }
  translate([+21/2, -6, 0]) {
    linear_extrude(cover_thickness+1) {
      circle(d=d);
    }
  }

  translate([-21/2, 6.5, 0]) {
    linear_extrude(cover_thickness+1) {
      circle(d=d);
    }
  }
  translate([+21/2, 6.5, 0]) {
    linear_extrude(cover_thickness+1) {
      circle(d=d);
    }
  }

  translate([-21/2, 13, 0]) {
    linear_extrude(cover_thickness+1) {
      circle(d=d);
    }
  }
  translate([+21/2, 13, 0]) {
    linear_extrude(cover_thickness+1) {
      circle(d=d);
    }
  }
}
