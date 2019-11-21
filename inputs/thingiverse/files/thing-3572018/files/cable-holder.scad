$fn=64;

bolt = 6;
boltHead = 13.5;
boltPad = 4;

height = 15;
gap = 5;
wall = 2;
width = 20;

r = 1;
tol=0.2;
length = 2*wall+boltHead+2*tol+gap;

not = 0.01;
inf=100;

difference(){
	u(){
		///bottom
		t([0,-width/2,0]) cubeRounded([boltHead+2*tol+wall,width,boltPad],r=[r,r,r]);
		
		//wall
		t([0,-width/2,0]) cubeRounded([wall,width,height],r=[r,r,r]);

		///top
		t([0,-width/2,height-wall]) cubeRounded([length,width,wall],r=[r,r,r]);
		
		///side
		t([length-wall,-width/2,gap]) cubeRounded([wall,width,height-gap],r=[r,r,r]);
	}
	t([boltHead/2+tol+wall,0,boltPad]) bolt(bolt, boltHead);
}


module bolt(bolt=3,boltHead=5){
	t([0,0,-inf+not]) cylinder(d=bolt+2*tol,h=inf);
	cylinder(d=boltHead+2*tol,h=inf);
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

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0]){rotate(a) children();}
module tr(v=[0,0,0],a=[0,0,0]){t(v) r(a) children();}
module rt(a=[0,0,0],v=[0,0,0]){r(a) t(v) children();}
module u(){union() children();}