$fn = 100;

length = 20;

difference(){
	union(){
		cylinder(h=5.5, d=13);
		translate([0,-6.6,0])cube([length,13,5.5]);
		translate([length,0,0])cylinder(h=5.5, d=13);
	}
	cylinder(h=5.5, d=5.5);
	translate([length,0,0])cylinder(h=5.5, d=5.5);
	translate([0,0,2.5])rotate(90)cylinder(h=5.5, d=9, $fn=6);
}