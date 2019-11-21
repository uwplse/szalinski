$fn=64;
tol=0.15;

tube = 65+2*tol;
prof=20;
r=1;

wall = 3;
wall2 = 2*.45;

gap = 2;

width = tube;
offset = wall;

bolt=5+2*tol;
boltHead=10.5+2*tol;
boltHeadPad=2.25;
boltH=40;

pad = 2*boltHead;
length = tube+2*pad;

not = 0.001;



difference() {
	union(){
		translate([-length/2,0,0]) cubeRounded([length,wall2,prof],r=[wall2/2,wall2/2,wall2/2]);
		translate([-length/2,0,0]) cubeRounded([(length-tube)/2,wall,prof],r=[r,r,r]);
		translate([tube/2,0,0]) cubeRounded([(length-tube)/2,wall,prof],r=[r,r,r]);

		translate([0,tube/2+wall-offset]) difference(){
			cylinderRounded([tube,tube+2*wall],prof,[r,r,r,r]);
			translate([-length/2,-length,0]) cube([length,length,prof]);
		}
		translate([-tube/2-wall,wall/2,0]) cubeRounded([wall,tube/2+wall/2-offset,prof],r=[r,0,r]);
		translate([+tube/2,wall/2,0]) cubeRounded([wall,tube/2+wall/2-offset,prof],r=[r,0,r]);
	}
	translate([tube/2+pad/2,boltHeadPad,prof/2]) rotate([-90,0,0]) nut(d1=bolt, d2=boltHead, h1=boltH, h2=boltH);
	translate([-(tube/2+pad/2),boltHeadPad,prof/2]) rotate([-90,0,0]) nut(d1=bolt, d2=boltHead, h1=boltH, h2=boltH);
}

//translate([0,tube/2+wall-offset]) cylinder(d=65,h=prof);

module outerCube(h=10){
	translate([0,0,h/2]) cube([prof,prof,h], true);
}

module innerCube(h=10){
	translate([0,0,h/2]) cube([7.2,7.2,h], true);
}

module notches(h=10){
	translate([0,0,h/2]) cube([5,prof,h], true);
	translate([0,0,h/2]) cube([prof,5,h], true);
}

module spheres(r=3){
	x=prof/2-r;
	hull(){
		translate([x,x,0]) sphere(r=r);
		translate([x,-x,0]) sphere(r=r);
		translate([-x,x,0]) sphere(r=r);
		translate([-x,-x,0]) sphere(r=r);
	}
}

module cubeRounded(size=[3,3,3],r=[1,1,1]){
	hull(){
		translate([r.x,r.y,r.z]) scale(r) sphere(1);
		translate([size.x-r.x,r.y,r.z]) scale(r) sphere(1);
		translate([r.x,size.y-r.y,r.z]) scale(r) sphere(1);
		translate([size.x-r.x,size.y-r.y,r.z]) scale(r) sphere(1);

		translate([r.x,r.y,size.z-r.z]) scale(r) sphere(1);
		translate([size.x-r.x,r.y,size.z-r.z]) scale(r) sphere(1);
		translate([r.x,size.y-r.y,size.z-r.z]) scale(r) sphere(1);
		translate([size.x-r.x,size.y-r.y,size.z-r.z]) scale(r) sphere(1);
	}
}

module nut6(d1=3, d2=6.15, h1=10, h2=30){
	rotate([180,0,0]) cylinder(d=d1,h=h1);
	cylinder(d=d2,h=h2,$fn=6);
}

module nut(d1=3, d2=6.15, h1=10, h2=30){
	rotate([180,0,0]) cylinder(d=d1,h=h1);
	cylinder(d=d2,h=h2);
}

module longBolt(){
	nut6(d1=bolt1,d2=nut1,h1=bolt1H,h2=nut1H);
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
