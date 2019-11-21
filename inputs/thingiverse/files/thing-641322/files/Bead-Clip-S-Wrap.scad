difference () {
	cube([30,31,25], center=true);
	translate ([-2,0,0]) cube([19,34,19], center=true);
	translate ([1,-2.5,15.5]) cube([40,2,10],center=true);
	translate ([1,2.5,15.5]) cube([40,2,10],center=true);
    translate ([-18,-2.5,0]) cube([10,2,40],center=true);
	translate ([-18,2.5,0]) cube([10,2,40],center=true);
	translate ([7,0,0]) cube ([10,15,19],center=true);
	translate ([13,0,0]) cube ([17,7,15],center=true);
    translate ([-25,0,0])sphere(r=13.3,$fn=200);
}