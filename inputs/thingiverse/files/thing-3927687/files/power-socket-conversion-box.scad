$fn = 64;

cd=37;
ch=51+1;
cw=53+1;
h=50+50+73;

wall = 1;
shift=[2.5,0,0];
d=60+wall;


threadH=10;
pitch = 5;
threadTurns = threadH/pitch-0.75;
threadTol=0.5;
threadD=d+pitch/2;

f=2;

capRounding=[3,3];
capNotches=2;

not=0.01;

//////////////////////////////////////////////////


t([1.2*d,0,0]) cap();
body();

//////////////////////////////////////////////////
module sockets(h=10){
	t(shift) hull(){
		t([ch/2-cd/2,0,0]) cylinderRounded(d=[0,cd],h=h,r=[0,f,0,f]);
		t([-ch/2+cd/2,cw/2-cd/2,0]) cylinderRounded(d=[0,cd],h=h,r=[0,f,0,f]);
		t([-ch/2+cd/2,-cw/2+cd/2,0]) cylinderRounded(d=[0,cd],h=h,r=[0,f,0,f]);
	}
}

module body(){
	difference(){
		u(){
			t(shift) t([0,0,-wall]) hull(){
				t([ch/2-cd/2,0,0]) cylinderRounded(d=[0,cd+2*wall],h=h+wall,r=[0,f,0,f]);
				t([-ch/2+cd/2,cw/2-cd/2,0]) cylinderRounded(d=[0,cd+2*wall],h=h+wall,r=[0,f,0,f]);
				t([-ch/2+cd/2,-cw/2+cd/2,0]) cylinderRounded(d=[0,cd+2*wall],h=h+wall,r=[0,f,0,f]);
			}
			
			t([0,0,h-threadH]) hull(){
				t([0,0,threadH]) cylinder(d=d,h=threadH);
				sockets(threadH);
			}
			
		}
		sockets(2*h);
	}
	
	t([0,0,h]) twist_convex(pitch,threadTurns){
		polygon([[d/2-wall,0],[d/2,0],[threadD/2,pitch/4],[threadD/2,pitch*2/4],[d/2,pitch*3/4],[d/2-wall,pitch*3/4]]);
	}
}


module cap() {
	difference(){
		t([0,0,-wall]) knob(d=threadD+2*threadTol+4*wall+2*capNotches,h=threadH+wall,depth=capNotches,r=[f,f]);
		
		cylinder(d=threadD+2*threadTol,h=threadH+wall);
	}
	
	t([0,0,0]) twist_convex(pitch,threadTurns){
		polygon([[threadD/2+threadTol,0],[d/2+threadTol,pitch/4],[d/2+threadTol,pitch*2/4],[threadD/2+threadTol,pitch*3/4]]);
	}
}

module body_thread(h = 1) {
	translate ([0,0,0]) trapezoidThreadNegativeSpace(length=h, pitch=threadPitch, pitchRadius = bodyWidth/2-threadPitch/4-wall, stepsPerTurn=threadPrecision);
}


//////////////////////////////////////////////////

module twist_convex(pitch=10,rotations=1,direction=1,$fn=$fn){
	not=0.001;
	s=direction>0?1:-1;
	for(i=[0:$fn*rotations-1]) hull(){
		t([0,0,i/$fn*pitch]) r([90,0,direction*i*(360/$fn)]) linear_extrude(not) children();
		t([0,0,(i+1)/$fn*pitch]) r([90,0,direction*(i+1)*(360/$fn)]) linear_extrude(not) children();
	}
}

module knob(d=10,h=10,depth=1,r=[1,1]) {
	notchesDepth = depth;
	//bottom rounding of knob
	rounding1 = r[0];
	//top rounding of knob
	rounding2 = r[1];
	//outer diameter of the nut
	noth = 0.01; // hack for preview only

	module notches(r1=1, r2=2, h=1){
		r3 = (r2-r1)*1.5 + r1; //actual outer radius
		r4 = r3-r1; //notch radius
		if(r4>0.001) {
			pi = 3.1415926535897932384626433832795;
			number = floor(pi*r3/r4*.8);
			angle = 360/number;
			for(i = [0 : angle : 360]) {           
					rotate([0,0,i]) translate ([r3,0,0]) cylinder (r=r4,h=h,center=false);
			}
		}
	}

	module cylinderRounded(d=10,h=10,r1=4,r2=1){
		r_1 = (r1<=0)?0.0001:r1;
		r_2 = (r2<=0)?0.0001:r2;
		
		hull(){
			translate([0,0,r_1]) mirror([0,0,1]) torusQuart(r1=d/2-r_1,r2=r_1);
			translate([0,0,h-r_2]) torusQuart(r1=d/2-r_2,r2=r_2);
		}
	}

	module torusQuart(r1=10,r2=1){
		rotate_extrude(convexity = 10)
		intersection(){
			translate([r1, 0, 0]) circle(r = r2);
			translate([r1, 0, 0]) square([2*r2,2*r2]);
		}
	}

	intersection(){
		difference (){
			cylinder(r=d/2,h=h);		
			translate([0,0,-noth]) notches(r1=d/2-notchesDepth, r2=d/2, h=h+2*noth);
		}    
		cylinderRounded(h=h,d=d,r1=rounding1,r2=rounding2);
	}
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