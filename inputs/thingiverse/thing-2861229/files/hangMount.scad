use <../shapes/tombstone.scad>
use <../shapes/bend.scad>
use <../shapes/wedge.scad>

$fn = 50;

mount_width = 39; //mm


module grab_mount(mount_size = 33, clearance = 0.2)
{difference() {
	grip_size = [mount_size*0.5, mount_size/4, mount_size];
	union(){

	for(i = [0:1]) {
		translate([grip_size[0]*i,(mount_size+grip_size[1]*2)*i],0)
		rotate([0,0,180*i])
			difference() {
				shape_tombstone(
					grip_size[0]/2,
					grip_size[1],
					grip_size[0]*1.5
					);
				/*
				translate([grip_size[0]*0.05,-grip_size[1]*0.75,-grip_size[0]*0.1])
				shape_tombstone(
					grip_size[0]/2*0.9,
					grip_size[1]*0.9,
					grip_size[0]*1.1
					);
				*/
			}
	}

	translate([0,0,-grip_size[1]]) difference() {
		cube([
			grip_size[0],
			grip_size[1]*2+mount_size,
			grip_size[1]
		]);
	}

	r = 10;
	t = grip_size[1]*2+mount_size;
	a = 24;
	h = grip_size[0];

	translate([grip_size[0],(grip_size[1]*2+mount_size),-grip_size[1]])
	rotate([180,0,-90])
	{
		shape_bend(r,t,a,h);
	
	translate(shape_bend_pos(r,t,a))
	rotate(shape_bend_rot(r,t,a))
		arm(120,t,h);
	}
}
	translate([grip_size[0]/2,-grip_size[1],grip_size[0]*1.25])
	rotate([-90,0,0])
		cylinder(r=2.5,h=grip_size[1]*2+mount_size*2);

	translate([grip_size[0]/2,-grip_size[1],grip_size[0]/2])
	rotate([-90,0,0])
		cylinder(r=2.5,h=grip_size[1]*2+mount_size*2);

}}

module arm(l,bl,bd,r)
{difference() {
	translate([bl/2,bd/2,0])
		shape_wedge(bl,bd,l,bl*0.5,bd,1,1);

	translate([bl*1.25,bd*0.25,l-bd*1.25])
	rotate([0,270,0])
	shape_tombstone(r=9,a=bl*0.4,h=bd*1.5);
}}

//mount();

grab_mount(mount_width);

//shape_wedge(20,5,50,10,3,0.5,1);

/*
r = 10;
t = 20;
a = 24;
h = 5;
shape_bend(r,t,a,h);
translate(shape_bend_pos(r,t,a))
rotate(shape_bend_rot(r,t,a))
	cube([t,h,10]);
*/


//shape_tombstone(5,2,10);
