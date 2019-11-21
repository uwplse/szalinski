// Size of a single hexagonal link
link_diameter = 8;
grid_space = link_diameter/2;
// horizontal thickness of the chain wire
wire_width = 1.2;
// vertical thickness of the chain wire
bridge_thickness = 0.6;
// vertical distance between overlapping links
bridge_clearance = 1;
chain_h = bridge_thickness*2+bridge_clearance;
number_of_rows = 4;
number_of_cols = 4;

/* [Hidden] */
a_vec = [1,0,0];
b_vec = [cos(60),sin(60),0];
up = [0,0,chain_h-bridge_thickness];
link_a_vec = 1.5*a_vec+1.5*b_vec;
link_b_vec = -1.5*a_vec+3*b_vec;

$fs=0.3;

module hex_bar () {
	translate([0,-wire_width/2,0])
	cube([grid_space,wire_width,bridge_thickness]);
}

module hex_bar_down () {
	translate([0,-wire_width/2,0])
	cube([grid_space,wire_width,bridge_thickness]);

	translate([grid_space/2,0,chain_h])
	//scale([1,1,(chain_h)/(grid_space+wire_width)])
	intersection() {
		rotate(a=90,v=[1,0,0])
		rotate_extrude(convexity=10)//,$fn = 36,$fs=0.1)
		translate([grid_space/2,0])
		circle(r=wire_width/2);
		translate([0,0,(grid_space+wire_width)/4])
		cube([grid_space+wire_width,wire_width,(grid_space+wire_width)/2],center=true);
	}
}

module up_bar () {
	//translate([-wire_width/2,-wire_width/2,0])
	cylinder(r=wire_width/2,h=chain_h);
}

module hex_link_1 () {
	translate(grid_space*(0 * a_vec + -1 * b_vec))
	up_bar();
	translate(grid_space*(0 * a_vec + -1 * b_vec))
	rotate(a=0,v=[0,0,1])
	hex_bar_down();
	
	translate(grid_space*(1 * a_vec + -1 * b_vec))
	up_bar();
	translate(grid_space*(1 * a_vec + -1 * b_vec)+up)
	rotate(a=60,v=[0,0,1])
	hex_bar();
	
	translate(grid_space*(1 * a_vec + 0 * b_vec))
	up_bar();
	translate(grid_space*(1 * a_vec + 0 * b_vec))
	rotate(a=120,v=[0,0,1])
	hex_bar_down();
	
	translate(grid_space*(0 * a_vec + 1 * b_vec))
	up_bar();
	translate(grid_space*(0 * a_vec + 1 * b_vec)+up)
	rotate(a=180,v=[0,0,1])
	hex_bar();
	
	translate(grid_space*(-1 * a_vec + 1 * b_vec))
	up_bar();
	translate(grid_space*(-1 * a_vec + 1 * b_vec))
	rotate(a=240,v=[0,0,1])
	hex_bar_down();
	
	translate(grid_space*(-1 * a_vec + 0 * b_vec))
	up_bar();
	translate(grid_space*(-1 * a_vec + 0 * b_vec)+up)
	rotate(a=300,v=[0,0,1])
	hex_bar();
	
}

module hex_link_2 () {
	rotate(a=60,v=[0,0,1])
	hex_link_1();
}

rotate(a=-30,v=[0,0,1])
translate(-grid_space*((number_of_cols-1)*link_a_vec+(number_of_rows-1)*link_b_vec)/2)
union() {
	for (ia = [0:number_of_cols-1]) {
		for( ib = [0:number_of_rows-1]) {
			translate(grid_space*(ia*link_a_vec+ib*link_b_vec))
			hex_link_1();
		}
	}
	for (ia = [0:number_of_cols-1]) {
		for( ib = [0:number_of_rows-1]) {
			translate(grid_space*(ia*link_a_vec+ib*link_b_vec + 1.5*b_vec))
			hex_link_2();
		}
	}
}