$fn=32;

d=825/3.1415926535;
bolt=5+.2;
boltHead=9+.2;

nutPad=7;
nutW=16;
boltPad=5;
flat=[2+.5,12+1];
flap=[33/2,6,8,8,9+2];
handle=[53,77,25];
step=1;
fil=5;

difference(){
	t([d/2,0,0]) difference(){
		
		t([-handle.x,-handle.y/2,0]) cubeRounded([2*handle.x,handle.y,handle.z],r=[fil,fil,fil]);
		
		///bolt cut
		t([0,-nutW/2,handle.z/2-flat.y/2]) cube([nutPad,nutW,flat[1]]);
		
		///bolt
		tr([nutPad,0,handle.z/2],[0,90,0]) bolt(bolt,boltHead,boltHeadL=handle.x,nut=0,boltPad=boltPad,layer1=0,layer2=0);
		
		///big hole
		t([handle.x-3*fil,0,0]) for(x=[-20:step:0]) for(y=[-handle.y*.3:step:handle.y*.3]) t([x,y,0]) cylinderRounded(d=[0,5],h=handle.z,r=[0,-fil,0,-fil]);
		
		///flat cut
		t([-handle.x+flat.x,-handle.y*.4,handle.z/2-flat.y/2]) cube([handle.x,handle.y*.8,flat.y]);
		
		///flap cut
		for(s=[-1,1]) tr([0,s*flap[0],0],s*36.9) flap();
		
	}
	cylinder(d=d,h=100,$fn=256);
}



///////////////////////////////////////////

module flap(){
	w=10;
	t([0,-w/2,handle.z/2-flap[3]/2]) cube([flap[4],w,flap[3]]);
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

module bolt(bolt=3, boltHead=6, boltPad=3, boltHeadL=10, boltL=30, nut=6.3, nutPad=5, nutL=4, nutR=0, sideCutL=20, sideCutSlot=4, layer1=0.2, layer2=0.2, tol=0.2, not=0.01){
	
	bottom=layer1>0?true:false;
	top=layer2>0?true:false;
	
	t([0,0,-boltL+not+boltPad]) cylinder(d=bolt+tol,h=boltL);

	t([0,0,boltPad-2*layer1]) difference(){
		cylinder(d=boltHead+tol,h=boltHeadL+2*layer1);
		
		//easy print bolt
		if(layer1>0){
			t([(bolt+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer1+not]);
			t([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer1+not]);
			t([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer1+not]);
			t([-(boltHead+tol)/2,(bolt+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer1+not]);
		}
	}
	
	//nut
	if(nut>0 && nutL>0){
		rotate([0,0,nutR]) difference(){
			t([0,0,-nutPad-nutL-sideCutSlot-2*layer1]){
				cylinder(d=nut+tol,h=nutL+sideCutSlot+2*layer1+2*layer2,$fn=6);
				hull(){
					for(x=[0,sideCutL]) t([x,0,0]) cylinder(d=nut+tol,h=nutL+2*layer1,$fn=6);
				}
			}
		
		//easy print nut slot
		if(layer1>0){
				t([(bolt+tol)/2,-nut/2,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([sideCutL+nut+tol,nut,2*layer1+not]);
				t([-(bolt+tol)/2-nut,-nut/2,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([nut,nut,2*layer1+not]);
				t([-nut/2,-(bolt+tol)/2-nut,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([nut,nut,layer1+not]);
				t([-nut/2,+(bolt+tol)/2,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([nut,nut,layer1+not]);
			}				
		
		//easy print nut
		if(layer2>0){
				t([(bolt+tol)/2,-nut/2,-nutPad]) cube([nut,nut,2*layer2+not]);
				t([-(bolt+tol)/2-nut,-nut/2,-nutPad]) cube([nut,nut,2*layer2+not]);
				t([-nut/2,-(bolt+tol)/2-nut,-nutPad+layer2]) cube([nut,nut,layer2+not]);
				t([-nut/2,+(bolt+tol)/2,-nutPad+layer2]) cube([nut,nut,layer2+not]);
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
