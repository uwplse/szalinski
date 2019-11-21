difference () {
	cube([36,31,25], center=true);
	translate ([-4,0,0]) cube([19,34,19], center=true);
	translate ([0,-2.5,15.5]) cube([40,2,10],center=true);
	translate ([0,2.5,15.5]) cube([40,2,10],center=true);
    translate ([-21,-2.5,0]) cube([10,2,40],center=true);
	translate ([-21,2.5,0]) cube([10,2,40],center=true);
	translate ([10,0,0]) cube ([10,15,19],center=true);
	translate ([13,0,0]) cube ([17,7,15],center=true);
    translate ([-27,0,0])sphere(r=13.3,$fn=200);
}