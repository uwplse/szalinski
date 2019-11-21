$fn=128;

wall=1;
width=5;
thick=10;
height=50;
angle=45;

a=90-angle;
r=(width/2-sin(a)*wall/2)/(1-sin(a));

xCut=sin(a)*(r-wall/2);
//z2=(r-wall/2)*sin(a);
z3=sqrt(sqr(r)-sqr(xCut)); ///inner
z4=sqrt(sqr(r-wall)-sqr(xCut)); ///outter
z5=sqrt(sqr(r-wall/2)-sqr(xCut)); ///middle

not=0.01;

/////////////////////////////////////////////////

intersection(){
	for(z=[-2*z5:2*(2*z5):height]){
		t([0,0,z]) turn();
		t([0,0,z+2*z5]) mirror([1,0,0]) turn();
	}
	
	t([-2*r,0,0]) cube([4*r,thick,height]);
	
}

/////////////////////////////////////////////////

module turn(){	
	difference(){
		tr([xCut,0,z5],[-90,0,0]) difference(){
			cylinder(r=r,h=thick);
			t([0,0,-not]) cylinder(r=r-wall,h=thick+2*not);
		}
		
		rt([0,a,0],[0,0,0],[0,-not,-2*r]) cube([2*r,thick+2*not,4*r]);
		rt([0,-a,0],[0,0,2*z5],[0,-not,-2*r]) cube([2*r,thick+2*not,4*r]);
	}
}

function sqr(a) = ((a)*(a));
module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
