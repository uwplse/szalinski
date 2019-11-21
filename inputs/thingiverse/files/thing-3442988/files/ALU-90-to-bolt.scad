$fn=64;

// profile width
prof = 40;
l2 = 40;

bolt1 = 8;
bolt1Head = 17.5;
bolt1Pad = 3.75;

bolt2 = 10;
bolt2Head = 33.5;
bolt2Pad = 3;

offset = [36, 36 - prof/2];
wall = 3;

l1 = offset.x + 3/4*bolt2Head;

// rounding
r=3;

tol = 0.2;
not = 0.01;
inf = 100;



difference(){
	body();
	holes();
}

module holes(){
	translate([bolt1Pad,0,l2-prof/2]) rotate([0,90,0]) bolt(bolt1,bolt1Head);
	translate([offset.x,offset.y,bolt1Pad]) bolt(bolt2,bolt2Head);
}

module bolt(bolt=1,head=2){
	translate([0,0,-inf+not]) cylinder(d=bolt+2*tol,h=inf);
	cylinder(d=head+2*tol,h=inf);
}

module body(){
	hull(){
		cornersCenter();
		cornersSide();
		cornersTop();
	}
}

module cornersCenter(){
	translate([r,prof/2-r,r]) sphere(r=r);
	translate([r,-prof/2+r,r]) sphere(r=r);
}

module cornersSide(){
	translate([offset.x,offset.y,0]) cylinderRounded([0,bolt2Head+wall],2*r,[0,r,0,r]);
}

module cornersTop(){
	translate([r,prof/2-r,l2-r]) sphere(r=r);
	translate([r,-prof/2+r,l2-r]) sphere(r=r);
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
