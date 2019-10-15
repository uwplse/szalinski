// bottle diameter
D=60;

water_bottle(D);

module water_bottle(D=60) {
$fn=100;
d=D/8 < 5.5 ? 5.5 : D/8;
z=D+d+1.5;
zz=z+10;

difference() {

// main shape
hull() {
	cylinder(d=z, h=10);
	difference() {
	union() {
		translate([zz/2, z/2-8, -2]) rotate([0, -8, 0]) cylinder(d=10, h=15);
		translate([zz/2, -z/2+8, -2]) rotate([0, -8, 0]) cylinder(d=10, h=15);
	}
	translate([-z/2, -zz/2, -4]) cube([zz, zz, 4]);
	}

}

// bottle hole
translate([0, 0, -1]) union() {
	dd=d/2+.25;
	translate([-z/2+d/4, 0, 0]) difference() {
		translate([0, 0, 17/2]) cube([dd, dd, 17], center=true);
		translate([0, -dd/2-.1, -1]) cylinder(d=dd, h=19);
		translate([0, dd/2+.1, -1]) cylinder(d=dd, h=19);
	}
	cylinder(d=D+1.5, h=17);
}

// wire cage notch
translate([(z-2)/2, -zz/2, 7.5]) rotate([0, -10, 0]) hull() {
	cube([2, zz, 13]);
	translate([1, zz, 0]) rotate([90, 90, 0]) cylinder(d=3, h=zz);
}

}
}