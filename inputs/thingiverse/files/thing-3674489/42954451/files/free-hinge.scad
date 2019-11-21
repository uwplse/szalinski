$fn=64;

leafMale=[50,67,5];
leafFemale=[50,45,5];

pin=[13,20];

gap = 0.3;
gapZ = 0.002;

fillets=1;
r=fillets;
wall=(pin[1]-pin[0])/2-gap/2;

shiftM=-pin[1]/2+wall;
shiftF=pin[1]/2;

holes=[[[45,67+1+shiftM],[5,67+1+shiftM],[45,67+shiftM],[5,67+shiftM]],[[45,30+shiftF],[5,30+shiftF]]]; //male, female; distance from the [0,0] 

hole=5; ///nut 7.9

////////////////////////////////////////////////////

male(leafMale);
r(0) female(leafFemale);

////////////////////////////////////////////////////
module male(leaf=[10,10,5]){
	difference(){
		u(){
			t([pin.y/2-leaf.z,0,0]) cubeRounded([leaf.z,leaf.y,leaf.x/2],r=[r,r,r],r1=[r,0,r],r5=[r,0,r]);
					
			difference(){
				t([pin.y/2-leaf.z,0,leaf.x/2-2*r]) cubeRounded([leaf.z,leaf.y,leaf.x/2+2*r],r=[r,r,r],r1=[r,0,r],r5=[r,0,r]);
				cylinder(d=pin[1]+2*gap,h=2*leaf.x);
			}
		}		
		///holes
		for(i=[0:len(holes[0])-1]){
			tr([0,holes[0][i].y,holes[0][i].x],[0,90,0]) cylinder(d=hole,h=3*leaf.z);
		}
	}

	cylinderRounded(d=[0,pin[1]],h=leaf.x/2-gapZ/2,r=[0,r,0,r]);
	cylinderRounded(d=[0,pin[0]-gap],h=leaf.x,r=[0,r,0,r]);
}

module female(leaf=[10,10,5]){
	difference(){
		r(180) u(){
			t([pin.y/2-leaf.z,0,leaf.x/2]) cubeRounded([leaf.z,leaf.y,leaf.x/2],r=[r,r,r],r1=[r,0,r],r5=[r,0,r]);
		
			difference(){
				t([pin.y/2-leaf.z,0,0]) cubeRounded([leaf.z,leaf.y,leaf.x/2+2*r],r=[r,r,r],r1=[r,0,r],r5=[r,0,r]);
				cylinder(d=pin[1]+2*gap,h=leaf.x+gapZ/2);
			}	
		}
		t([0,0,leaf.x/2+gapZ/2]) cylinder(d=pin[1]-wall,h=leaf.x);

		///holes
		for(i=[0:len(holes[1])-1]){
			mirror([0,1,0]) tr([-2*leaf.z,holes[1][i].y,holes[1][i].x]) r([0,90,0]) cylinder(d=hole,h=3*leaf.z);
		}
	}

	t([0,0,leaf.x/2+gapZ/2]) cylinderRounded(d=[pin[0]+gap,pin[1]],h=leaf.x/2-gapZ/2,r=[r,r,r,r]);
}

////////////////////////////////////////////////////

module cylinderRounded(d=[20,40],h=30,center=false,r=[1,-10,4,1]){
	translate([0,0,-h/2* (center?1:0)])
	rotate_extrude(convexity = 10)
	{
		//square
		difference(){
			translate([d[0]/2,0,0]) square([(d[1]-d[0])/2,h]);
			if(r[0]>0) translate([d[0]/2,0,0]) square([r[0],r[0]]);
			if(r[1]>0) translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			if(r[2]>0) translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			if(r[3]>0) translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
		}
		
		//corners
		
		if(r[0]>0){
			intersection(){
				translate([d[0]/2+r[0], r[0], 0]) circle(r = r[0]);
				translate([d[0]/2,0,0]) square([r[0],r[0]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[0], 0, 0]) square([-r[0],-r[0]]);
				translate([d[0]/2+r[0], -r[0], 0]) circle(r = -r[0]);
			}
		}
		
		if(r[1]>0){
			intersection(){
				translate([d[1]/2-r[1], r[1], 0]) circle(r = r[1]);
				translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			}
		} else {
			difference(){
				translate([d[1]/2, 0, 0]) square([-r[1],-r[1]]);
				translate([d[1]/2-r[1], -r[1], 0]) circle(r = -r[1]);
			}
		}
		
		if(r[2]>0){
			intersection(){
				translate([d[0]/2+r[2], h-r[2], 0]) circle(r = r[2]);
				translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[2], h+r[2], 0]) square([-r[2],-r[2]]);
				translate([d[0]/2+r[2], h+r[2], 0]) circle(r = -r[2]);
			}
		}

		if(r[3]>0){
			intersection(){
				translate([d[1]/2-r[3], h-r[3], 0]) circle(r = r[3]);
				translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
			}
		} else {
			difference(){
				translate([d[1]/2, h+r[3], 0]) square([-r[3],-r[3]]);
				translate([d[1]/2-r[3], h+r[3], 0]) circle(r = -r[3]);
			}
		}		
	}
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
	chamfer=[0,0,0,0],
	chamferAngle=60,
	center=false
){

	module t(v=[0,0,0]){translate(v) children();}
	module r(a=[0,0,0]){rotate(a) children();}
	module tr(v=[0,0,0],a=[0,0,0]){t(v) r(a) children();}
	module rt(v=[0,0,0],a=[0,0,0]){r(a) t(v) children();}
	module u(){union() children();}

	module halfTriangle3D(angle=45,h=10,z=10){
		linear_extrude(z) halfTriangle(angle,h);
	}

	module halfTriangle(angle=45,h=10){
		r=angle;
		base=h*tan(r);
		sidex=2.1*base*cos(r);
		sidey=h/cos(r)+base;
		
		intersection(){
			tr([base,0,0],[0,0,r]) translate([-sidex,0,0]) square([sidex,sidey]);
			square([2.2*base,1.1*h]);
		}
	}
	
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
	
	module cubeR(){
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
		
		//chamfering
		if(chamfer[0]) r([0,90,0]) halfTriangle3D(90-chamferAngle,size.y/(chamfer[2]+1),size.x);
			
		if(chamfer[2]) tr([0,size.y,0],[0,90,0]) mirror([0,1,0]) halfTriangle3D(90-chamferAngle,size.y/(chamfer[0]+1),size.x);

		if(chamfer[1]) tr([0,size.y,0],[90,90,0]) halfTriangle3D(90-chamferAngle,size.x/(chamfer[3]+1),size.y);

		if(chamfer[3]) tr([size.x,size.y,0],[90,90,0]) mirror([0,1,0]) halfTriangle3D(90-chamferAngle,size.x/(chamfer[1]+1),size.y);
	}
	
	c = center?1:0;
	translate([-size.x/2*c,-size.y/2*c,-size.z/2*c]) cubeR();
}

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
