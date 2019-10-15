$fn=50;
h=5;
prof=20;
r=2;

rotate([180,0,0]){
	difference(){
		spheres(r=r);
		translate([0,0,-h]) outerCube(h=h);
	}

	translate([0,0,-h]) difference(){
		notches(h=h);
		innerCube(h=h+0.01);
	}
}

module outerCube(h=10){
	translate([0,0,h/2]) cube([prof,prof,h], true);
}

module innerCube(h=10){
	translate([0,0,h/2]) cube([7.2,7.2,h], true);
}

module notches(h=10){
	translate([0,0,h/2]) cube([5,prof,h], true);
	translate([0,0,h/2]) cube([prof,5,h], true);
}

module spheres(r=3){
	x=prof/2-r;
	hull(){
		translate([x,x,0]) sphere(r=r);
		translate([x,-x,0]) sphere(r=r);
		translate([-x,x,0]) sphere(r=r);
		translate([-x,-x,0]) sphere(r=r);
	}
}