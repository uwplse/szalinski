$fn=60;
aj=125; // [0:400]
tilt=0; // [-45:45]
squeeze=100; // [0:200]
 // 

sq=squeeze/100;

module ring1(adj=0) {
	rotate_extrude () translate([500,0,0])  circle (125+adj, center=true);
}

module ring1a() {
	translate([(1000)*sin(60),0,0]) rotate ([0,90,0]) ring1(aj);
}

module seg() {
	//translate ([0,(-.95*(125))/2]) scale ([1,.95,1]) 
		difference () {
			ring1a();
			translate ([-900,-1000,-4001]) cube (4000);
		}
}

module seg2() {
	rotate ([0,0,60]) difference () {
		translate([-(1000)*sin(60),-500,0])ring1a();
		translate ([-900,-2000,0]) cube (4000);
	}
}

module make1() {
	rotate ([0,tilt,0]) union (){
		seg();
		seg2();
	}
}
module make6() {
	for (i=[1:6]) {
		rotate ([0,0,60*(i-1)]) scale ([1,sq,1]) make1();
	}
}
module sh1() {}


module shp1() {
	rotate_extrude () translate([450,0,0])  sh1();
}

make6();
translate ([0,0,300]) rotate ([0,180,30]) make6();


//rotate ([0,0,60*(i-1)]) seg();
//rotate ([0,0,60]) seg2();


