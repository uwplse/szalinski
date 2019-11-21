/* [Pipe Dimensions] */
// Outside Diameter
pipe_od = 50;
// Total Height
total_ht = 50;
// Fudge
fudge = .25;
// Wall Thickness
wall_thick = 2;
// Cylinders Resolution
cyl_res = 64;


difference() {

	union() {
		cylinder(r=(pipe_od/2)+(wall_thick*2)+fudge,h=total_ht,$fn=cyl_res);
		cylinder(r=(pipe_od/2)+((wall_thick*2)+(wall_thick*2)+fudge),h=total_ht/3.66666,$fn=cyl_res);
		//cone
		translate([0,0,total_ht/3.66666]) cylinder(r1=(pipe_od/2)+((wall_thick*2)+(wall_thick*2)+fudge),r2=2,h=total_ht*.95,$fn=cyl_res);
	}

	union() {
		cylinder(r=(pipe_od/2)+fudge,h=total_ht*2,$fn=cyl_res);
	}

}