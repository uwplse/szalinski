$fn=16;

///// profile 2020
//	// profile width
//	prof=20;
//	//size of notches
//	h=5;
//	//rounding of edges
//	r=2;
//	//center skewed bolt
//	center = 0;
//	l = 30;
//	bolt = 5;
//	boltHead = 10.5;
//	//thickness of plastic under bolt head
//	boltPad = 2.15;
//	notchX = 5;
//	notchY = 6.4;
///// profile 2020

/// profile 4040
	// profile width
	prof=40;
	wall=5;
	//rounding of edges
	r=3;
	r2=1.5;
	//length of notches
	h=2*r;
	//center skewed bolt
	center = 0;
	l = 30;
	bolt = 6;
	boltHead = 13.5;
	//thickness of plastic under bolt head
	boltPad = 4;
	notch = [8.3, 15.5];
/// profile 4040

//compensation of overextrusion of printer
tol = 0.2;
gap = .1;
not = 0.001+0;
inf = 3*max(l,prof);

////////////////////////////////////////

rotate([0,45,0])
difference(){
	union(){
		translate([0,0,prof/2]) rotate([90,0,90]) translate([0,0,-h]) notches(h=h);

		wedge();
		body();
	}
	holes();
}

////////////////////////////////////////

module innerCube(h=10){
	w = prof-2*notchY;
	translate([0,0,h/2]) cube([w,w,h+not], true);
	if(center) translate([0,notchY/2,h/2]) cube([w,w+notchY,h+not], true);	
}

module notches(h=10){
	w=notch.x;
	difference(){
		union(){
			translate([-w/2,-prof/2,0]) cubeRounded([w,prof,h],r0=[r2,0,r2],r1=[r2,0,r2],r2=[r2,0,r2],r3=[r2,0,r2]);
			translate([-prof/2,-w/2,0]) cubeRounded([prof,w,h],r0=[0,r2,r2],r1=[0,r2,r2],r2=[0,r2,r2],r3=[0,r2,r2]);
		}
		translate([0,0,h/2]) cube([notch.y,notch.y,h], true);
	}
}

module holes(){
	translate([-l/2,0,prof+boltPad]) bolt();
	//translate([-prof/2+r+sqrt(boltPad)-sqrt(r),-sqrt(boltPad)+sqrt(r),prof/2]) rotate([90,0,45]) bolt();
		
	//rotate([0,-45,0]) translate([l/2+prof*sqrt(2),0,boltPad]) bolt();
	l2=center ? (prof/2*sqrt(2)) : prof;
	rotate([0,-45,0]) translate([l2,0,boltPad]) bolt();
}

module bolt(){
	translate([0,0,-inf+not]) cylinder(d=bolt+2*tol,h=inf);
	cylinder(d=boltHead+2*tol,h=inf);
}

module wedge(){
	hull(){
		translate([0,-prof/2+r,r]) rotate([0,90,0]) cylinder(r=r, h=not);
		translate([0,prof/2-r,r]) rotate([0,90,0]) cylinder(r=r, h=not);
		
		translate([0,-prof/2,prof]) sphere(r=not);
		translate([0,prof/2,prof]) sphere(r=not);		
		
		points1();
	}	
}

module body(){
	//#translate([0,-prof/2,prof]) cube([10,10,10]);
	
	difference(){
		hull(){	
			points1();
			
			translate([0,-prof/2,prof]) sphere(r=not);
			translate([0,prof/2,prof]) sphere(r=not);
		
			translate([-l,-prof/2+r,prof+r]) sphere(r=r);
			translate([-l,prof/2-r,prof+r]) sphere(r=r);
		}
		translate([-prof,-prof,prof-gap]) cube([prof,2*prof,2*gap]);

		//translate([-prof,-prof,prof+2*r-gap]) cube([3*prof,2*prof,2*gap]);
	}
}

module points1(){
	rn=r;
	translate([prof+rn-r*sqrt(2),-prof/2+rn,prof+rn]) sphere(r=rn);
	translate([prof+rn-r*sqrt(2),prof/2-rn,prof+rn]) sphere(r=rn);

//	translate([prof+r,-prof/2,prof+r]) sphere(r=not);
//	translate([prof+r,prof/2,prof+r]) sphere(r=not);
}

module cubeRounded(	
	size=[3,3,3],
	r=[0,0,0],
	r0=[-1,-1,-1],
	r1=[-1,-1,-1],
	r2=[-1,-1,-1],
	r3=[-1,-1,-1],
	r4=[-1,-1,-1],
	r5=[-1,-1,-1],
	r6=[-1,-1,-1],
	r7=[-1,-1,-1],
){
	
	function sat3(a) = [max(0,a.x),max(0,a.y),max(0,a.z)];
	function chg(a, b) = (a.x==-1 && a.y==-1 && a.z==-1) ? b : a;

	_r0 = sat3(chg(r0, r));
	_r1 = sat3(chg(r1, r));
	_r2 = sat3(chg(r2, r));
	_r3 = sat3(chg(r3, r));
	_r4 = sat3(chg(r4, r));
	_r5 = sat3(chg(r5, r));
	_r6 = sat3(chg(r6, r));
	_r7 = sat3(chg(r7, r));
		
	hull(){
		translate(_r0) scale(_r0) sphere(1);
		translate([size.x-_r1.x,_r1.y,_r1.z]) scale(_r1) sphere(1);
		translate([_r2.x,size.y-_r2.y,_r2.z]) scale(_r2) sphere(1);
		translate([size.x-_r3.x,size.y-_r3.y,_r3.z]) scale(_r3) sphere(1);

		translate([_r4.x,_r4.y,size.z-_r4.z]) scale(_r4) sphere(1);
		translate([size.x-_r5.x,_r5.y,size.z-_r5.z]) scale(_r5) sphere(1);
		translate([_r6.x,size.y-_r6.y,size.z-_r6.z]) scale(_r6) sphere(1);
		translate([size.x-_r7.x,size.y-_r7.y,size.z-_r7.z]) scale(_r7) sphere(1);
	}
}
