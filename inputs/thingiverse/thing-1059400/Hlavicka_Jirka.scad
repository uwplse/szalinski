$fn=100;

difference(){
cylinder(h=10.5, r=17);
	union(){
		rotate([0,0,120]) translate([0,40,-1]) cylinder(r=30,h=17);
		rotate([0,0,240]) translate([0,40,-1]) cylinder(r=30,h=17);
		rotate([0,0,0  ]) translate([0,40,-1]) cylinder(r=30,h=17);
		rotate([0,0,0  ]) translate([0,00,1]) cylinder(r=9/2,h=17);
	}
}