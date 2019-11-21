
//Spoon part height
spoon_height = 20; // [5:50]

//Spoon twist
spoon_twist = 45; // [0:720]

//Spoon radius
spoon_radius = 10; // [5:50]

//Spoon fan size
spoon_fan = 2.5; 

//Handle_height
handle_height = 60; // [5:200]

//Handle radius
handle_radius = 5; // [1:50]


/* [Hidden] */
handle_height_t= spoon_height+handle_height;
$fn=60;


module spoon() {



 union() {
	linear_extrude(height=spoon_height, twist=spoon_twist) {
		polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,30]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,60]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,90]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,120]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,150]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,180]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,210]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,240]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,270]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,300]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,330]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
		rotate([0,0,60]) polygon(points=[[0,0],[spoon_radius,0],[spoon_radius,spoon_fan],[0,spoon_fan]]);
	}

}

}

module holder() {
union() {
cylinder(h=handle_height_t,r=handle_radius);
translate([0,0,handle_height_t]) sphere(r=handle_radius);
}
}

union() {
spoon();
holder();
}

