ht = 14;
id = 17;
wall = 5.5;
screw_w_in = 7.5;
screw_w_out = 14.5;
hole_dia = 2.6;
end_d = 6;
front_w = 8;

$fn=200;

module screw_hole(z_pos)
{
	len = 5;
	r = hole_dia/2;
	
	translate([0, -(wall/2 + id/2 - 4), z_pos]) {
		rotate([90, 0, 0]) {
			// actual hole
			cylinder(r=r, h=len);
			// chamfer
			cylinder(r=3, h=1.5);
		}
	}
}

module end_cap(off)
{
	translate([off, (wall/2 + id/2 - 2), 0]) {
		scale([1, 1, 1]) {
			cylinder(r=end_d/2, h=ht);
			translate([0, 0, 0])
				sphere(r=end_d/2);
		}
	}
}

scale([1, 1, 1]) {
	union() {
		difference() {
			union() {
				difference() {
					// outer cylinder
					cylinder(r=(wall/2 + id/2), h=ht);
					// inner cylinder
					translate([0,2,-1])
						cylinder(r=id/2, h=ht+2);
					// cube for front cutout
					translate([-(front_w/2), (wall/2 + id/2 - 2), -1])
						cube([front_w, 2, ht+2]);
					// cube for back screw cutout
					translate([-(screw_w_in/2), -(wall/2 + id/2 - 3), -1])
						cube([screw_w_in, 3, ht+2]);
				}

				// cube for outer screw block
				translate([-(screw_w_out/2), -(wall/2 + id/2), 0])
					cube([screw_w_out, 3, ht]);
			}
			
			screw_hole(2.6);
			screw_hole(10);
		}

		// front end-cylinders
		end_cap(-(front_w/2));
		end_cap(front_w/2);
	}
}