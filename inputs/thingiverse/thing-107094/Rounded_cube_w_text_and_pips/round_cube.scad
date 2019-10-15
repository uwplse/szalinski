$fn=15;
pad=0.01;

//Die size
die_size=4;
//Die rounding radius
die_radius=.25;

//Pip parameters
pip_depth=.25;
pip_radius=.3;

//Face labels
letter_top="1";
letter_front="2";
letter_right="3";
letter_back="4";
letter_left="5";
letter_bottom="6";

//Text Parameters
letter_depth=-.3;
letter_height=2;

use <Write.scad>

die();

module die() {
	difference() {
		round_cube();
		letters();
		translate([0,0,die_size/2]) //workaround for die misplacement
		pips();
	}
}

module pips() {
	//top face - 1
	translate([0,0,(die_size/2)+pip_radius-pip_depth])
	sphere(pip_radius,center=true);
	
	//front face - 2
	rotate([90,0,0])
	translate([0,0,(die_size/2)+pip_radius-pip_depth]) {
		translate([die_size/7,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-7,die_size/-7,0])
		sphere(pip_radius,center=true);
	}
	
	//right face - 3
	rotate([0,90,0])
	translate([0,0,(die_size/2)+pip_radius-pip_depth]) {
		sphere(pip_radius,center=true);
		translate([die_size/7,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-7,die_size/-7,0])
		sphere(pip_radius,center=true);
	}

	//back face - 4
	rotate([270,0,0])
	translate([0,0,(die_size/2)+pip_radius-pip_depth]) {
		translate([die_size/7,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-7,die_size/-7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-7,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/7,die_size/-7,0])
		sphere(pip_radius,center=true);
	}

	//left face - 5
	rotate([0,270,0])
	translate([0,0,(die_size/2)+pip_radius-pip_depth]) {
		sphere(pip_radius,center=true);
		translate([die_size/7,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-7,die_size/-7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-7,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/7,die_size/-7,0])
		sphere(pip_radius,center=true);
	}

	//bottom face - 6
	rotate([0,180,0])
	translate([0,0,(die_size/2)+pip_radius-pip_depth]) {
		translate([die_size/5,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([0,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-5,die_size/7,0])
		sphere(pip_radius,center=true);
		translate([die_size/5,die_size/-7,0])
		sphere(pip_radius,center=true);
		translate([0,die_size/-7,0])
		sphere(pip_radius,center=true);
		translate([die_size/-5,die_size/-7,0])
		sphere(pip_radius,center=true);
	}
}

// letters on faces of cube	
module letters(){
	c=[0,0,die_size/2];
	s=[die_size,die_size,die_size];
	writecube(letter_top,c,s,h=letter_height,t=letter_depth,face="top");
	writecube(letter_front,c,s,h=letter_height,t=letter_depth,face="front");
	writecube(letter_right,c,s,h=letter_height,t=letter_depth,face="right");
	writecube(letter_back,c,s,h=letter_height,t=letter_depth,face="back");
	writecube(letter_left,c,s,h=letter_height,t=letter_depth,face="left");
	writecube(letter_bottom,c,s,h=letter_height,t=letter_depth,face="bottom");
}

// rounded cube
module round_cube() {
	difference() {
		translate([0,0,die_size/2])
		cube([die_size,die_size,die_size],center=true);
		diff_of_ext_spheres(die_size+pad,die_radius+pad);
		rotate(a=90,v=[1,0,0])
		translate([0,die_size/2,die_size/-2])
		diff_of_ext_spheres(die_size+pad,die_radius+pad);
		rotate(a=90,v=[0,1,0])
		translate([die_size/-2,0,die_size/-2])
		diff_of_ext_spheres(die_size+pad,die_radius+pad);
	}
}

// "extruded" sphere
module extrude_sphere(h,r) {
	cylinder(h-2*r,r,r,center=true);
	translate([0,0,(h/2)-r])
	sphere(r,center=true);
	translate([0,0,-((h/2)-r)])
	sphere(r,center=true);
}

// absence of an extruded sphere
module diff_of_ext_sphere(h,r) {
	difference() {
		cube([r,r,h]);
		translate([0,0,h/2])
		extrude_sphere(h,r);
	}
}

// array of absences of extruded spheres
module diff_of_ext_spheres(h,r) {
	for(i=[0:3]) {
		rotate( i*360/4, [0,0,1] )
		translate([(die_size/2)-r+pad,(die_size/2)-r+pad,0])
		diff_of_ext_sphere(h,r);
	}
}
	