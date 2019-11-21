$fn=100;

difference() {
	union() {
		cylinder(d=12,h=1);
		cylinder(d=4.6,h=3);
	}
	cylinder(d=3,h=8);
}
