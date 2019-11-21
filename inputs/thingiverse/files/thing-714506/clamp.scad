tube_diam = 30;
wall_width = 2.5;

cabled = 5; //cable diameter
cabler = cabled /2;
cableww = 2; //cable wall width
cangle = 30;

length = 30;


//cable ties
tiew = 5;
tieh = 2;

loopd = cabled + cableww *2;


//maths
clampw = cabled+cableww*2;
tube_circum = 3.13159 * tube_diam;
// double clamp width
angle = 360 * clampw * 2 / tube_circum;

bracingr = tube_diam / 2 + wall_width;


module tubebody(){
	intersection() {
		cylinder(h = length, r = bracingr);
		translate([0,-clampw, 0])cube([bracingr, clampw *2, length]);	
	}
	
	
}

//body no cutouts
module clamp_body_1() {
	$fn=32;
	translate([-cabler-cableww, -cabler - cableww,0])
		cube([cabler + cableww,cabled + cableww*2,length/2]);
	translate([0,cabler +cableww/2 , 0])
		cylinder(h = length/2, r = cableww/2);
	translate([0,-cabler- cableww/2 , 0])
		cylinder(h = length/2, r = cableww/2);
}

//cut out cable and slope
module clamp_body_2() {
	$fn=32;
	//cable
	difference(){
		clamp_body_1();
		cylinder(h= length, r = cabler);
		//slope
		translate([-cabler-cableww,0,0])
			rotate([0,cangle,0])
				translate([0,-cabled*3,0])
					cube([cabled*6,cabled*6,length]);
	}
	
}

//mirror for both sides
module clamp_body_3() {
	translate([0,0 ,length ])
	mirror([0, 0, 1])
	clamp_body_2();
	clamp_body_2();
}


module body_all(){
	tubebody();
	translate([bracingr  + wall_width,0 , 0])
		clamp_body_3();	
}

module body_final() {
	difference() {
		body_all();	
		cylinder(h = length, r = tube_diam/2 );

		//cable ties
		#translate([bracingr  + wall_width,0,length /2-tiew/2])cabletie();
	}
	
}

module cabletie() {
	difference() {
		cylinder(h = tiew, r = loopd/2 + tieh);
		cylinder(h = tiew, r = loopd/2 );	
	}
	
}

body_final();
//cabletie();
//clamp_body_2();