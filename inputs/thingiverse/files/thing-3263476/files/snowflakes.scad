/*
  Project: Xmas 2018 What Do I Do Project
  Part: Hex Snowflake Cookie Cutter Generator

  dwu <dyanawu@gmail.com>
*/

use <MCAD/array/along_curve.scad>
use <MCAD/shapes/2Dshapes.scad>
include <MCAD/units/metric.scad>

//length of one edge of cookie
edge_l = 25;

//cutter edge thickness
edge_w = 0.8;

//raw cookie dough thickness
cookie_t = 6;

//snowflake hub
hub = 3;
hub_s = 6;

//snowflake dots
dot = 6; // maximum of 0.43* edge_l if you want non-touching dots but who cares
dot_s = 6;

//distance of dots from corners
dot_dist = 2;

//snowflake spoke length
spoke_l = 22;

//snowflake spoke width
spoke_w = 0.8;

//snowflake branch length
branch_l = 10;

//snowflake branch angle
branch_a = 35;

//number of branches
branch_n = 4;

//branch snowflake branch width
branch_w = 0.8;

//support struts
strut_l = ((edge_l/2)/tan(30))+(edge_w*3);
strut_w = 4;

$fn = 50;

module hex() {
	mcad_rotate_multiply(6)
		children();
}

module cutter() {
//cutter edge
	linear_extrude(height = cookie_t+8) {
		rotate([0,0,30]) {
			hex() {
				translate([-edge_l/2,((edge_l/2)/tan(30))-edge_w,0]) {
					square([edge_l,edge_w]);
				}
			}
		}
	}

//support struts
	translate([0,0,cookie_t+2]) {
		linear_extrude(height=2) {
			hex() {
				translate([-strut_w/2,0,0]) {
					square([strut_w,strut_l]);
				}
			}
		}
	}
}

module lock_pegs() {
	mcad_rotate_multiply(3) {
		translate([((edge_l/2)/tan(30)),0,cookie_t+6-strut_w/3]) {
			ccube([edge_w*2,strut_w,strut_w/3], center = X+Y);
		}
	}
}

module lock_holes() {
	rotate([0,0,60]) {
		mcad_rotate_multiply(3) {
			translate([((edge_l/2)/tan(30))-strut_w*0.1,0,cookie_t+6-strut_w/3]) {
				ccube([strut_w*0.4,strut_w,strut_w/3], center = X+Y);
			}
		}
	}
}

module trimmer() {
	linear_extrude(height = cookie_t+10) {
		rotate([0,0,30]) {
			circle(r = (edge_l/2)/sin(30), $fn = 6);
		}
	}
}

module cuttify() {
	translate([0,0,cookie_t*0.25]) {
		linear_extrude(height = cookie_t+1.5)
			children();
	}
}

module hub() {
	cuttify() {
		circle(hub, $fn = hub_s);
	}
}

module dots() {
	cuttify() {
		hex() {
			translate([0,((edge_l/2)/sin(30))-(dot/2)-dot_dist-edge_w,0]) {
				circle(r = dot/2, $fn = dot_s);
			}
		}
	}
}

module spokes() {
	cuttify() {
		hex() {
			translate([-spoke_w/2,0,0]) {
				square([spoke_w, spoke_l]);
			}
		}
	}
}

module branches() {
	hex() {
		for(i = [1 : branch_n]) {
			translate([0,(((edge_l/2)/sin(30))-(dot/2)-dot_dist-edge_w)*(i/(branch_n+1)),cookie_t*0.25]) {
				rotate([0,0,branch_a]) {
					ccube([branch_w,branch_l,cookie_t+1.5], center = [1,0,0]);
				}
				mirror([1,0,0]) {
					rotate([0,0,branch_a]) {
						ccube([branch_w,branch_l,cookie_t+1.5], center = [1,0,0]);
					}
				}
			}
		}
	}
}

intersection() {
	union() {
		difference() {
			cutter();
			lock_holes();
		}
		hub();
		dots();
		branches();
		spokes();
	}
	trimmer();
}
lock_pegs();
