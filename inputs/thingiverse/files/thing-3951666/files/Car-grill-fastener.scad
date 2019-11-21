//$fs=0.2;
//$fa=3;
$fn=16;

grillGap=20;
grillWall=2;
grillDepth=25+2;

wall=2;
tip=2;

bolt=8;
boltL=50;
boltHead=[30,5];
threadW=2;
pitch=4;
threadGap=0.5;

w=bolt+2*threadW+2*wall;
f=1;
chamfer=30;

//////////////////////////////////////////////////////

bolt();
nut();

//////////////////////////////////////////////////////
module nut(){
	tr([-wall,0,bolt/2+threadW+wall],[0,90,0]) nutThread([bolt,bolt+2*threadW],pitch,grillDepth+wall,gap=threadGap,wall=wall);


	difference(){
		cubeRounded([wall,grillGap+2*grillWall+2*wall,w],r=[f,f,f],center=[2,1,0]);
		
		tr([-50,0,bolt/2+threadW+wall],[0,90,0]) cylinder(d=bolt+2*threadW,h=100);
	}

	for(y=[-wall/2-wall-grillGap/2,wall/2+wall+grillGap/2]){
		t([-wall,y,0]) cubeRounded([grillDepth+2*wall,wall,w],r=[f,f,f],center=[0,1,0]);
	}

	for(m=[0,1]){
		mirror([0,m,0]) t([grillDepth,-grillGap/2-grillWall-wall,0]) cubeRounded([wall,wall+tip,w],r=[f,f,f],center=[0,0,0]);
	}
}

module bolt(){
	t([-boltHead[0],0,0]){
		boltThread([bolt,bolt+2*threadW],pitch,h=boltL+boltHead[1],gap=threadGap,wall=-1);

		t([0,0,boltL+boltHead[1]]) sphere(d=bolt);
		
		cylinderRounded(d=[0,boltHead[0]],h=boltHead[1],r=[0,2*f,0,f],chamfer=chamfer);
		
	}
}
//////////////////////////////////////////////////////

//////////////////////////////////
module cylinderRounded(d=[20,40],h=30,center=false,r=[0,0,0,0],chamfer=0){
	t([0,0,-h/2* (center?1:0)])
	rotate_extrude(convexity = 10)
	{
		//square
		difference(){
			t([d[0]/2,0,0]) square([(d[1]-d[0])/2,h]);
			if(r[0]>0) t([d[0]/2,0,0]) square([r[0],r[0]]);
			if(r[1]>0) t([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			if(r[2]>0) t([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			if(r[3]>0) t([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
		}
		
		//corners
		
		if(r[0]>0){
			intersection(){
				t([d[0]/2+r[0], r[0], 0]) circle(r = r[0]);
				t([d[0]/2,0,0]) square([r[0],r[0]]);
			}
			polygon([[d[0]/2+r[0],0],[d[0]/2+r[0]-r[0]*cos(90-chamfer),r[0]-r[0]*sin(90-chamfer)],[d[0]/2+r[0]-r[0]*cos(90-chamfer)+tan(90-chamfer)*(r[0]-r[0]*sin(90-chamfer)),0]]);
		} else {
			difference(){
				t([d[0]/2+r[0], 0, 0]) square([-r[0],-r[0]]);
				t([d[0]/2+r[0], -r[0], 0]) circle(r = -r[0]);
			}
		}
		
		if(r[1]>0){
			intersection(){
				t([d[1]/2-r[1], r[1], 0]) circle(r = r[1]);
				t([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			}
			polygon([[d[1]/2-r[1],0],[d[1]/2-r[1]+r[1]*cos(90-chamfer),r[1]-r[1]*sin(90-chamfer)],[d[1]/2-r[1]+r[1]*cos(90-chamfer)-tan(90-chamfer)*(r[1]-r[1]*sin(90-chamfer)),0]]);
		} else {
			difference(){
				t([d[1]/2, 0, 0]) square([-r[1],-r[1]]);
				t([d[1]/2-r[1], -r[1], 0]) circle(r = -r[1]);
			}
		}
		
		if(r[2]>0){
			intersection(){
				t([d[0]/2+r[2], h-r[2], 0]) circle(r = r[2]);
				t([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			}
		} else {
			difference(){
				t([d[0]/2+r[2], h+r[2], 0]) square([-r[2],-r[2]]);
				t([d[0]/2+r[2], h+r[2], 0]) circle(r = -r[2]);
			}
		}

		if(r[3]>0){
			intersection(){
				t([d[1]/2-r[3], h-r[3], 0]) circle(r = r[3]);
				t([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
			}
		} else {
			difference(){
				t([d[1]/2, h+r[3], 0]) square([-r[3],-r[3]]);
				t([d[1]/2-r[3], h+r[3], 0]) circle(r = -r[3]);
			}
		}		
	}
}

module boltThread(d=[5,10],pitch=2,h=10,gap=0.2,wall=1,toothH=-1,direction=1){
	tH=(toothH==-1)?(pitch/4):toothH;
	iT=pitch/2-tH;
	w=wall<0?d[0]/2:min(wall,d[0]/2);
	
	twist_convex(pitch,(h+iT)/pitch-1,direction){
		polygon([[d[0]/2-w,0],[d[0]/2,0],[d[1]/2-gap,iT],[d[1]/2-gap,iT+tH],[d[0]/2,2*iT+tH],[d[0]/2-w,2*iT+tH]]);
	}

	difference(){
		cylinder(d=d[0],h=h);
		translate([0,0,-h]) cylinder(d=d[0]-2*w,h=3*h);
	}
}

module nutThread(d=[5,10],pitch=2,h=10,toothH=-1,gap=0,wall=1,direction=1){
	tH=toothH==-1?pitch/4:toothH;
	iT=pitch/2-tH;
	
	twist_convex(pitch,(h+iT)/pitch-1,direction){
		polygon([[d[1]/2+wall,0], [d[1]/2,0], [d[0]/2+gap,iT], [d[0]/2+gap,iT+tH], [d[1]/2,2*iT+tH], [d[1]/2+wall,2*iT+tH]]);
	}
	
	difference(){
		cylinder(d=d[1]+2*wall,h=h);
		translate([0,0,-h]) cylinder(d=d[1],h=3*h);
	}
}

module twist_convex(pitch=10,rotations=1,direction=1,$fn=$fn){
	not=0.001;
	s=direction!=0?1:-1;
	for(i=[0:$fn*rotations-1]){
		translate([0,0,i/$fn*pitch]) r(direction*i*(360/$fn)) hull(){
			r([90,0,0]) linear_extrude(not) children();
			translate([0,0,pitch/$fn]) r([90,0,direction*(360/$fn)]) linear_extrude(
		not) children();
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
	center=[0,0,0],
	not=0.00001
){
	module halfTriangle3D(angle=45,h=10,z=10){
		linear_extrude(z) halfTriangle(angle,h);
	}

	module halfTriangle(angle=45,h=10){
		r=angle;
		base=h*tan(r);
		sidex=2.1*base*cos(r);
		sidey=h/cos(r)+base;
		
		intersection(){
			tr([base,0,0],[0,0,r]) t([-sidex,0,0]) square([sidex,sidey]);
			square([2.2*base,1.1*h]);
		}
	}
	
	function sat3(a) = [max(not,a.x),max(not,a.y),max(not,a.z)];
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
			t(_r0) scale(_r0) intersection(){
				sphere(1);
				mirror([1,0,0]) mirror([0,1,1]) cube(1);
			}
			
			t([size.x-_r1.x,_r1.y,_r1.z]) scale(_r1) intersection(){
				sphere(1);
				mirror([0,1,1]) cube(1);
			}
			
			t([_r2.x,size.y-_r2.y,_r2.z]) scale(_r2) intersection(){
				sphere(1);
				mirror([1,0,1]) cube(1);
			}
			
			t([size.x-_r3.x,size.y-_r3.y,_r3.z]) scale(_r3) intersection(){
				sphere(1);
				mirror([0,0,1]) cube(1);
			}

			t([_r4.x,_r4.y,size.z-_r4.z]) scale(_r4) intersection(){
				sphere(1);
				mirror([1,1,0]) cube(1);
			}
			
			t([size.x-_r5.x,_r5.y,size.z-_r5.z]) scale(_r5) intersection(){
				sphere(1);
				mirror([0,1,0]) cube(1);
			}

			t([_r6.x,size.y-_r6.y,size.z-_r6.z]) scale(_r6) intersection(){
				sphere(1);
				mirror([1,0,0]) cube(1);
			}
			
			t([size.x-_r7.x,size.y-_r7.y,size.z-_r7.z]) scale(_r7) intersection(){
				sphere(1);
				mirror([0,0,0]) cube(1);
			}
		}
		
		//chamfering
		if(chamfer[0]) r([0,90,0]) halfTriangle3D(90-chamferAngle,size.y/(chamfer[2]+1),size.x);
			
		if(chamfer[2]) tr([0,size.y,0],[0,90,0]) mirror([0,1,0]) halfTriangle3D(90-chamferAngle,size.y/(chamfer[0]+1),size.x);

		if(chamfer[1]) tr([0,size.y,0],[90,90,0]) halfTriangle3D(90-chamferAngle,size.x/(chamfer[3]+1),size.y);

		if(chamfer[3]) tr([size.x,size.y,0],[90,90,0]) mirror([0,1,0]) halfTriangle3D(90-chamferAngle,size.x/(chamfer[1]+1),size.y);
	}
	
	t([-size.x/2*center.x,-size.y/2*center.y,-size.z/2*center.z]) cubeR();
}


module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
