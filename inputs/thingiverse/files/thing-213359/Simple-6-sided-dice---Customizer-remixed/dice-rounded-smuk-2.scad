$fn=25;

// Dice-Eyes Radius
radiuseye=1.8;

scale(2,2,2) {
difference() {
	minkowski() {
		translate([3,3,3], center=true) sphere(r=3);
		translate([0,0,0]) cube([14,14,14]);
	}

	translate([10,  0, 10]) sphere(r=radiuseye); // 1

	translate([20,  5,  5]) sphere(r=radiuseye); // 2 
	translate([20, 15, 15]) sphere(r=radiuseye); // 2

	translate([ 5,  5, 20]) sphere(r=radiuseye); // 3
	translate([10, 10, 20]) sphere(r=radiuseye); // 3
	translate([15, 15, 20]) sphere(r=radiuseye); // 3

	translate([ 5,  5,  0]) sphere(r=radiuseye); // 4
	translate([15,  5,  0]) sphere(r=radiuseye); // 4
	translate([ 5, 15,  0]) sphere(r=radiuseye); // 4
	translate([15, 15,  0]) sphere(r=radiuseye); // 4

	translate([ 0,  5,  5]) sphere(r=radiuseye); // 5
	translate([ 0, 15,  5]) sphere(r=radiuseye); // 5
	translate([ 0,  5, 15]) sphere(r=radiuseye); // 5
	translate([ 0, 15, 15]) sphere(r=radiuseye); // 5
	translate([ 0, 10, 10]) sphere(r=radiuseye); // 5

	translate([ 5, 20,  5]) sphere(r=radiuseye); // 6
	translate([15, 20,  5]) sphere(r=radiuseye); // 6
	translate([ 5, 20, 10]) sphere(r=radiuseye); // 6
	translate([15, 20, 10]) sphere(r=radiuseye); // 6
	translate([ 5, 20, 15]) sphere(r=radiuseye); // 6
	translate([15, 20, 15]) sphere(r=radiuseye); // 6
}
}