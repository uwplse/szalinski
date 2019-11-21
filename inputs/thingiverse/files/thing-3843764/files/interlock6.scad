$fn=32;

thread=0.5;
th=thread/2;
gap=0.01;
l=0.5;
z=1;

////////////////////////////////////////////////////////

difference(){
	cube([10,10,z]);
	starSquare([10,10]);
}

////////////////////////////////////////////////////////
module starSquare(n=[10,10]){
	a=l+2*th+th/sin(30);
	b=a*cos(30);
	c=a*sin(30);
	for(x=[0:2:n.x-1]) t([x*b,0,0]) starLine(n.y);
	for(x=[1:2:n.x-1]) t([x*b,c,0]) starLine(n.y);
}

module starLine(n=5){
	for(y=[0:n-1]) t([0,y*(l+2*th+th/sin(30)),0]) star();
}

module star(){
	for(a=[0,120,240]) rt(a,v=[0,th/2/sin(30),0]) wedge();
}

module wedge(){
	for(a=[-60,60]) rt(a,v=[-gap/2,0,0]) cube([gap,l,z]);
}

////////////////////////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
