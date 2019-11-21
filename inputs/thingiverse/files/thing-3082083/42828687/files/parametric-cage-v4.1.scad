// Parametric chastity cage, modified from this one: https://www.thingiverse.com/thing:2764421/
// August 2018
// Last update: February 2019

// Render cage and ring separately
separateParts = 1; // [0: Together, 1: Separate]

// Clip the bottom so the base is flatter when printing
flattenBase = 0; // [0: Unclipped, 1: Clipped]

// Base ring diameter
base_ring_diameter=45; // [30:55]

// Thickness of base ring 
base_thick_bar_diameter=6; // [6:10]

// EXPERIMENTAL: Add a "wave" to the base ring (contours to the body a little better, reduces chafing)
wavyBase = 1; // [0: Flat, 1: Wavy]

// EXPERIMENTAL: If the base ring has a wave, set the angle of the wave
waveAngle = 25; // [0:45]

// Cage diameter
cage_diameter=40; // [30:40]

// Cage length
cage_length=100; // [30:200]

// Thickness of the rings of the cage
cage_thick_bar_diameter=4; // [4:8]

// Number of vertical bars on the cage
cage_bar_count=8;

/* [Hidden] */

// Glans cage height (minimum is cage radius)
cage_glans_height=cage_diameter/2; // [15:50]

// Base ring type: single solid ring, or two-part ring (for folks who can't fit into a solid ring)
// -- IN PROGRESS --
// -- THIS ISN'T FINISHED YET --
bigBalls=false;

// Variables affecting base ring and keyhole
bore = 4;
diameter = 6;
crosshole = 3.5;
boredist=0.3;
locker_width=9;
locker_base=1.5;
locker_overhang=0.75;
v_locker_height=2*crosshole;
lock_diameter=6.2;
lock_length=20;
lock_case_wall=1.5;
lock_case_height=5;
lock_case_width=3.2;
lock_twist_length=7;
wiggle=0.005;
lc_rounding=0.7;


// Variables affecting cage properties
thin_bar_diameter=4;
thin_bar=thin_bar_diameter/2;
mount_width=4;
bend_point_x=50;
bend_point_z=35;

// I have no idea what these do --spacebuck
mount_length=24.505; 
mount_height=18;
part_distance=0.3;

// Tilt angle of the cage at the base ring
tilt=15; // [0:30]

$fn=36;
make();


module make() {
  if (flattenBase) {
    difference() {
      union() {
        make_cage();
        translate([1,0,0]) make_base();
      }
      slicer();
    }
  } else {
    union() {
      make_cage();
      translate([1,0,0]) make_base();
    }
  }
}

module make_base() {
  if (separateParts) {
    translate([-base_ring_diameter-cage_diameter/2, 0, 10+base_thick_bar_diameter]) {
      ring(base_ring_diameter/2, tilt, base_thick_bar_diameter);
    }
  } else {
    ring(base_ring_diameter/2, tilt, base_thick_bar_diameter);
  }
}

module make_cage() {
  h=max(0, cage_glans_height-cage_diameter/2);
  cage(cage_diameter/2, h, 360/cage_bar_count,cage_length, tilt, cage_thick_bar_diameter);

}

// Slice the bottom off the ring and cage to make them more printable
module slicer() {
  if (separateParts) {
    translate([0,0,-1.8]) {
      cylinder(r=200,h=2);
    }
  } else {
    translate([0,0,-11.8-base_thick_bar_diameter]) {
      cylinder(r=200,h=2);
    }
  }
}

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

module rounded_hollow_cylinder(r,r2,h,n) {
  rotate_extrude(convexity=4) {
    translate([r2,0,0]) offset(r=n) offset(delta=-n) square([r-r2,h]);
  }
}

module rounded_cube(size, radius) {
	translate([radius, radius, radius]) minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}

module _bent_cylinder_top(zr, phi_max, bendx) {
  rotate([0, 0, 180]) translate([-bendx, 0, 0]) rotate([90, 0, 0]) {
    torus(bendx, zr, phi_max);
  }
}

module bent_cylinder(zr, phi_max, bend_point) {
  wiggle=0.001;
  a=bend_point[2];
  cylinder(r=zr, h=a);
  translate([0,0,a-wiggle]) {
    _bent_cylinder_top(zr, phi_max, bend_point[0]);
  }
}

module torus(r, d, phi=360) {
  if (phi <= 180) {
    difference() {
      rotate_extrude(convexity=4) {
        translate([r,0,0]) circle(d);
      }
      translate([0,-(r+d),0])
        cube([3*r+3*d,2*(r+d),3*d], center=true);
      rotate([0, 0, phi - 180])
        translate([0,-(r+d),0])
          cube([3*r+3*d,2*(r+d),3*d], center=true);
    }
  } else if (phi == 360 ) {
    rotate_extrude(convexity=4) {
      translate([r,0,0]) circle(d);
    }
  } else if (phi < 360) {
    rotate([0,0,180])
    difference() {
      torus(r,d,360);// full torus
      torus(r,d,360-phi);//partial torus
    }
  } else {
    echo("Not implemented");
  }
}

//$fn=60;
//torus(95, 5);
//bent_cylinder(3, 45, [100, 0, 20]);
//_bent_cylinder_top(3, 45, 100);



module lock_casing_outer() {
  translate([-lock_diameter/2-lock_case_wall, (lock_length+lock_case_wall)/2, lock_case_height+lock_case_wall+lock_diameter/2]) {
    rotate([90, 90, 0]) {
      union() {
        rounded_hollow_cylinder(lock_diameter/2+lock_case_wall, lock_diameter/2+wiggle, lock_length+lock_case_wall, lc_rounding);
        translate([lock_diameter/2,-lock_diameter/2,0]) {
          rounded_cube([lock_case_height+lock_case_wall+wiggle, lock_case_width+2*lock_case_wall, lock_length+lock_case_wall], lc_rounding);
        }
        rotate([0,0,-32.7]) { // The smaller chamber
          translate([lock_diameter/2,-lock_diameter/2,0]) {
            rounded_cube([lock_case_height+lock_case_wall+wiggle, lock_case_width+2*lock_case_wall, lock_twist_length+2*lock_case_wall], lc_rounding);
          }
        }
        // This is a dumb hack to make a rounded-looking shield around the lock
        translate([0,0,0]) {
          rounded_hollow_cylinder(lock_diameter/2+lock_case_wall+3.8, lock_diameter/2+wiggle, lock_length+lock_case_wall, lc_rounding);
        }
        translate([2,0,0]) {
          rounded_hollow_cylinder(lock_diameter/2+lock_case_wall+3.8, lock_diameter/2+wiggle, lock_length+lock_case_wall, lc_rounding);
        }
        translate([4,0,0]) {
          rounded_hollow_cylinder(lock_diameter/2+lock_case_wall+3.8, lock_diameter/2+wiggle, lock_length+lock_case_wall, lc_rounding);
        }
      }
    }
  }
}

module lock_casing_inner() {
  translate([-lock_diameter/2-lock_case_wall, (lock_length+lock_case_wall)/2, lock_case_height+lock_case_wall+lock_diameter/2]) {
    rotate([90, 90, 0]) {
      union() {
        translate([lock_diameter/2-lock_case_wall-wiggle, -lock_case_width+lock_case_wall, lock_case_wall]) {
          rounded_cube([lock_case_height+lock_case_wall, lock_case_width, lock_length+lock_case_wall], lc_rounding);
        }
        rotate([0,0,-32.7]) {
          translate([lock_diameter/2-lock_case_wall-wiggle, -lock_case_width+lock_case_wall, lock_case_wall]) {
            rounded_cube([lock_case_height+lock_case_wall, lock_case_width, lock_twist_length], lc_rounding);
          }
        }
        rotate([0,0,-16.35]) {
          translate([lock_diameter/2-lock_case_wall-wiggle, -lock_case_width+lock_case_wall+0.05, lock_case_wall]) {
            rounded_cube([lock_case_height+lock_case_wall, lock_case_width-0.1, lock_twist_length], lc_rounding);
          }
        }
        translate([0, 0, -lock_case_wall/2]) {
          cylinder(r=lock_diameter/2, h=lock_length+2*lock_case_wall);
        }
      }
    }
  }
}

module lock_casing() {
  difference() {
    lock_casing_outer();
    lock_casing_inner();
  }
}

//$fn = 60;
//lock_casing(); 



module glans_cage_bar(r,h) {
  union() {
    translate([0,0,h]) {
      rotate([90,0,0]) {
        torus(r+thin_bar, thin_bar, 180);
      }
    }
    translate([r+thin_bar,0,0]) {
      cylinder(r=thin_bar, h=h);
    }
    translate([-r-thin_bar,0,0]) {
      cylinder(r=thin_bar, h=h);
    }
  }
}

module glans_cage(r,h,step,thick_bar) {
  union() {
    torus(r+thick_bar, thick_bar);
    difference() {
      for (phi =[90-step/2:step:90+(step/2)]) {
        rotate([0,0,phi]) glans_cage_bar(r,h);
      }
      cylinder(r=(cage_diameter/2+thin_bar)*sin(step/2),h=h+r+2*thick_bar);
    }
    difference() {
      union() {
        translate([0,-1*(cage_diameter/2+thin_bar)*sin(step/2), 0]) {
          rotate([87,0,0]) {
            torus((cage_diameter/2+thin_bar)*cos(step/2), thin_bar);
          }
        }
        translate([0,(cage_diameter/2+thin_bar)*sin(step/2), 0]) {
          rotate([93,0,0]) {
            torus((cage_diameter/2+thin_bar)*cos(step/2), thin_bar);
          }
        }
      }
    translate([0,0,-25]) cube([50,50,50], center=true);
    }
//  translate([0,0,h+r+1]) torus(pee_hole+thick_bar, thick_bar);
  }
}

module body_bars(r, bend_z, max_phi, step) {
  for (phi =[step/2:step:360-step/2]) {
    translate([(r+thin_bar)*cos(phi),(r+thin_bar)*sin(phi),0]) {
      bent_cylinder(thin_bar, max_phi, [bend_point_x-(r+thin_bar)*cos(phi),0,bend_z]);
    }
  }
}

module cage(r,h,step,length,tilt=0,thick_bar_diameter=4.5) {
  translate([r+(1+sin(tilt))*thick_bar_diameter,0,thick_bar_diameter/2]) {
    centered_cage(r,h,step,length,tilt,thick_bar_diameter/2);
  }
}

module centered_cage(r,h,step,length,tilt=0,thick_bar) {
  difference() {
    translate([-r-sin(tilt)*thick_bar,0,0]) {
      rotate([0,tilt,0]) {
        translate([r,0,0]) {
          cage_body(r,h,step,length, thick_bar);
        }
      }
    }
    translate([0,0,-2*r]) {
      cube([4*r,4*r,4*r], center=true);
    }
  }
  translate([-r-2*thick_bar-sin(tilt)*thick_bar,0,-thick_bar]) {
    rotate([0,tilt,0]) {
      mount(r,mount_height, thick_bar);
    }
  }
  torus(r+thick_bar, thick_bar);
}

module cage_body(r,h,step,length,thick_bar) {
  body_length=length-h-r;
  if (body_length < bend_point_z) {
    body_bars(r, body_length, 0, step);
    translate([0,0,body_length]) glans_cage(r,h,step, thick_bar);
  } else {
    max_phi=(body_length-bend_point_z)/bend_point_x/3.14159*180;
    body_bars(r, bend_point_z, max_phi, step);
    translate([bend_point_x,0,bend_point_z]) {
      rotate([0,max_phi,0]) {
        translate([-bend_point_x,0,0]) {
          glans_cage(r,h,step, thick_bar);
        }
      }
    }
  }
}

module dovetail(h, d, w) {
  translate([w-11,0,0]) {
    difference() {
      rotate([0,0,45]) {
        translate([-mount_length/2, -mount_length/2, 0]) {
          rounded_cube([mount_length, mount_length, h-part_distance], 0.5);
        }
      }
      translate([sqrt(2)*mount_length/2-w, -mount_length, -part_distance]) {
        cube([2*mount_length, 2*mount_length, h+part_distance]);
      }
      translate([sqrt(2)*mount_length/2-2*mount_length-w-d, -mount_length, -part_distance]) {
        cube([2*mount_length, 2*mount_length, h+part_distance]);
      }
    }
  }
}

module mount(r, h, thick_bar) {
  translate([r+thick_bar+mount_width/2+part_distance,0,thick_bar])
    mount_halfcircle(r, h, thick_bar);
  translate([-thick_bar+mount_width/2+part_distance, -mount_length/2, 0])
    rounded_cube([mount_width, mount_length, h], 0.5);
  translate([-thick_bar-mount_width/2+part_distance, 0, part_distance])
    difference() {
        dovetail(h, mount_width, 3.2);
        translate([thick_bar+mount_width/2,0,-part_distance])
            lock_casing_inner();
    }
}

module mount_halfcircle(r, h, thick_bar) {
  step=360/$fn;
  cube_y=10*(r+thick_bar)/$fn;
  for (phi =[-30:step:30]) {
    rotate([0,0,phi]) {
      translate([-r-2*thick_bar, -cube_y/2, 0]) {
        rounded_cube([mount_width, cube_y, h-thick_bar], 0.5);
      }
    }
  }
}

//$fn = 60;
//cage(18, 12, 45, 90, 15);
//glans_cage_bar(18, 12);

wiggle=0.05;
part_distance=0.3;
rounding=1;
gap=10;
mount_width=4;
mount_length=21.505;
mount_height=18;
tilt=15;

module base_ring(r, thick_bar) {
  a=r+thick_bar;
  c=a/sin(120)*sin(60-asin(sin(120)*r/a));
  if (wavyBase) {
    wavy_torus(r+thick_bar, thick_bar, waveAngle);
    translate([-c, 0, a*sin(waveAngle)*sin(45)])
      rotate([0,-waveAngle,0]) rotate([0,0,120]) {
        torus(r, thick_bar, 120);
        translate([r, 0, 0]) sphere(thick_bar);
        rotate([0,0,120]) translate([r, 0, 0]) sphere(thick_bar);
      }
  } else {
    torus(r+thick_bar, thick_bar);
    translate([-c, 0, 0])
      rotate([0,0,120])
        torus(r, thick_bar, 120);
  }
}

module wavy_torus(R, r, pitch) {
  union() {
    translate([-sin(-45)*R*(1-cos(pitch)), 0, 1-R*sin(-45)*sin(pitch)]) rotate([0, pitch, 0]) rotate([0, 0, -45]) {
      torus(R, r, 90);
      translate([R, 0, 0]) sphere(r, center=true);
    }
    translate([0, sin(45)*R*(1-cos(pitch)), 1-R*sin(45)*sin(pitch)]) rotate([pitch, 0, 0]) rotate([0, 0, 45]) {
      torus(R, r, 90);
      translate([R, 0, 0]) sphere(r, center=true);
    }
    translate([-sin(135)*R*(1-cos(pitch)), 0, 1-R*sin(135)*sin(-pitch)]) rotate([0, -pitch, 0]) rotate([0, 0, 135]) {
      torus(R, r, 90);
      translate([R, 0, 0]) sphere(r, center=true);
    }
    translate([0, sin(-135)*R*(1-cos(pitch)), 1-R*sin(-135)*sin(-pitch)]) rotate([-pitch, 0, 0]) rotate([0, 0, -135]) {
      torus(R, r, 90);
      translate([R, 0, 0]) sphere(r, center=true);
    }
  }
}


module shield_lock_case(thick_bar) {
  difference() {
    union() {
      translate([-mount_width-part_distance, -mount_length/2, 0]) {
        difference() {
          rounded_cube([mount_width, mount_length, mount_height+thick_bar], rounding);
          translate([-mount_length/3, -0.21*mount_length, -wiggle]) {
            rotate([0,0,45]) {
              cube([mount_length, mount_length, mount_height+thick_bar+2*wiggle]);
            }
          }
        }
      }
      translate([0, 0, thick_bar]) {
        difference() {
          lock_casing_outer();
          translate([mount_length-mount_width-part_distance+rounding, 0, 0]) {
            cube(2*mount_length, center=true);
            dove_length=mount_length-5;
            translate([mount_length/2-mount_width-2*part_distance, 0, 0]) {
              cube([mount_length,dove_length,2*mount_length], center=true);
            }
          }
        }
      }
    }
    translate([0, 0, thick_bar]) lock_casing_inner();
  }
}

module shield(thick_bar) {
  translate([-2*mount_width-part_distance, -mount_length/2, 0]) {
    rounded_cube([2*mount_width+part_distance, mount_length, gap+2*thick_bar], rounding);
  }
  translate([-mount_width, 0, gap+thick_bar]) {
    shield_lock_case(thick_bar);
  }
}

module ring(r, tilt=0, thick_bar_diameter) {
  translate([r-sin(tilt)*(gap+thick_bar_diameter)+cos(tilt)*thick_bar_diameter, 0, thick_bar_diameter/2-cos(tilt)*(gap+thick_bar_diameter)-sin(tilt)*mount_width]) {
    centered_ring(r, tilt, thick_bar_diameter/2);
  }
}

module centered_ring(r, tilt=0, thick_bar) {
  base_ring(r, thick_bar);
  translate([-r-thick_bar*2.0/3.0,0,-thick_bar]) rotate([0,tilt,0]) {
    shield(thick_bar);
  }
}