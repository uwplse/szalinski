// to show stuff
show_chamber = true;
show_comb = true;
show_barier = true;

use <MCAD/boxes.scad>

$fn=50;

height = 25;

glass_x = 102;
glass_y = 82;
glass_h = 2.7;
wall = 3;

wet_x = glass_x + 25;
wet_y = glass_y + 10;

comb_tooth_h = 10;

comb_site_tooth_h = 5;
comb_site_top_h = wall+glass_h+comb_tooth_h+comb_site_tooth_h;
comb_site_tooth_h = 5;
wire_holder_z = 5;

wire_d = 2;

istep = 10;
comb_site_width = 6;
comb_site_count = 9;

banana_d = 5+0.5;

hole_d = 3.2;

font = "Liberation Sans";

// for 0.3mm
comb_thick_x = 4.8;
comb_thin_x = 1.5;
comb_well_x = 1.5;

module barier() {
  h = height;
  translate([0, 0, -h/2]) {
    difference() {
      union() {
        // handle
        translate([-(comb_thin_x-comb_thick_x)/2, 0, h/2-4/2]) {
          cube([comb_thin_x, wet_y+25, 3], center=true);
        }
        // with side gap along y
        cube([comb_thick_x, wet_y-8, h], center=true);
      }
      // remove top
      translate([0, 0, 6]) {
        cube([comb_thick_x, wet_y-18, h-4], center=true);
      }
      // make middle thinner
      translate([-(comb_thick_x-comb_thin_x)/2, 0, -12]) {
        cube([comb_thick_x-comb_thin_x, wet_y, h-6], center=true);
      }
    }
  }
}

module comb() {
  h = 15;
  tooth_size = 5;
  translate([0, 0, h/2-height/2]) {
    // handle
    difference() {
      union() {
        // handle
        translate([(comb_thick_x-comb_thin_x)/2, 0, 6]) {
          cube([comb_thin_x, wet_y+25, 4], center=true);
        }
        // with side gap along y
        cube([comb_thick_x, wet_y-3, h], center=true);
      }
      // remove top
      translate([0, 0, 4]) {
        cube([comb_thick_x, wet_y-10, h-3], center=true);
      }
      // make middle thinner
      translate([(comb_thick_x-comb_thin_x)/2, 0, 0]) {
        cube([comb_thin_x, wet_y-10, h-3], center=true);
      }
    }
    // comb
    translate([0, 0, -comb_tooth_h/2-h/2]) {
      for(y=[-3:1:3]) {
        translate([(comb_thick_x-comb_well_x)/2, y * 10, 0]) {
          cube([comb_well_x, tooth_size, comb_tooth_h], center=true);
        }
      }
    }
  }
}

module banana_hole(socket=false) {
  translate([0, glass_y/2, height/2-10]) {
    rotate([90, 0, 0]) {
      if(socket) {
        translate([-1, 5, -10]) {
          cylinder(d=banana_d, h=50, center=true);
        }
      } else {
        translate([-2, 1, -22]) {
          roundedBox([10, 16, 30], 5, true);
          translate([0, 4, 0]) {
            cylinder(d=hole_d, h=50, center=true);
          }
          // for wire
          translate([7, 4, 0]) {
            cylinder(d=2.5, h=50, center=true);
          }
        }
      }
    }
  }
}

module wire_holder() {
  d_pad = 2;
  d = wire_d + d_pad*2;
  w = 2;
  translate([-d/4, 0, -d/4*3]) {
    union() {
      difference() {
        rotate([90, 0, 0]) {
          difference() {
            cylinder(d=d, h=w, center=true);
            cylinder(d=wire_d, h=w, center=true);
          }
        }
        translate([0, 0, -d/2]) {
          cube([d, w*2, d], center=true);
        }
        translate([-d/2, 0, 0]) {
          cube([d, w*2, d], center=true);
        }
      }
      translate([-d/4, 0, wire_d]) {
        cube([d/4*3, w, d_pad], center=true);
      }
      translate([wire_d, 0, -d/4]) {
        cube([d_pad, w, d/4*3], center=true);
      }
    }
  }
}

module chamber() {
  difference() {
    // walls
    cube([wet_x+2*wall, wet_y+2*wall, height], center=true);
    translate([0, 0, 0]) {
      // attach zone
      translate([0, 0, comb_site_top_h]) {
        cube([glass_x, wet_y, height], center=true);
        // comb zone
        comb_start = -comb_site_count/2;
        comb_end = comb_site_count/2;
        for(i=[comb_start:comb_end]) {
          translate([i*istep, 0, 0]) {
            translate([0, 0, -comb_site_tooth_h]) {
              cube([comb_site_width, wet_y, height], center=true);
            }
            // get low to the glass level for rubber
            translate([0, 0, -comb_site_top_h+wall+glass_h]) {
              if(i == comb_start) {
                cube([5, glass_y+5, height], center=true);
              } else if(i == comb_end) {
                cube([5, glass_y+5, height], center=true);
              }
            }
          }
        }
      }
      // water zone
      translate([0, 0, 3+glass_h]) {
        cube([wet_x, glass_y, height], center=true);
      }
      // extraction bigger
      translate([0, 0, 3]) {
        cube([glass_x, glass_y, height], center=true);
      }
      translate([0, 0, 0]) {
        // extraction smaller with pads
        cube([glass_x-5, glass_y-7, height], center=true);
      }
      // plus
      translate([glass_x/2+5, 0, 0]) {
        banana_hole();
      }
      // minus
      translate([-glass_x/2-5, 0, 0]) {
        banana_hole(socket=true);
      }      
    }
    for(x=[-glass_x/2-5, glass_x/2+5]) {
      for(y=[-glass_y/2-4, glass_y/2+4]) {
        translate([x, y, -height/2-1]) {
          cylinder(d=3.2, h=12);
        }
      }
    }
    translate([wet_x/2+wall, wet_y/2-20, 0]) {
      rotate([90, 0, 90]) {
        linear_extrude(height = 2) {
          text("PLUS", font = font, size = 5, direction = "ltr", spacing = 1 );
        }
      }
    }
    translate([-wet_x/2-wall, wet_y/2, 0]) {
      rotate([90, 0, 270]) {
        linear_extrude(height = wall-2) {
          text("MINUS", font = font, size = 5, direction = "ltr", spacing = 1 );
        }
      }
    }
  }
  translate([0, 0, 0]) {
    for(i=[-1.5,1.5]) {
      translate([-glass_x/2-9, i*(glass_y/4.5), 0]) {
        wire_holder();
      }
      translate([glass_x/2+9, i*(glass_y/4.5), 0]) {
          rotate([0, 0, 180]) {
            wire_holder();
          }
      }
    }
  }
}

if(show_chamber) chamber();
if(show_comb)
  color("green")
  translate([comb_site_width-1, 0, comb_site_top_h-comb_site_tooth_h]) {
    comb();
  }
if(show_barier)
  color("blue")
  translate([glass_x/2-6, 0, 22]) {
    barier();
  }



