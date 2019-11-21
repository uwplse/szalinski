$fn=16;
wall = 3;
cube=[200,100,50];
handle=[20,50,30];
handleH=15;
r=10;
f=1;

not=0.001;
////////////////////////////////////////////////////////
box(cube,wall,r);
tr([not,cube.y/2,handleH],180) handle(handle,wall,f);

////////////////////////////////////////////////////////
module handle(size=[7,20,10],wall=2,f=1){
	t([0,-size.y/2,0]) intersection(){
		cube(size);
		
		u(){
			for(y=[0,size.y-wall]){
				t([0,y,0]) hull(){
					for(w=[f,wall-f]){
						t([0,w,f]) sphere(r=f);
						t([size.x-f,w,size.x]) sphere(r=f);
						t([size.x-f,w,size.z-f]) sphere(r=f);
						t([0,w,size.z-f]) sphere(r=f);
					}
				}
			}

			hull(){
				for(w=[f,size.y-f]){
					t([size.x-f,w,size.x]) sphere(r=f);
					t([size.x-wall+f,w,size.x]) sphere(r=f);
					
					t([size.x-f,w,size.z-f]) sphere(r=f);
					t([size.x-wall+f,w,size.z-f]) sphere(r=f);
				}
			}
		}
	}
}

module box(size=[50,30,20],wall=2,r=10){
	module top(size=[9,9,1],r=1){
		r1=size[2]/2;
		r2=r;
		
		t([size[0]-r2,size[1]-r2,0]) quartTorus(r1,r2-r1);
		tr([r2,size[1]-r2,0],[0,0,90]) quartTorus(r1,r2-r1);
		tr([size[0]-r2,r2,0],[0,0,-90]) quartTorus(r1,r2-r1);
		tr([r2,r2,0],[0,0,180]) quartTorus(r1,r2-r1);
		
		tr([r2-not,r1,0],[0,90,0]) cylinder(h=size[0]-2*r2+2*not,r=r1);
		tr([r2-not,size[1]-r1,0],[0,90,0]) cylinder(h=size[0]-2*r2+2*not,r=r1);
		tr([r1,r2-not,0],[-90,90,0]) cylinder(h=size[1]-2*r2+2*not,r=r1);
		tr([size[0]-r1,r2-not,0],[-90,90,0]) cylinder(h=size[1]-2*r2+2*not,r=r1);
	}

	module quartTorus(r1=3, r2=5){
		intersection(){
			rotate_extrude(convexity = 10) t([r2, 0, 0]) circle(r=r1);
			t([0,0,-2*r1]) cube([r1+r2,r1+r2,4*r1]);
		}
	}

	module roundedCube(size = [9,9,9], r = 3){
		if(r<=0)
			cube(size);
		else {
			hull(){
				t([r,r,r]) sphere(r=r);
				t([size[0]-r,r,r]) sphere(r=r);
				t([r,size[1]-r,r]) sphere(r=r);
				t([size[0]-r,size[1]-r,r]) sphere(r=r);

				t([r,r,size[2]-r]) cylinder(h=r,r=r);
				t([size[0]-r,r,size[2]-r]) cylinder(h=r,r=r);
				t([r,size[1]-r,size[2]-r]) cylinder(h=r,r=r);
				t([size[0]-r,size[1]-r,size[2]-r]) cylinder(h=r,r=r);
			}
		}
	}

	rInner = r-wall;
	difference(){
		roundedCube([size.x,size.y,size.z-wall/2],r);
		t([wall,wall,wall]) roundedCube([size.x-2*wall,size.y-2*wall,size.z+2*wall], rInner);
	}
	t([0,0,size.z-wall/2-not]) top([size.x,size.y,wall],r);
}


////////////////////////////////////////////////////////


module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
