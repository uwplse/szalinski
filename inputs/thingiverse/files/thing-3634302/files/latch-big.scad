$fn=32;

width=20;
gap=0.25;
wall=2;
axis=[3,5];
///location of axes: x coord of 1st and 3rd axes, y coord. od 2nd axis
pos=[-7,3,20];
///shift of top to gain a preassure when closed
preassure=1;

widthIn=width-2*wall-2*gap;
negative=20;

layer=0.25;
not=0.01;
inf=100;
r1=1;

///////////////////////////////////

angles=[45,-45];

axes(angles);
r(angles[0],[0,pos[1]+axis[0]/2,0]) r(angles[1],[pos[2],axis[1]/2,0]) cover();
t([-preassure,0,0]) catch();
//r(angles[0],[pos[2],axis[1]/2,0]) r(angles[1],[0,pos[1]+axis[0]/2,0]) bottom();
bottom();
//r(angles[0],[pos[2],axis[1]/2,0]) connect();
r(angles[0],[0,pos[1]+axis[0]/2,0]) connect();

///////////////////////////////////
module catch(){
	module block(){
			cubeRounded([axis[0]/2+wall,axis[0]+gap+wall+negative,widthIn],r=[r1,r1,r1]);
	}

	difference(){
		u(){
			t([pos[0],-negative,wall+gap]) block();
			t([pos[0]-gap,axis[0]/2,wall+gap]){
				difference(){
					intersection(){
						cylinder(d=axis[0]+2*gap+2*wall,h=widthIn);
						t([gap,-negative-axis[0]/2,0]) block();
					}
					mirror([1,0,0]) t([-gap,-5*axis[0],0]) cube([10*axis[0],10*axis[0]+2*gap+2*wall,width+2*not]);
				}
			}
		}
		
		hull(){
			t([pos[0],axis[0]/2,0]) cylinder(d=axis[0]+2*gap,h=width);
			t([pos[0]-gap-inf,axis[0]/2,0]) cylinder(d=axis[0]+2*gap,h=width);
		}
		
	}
}

module connect(){
	//h=widthIn/4-gap/2;
	t([0,0,wall+gap]) difference(){
		hull(){
			t([0,pos[1]+axis[0]/2,0]) cylinderRounded(d=[0,axis[1]+gap],h=widthIn,r=[0,r1,0,r1]);
			t([pos[2],axis[1]/2,0]) cylinderRounded(d=[0,axis[1]+gap],h=widthIn,r=[0,r1,0,r1]);
		}
		
		t([0,pos[1]+axis[0]/2,widthIn/4-gap/2]) cylinder(d=2*axis[1],h=widthIn/2+gap);		
		t([pos[2],axis[1]/2,-not]) cylinder(d=axis[0]+2*gap,h=width);
		t([0,pos[1]+axis[0]/2,-not]) cylinder(d=axis[0]+2*gap,h=width);
	}
}

module bottom(){
	t([0,0,wall+gap]){
		difference(){
			u(){
				t([-axis[1]/2,-negative,0]) cubeRounded([axis[1],negative,widthIn],r=[r1,r1,r1]);
				hull(){
					t([0,-2*r1,widthIn/4+gap/2]) cylinderRounded(d=[0,axis[1]],h=widthIn/2-gap,r=[0,r1,0,r1]);
					t([0,pos[1]+axis[0]/2,widthIn/4+gap/2]) cylinderRounded(d=[0,axis[1]],h=widthIn/2-gap,r=[0,r1,0,r1]);
				}
			}

//			hull(){
//				t([0,pos[1]+axis[0]/2,-not]) cylinder(d=axis[1]+gap,h=widthIn/4+gap/2);
//				t([-axis[1]/2,0,-not]) cube([axis[1],axis[1],widthIn/4+gap/2]);
//			}
//			
//			hull(){
//				t([0,pos[1]+axis[0]/2,widthIn*3/4-gap/2]) cylinder(d=axis[1]+gap,h=width);
//				t([-axis[1]/2,0,widthIn*3/4-gap/2]) cube([axis[1],axis[1],width]);
//			}
		}
	}
}

module axes(angles=[0,0]){
	r(angles[0],[0,pos[1]+axis[0]/2,0]) r(angles[1],[pos[2],axis[1]/2,0]) {
		t([pos[0]-axis[0]/2-wall/2,0,wall]) cube([axis[0]/2+wall/2,axis[0],width-2*wall]);
		t([pos[0],axis[0]/2,wall]) cylinder(d=axis[0],h=width-2*wall);
	}
	
	t([0,pos[1]+axis[0]/2,wall+gap]) cylinder(d=axis[0],h=widthIn);
	r(angles[0],[0,pos[1]+axis[0]/2,0]) t([pos[2],axis[1]/2,wall]) cylinder(d=axis[0],h=width-2*wall);
}

module cover(){
	t([pos[0]-axis[0]/2-wall,0,0]) difference(){
		cubeRounded([pos[2]-pos[0]+(axis[0]+axis[1])/2+gap+2*wall,pos[1]+axis[1]+wall+gap,width],r=[r1,r1,r1]);
		t([-not+wall,-not,wall]) cube([pos[2]-pos[0]+(axis[0]+axis[1])/2+gap,pos[1]+axis[1]+gap,width-2*wall]);
	}
}

///////////////////////////////////

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

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rv=[0,0,0]){translate(rv) rotate(a) translate(-rv) children();}
module tr(v=[0,0,0],a=[0,0,0]){t(v) r(a) children();}
module rt(a=[0,0,0],v=[0,0,0]){r(a) t(v) children();}
module u(){union() children();}
