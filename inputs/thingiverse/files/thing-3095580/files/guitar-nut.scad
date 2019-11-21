$fn=64;

h=8.5;
w=[6,5];
l=44;
decline=20;
groove=0;

pos=[18.5,11.1,3.7,-3.7,-11.1,-18.5];
cut=[0.3,0.45,0.7,0.9,1.2,1.5];

f=1;

///////////////////////////////////////////////////////

difference(){
	hull(){
		for(x=[-w[0]+f,-f]) for(y=[-l/2+f,l/2-f])	t([x,y,f]) sphere(f);
		for(x=[-w[1]+f,-f]) for(y=[-l/2+f,l/2-f])	t([x,y,h-f]) sphere(f);
	}
	
	for(i=[0:5]) tr([0,pos[i],h-groove],[0,-decline,0]) t([-h,0,0]) cube([2*h,cut[i],h]);
}

///////////////////////////////////////////////////////

///////////////////////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
