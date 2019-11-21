extra=0.1;
H=12;
L=4.5+extra;
B=12.1+extra;
union(){
rotate([0,0,90])
translate([24,-(L+2),0])
difference()
{

cube([B+2,L+2,H+1]);
translate([1,1,1])
cube([B,L,H+2]);
}

difference() {
	union() {
		cube([4,24,10]);  //4,45,10
		translate([8, 15,0]) cylinder(h = 10, r = 8, $fn = 50);
		cube([16, 15,10]);
		
		translate([17,6,5]) cube([2,5.75,10], center=true);
		translate([17,6,5]) rotate(a=[60,0,0]) cube([2,5.75,10], center=true);
		translate([17,6,5]) rotate(a=[120,0,0]) cube([2,5.75,10], center=true);

	}
	translate([8, 15,0]) cylinder(h = 10, r = 4, $fn = 50);
	translate([5, 0, 0]) cube([6, 15,10]);
	translate([-10, 6, 5]) rotate(a=[0, 90, 0]) cylinder(h = 30, r = 1.5, $fn= 20);

	translate([17,6,5]) cube([2,3.5,6], center=true);
	translate([17,6,5]) rotate(a=[60,0,0]) cube([2,3.5,6], center=true);
	translate([17,6,5]) rotate(a=[120,0,0]) cube([2,3.5,6], center=true);
}
}