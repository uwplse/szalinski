

BASE=43.5;
TOP=35.5;
HEIGHT=9;

$fn = 100;

module quick_release_body(base=BASE, top=TOP, height=HEIGHT) {
  width = base + 6.5;
  depth = base + 6.5;
  body_height = height + 8;
  knob_offset = base - 8.5;
  color("orange") difference() {
    union() {
      translate([width/-2, depth/-2, 0]) rounded_cube(size=[width, depth, body_height], flat_bottom=true);
      translate([0,knob_offset, 0]) cylinder(r=10,h=body_height);
      translate([-10,14.5, 0]) cube(size=[20,20,body_height]);
    }
    translate([0,depth/-2+5, body_height - height + 0.5]) headspace(base, top, height);
    translate([0,knob_offset, -1]) cylinder(h=body_height+2, r=3);
    translate([0,knob_offset, -1]) cylinder(h=6.5, r=5.75, $fn=6);
  }
}

module knob(base=BASE, top=TOP, height=HEIGHT) {
  color("purple") difference() {
    union() {
      intersection() {
        hull() {
          cylinder(h=0.05, r=9.5);
          translate([0,1,height-1]) cylinder(h=0.05, r=base-top+7);
        }
        translate([0,7,0]) cylinder(h=20, r=15);
      }
      rotate([0,0,-14]) translate([-30, -2.5, 0]) rounded_cube(size=[30,5,8], r=2, flat_bottom=false);
    }
    translate([0,0,2.5]) cylinder(h=6, r=5);
    translate([0,0,-1]) cylinder(h=15, r=3);
  }
}

module headspace(base, top, height) {
  offset = sqrt(pow(base-top,2) + pow(height,2))/2;
  translate([base/-2,20,0]) cube(size = [base,base*2, height]);
  translate([base/-2,0,0]) hull() {
     translate([0,offset,0]) cube(size = [base,base, height*2/3]);
     translate([2,offset,height*2/3]) cube(size = [base-4,base, height/3]);
     translate([0,0,0]) cube(size = [base,base, 0.5]);
  }
}

module rounded_cube(size=[50,50,50], r=2.5, flat_bottom=false, $fn=$fn) {
  y_offset = flat_bottom ? r : 0;
  difference() {
    translate([r,r,r]) hull () {
      translate([0,0,-y_offset]) sphere(r=r);
      translate([size[0]-r*2, 0, -y_offset]) sphere(r=r);
      translate([size[0]-r*2, size[1]-r*2, -y_offset]) sphere(r=r);
      translate([size[0]-r*2, size[1]-r*2, size[2]-r*2]) sphere(r=r);
      translate([0, size[1]-r*2, size[2]-r*2]) sphere(r=r);
      translate([0, 0, size[2]-r*2]) sphere(r=r);
      translate([size[0]-r*2, 0, size[2]-r*2]) sphere(r=r);
      translate([0, size[1]-r*2, -y_offset]) sphere(r=r);
    }
    if (flat_bottom) {
      translate([0,0,-r-1]) cube(size=[size[0], size[1], r+1]);
    }
  }
}

print = false;

if (print) {
  quick_release_body();
  translate([0,-35,8.05]) rotate([180,0,0]) knob();
} else {
  translate([0,BASE - 8.5,HEIGHT-0.5]) rotate([0,0,180]) knob();
  quick_release_body();
}