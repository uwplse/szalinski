$fn=32;
wall=2;
r=2;
groove=13;

not=0.001;

smallBox(wall,r);
t([125,0,0]) quadBox(wall,r);
t([125,170,0]) longBox(wall,r);
t([0,90,0]) wideBox(wall,r);

//halfGroove();
//translate([0,1,0]) groove(2);
//chamferX([117.6,81.5,91.5],1);

module wideBox(wall=1,r=1){
	size=[117.6,2*81.5,91.5];
	r2=max(0,r-wall);
	
	difference(){
		union(){
			difference(){
				cubeRounded(size,r=[r,r,r]);
				t([wall,wall,wall]) cubeRounded([size.x-2*wall,size.y-2*wall,size.z],r=[r2,r2,r2]);
			}
			
			// insert floor groove
			t([0,0,wall45(wall)]) chamferFloorY(size,r);
			t([size.x,0,wall45(wall)]) mirror([1,0,0]) chamferFloorY(size,r);

			t([0,0,wall45(wall)])	chamferFloorX(size,r);
			t([0,size.y,wall45(wall)]) mirror([0,1,0]) chamferFloorX(size,r);
		}
		
		/// chamfers
		t([0,0,0]) chamferY(size);
		t([size.x,0,0]) mirror([1,0,0]) chamferY(size);

		t([0,0,0])	chamferX(size);
		t([0,size.y,0]) mirror([0,1,0]) chamferX(size);
	}
}

module longBox(wall=1,r=1){
	size=[2*117.6,81.5,91.5];
	r2=max(0,r-wall);
	
	difference(){
		union(){
			difference(){
				cubeRounded(size,r=[r,r,r]);
				t([wall,wall,wall]) cubeRounded([size.x-2*wall,size.y-2*wall,size.z],r=[r2,r2,r2]);
			}
			
			// insert floor groove
			t([0,0,wall45(wall)]) chamferFloorY(size,r);
			t([size.x,0,wall45(wall)]) mirror([1,0,0]) chamferFloorY(size,r);

			t([0,0,wall45(wall)])	chamferFloorX(size,r);
			t([0,size.y,wall45(wall)]) mirror([0,1,0]) chamferFloorX(size,r);

			t([size.x/2,0,0]) groove(size.y,wall);
		}
		
		/// chamfers
		t([0,0,0]) chamferY(size);
		t([size.x,0,0]) mirror([1,0,0]) chamferY(size);

		t([0,0,0])	chamferX(size);
		t([0,size.y,0]) mirror([0,1,0]) chamferX(size);
		
		t([size.x/2,0,-not]) groove(size.y);
	}
}

module quadBox(wall=1,r=1){
	size=[2*117.6,2*81.5,91.5];
	r2=max(0,r-wall);
	
	difference(){
		union(){
			difference(){
				cubeRounded(size,r=[r,r,r]);
				t([wall,wall,wall]) cubeRounded([size.x-2*wall,size.y-2*wall,size.z],r=[r2,r2,r2]);
			}
			
			// insert floor groove
			t([0,0,wall45(wall)]) chamferFloorY(size,r);
			t([size.x,0,wall45(wall)]) mirror([1,0,0]) chamferFloorY(size,r);

			t([0,0,wall45(wall)])	chamferFloorX(size,r);
			t([0,size.y,wall45(wall)]) mirror([0,1,0]) chamferFloorX(size,r);

			t([size.x/2,0,0]) groove(size.y,wall);
		}
		
		/// chamfers
		t([0,0,0]) chamferY(size);
		t([size.x,0,0]) mirror([1,0,0]) chamferY(size);

		t([0,0,0])	chamferX(size);
		t([0,size.y,0]) mirror([0,1,0]) chamferX(size);
		
		t([size.x/2,0,-not]) groove(size.y);
	}
}

module smallBox(wall=1,r=1){
	size=[117.6,81.5,91.5]; ///small box
	r2=max(0,r-wall);
	
	difference(){
		union(){
			difference(){
				base(size,r);
				translate([wall,wall,wall]) cubeRounded([size.x-2*wall,size.y-2*wall,size.z],r=[r2,r2,r2]);
			}
			
			// insert floor groove
			translate([0,0,wall45(wall)]) chamferFloorY(size,r);
			translate([size.x,0,wall45(wall)]) mirror([1,0,0]) chamferFloorY(size,r);

			translate([0,0,wall45(wall)])	chamferFloorX(size,r);
			translate([0,size.y,wall45(wall)]) mirror([0,1,0]) chamferFloorX(size,r);
		}
		
		/// chamfer
		translate([0,0,0]) chamferY(size);
		translate([size.x,0,0]) mirror([1,0,0]) chamferY(size);

		translate([0,0,0])	chamferX(size);
		translate([0,size.y,0]) mirror([0,1,0]) chamferX(size);
	}
}

function wall45(wall) = wall/sqrt(2);

module base(size,r){
	cubeRounded(size,r=[r,r,r]);
}

module chamferY(size){
	translate([0,size.y,0]) rotate([90,0,0]) triangle3D(90,groove,size.y);
}

module chamferX(size){
	rotate([0,0,-90]) translate([0,size.x,0]) rotate([90,0,0]) triangle3D(90,groove,size.x);
}

module chamferFloorX(size,r){
	intersection(){
		base(size,r);
		rotate([0,0,-90]) translate([0,size.x,0]) rotate([90,0,0]) triangle3D(90,groove,size.x);
	}
}

module chamferFloorY(size,r){
	intersection(){
		base(size,r);
		translate([0,size.y,0]) rotate([90,0,0]) triangle3D(90,groove,size.y);
	}
}

module groove(length=1, wall=0){
	add=wall/2*sqrt(3);
	groove=[13+2*add,0,5+add];
	translate([-groove.x/2,length,0]) hull(){
		 rotate([90,0,0]) triangle3D(90,groove.z,length);
		translate([groove.x,0,0]) rotate([90,0,0]) triangle3D(90,groove.z,length);
	}
}

module triangle3D(angle=10,h=10,z=10){
	linear_extrude(z) triangle(angle,h);
}

module triangle(angle=10,h=10){	
	r=angle/2;
	base=h*tan(r);
	sidex=2.1*base*cos(r);
	sidey=h/cos(r)+base;
	
	intersection(){
		translate([-base,0,0]) rotate([0,0,-r]) square([sidex,sidey]);
		translate([base,0,0]) rotate([0,0,r]) translate([-sidex,0,0]) square([sidex,sidey]);
		translate([-1.1*base,0,0]) square([2.2*base,1.1*h]);
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