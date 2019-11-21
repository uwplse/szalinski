//table thickness in mm
table=17.5;

/* [Hidden] */
t=table+1;
$fn=50;

difference() {
	union (){
	translate ([2,2,0]) minkowski(){
		cube([t+21,36,2]);
		cylinder(r=2,h=1);
	}
	translate([0,37,2]) minkowski(){
		cube([2,33,2]);
		rotate([0,90,0]) cylinder(r=2,h=1);
	}
		
	translate([t+2,40,0]) cube([23,6,3]);
	}
	translate([t,2,-1])cube([31,1,5]);
	translate([t+25,23,-1])cylinder(r=18,h=5);
	translate([t+5,43,-1])cube([30,1,5]);
}

difference() {
	translate([t+6,57,0]) resize([11,37,6])cylinder(r=10,h=6);
	translate ([t+6,57,-1])resize([7,33,8]) cylinder(r=10,h=6);
	translate ([t+5,35,-1])cube([20,45,8]);
	translate ([t-1,72,-1])cube([20,45,8]);
}