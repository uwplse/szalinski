
//distance between inside of crank and surface of magnet.
crank_offset=12.5;
//diameter of magnet in mm.  Add about 0.2mm extra to ensure a tigth but not impossible fit.
magnet_diameter=6.55;
//height of magnet in mm
magnet_height=3.2;


difference() {
	translate([-10,-10])
	  v_rounded_cube([20,20,crank_offset],2);
	//magnet hole
	translate([0,0,crank_offset-magnet_height ])
		cylinder(h=magnet_height,d=magnet_diameter,$fn=40);
	//cabletie hole
	translate([-50,-3 ,2 ]) cube([100,6,3]);
}
module v_rounded_cube(xyz,r,$fn=30) {
	z = xyz[2];
	y = xyz[1];
	x = xyz[0];
	translate([r,r])
	hull() {
		cylinder(h=z-r,r=r);
		translate([0,y-2*r])
		cylinder(h=z-r,r=r);
		translate([x-2*r,0])
		cylinder(h=z-r,r=r);
		translate([x-2*r,y-2*r])
		cylinder(h=z-r,r=r);
		translate([0,0,z-r])
		sphere(r);
		translate([0,y-2*r,z-r])
		sphere(r);
		translate([x-2*r,0,z-r])
		sphere(r);
		translate([x-2*r,y-2*r,z-r])
		sphere(r);
	}
}