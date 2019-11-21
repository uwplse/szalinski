//Diameter of ring opening in mm
hole=50;

/* [Hidden] */
$fn=60;

difference() {
	hull() {
		cylinder(r=hole/2+7,h=2);
		translate([hole/2+7+5,0,0]) cylinder(r=9,h=2);
	}
	translate([0,0,-1])cylinder(r=hole/2,h=4);
	translate([hole/2+7+5,0,-1])cylinder(r=5,h=5);
}
