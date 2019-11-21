$fn=64;
l1 = 20;
l2 = 20;
// profile width
prof = 20;
nut = 5;
nutHead = 10.5;
padH = 1;
// rounding
r=2;
tol = 0.15;
not = 0.01;
inf = 100;

difference(){
	body();
	holes();
}

module holes(){
	translate([l1/2,0,padH]) nut();
	translate([padH,0,l2/2]) rotate([0,90,0]) nut();


//	translate([-prof/2+r+sqrt(padH)-sqrt(r),-sqrt(padH)+sqrt(r),prof/2]) rotate([90,0,45]) nut();
}

module nut(){
	translate([0,0,-inf+not]) cylinder(d=nut+2*tol,h=inf);
	cylinder(d=nutHead+2*tol,h=inf);
}

module body(){
	hull(){
		cornersCenter();
		cornersSide();
		cornersTop();
	}
}

module cornersCenter(){
	translate([r,prof/2-r,r]) sphere(r=r);
	translate([r,-prof/2+r,r]) sphere(r=r);
}

module cornersSide(){
	translate([l1-r,prof/2-r,r]) sphere(r=r);
	translate([l1-r,-prof/2+r,r]) sphere(r=r);
}

module cornersTop(){
	translate([r,prof/2-r,l2-r]) sphere(r=r);
	translate([r,-prof/2+r,l2-r]) sphere(r=r);
}
