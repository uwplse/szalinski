$fn = 50;
cover_thickness = 2;
tube_thickness = 2;
pcb_disk_r = 53.5/2;
cover_disk_r = 54.5/2;
cover_r = pcb_disk_r+tube_thickness;
peg_thickness = 2;

module stick_with_holes() {
  clen = 5;
  cwidth = 8;
  translate([-cwidth/2, -pcb_disk_r-clen, 0]) {
   difference() {
      union() {
        cube([cwidth, (pcb_disk_r + clen) * 2, cover_thickness]);
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
  rotate(45) {
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
  }
}



