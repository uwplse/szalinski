thickness = 1.2;
difference() {
	cube([38,26,thickness], center=true);
	translate([14/2,0,0]) cylinder(r=4.25, h = thickness+1, center=true);
	translate([-14/2,0,0]) cylinder(r=4.25, h = thickness+1, center=true);
	translate([38/2, 26/2, 0]) corner();
	translate([-38/2, 26/2, 0]) corner();
	translate([-38/2, -26/2, 0]) corner();
	translate([38/2, -26/2, 0]) corner();
}
module corner() {
	cube([9*2,5*2,thickness+1], center = true);
}