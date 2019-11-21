$fn=64;

//Frame thickness, 6mm default, change this if you have something else and feel adventurous.
frameThickness=6;

//Frame upper part height, 40mm default, change this if you have something else and feel adventurous.
frameHeight=40;

//Mount's thickness, I dont know how sturdy it will be below 6mm. Reduce if extruder can't fit past them at max printing heights.
mountThickness=4;//[2,3,4,5,6]
mountThickness2=1.5;//[2,3,4,5,6]

//Holder's "hook's" length.
hookLength=6;// [1,2,3,4,5,6,7,8,9,10]

holes=2;
hole=16;
smallHole=3;
smallHoleShift=70;
holeWall=5;

//Thickness of the holder. 10mm seems to work well.
holderThickness=holeWall/2+holes*(hole+1.5*holeWall);

arm = [mountThickness,150,holderThickness];
armAngle=15;
r=2;

///////////////////////

mirror([0,1,0]) clip();
arm();

/////////////////////

module arm(){
	holesW=holes*(hole+holeWall);
	rotate([0,0,armAngle]){
		difference(){
			union(){
				cubeRounded(arm,r=[r,r,r]);
				//t([0,arm.y-2*r,0]) cubeRounded([arm.x,hole+2*holeWall,holesW],r=[r,r,r]);
				//t([0,arm.y*3/4,0]) cubeRounded([arm.x,hole+2*holeWall,holesW],r=[r,r,r]);
			}
			t([0,arm.y,0]) hole_negative();
			t([0,arm.y-smallHoleShift,0]) smallHole_negative();
			//t([0,arm.y*3/4+holeWall+hole/2,0]) holes();
		}			
		t([0,arm.y,0]) hole();
	}
}


module smallHole_negative(){
	for(i=[0:holes-1]){
		for(z=[-(hole+1.5*holeWall)/4,(hole+1.5*holeWall)/4]){
			t([arm.x/2,0,holeWall+hole/2+i*(hole+1.5*holeWall)+z]) rt([0,90,0],[0,0,-arm.x/2]) cylinderRounded(d=[0,smallHole],h=2*arm.x,r=[0,0,0,0]);
		}
	}
}

module hole_negative(){
	for(i=[0:holes-1]){
		t([arm.x/2,0,holeWall+hole/2+i*(hole+1.5*holeWall)]) rt([0,90,0],[0,0,-arm.x/2]) cylinderRounded(d=[0,hole+2*holeWall],h=arm.x,r=[0,0,0,0]);
	}
}

module hole(){
	for(i=[0:holes-1]){
		t([arm.x,0,hole/2+holeWall+i*(hole+1.5*holeWall)]) rt([0,90,0],[0,0,-arm.x/2])
		rotate_extrude(convexity = 10) t([hole/2+holeWall,0,0]) difference(){
			circle(r=holeWall);
			t([0,-holeWall,0]) square([3*holeWall,3*holeWall]);
		}
	}
}

module rounding(r,angle){
	rotate([0,0,angle]){
			difference(){
							translate([-r,-r,-1])cube([r+1,r+1,holderThickness+2]);
							translate([-r,-r,-1])cylinder(holderThickness+2,r,r);
			}
	}
}

module clip(){ 
	difference(){
		
		linear_extrude(height=holderThickness, convexity=10) polygon(points=[
			[0,0],
			[frameThickness,0],
			[frameThickness,hookLength],
			[frameThickness+mountThickness,hookLength],
			[frameThickness+mountThickness,-mountThickness],
			[-mountThickness,-mountThickness],
			
			[-mountThickness,frameHeight+mountThickness2],
			[frameThickness+1,frameHeight+mountThickness2],
			
			[frameThickness+1,frameHeight-0.5],
			[frameThickness,frameHeight-0.5],
			[frameThickness,frameHeight],
			[0,frameHeight],
			[-mountThickness+mountThickness2,frameHeight],
			[-mountThickness+mountThickness2,frameHeight-1],
			[0,frameHeight-1]
		]);
        
		t([-mountThickness,-mountThickness,0]) rounding(mountThickness,180);
		t([frameThickness+mountThickness,-mountThickness,0]) rounding(mountThickness,-90);
		t([frameThickness+mountThickness,hookLength,0]) rounding(mountThickness/2,0);
		t([frameThickness,hookLength,0]) rounding(mountThickness/2,90);
		
		t([mountThickness/12,mountThickness/12,-1]) cylinder(holderThickness+2,r=mountThickness/6);
		t([frameThickness-mountThickness/12,mountThickness/12,-1]) cylinder(holderThickness+2,r=mountThickness/6);
		
	}
	t([frameThickness+0.5,frameHeight-0.5]) cylinder(holderThickness,d=1);
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