//table thickness in mm
t=16.5;

translate([0,0,0])cube([2,70,3]);
difference() {
	cube([t+25,40,3]);
	translate([t,2,-1])cube([31,1,5]);
	translate([t+25,23,-1])cylinder(r=16,h=5);
}
translate([t+2,40,0]) cube([4,30,10]);
difference() {
	translate([t+2,40,0]) cube([23,6,3]);
	translate([t+5,43,-1])cube([30,1,5]);

}
