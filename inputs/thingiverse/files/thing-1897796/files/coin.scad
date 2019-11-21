//I tried to make it easy to adjust
//but it is possible to screw up the math
coin_radius=20;
outer_thickness=10; //must be less than coin_radius;
inner_thickness=5; //should be less than outer_thinkness
internal_torus_diameter=8; //should be less than outer_thickness
notches_radius=4;
notches_offset=1; //should be less than notches_radius

//edit the logo module to personalize your coin

//lots of math to make sure the circles are tangent
r1=outer_thickness/2;
r1_dist=coin_radius-r1;
diff=r1-inner_thickness;
r2=(pow(r1_dist,2)-(pow(r1,2)-pow(diff,2)))/((2*r1)+(2*diff));
r2_dist=r2+inner_thickness;
r3=internal_torus_diameter/2;

//I separated everything so its easy to troubleshoot

module main_profile() {
difference() {
	union() {
		polygon(points=[[0,0],[r1_dist,0],[r1_dist,r1,],[0,r2_dist]]);
		translate([r1_dist,r1,0]) circle(r1);
	}
	//I add an extra .01 to insure they touch
	//might not be necessary
	translate([0,r2_dist,0]) circle(r2+.01);
}
}

module main_coin() {
rotate_extrude(convexity = 10, $fn = 100) {
	main_profile();
}
}

module internal_torus() {
rotate_extrude(convexity = 10, $fn = 100) {
				translate([r1_dist,r1,0]) circle(r3);
}
}

module logo() {
linear_extrude($r1*2) text("KWM",valign="cente
r",halign="center");
}

module notches() {
for (a=[0:36:359]) {
	rotate([0,0,a]) translate([coin_radius+notches_offset,0,0]) cylinder(r=notches_radius,h=outer_thickness,$fn = 100);
}
}

//now put it all back together
difference() {
	union() {
		difference() {
			main_coin();
			logo();
		}
		internal_torus();
	}
	notches();
}