$fn=64;
d1=10;
d2=10;

intersection(){
	cyl();
	rotate([0,90,0]) cyl();
	rotate([90,0,0]) cyl();
	sphere(d=d2);
}

module cyl(){
	rotate(22.5) cylinder(d=d1,h=d1,center=true,$fn=8);
}