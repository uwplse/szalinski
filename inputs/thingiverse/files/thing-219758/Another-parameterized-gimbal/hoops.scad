$fn = 100 + 0;

// height of the hoops
hoop_height = 8;
// thickness of each hoop
hoop_thinkness = 3;
// space between hoops
hoop_gap = 1;
// number of hoops
num_hoops = 3;
// radius of outer loop
outer_r = 30;

module hoop(ro, wh, inner, outer){
	if (wh % 2){
		rotate([0,0,90])
			hoop2(ro, inner, outer);
	}
	else {
		hoop2(ro, inner, outer);

	}
}

module hoop2(ro, inner, outer){
	ri = ro - hoop_thinkness;
	difference(){
		sphere(r=ro);
		sphere(r=ri);
		translate([0,0,ro / 2 + hoop_height / 2])
			cube([ro*2, ro * 2, ro], center=true);

		translate([0,0,-(ro / 2 + hoop_height / 2)])
			cube([ro*2, ro * 2, ro], center=true);

		if (!outer){
			translate([0, ro, 0])
				rotate([90, 0, 0])
				cylinder(r1 = 4, r2 = 0, h=3);

			translate([0, -(ro), 0])
				rotate([-90, 0, 0])
				cylinder(r1 = 4, r2 = 0, h=3);
		}
	}

	if (!inner){

		translate([ri, 0, 0])
			rotate([0, -90, 0])
			cylinder(r1 = 4, r2 = 0, h=3.5);

		translate([-(ri), 0, 0])
			rotate([0, 90, 0])
			cylinder(r1 = 4, r2 = 0, h=3.5);

	}
}


module hoop_non_rec(){
	for (i = [1:num_hoops]){
		hoop(outer_r - (hoop_thinkness + hoop_gap) * (num_hoops - i), i, i == 1, i == num_hoops);
	}
}

module hoop_rec(r, num, outer){
//	echo (r);
	hoop(r, num, num == 1, outer);
	if (num > 1){
		hoop_rec(r - hoop_thinkness - hoop_gap, num - 1, false);

	}
}

//hoop_rec(30, num_hoops, true);
hoop_non_rec();

