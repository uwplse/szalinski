////////////////////////////////////
//
// Parametric chastity cage, modified from this one: https://www.thingiverse.com/thing:2764421/
// Version 3, published August 2018

// V4 update: February 2019
//    - Added option to bend the base ring, for comfort
//    - Updated variables for Thingiverse Customizer

// V5 update: June 2019
//    - Rewrote as many functions as possible

//////////////////////////////////////

// Render cage and ring separately
separateParts = 1; // [0: Together, 1: Separate]

// Cage diameter
cage_diameter=40; // [30:40]

// Cage length (this should be about 16mm less than one's penis length)
cage_length=80; // [30:200]

// Base ring diameter
base_ring_diameter=45; // [30:55]

// Thickness of base ring 
base_thick_bar_diameter=6; // [6:10]

// Add a "wave" to the base ring (contours to the body a little better, reduces chafing)
wavyBase = 1; // [0: Flat, 1: Wavy]

// If the base ring has a wave, set the angle of the wave
waveAngle = 20; // [0:45]

// Thickness of the rings of the cage
cage_thick_bar_diameter=4; // [4:8]

// Number of vertical bars on the cage
cage_bar_count=8;

// Tilt angle of the cage at the base ring
tilt=15; // [0:30]

// If your lock fits too tightly in the casing, add some space around it here (NOTE: this is computationally taxing, keep it set to 0 until you are really sure you need it)
lock_margin = 0; // [0:0.01:1]

// If the two parts slide too stiffly, add some space here
part_margin = 0; // [0:0.01:1]

// X-axis coordinate of the bend point (the center of the arc the cage bends around)
bend_point_x=50; // [0:0.1:200]

// Z-axis coordinate of the bend point (the center of the arc the cage bends around)
bend_point_z=15; // [0:0.1:200]

/* [Hidden] */

// Clip the bottom so the base is flatter when printing
flattenBase = 0; // [0: Unclipped, 1: Clipped]

// Glans cage height (minimum is cage radius)
glans_cage_height=cage_diameter/2; // [15:50]

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
bend_point_y=0;
thin_bar_diameter=4;
thin_bar=thin_bar_diameter/2;
mount_width=4;
mount_height=18;
mount_length=21.505;
part_distance=0.3;
rounding=1;
gap=10;

// Square function for math
function sq(x) = pow(x, 2);


////////////////////////////////////
//
// Useful values calculated from parameters above
//

// step: angle between cage bars
step = 360/cage_bar_count;

// R1: Inner radius of shaft of cage
// R2: Inner radius of base ring
R1 = cage_diameter/2;
R2 = base_ring_diameter/2;

// r1: cage bar radius
// r2: base ring radius
r1 = cage_thick_bar_diameter/2;
r2 = base_thick_bar_diameter/2;

// P: bend point (assumed to be on the XZ plane)
// dP: distance from origin to bend point
P = [bend_point_x, 0, bend_point_z];
dP = sqrt(sq(P[0]) + sq(P[1]) + sq(P[2]));

// psi: angle from origin to bend point (in degrees)
psi = atan(P[2]/P[0]);

// dQ: length of straight cage segment
dQ = dP*cos(90-tilt-psi);
if (cage_length-glans_cage_height < dQ) {
  dQ = cage_length-glans_cage_height;
}

// Q: upper endpoint of straight segment of cage
Q = [dQ*sin(tilt), 0, dQ*cos(tilt)];

// Phi: arc length of curved segment of cage (in degrees)
curve_radius = sqrt(sq(P[0]-Q[0]) + sq(P[1]-Q[1]) + sq(P[2]-Q[2]));
Phi = (cage_length - dQ - glans_cage_height)/curve_radius * 180/PI;

// slit_width: 
slit_width = (R1+r1)*cos(step);


////////////////////////////////////
//
// Finally, here's where the modules begin
//
$fn=32;
make();

module make() {
  if (flattenBase) {
    difference() {
      union() {
        cage();
        translate([1,0,0]) make_base();
      }
      slicer();
    }
  } else {
    union() {
      cage();
      translate([1,0,0]) make_base();
    }
  }
}

module make_base() {
  if (separateParts) {
    translate([-base_ring_diameter-cage_diameter-10, 0, 10+base_thick_bar_diameter]) {
      ring(base_ring_diameter/2, tilt, base_thick_bar_diameter);
    }
  } else {
    translate([R1*(-1-sin(tilt)), 0, -2])
    ring(base_ring_diameter/2, tilt, base_thick_bar_diameter);
//    rotate([0, tilt, 0]) mount();
  }
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

module torus(R, r, phi=360, rounded=false) {
  if (version_num() > 20151231) {
    union() {
      rotate_extrude(convexity=4, angle=phi) {
        translate([R,0,0]) circle(r);
      }
      if (rounded) {
        translate([R,0,0]) sphere(r);
        rotate([0,0,phi]) translate([R,0,0]) sphere(r, $fa=60);
      }
    }
  } else {
    echo("Using a deprecated method for torus(); consider updating to OpenSCAD 2016 or newer");
    if (phi <= 180) {
      difference() {
        rotate_extrude(convexity=4) {
          translate([R,0,0]) circle(r);
        }
        translate([0,-(R+r),0])
          cube([3*R+3*r,2*(R+r),3*r], center=true);
        rotate([0, 0, phi - 180])
          translate([0,-(R+r),0])
            cube([3*R+3*r,2*(R+r),3*r], center=true);
      }
    } else if (phi <= 360 ) {
      rotate_extrude(convexity=4) {
        translate([R,0,0]) circle(r);
      }
    } else if (phi < 360) {
      rotate([0,0,180])
      difference() {
        torus(R,r,360);// full torus
        torus(R,r,360-phi);//partial torus
      }
    }
  }
}

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
        translate([6,0,0]) {
          rounded_hollow_cylinder(lock_diameter/2+lock_case_wall+3.8, lock_diameter/2+wiggle, lock_length+lock_case_wall, lc_rounding);
        }
        translate([8,0,0]) {
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


module cage() {
  cage_bar_segment();
  glans_cap();
  torus(R1+r1, r1*1.2);  // Cage base ring
//  translate([-R1-r1-2, 0, 0]) rotate([0, tilt, 0]) translate([0, 0, -r1]) mount(); // Shield for the lock
  translate([R1*(-1-sin(tilt)), 0, -2]) rotate([0, tilt, 0]) mount(); // Shield for the lock
}

module cage_bar_segment() {
  // Straight segment: N tilted cage bars
  for (theta = [step/2:step:360-step/2]) {
    straightseg = dQ - (R1+r1)*cos(theta)*cos(90-tilt);
    translate([(R1+r1)*cos(theta), (R1+r1)*sin(theta), 0]) rotate([0, tilt, 0]) {
      // Straight segment
      union() {
        cylinder(r=r1, h=straightseg);
        sphere(r1);
      }
      // Curved segment
      R_curve = curve_radius - (R1+r1)*cos(theta)*sin(90-tilt);
      translate([R_curve, 0, straightseg]) rotate([90, 0, 0]) {
        torus(-R_curve, r1, phi=-Phi, rounded=true);
      }
    }
  }
}

module glans_cap() {
  translate(P) rotate([0, Phi, 0]) translate(-P) {
    translate([dQ*sin(tilt), 0, dQ*cos(tilt)]) {
      rotate([0, tilt, 0]) {
        torus(R1+r1,r1); // Base of glans cap
        // Slit edges
        translate([0, -slit_width/2, 0]) rotate([85, 0, 0]) {
          torus((R1+r1)*cos(180/cage_bar_count), r1, phi=180, rounded=true);
        }
        translate([0, slit_width/2, 0]) rotate([95, 0, 0]) {
          torus((R1+r1)*cos(180/cage_bar_count), r1, phi=180, rounded=true);
        }
        // Cap side bars
        for (theta = [90-step/2:step:90+step/2]) {
          rotate([90, 0, theta]) torus(R1+r1, r1, phi=70, rounded=true);
          rotate([90, 0, 360-theta]) torus(R1+r1, r1, phi=70, rounded=true);
        }
      }
    }
  }
}

//////no longer a dovetail////////////
//////now it's a big slot ////////////
module dovetail(h, d, w) {
  
  translate([w-11,0,0]) {
    difference() {
      rotate([0,0,0]) {
        translate([-mount_length/4, -mount_length/4, 0-part_distance]) {
          
          intersection() {
            rounded_cube([4*mount_length/4, mount_length/2, h], 0.5);
          
            translate([-lock_diameter/2-lock_case_wall+17.1, (lock_length+lock_case_wall)/2+5, lock_case_height+lock_case_wall+lock_diameter/2]) rotate([90,90,0]) {
              union() {
                rounded_hollow_cylinder(lock_diameter/2+lock_case_wall+3.8, lock_diameter/8+wiggle, lock_length+lock_case_wall, lc_rounding);
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
      }
      translate([sqrt(2)*mount_length/2-w, -mount_length, -part_distance]) {
        cube([2*mount_length, 2*mount_length, h+part_distance]);
      }
    }
  }
}

module mount(r=R1, h=mount_height, thick_bar=r1) {
  translate([r+thick_bar+mount_width/2+part_distance,0,thick_bar+1])
    mount_halfcircle(r, h, thick_bar);
  translate([-thick_bar+mount_width/2+part_distance, -mount_length/2, 0])
    rounded_cube([mount_width, mount_length, h], 0.5);
  translate([-thick_bar-mount_width/2+part_distance, 0, part_distance]) {
    difference() {
      dovetail(h, mount_width, 3.2);
      translate([thick_bar+mount_width/2,0,-part_distance]) {
        if (lock_margin > 0) {
          minkowski() {
            lock_casing_inner();
            cube(lock_margin, center=true);
          }
        } else {
          lock_casing_inner();
        }
      }
    }
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

module base_ring(r=R2, thick_bar=r2) {
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
      translate([R, 0, 0]) sphere(r);
    }
    translate([0, sin(45)*R*(1-cos(pitch)), 1-R*sin(45)*sin(pitch)]) rotate([pitch, 0, 0]) rotate([0, 0, 45]) {
      torus(R, r, 90);
      translate([R, 0, 0]) sphere(r);
    }
    translate([-sin(135)*R*(1-cos(pitch)), 0, 1-R*sin(135)*sin(-pitch)]) rotate([0, -pitch, 0]) rotate([0, 0, 135]) {
      torus(R, r, 90);
      translate([R, 0, 0]) sphere(r);
    }
    translate([0, sin(-135)*R*(1-cos(pitch)), 1-R*sin(-135)*sin(-pitch)]) rotate([-pitch, 0, 0]) rotate([0, 0, -135]) {
      torus(R, r, 90);
      translate([R, 0, 0]) sphere(r);
    }
  }
}


module shield_lock_case(thick_bar) {
  difference() {
    union() {
      translate([-mount_width-part_distance, -mount_length/2, 0]) {
        translate([0, 0, -13]) {
          rounded_cube([2*mount_width+part_distance, mount_length, gap+2*thick_bar], rounding);
        }
        difference() {
          rounded_cube([mount_width, mount_length, mount_height+thick_bar], rounding);
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
    translate([0, 0, thick_bar]) {
      if (lock_margin > 0) {
        minkowski() {
          lock_casing_inner();
          cube(lock_margin, center=true);
        }
      } else {
        lock_casing_inner();
      }
    }
    translate([0, 0, 18]) cube([30, 11+2*part_margin, 30], center=true);
  }
}

module shield(thick_bar) {
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