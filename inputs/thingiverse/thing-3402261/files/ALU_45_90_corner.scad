$fn=16;
l1 = 40;
l2 = 40;
l3 = 48.5;
l=l3;
// profile width
prof = 20;
nut = 5;
nutHead = 10.5;
//thickness of plastic under bolt head
padH = 2.15;
// rounding
r=2;
//compensation of overextrusion of printer
tol = 0.15;
not = 0.001+0;
inf = prof*1.2;
wall=prof/5;


//size of notches
h=5;
//center skewed bolt
center = 0;
notchX = 5;
notchY = 6.4;


difference(){
	union(){
		difference(){
			body1();
			rotate([0,45,0]) translate([-prof/2,-prof/2,prof/2+wall]) profile(l=inf);
		}
		rotate([0,45,0])translate([0,0,prof/2+wall]) difference(){
			notches(h=h);
			innerCube(h=h);
		}
		rotate([0,-45,0]) translate([prof/2+wall,0,prof/2+r]) body2();
	}
	rotate([0,-45,0]) translate([prof/2+wall+l3-prof/2,0,prof/2+r]) nut();
	holes();
}

module holes(){
	translate([l1-prof/2,0,padH]) nut();
	translate([padH,0,l2-prof/2]) rotate([0,90,0]) nut();
}

module nut(){
	translate([0,0,-inf+not]) cylinder(d=nut+2*tol,h=inf);
	cylinder(d=nutHead+2*tol,h=inf);
}

module body1(){
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


///////////////////////////////////////

//translate([0,0,0]) rotate([0,45,180]) difference(){
//	union(){
//		translate([0,0,prof/2]) rotate([90,0,90])translate([0,0,-h]) difference(){
//			notches(h=h);
//			innerCube(h=h);
//		}
//
//		wedge();
//		body2();
//	}
//	holes2();
//}

module innerCube(h=10){
	w = prof-2*notchY;
	translate([0,0,h/2]) cube([w,w,h+not], true);
	if(center) translate([0,notchY/2,h/2]) cube([w,w+notchY,h+not], true);	
}

module notches(h=10){
	translate([0,0,h/2]) cube([notchX,prof,h], true);
	translate([0,0,h/2]) cube([prof,notchX,h], true);
}

module holes2(){
	//translate([-l/2,0,prof+padH]) nut();
	//l2=center ? (prof/2*sqrt(2)) : prof;
	rotate([0,-45,0]) translate([l2,0,padH]) nut();
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

module body2(){
	//rs2 = r/sqrt(2);
	hull(){	
		translate([r,prof/2-r,0]) sphere(r=r);
		translate([l3-r,prof/2-r,0]) sphere(r=r);
		translate([r,-prof/2+r,0]) sphere(r=r);
		translate([l3-r,-prof/2+r,0]) sphere(r=r);
		
		//points1();
		
		//translate([0,-prof/2,prof]) sphere(r=not);
		//translate([0,prof/2,prof]) sphere(r=not);
	
		//translate([-l,-prof/2+r,prof+r]) sphere(r=r);
		//translate([-l,prof/2-r,prof+r]) sphere(r=r);
	}
}

module points1(){
	rotate([0,-45,0]) translate([prof*sqrt(2),-prof/2+r,r]) sphere(r=r);
	rotate([0,-45,0]) translate([prof*sqrt(2),prof/2-r,r]) sphere(r=r);
}

module profile(l=10){
	hull(){
		translate([r,r,0]) cylinder(h=l,r=r);
		translate([prof-r,r,0]) cylinder(h=l,r=r);
		translate([r,prof-r,0]) cylinder(h=l,r=r);
		translate([prof-r,prof-r,0]) cylinder(h=l,r=r);
	}
}