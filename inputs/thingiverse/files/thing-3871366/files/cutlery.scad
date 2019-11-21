$fn=32;
wall = 2;
h=50;
r=10;

////////////////////////////////////////////////////////

t([0,0,0]) box([150,50,h],wall,r);
t([0,50-wall,0]) box([150,50,h],wall,r);
t([0,100-2*wall,0]) box([150,50,h],wall,r);
t([0,150-3*wall,0]) box([150,50,h],wall,r);

t([150-wall,0,0]) box([50,200-3*wall,h],wall,r);

////////////////////////////////////////////////////////

module box(size=[50,30,20],wall=2,r=10){
	module top(size=[9,9,1],r=1){
		r1=size[2]/2;
		r2=r;
		
		t([size[0]-r2,size[1]-r2,0]) quartTorus(r1,r2-r1);
		tr([r2,size[1]-r2,0],[0,0,90]) quartTorus(r1,r2-r1);
		tr([size[0]-r2,r2,0],[0,0,-90]) quartTorus(r1,r2-r1);
		tr([r2,r2,0],[0,0,180]) quartTorus(r1,r2-r1);
		
		tr([r2,r1,0],[0,90,0]) cylinder(h=size[0]-2*r2,r=r1);
		tr([r2,size[1]-r1,0],[0,90,0]) cylinder(h=size[0]-2*r2,r=r1);
		tr([r1,r2,0],[-90,90,0]) cylinder(h=size[1]-2*r2,r=r1);
		tr([size[0]-r1,r2,0],[-90,90,0]) cylinder(h=size[1]-2*r2,r=r1);
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

	module halfRoundedCube(size = [9,9,9], r = 3){
		if(r<=0)
			cube(size);
		else {
			hull(){
				t([r,r,0]) cylinder(r=r,h=r);
				t([size[0]-r,r,0]) cylinder(r=r,h=r);
				t([r,size[1]-r,0]) cylinder(r=r,h=r);
				t([size[0]-r,size[1]-r,0]) cylinder(r=r,h=r);

				t([r,r,size[2]-r]) cylinder(h=r,r=r);
				t([size[0]-r,r,size[2]-r]) cylinder(h=r,r=r);
				t([r,size[1]-r,size[2]-r]) cylinder(h=r,r=r);
				t([size[0]-r,size[1]-r,size[2]-r]) cylinder(h=r,r=r);
			}
		}
	}

	rInner = r-wall;
	difference(){
		halfRoundedCube([size.x,size.y,size.z-wall/2],r);
		t([wall,wall,wall]) roundedCube([size.x-2*wall,size.y-2*wall,size.z+2*wall], rInner);
	}
	t([0,0,size.z-wall/2]) top([size.x,size.y,wall],r);
}


////////////////////////////////////////////////////////


module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
