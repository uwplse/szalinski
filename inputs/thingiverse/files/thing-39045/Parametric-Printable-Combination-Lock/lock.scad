use <../WriteScad/Write.scad>

combination = [10,20,30,40];

// If zero, render all, otherwise render one part at a time.
part_number=0;

// Make this non-zero for an exploded view
explode_distance=0;

disc_thickness=5;
disc_radius=25;
groove_depth=3;
disc_distance=2;
spacing=0.2;
holder_radius=11;
peg_distance=7;
peg_radius=2.2;
bolt_radius=2.2;
layer_height=0.4;

module render_part(part, x=0) {
  if (part_number == 0 || part_number == part) {
    for (i = [0 : $children-1]) translate([0,0,-x*explode_distance]) child(i);
  }
}

module pie_slice(r, start_angle, end_angle) {
    R = r * sqrt(2) + 1;
    a0 = (4 * start_angle + 0 * end_angle) / 4;
    a1 = (3 * start_angle + 1 * end_angle) / 4;
    a2 = (2 * start_angle + 2 * end_angle) / 4;
    a3 = (1 * start_angle + 3 * end_angle) / 4;
    a4 = (0 * start_angle + 4 * end_angle) / 4;
    if(end_angle > start_angle)
        intersection() {
        circle(r, $fn=200);
        polygon([
            [0,0],
            [R * cos(a0), R * sin(a0)],
            [R * cos(a1), R * sin(a1)],
            [R * cos(a2), R * sin(a2)],
            [R * cos(a3), R * sin(a3)],
            [R * cos(a4), R * sin(a4)],
            [0,0]
       ]);
    }
}

module disc_holder() {
  difference() {
    union() {
      translate([0,0,-disc_distance+spacing]) {
        cylinder(r=15, h=disc_distance-spacing*2, $fn=200);
      }
      translate([0,0,-1]) {
       cylinder(r=holder_radius-spacing, h=disc_thickness + 1, $fn=200);
      }
      for (rot=[0,120,240]) {
        rotate([0,0,rot]) {
          translate([0,peg_distance,disc_thickness]) cylinder(r=peg_radius-spacing, h=3, $fn=64);
        } 
      }
    }
    translate([0,0,-disc_distance]) {
      cylinder(r=bolt_radius+spacing, h=disc_distance + disc_thickness + 1, $fn=64);
      for (rot=[0,120,240]) {
        rotate([0,0,rot]) {
          translate([0,peg_distance,0]) cylinder(r=peg_radius, h=5, $fn=64);
        }
      }
    }
  }
}

module disc(disc_num, angle=0, peg=1) {
  difference() {
    cylinder(r=disc_radius, h=disc_thickness, $fn=200);
    translate([disc_radius-8,-3,-1])  rotate([0,180,90])
   write(str(disc_num+1),h=4,t=3, center=true, font="../WriteScad/orbitron.dxf");

    translate([0,0,-1]) cylinder(r=holder_radius, h=disc_thickness+2, $fn=200);
    rotate([0,0,-angle])
    hull() {
      translate([0,disc_radius-1,-1]) {
         cylinder(r=3, h=disc_thickness+2, $fn=20);
      }
      translate([0,disc_radius+8,-1]) {
         cylinder(r=3, h=disc_thickness+ 2, $fn=20);
      }
    }
    translate([0,0,-1]) {
      linear_extrude(height=groove_depth+1)
        difference() {
          pie_slice(19, 0, 340);
          circle(r=15, $fn=200);
        }
    }
  }
  if (peg) {
     translate([0,0,disc_thickness-1])
      linear_extrude(height=groove_depth+disc_distance)
        difference() {
          pie_slice(18, 0, 20);
          circle(r=16, $fn=200);
        }
  }
  if(part_number == 0) translate([0,0,-explode_distance-3]) disc_holder();
}

module final_disc(angle=0) {
  difference() {
    cylinder(r=disc_radius + 0.5, h=disc_thickness, $fn=200);
      translate([0,0,3.2-0.5+layer_height]) cylinder(r=bolt_radius+spacing, h=disc_thickness+2, $fn=200);
   translate([disc_radius-8,-3,-1]) rotate([0,180,90])
     write(str(len(combination)),h=4,t=3, center=true, font="../WriteScad/orbitron.dxf");
    if (0) {
      translate([0,disc_radius * 4/3,-1]) {
         cylinder(r=disc_radius * 1/3 + 4 +spacing*2, h=disc_thickness+2, $fn=200);
      }
    } else {
      rotate([0,0,-angle])
      hull() {
        translate([0,disc_radius-1,-1]) {
           cylinder(r=3, h=disc_thickness+2, $fn=20);
        }
        translate([0,disc_radius+8,-1]) {
           cylinder(r=3, h=disc_thickness+ 2, $fn=20);
        }
      }
    }
    translate([0,0,-0.5]) cylinder(r=(3.5+spacing)/cos(30), h=3.2, $fn=6);
  }
  translate([0,0,disc_thickness-1])
    linear_extrude(height=groove_depth+disc_distance)
      difference() {
        pie_slice(18, 0, 20);
        circle(r=16, $fn=200);
      }
}

lever_thickness=disc_distance * (len(combination)-1) + disc_thickness*len(combination);

module lever() {
  difference() {
    union() {
      hull() {
        translate([0,disc_radius-1.5,-(disc_distance + disc_thickness) * (len(combination)-1)]) {
          cylinder(r=2, h=lever_thickness, $fn=20);
        }
        translate([0,disc_radius+15,-(disc_distance + disc_thickness) * (len(combination)-1)]) {
         cylinder(r=2, h=lever_thickness, $fn=20);
        }
      }
      translate([-5,disc_radius+5,disc_thickness-8]) {
        cube([10,35,8]);
      }
    }
    translate([0,40,0]) cylinder(r=1.5+spacing, h=30, $fn=64);
  }
}

module door() {
  difference() {
    union() {
      translate([-40,disc_radius+35+5-100,disc_thickness+spacing]) {
        cube([80,100,5]);
      }
      translate([-8,disc_radius+5,disc_thickness-11]) {
        cube([16,35,12]);
      }
    }
    translate([-5-spacing/2,0,disc_thickness-8-spacing/2]) {
      cube([10+spacing,135,8+spacing]);
    }
    translate([-5-spacing/2,0,disc_thickness-8-10]) {
      cube([10+spacing,disc_radius+15+2+6,12]);
    }
    cylinder(r=bolt_radius+spacing, h=30, $fn=64);
    hull() {
      translate([0,40,0]) cylinder(r=1.5+spacing*2, h=30, $fn=64);
      translate([0,46,0]) cylinder(r=1.5+spacing*2, h=30, $fn=64);
    }
    translate([-28,0,disc_thickness + 4]) cylinder(r=2, h=20,$fn=3);
    for (rot=[0,120,240]) {
      rotate([0,0,rot]) {
        translate([0,peg_distance,disc_thickness-1]) cylinder(r=peg_radius, h=5, $fn=64);
      }
    }
  }
}

module knob() {
  F=40;
  difference() {
    translate([0,0,disc_thickness + 5 + spacing * 2]) {
      rotate([0,0,4.5]) {
        cylinder(r1=25, r2=25, h=1, $fn=F);
        translate([0,0,0.999]) cylinder(r1=25, r2=10, h=5, $fn=F);
        translate([0,0,5.998]) cylinder(r1=10, r2=8, h=10, $fn=F);
      }
      for (rot=[0:9:359]) {
        rotate([0,0,rot]) {
          translate([0,22,2]) sphere(r=1,$fn=20);
        }
      }
      for (rot=[0:9 * 5:359]) {
        rotate([-17,0,90-rot]) {
           translate([0,15,7.5]) {
#            write(str(rot/9),h=6,t=3, center=true, font="../WriteScad/orbitron.dxf");
           }
        }
      }
    }
    translate([0,0,-1]) cylinder(r=bolt_radius+spacing, h=30, $fn=20);
    translate([0,0,17]) cylinder(r=(3.5+spacing)/cos(30), h=30, $fn=6);
  }
}

for (d=[0:len(combination)-2]) {
  translate([0,0,(-disc_thickness-disc_distance)*d]) {
    render_part(6+d, d * 2 + 1) disc(d, combination[d] * 9 + ((len(combination) - d)%2)*((len(combination) - d - 1)*20), d == 0 ? 0 : 1);
  }
}
translate([0,0,(-disc_thickness-disc_distance)*(len(combination)-1)]) {
  render_part(5, len(combination)*2-1) final_disc(combination[len(combination)-1] * 9);
}
if (part_number == 4) {
  disc_holder();  
}
render_part(3, 0) lever();
render_part(2, 0) door();
render_part(1, -1) knob();




