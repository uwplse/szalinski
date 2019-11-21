//
//  Base for 5.8Ghz TV
// 
//  by Egil Kvaleberg
//
//

// platform inner size X
case_x = 94.0;  
// platform inner size X
case_y = 143.5;

// wall thickness
wall_t = 3.0;

// wall height
wall_h = 4.9;

// height of ribs in floor
rib_h = 7.0; 
// width of ribs
rib_w = 3.0; 
// thickness of floor
floor_t = 1.0; 
// divisions in X 
rooms_x = 3;
// divisions in Y 
rooms_y = 4;

// distance between mounting holes
hole_dy = 70;  
// spacing between alternative mounting holes
hole_ddx = 13.5; 
// mounting hole diameter
hole_d = 4.2;  // (for M4)
// mounting hole countersunk head diameter
screw_d = 7.5;  // (for M4)

pad_dia = 1*25.0;
pad_h = 1*0.5;

d = 1*0.1;
$fs = 1*0.2;

// lock mount screw diameter
lock_screw_d = 1.7;
// lock mount screw length
lock_screw_l = 12.0;
// lock flange overall width
lock_width = 40.2; 
lock_width2 = 19.5; 
// lock flange height
lock_height = 8.0;
// spacing of lock mount screws
lock_spacing = 32;

module base_add()
{
	union () {
		translate([	-(case_x/2+wall_t), -(case_y/2+wall_t), 0]) cube([case_x + 2*wall_t, case_y + 2*wall_t, rib_h+wall_h]);
/*
		// pads to prevent warping
		for (x = [-1 : 2 : 1]) for (y = [-1 : 2 : 1])
			translate([	x*(case_x/2+wall_t), y*(case_y/2+wall_t), 0]) cylinder(r = pad_dia/2, h = pad_h);
*/
	}

}

module base_sub()
{
	module cscrew(dx, dy) {
		translate([dx, dy, 0]) union() {
			translate([0, 0, -d]) cylinder(r = hole_d/2, h = d + rib_h + d);
			translate([0, 0, rib_h+d - screw_d/2]) cylinder(r1 = 0, r2 = screw_d/2, h = screw_d/2+d); // 45 deg countersunk screw
		}
	}
	sx = (case_x - (1+rooms_x)*rib_w) / rooms_x;
	sy = (case_y - (1+rooms_y)*rib_w) / rooms_y;

	module lock() {
		translate([0,-(case_y/2 + wall_t + d), 0])
		union () { 
			//translate([-lock_width/2, 0, -d]) cube([lock_width, wall_t + d, lock_height + d]);
			//translate([-lock_width2/2, 0, -d]) cube([lock_width2, d + wall_t + d, d + rib_h + wall_h + d]);
			translate([-lock_width/2, 0, -d]) cube([lock_width, wall_t + d, d + rib_h + wall_h + d]);
			translate([-lock_spacing/2,0, lock_height/2]) rotate([-90,0,0]) cylinder(r = lock_screw_d/2, h = lock_screw_l+d);
			translate([lock_spacing/2,0, lock_height/2]) rotate([-90,0,0]) cylinder(r = lock_screw_d/2, h = lock_screw_l+d);
		}
	}

	union () {
		// hole for case
		translate([	-case_x/2, -case_y/2, rib_h]) cube([case_x, case_y, wall_h+d]);

		difference () {
			// "rooms" for lightening/strengthening
			for (x = [0 : rooms_x-1]) {
				for (y = [0 : rooms_y-1]) {
					translate([	-case_x/2 + rib_w + x*(rib_w+sx), 
								-case_y/2 + rib_w + y*(rib_w+sy), 
								floor_t ]) 
						cube([sx, sy, (rib_h-floor_t)+d]);  
				}
			}
			union () {
				// minus screws in bottom
				for (x = [0 : hole_ddx : case_x/2 - wall_t - screw_d/2]) {
					translate([x, hole_dy/2, -d]) cylinder(r = screw_d/2 + rib_w, h = d + rib_h + d);
					translate([x, -hole_dy/2, -d]) cylinder(r = screw_d/2 + rib_w, h = d + rib_h + d);
				}
				// minus screws to mount locks
				translate([0,-(case_y/2 + wall_t ), 0]) union () { 
					translate([-lock_spacing/2,0, lock_height/2]) rotate([-90,0,0]) cylinder(r = lock_screw_d/2 + rib_w, h = lock_screw_l+rib_w);
					translate([lock_spacing/2,0, lock_height/2]) rotate([-90,0,0]) cylinder(r = lock_screw_d/2 + rib_w, h = lock_screw_l+rib_w);
				}
				translate([0,(case_y/2 + wall_t ), 0]) union () { 
					translate([-lock_spacing/2,0, lock_height/2]) rotate([90,0,0]) cylinder(r = lock_screw_d/2 + rib_w, h = lock_screw_l+rib_w);
					translate([lock_spacing/2,0, lock_height/2]) rotate([90,0,0]) cylinder(r = lock_screw_d/2 + rib_w, h = lock_screw_l+rib_w);
				}
			}

		}
		translate([	-case_x/2, -case_y/2, rib_h]) cube([case_x, case_y, wall_h+d]);

		for (x = [0 : hole_ddx : case_x/2 - wall_t - screw_d/2]) {
			cscrew(x, -hole_dy/2);
			cscrew(x, hole_dy/2);
		}

		lock();
		mirror([0,1,0]) lock();
	}
}


module view()
{
	difference () {
		base_add();
		base_sub();
	}
}

view();

