sides = 3;
angle = 360 / sides;
radius = 100;
rotate([0, 0, $t*angle]) union() {
	difference() {
		union() {
			linear_extrude(10, scale=.525,twist=-22,slices=40) for (rot = [0 : angle : 359])
			rotate(rot) translate([0,-1.5,0]) square([radius,3],center=false);
			cylinder(h=10,r1=radius/8.5,r2=radius/30,$fn=50);
		}
		cylinder(h=8,r=2,$fn=20);
		difference() {
			cylinder(r=radius+.5,h=10,slices=50);
			cylinder(r=radius*.85,h=10, slices=50);
		}
	}
//	translate([0,0,1.5]) rotate_extrude($fn=90) translate([radius*.85,0,0]) //circle(r=1.5,center=true,$fn=40);
}
