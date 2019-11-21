x = 10;
y = 6;
z = 1;

module bench(x1,y1,z1){
	difference(){
		cube([x1,y1,z1]);
		translate([x1/2,y1/2,0])
		cylinder(h = z1+2, r = 1);
	}
}

module legs(){
	translate([1,0,-4])
	cylinder(h=4, r =1);

	translate([x-1,0,-4])
	cylinder(h=4, r =1);

	translate([1,y-2,-4])
	cylinder(h=4, r =1);

	translate([x-1,y-2,-4])
	cylinder(h=4, r =1);
}

translate([0,-1,0])
bench(x,y,z);
rotate([115,0,0])
bench(x,y,z);
legs();