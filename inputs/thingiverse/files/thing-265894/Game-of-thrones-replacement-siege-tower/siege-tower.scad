height = 25;

base_of_center_section = 10;

base_of_support_section = 5;

size_of_wood_shapes = 1;

radius_of_wheels = 2;

number_of_levels = 3;

number_of_wheels = 3;

tower(
	height,
	base_of_center_section,
	base_of_support_section,
	size_of_wood_shapes,
	radius_of_wheels,
	number_of_levels,
	number_of_wheels
);

/**
h  = height of the tower
b  = base of the center section
b2 = base of the support zone
s  = size of the wood in the sides
r  = radius of the wheels
hn = number of levels of the tower
wn = number of wheels
*/
module tower(h,b,b2,s,r,hn,wn)
	translate([-(b+b2)/2,r,-b/2]) {
	//Main body of the tower
	hull(){
		translate([b,0,0]) cube([b2,0.001,b]);
		translate([b-s,0,0]) cube([s,h,b]);
		//gate
		translate([-s,h,2*s]) cube([2*s,s,b-4*s]);
	}
	translate([0,0,s])  cube([b,h,b-2*s]);
	cube([s,h,b]);
	//wheels
	for(i = [0:wn-1]){
		translate([r + i*(b+b2-2*r)/(wn-1),0,0])
			cylinder(b,r,r);
	}
	//wood divisions
	cube([b,s,b]);
	for(i = [1:hn]) translate([0,i*h/wn]) {
		cube([b,s,b]);
		hull(){
			cube([s,s,b]);
			translate([b-s,-h/wn,0]) cube([s,s,b]);
		}
	}
	
}

