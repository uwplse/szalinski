$fn=64;

d1 = 40;
h1 = 5;

d2 = 23+1;
h2 = 22;

teeth=2; ///thickness of teeth
teethFlat=1; ///flat part so the diameter fits, should be at least 1 layer height

r1 = 1;
r2 = 1;
r3 = 0;

///////////////////////////////////////////////

cylinderRounded(h=h1,d=d1,r1=r1,r2=r2);
t([0,0,h1]){
	cylinderRounded(h=h2,d=d2-2*teeth,r1=0,r2=r3);
	teeth(d2,teeth,h2-r3);
	
}

///////////////////////////////////////////////

module teeth(d=10,teeth=1,h=5){
	if(teeth>0) {
		step=2*teeth+teethFlat;
		for(z=[0:step:h-step]){
			t([0,0,z]) rotate_extrude(){
				t([d/2-teeth,0,0]) polygon([[0,0],[teeth,teeth],[teeth,teeth+teethFlat],[0,2*teeth+teethFlat]]);
			}
		}
	}
}

///////////////////////////////////////////////

module cylinderRounded(d=10,h=10,r1=1,r2=2){
	not = 0.000001;
	difference(){
		hull(){
			if (r1>0){
				translate([0,0,r1]) mirror([0,0,1]) torusQuart(r1=d/2-r1,r2=r1);
			} else {
				translate([0,0,0]) cylinder(d=d,h=not);
			}
			if (r2>0){
				translate([0,0,h-r2]) torusQuart(r1=d/2-r2,r2=r2);
			} else {
				translate([0,0,h]) cylinder(d=d,h=not);
			}
		}
	}
}

module torusQuart(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	intersection(){
		translate([r1, 0, 0]) circle(r = r2);
		translate([r1, 0, 0]) square([2*r2,2*r2]);
	}
}

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
