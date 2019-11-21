

/* Mini Blind Pull
   Version 1.0
   by Kirk Saathoff
   2014-05-17
 */
CordHole = 2.6; //  [2.6:Small,4.4:Large]

/* [Hidden] */

res = 70;
sphere_res = res;
torus_res = res;

cross_section = 0;

ridge_size = 1.0;
ridge_height = 11;
large_hole_diam = 4.4;
small_hole_diam = 2.6;
hole_diam = CordHole;

module ridge1(offset)
{
		translate([-ridge_size/2+offset, 0, 0])
		rotate([0, 0, 0])
			cube([ridge_size, 16.4/2, ridge_height]);
}

module ridge(ang)
{
	rotate([0, 0, ang*(360/5)]) {
		ridge1(.8);
		ridge1(-.8);
	}
}

height = 28;
diam = 15;
rad = diam/2;

difference() {
	union() {
		rotate_extrude(convexity = 10, $fn = torus_res)
			translate([rad*.93, 0, 0])
				circle(r = 2.25, $fn = torus_res);
		
		scale([1, 1, height/(diam/2)])
			sphere(r=rad, $fn=sphere_res);
		intersection() {
			for (ang = [0:4]) {
				ridge(ang);
			}
			scale([1, 1, height/(diam/2)])
				sphere(r=rad*1.07, $fn=sphere_res);
		}
	}
	union() {
		translate([0, 0, -20.9]) {
			cube([20, 20, 40], center=true);
		}
		scale([1, 1, (height*.9)/(rad*.85)])
			sphere(r=rad*.8, $fn=sphere_res);
		cylinder(r=hole_diam/2, h=30, $fn=sphere_res);
		translate([0, 0, (height+((large_hole_diam-hole_diam)*0.5))*1.11]) {
			cube([10, 10, 10], center=true);
		}
		if (cross_section) {
			translate([0, 0, 20])
				cube([20, 20, 20], center=true);
		}
	}
}		





