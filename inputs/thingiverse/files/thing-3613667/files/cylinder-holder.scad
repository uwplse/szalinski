$fn=64;

base=[5,0,2];
cylinderD=15;
latchL=10;
padL=2;
padWall = 2;
wall = 1;
latches = 32;
latchGap = 2;
r = 1;

not=0.001+0.001;

////////////////////////////////
cylinderHolder(base,cylinderD,latchL,padL,padWall,wall,latches,latchGap,r);

//#cylinderHolderNegative();

///////////////////////////////
module cylinderHolder(
	base=[5,0,2],
	cylinderD=15,
	latchL=10,
	padL=2,
	padWall = 2,
	wall = 1,
	latches = 32,
	latchGap = 2,
	r = 1
){
	cylinderRounded(d=[cylinderD,cylinderD+base.x],h=base.z,r=[r,0,0,0]);

	difference(){
		u(){
			t([0,0,base.z]) cylinderRounded(d=[cylinderD,cylinderD+wall],h=latchL-padL,r=[0,0,-(padWall-wall)/4,0]);
			t([0,0,base.z+latchL-padL]) cylinderRounded(d=[cylinderD+wall-padWall,cylinderD+wall],h=padL,r=[(padWall-wall)/4,0,padWall/4,padWall/4]);
		}
		
		for(i=[0:360/latches:360]){
			rt([0,0,i],[0,-(cylinderD+base.x),base.z]) triangle3D(latchGap,cylinderD+base.x,latchL);
		}
	}
}
module cylinderHolderNegative(
	base=[5,0,2],
	cylinderD=15,
	latchL=10,
	padWall = 2,
	r = 1
){
	cylinderRounded(d=[0,cylinderD],h=base.z+latchL,r=[0,-r,0,0]);
	t([0,0,base.z]) cylinderRounded(d=[0,cylinderD+padWall],h=latchL,r=[0,0,0,r]);
}

///////////////////////////////

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

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0]){rotate(a) children();}
module tr(v=[0,0,0],a=[0,0,0]){t(v) r(a) children();}
module rt(a=[0,0,0],v=[0,0,0]){r(a) t(v) children();}
module u(){union() children();}