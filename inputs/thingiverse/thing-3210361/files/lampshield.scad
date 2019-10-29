/*
  Project: UV lamp shield + buttons
  Part: entirety

  Revision:
  2018-11-11: creation

  dwu <dyanawu@gmail.com>
 */

include <MCAD/units/metric.scad>

height = 63;
length = 172;
depth  = 56;

wallthick = 2.8;
sides = wallthick*2;

cutout_h = 32;
cutout_w = 16;
cutout_t = wallthick + 0.5;

module mainshell() {
	difference() {
		cube([length+sides, depth+sides, height+wallthick]);
		translate([wallthick,wallthick,-0.5]) {
			cube([length,depth,height+0.5]);
		}
	}
}

module cutouts() {
	translate([-0.25,depth/2-cutout_w/2+wallthick,-0.25]) {
		cube([cutout_t,cutout_w,cutout_h+0.25]);
	}
	
	translate([length/2+wallthick,depth/2+wallthick,height-(wallthick*0.5)]) {
		cylinder(r = 2.75, h = sides, $fn = 50);
	}
	
/*	translate([length*0.65,depth/2+wallthick,height-(wallthick*0.5)]) {
			cylinder(r = 0.75, h = sides, $fn = 50);
	}*/
}

difference() {
	mainshell();
	cutouts();
}
