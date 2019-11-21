$fn=64;

d1=7;
d2=10;
pitch=1.5;
h=5;

//////////////////////////////////

twist_convex(pitch,h/pitch-1){
	polygon([[d1/2,0],[d2/2,pitch/2],[d1/2,pitch]]);
}


t([d2*1.1,0,0])
	twist(pitch,h/pitch-1){
		polygon([[d1/2,0],[d2/2,pitch/4],[d2/2,pitch*2/4],[d1/2,pitch*3/4],[d1/2,pitch],[d1/3,pitch],[d1/3,0]]);
	}

//////////////////////////////////

module twist(pitch=10,rotations=1,direction=1,point=[10,3],inf=100,$fn=$fn){
	not=0.001;
	s=direction>0?1:-1;
	angle=180/$fn;
	l=point.x*sin(angle);
	step=pitch/$fn;
	a=asin(step/l);
	
	for(i=[0:$fn*rotations-1]){
		t([0,0,i*step]) r([0,0,direction*i*(360/$fn)]) difference(){
			r([0,0,angle],[point.x/2,0,0]) r([90+a,0,0]) mirror([0,0,1])
				linear_extrude(l/cos(a)) children();
			
			mirror([0,1,0]) cube([inf,inf,inf]);
			r(2*angle) cube([inf,inf,inf]);
		}
	}
}

module twist_convex(pitch=10,rotations=1,direction=1,$fn=$fn){
	not=0.001;
	s=direction>0?1:-1;
	for(i=[0:$fn*rotations-1]) hull(){
		t([0,0,i/$fn*pitch]) r([90,0,direction*i*(360/$fn)]) linear_extrude(not) children();
		t([0,0,(i+1)/$fn*pitch]) r([90,0,direction*(i+1)*(360/$fn)]) linear_extrude(not) children();
	}
}

//////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
