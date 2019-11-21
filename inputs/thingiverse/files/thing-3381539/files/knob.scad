$fn=64;
//outer diameter of knob
d = 20;
//height
h = 5;
notchesDepth = 2;

//bottom rounding of knob
rounding1 = 4;
//top rounding of knob
rounding2 = .5;
//outer diameter of the nut
nut = 8.8;
// M3 = 6.15, M5 = 8.8;

nutDepth = 3.75;
bolt = 3;
//my printer makes 0.3 smaller holes with PLA
printerOverextrusionCompensation = 0.15;

noth = 0.001+0; // hack for preview only
tol = printerOverextrusionCompensation;


knob(d=d,h=h);

module knob(d=10,h=10) {
	intersection(){
		difference (){
			cylinder(r=d/2,h=h);		
			translate([0,0,-noth]) notches(r1=d/2-notchesDepth, r2=d/2, h=h+2*noth);
			translate([0,0,h-nutDepth+noth]) nut(d=nut+tol,h=nutDepth); //smaller tolerance so it fits firmly
			translate([0,0,-noth]) cylinder(h=2*h,d=bolt+2*tol);
		}    
		cylinderRounded(h=h,d=d,r1=rounding1,r2=rounding2);
	}
}

module notches(r1=1, r2=2, h=1){
	r3 = (r2-r1)*1.5 + r1; //actual outer radius
	r4 = r3-r1; //notch radius
	if(r4>0.001) {
		pi = 3.1415926535897932384626433832795;
		number = floor(pi*r3/r4*.8);
		angle = 360/number;
		for(i = [0 : angle : 360]) {           
				rotate([0,0,i]) translate ([r3,0,0]) cylinder (r=r4,h=h,center=false);
		}
	}
}

module nut(d=3, h=1){
	cylinder(d=d,h=h,$fn=6);
}

module cylinderRounded(d=10,h=10,r1=4,r2=1){
	r_1 = (r1<=0)?0.0001:r1;
	r_2 = (r2<=0)?0.0001:r2;
	
	hull(){
		translate([0,0,r_1]) mirror([0,0,1]) torusQuart(r1=d/2-r_1,r2=r_1);
		translate([0,0,h-r_2]) torusQuart(r1=d/2-r_2,r2=r_2);
	}
}

module torusQuart(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	intersection(){
		translate([r1, 0, 0]) circle(r = r2);
		translate([r1, 0, 0]) square([2*r2,2*r2]);
	}
}
