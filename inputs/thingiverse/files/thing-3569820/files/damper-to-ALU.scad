$fn=64;

profile=20;
damper=[10.3,51.5,12,0.8];
wall=3;

bolt=5;
boltHead=10;
boltPad=2;

shift=[0,26,10];
//shift=[0,damper.y/2+tol/2+0.5,2];

r=2;

tol=0.2;
not=0.001;

block=[damper.x+tol+2*wall,shift.y,damper.y+wall];

////////////////////////////

body();

////////////////////////////

module body(){
	difference(){
		u(){
			t([-damper.x/2-wall-tol/2,0,-shift.z]) mirror([0,1,0]) cubeRounded(block,r=[r,r,r],r2=[r,0,r],r3=[r,0,r],r6=[r,0,r],r7=[r,0,r]);
			
			t([0,-shift.y,-shift.z]) difference(){
				cylinderRounded(d=[0,damper.x+2*wall],h=damper.y+wall,r=[0,r,0,r]);
				t([-damper.x,0,-not]) cube([3*damper.x,damper.x,damper.y*3]);
			}
		}
		damper();
	}
	pads();
}

module pad(){
	tr([block.x/2+boltHead/2,0,profile/2],[90,0,0]) 
		cylinderRounded(d=[0,boltHead+tol],h=boltPad,r=[0,0,0,boltPad/2]);
}

module bolt(){
	tr([block.x/2+boltHead/2,damper.x/2+tol,profile/2],[90,0,0]) 
		t([0,0,-not]) cylinder(d=bolt+tol,h=profile);
}

module pads(){
	r=boltPad/2;
	difference(){
		hull(){
			pad();
			mirror([1,0,0]) pad();
			#t([-block.x/2,-boltPad,0]) cubeRounded([block.x,boltPad,profile],r=[r,r,r]);
		}
		bolt();
		mirror([1,0,0]) bolt();
		damper();
	}
}

module damper(){
	t([0,-shift.y,-shift.z-not]){
		cylinder(d=damper.x+tol,h=damper.y);
		cylinder(d=damper[2]+tol,h=damper[3]);
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
	chamferAngle=60
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

module cylinderRounded(d=[20,40],h=30,r=[1,-10,4,1]){
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

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0]){rotate(a) children();}
module tr(v=[0,0,0],a=[0,0,0]){t(v) r(a) children();}
module rt(a=[0,0,0],v=[0,0,0]){r(a) t(v) children();}
module u(){union() children();}