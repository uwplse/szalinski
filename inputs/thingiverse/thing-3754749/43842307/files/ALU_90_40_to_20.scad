$fn=50;
tol = 0.2;

l1 = 40;
l2 = 30;

// profile width
prof=[40,20];
nut = [8,5];
nutHead = [14+tol,9.5+tol];
padH = [4.5,3];
r=2; // fillet
rail=[[0,8,2],[0,4.8,0.8]];


not = 0.001;
inf = 100;

///////////////////////////////////////////////////////////

difference(){
	body();
	holes();
}

///////////////////////////////////////////////////////////

module rails(){
	t([r,-rail[0].y/2,-rail[0].z]) cube([l1-2*r,rail[0].y,rail[0].z]);
	rt([0,-90,0],v=[r,-rail[1].y/2+(prof[0]-prof[1])/2,0]) cube([l2-2*r,rail[1].y,rail[1].z]);
}

module holes(){
	t([l1-prof[0]/2,0,padH[0]]) nut(nut[0],nutHead[0]);
	tr([padH[1],(prof[0]-prof[1])/2,l2-prof[1]/2],[0,90,0]) nut(nut[1],nutHead[1]);
}

module nut(d1=3,d2=5){
	t([0,0,-inf+not]) cylinder(d=d1+2*tol,h=inf);
	cylinder(d=d2+2*tol,h=inf);
}

module body(){
	hull(){
		cornersCenter();
		cornersSide();
		cornersTop();
	}
	rails();
}

module cornersCenter(){
	t([r,prof[0]/2-r,r]) sphere(r=r);
	t([r,-prof[0]/2+r,r]) sphere(r=r);
}

module cornersSide(){
	t([l1-r,prof[0]/2-r,r]) sphere(r=r);
	t([l1-r,-prof[0]/2+r,r]) sphere(r=r);
}

module cornersTop(){
	t([r,prof[0]/2-r,l2-r]) sphere(r=r);
	t([r,prof[0]/2-prof[1]+r,l2-r]) sphere(r=r);
}

///////////////////////////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
