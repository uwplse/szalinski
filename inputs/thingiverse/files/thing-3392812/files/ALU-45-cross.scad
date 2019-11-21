$fn=64;
l = 30;
// profile width
prof = 20;
nut = 5;
nutHead = 10.5;
padH = 3-0.75;
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
	translate([prof/2,0,padH]) nut();
	translate([-prof/2+r+sqrt(padH)-sqrt(r),-sqrt(padH)+sqrt(r),prof/2]) rotate([90,0,45]) nut();
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
	translate([0,prof/2-r,r]) sphere(r=r);
	translate([2*r-prof,-prof/2+r,r]) sphere(r=r);
}

module cornersSide(){
	translate([prof-r,prof/2-r,r]) sphere(r=r);
	translate([prof-r,-prof/2+r,r]) sphere(r=r);
}

module cornersTop(){
	translate([0,prof/2-r,prof-r]) sphere(r=r);
	translate([0,-prof/2+r,prof-r]) sphere(r=r);
	translate([2*r-prof,-prof/2+r,prof-r]) sphere(r=r);
}
