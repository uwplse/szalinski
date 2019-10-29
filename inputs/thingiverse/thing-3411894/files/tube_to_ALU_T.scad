$fn=50;
tube = 25;
tube1 = 25;
tube2 = 33;

h=5;
prof=20;
r=1;

wall = 3;
gap = 2;
length = 230;
height = prof;
width = tube;
overlap = 10;
overfill = 0.1; // leave a gap for connected parts to fit
padL = prof;

tol=0.15;

bolt1=3+2*tol;
nut1=6.15+2*tol;
nut1Thick=2;
bolt1HeadPad=2.25;
bolt1H=40;
nut1H=1.5*bolt1H;

bolt2=5+2*tol;
bolt2Head=10.5+2*tol;
bolt2HeadPad=2.25;
bolt2H=40;

nothing=0.02;
not = 0.01;


//thick
translate([height/2,0,-gap/2]) rotate([0,-90,0]) difference(){
	holder1();
	rotate([0,0,180]) translate([0,-tube1-width,-10]) cube([2*tube1,2*tube1+2*width,2*height]);
}

//thin
translate([-(tube2/2+wall),0,0]) difference(){
	holder1();
	translate([0,-tube1-width,0]) cube([2*tube1,2*tube1+2*width,2*height]);
}

//notches
translate([0,0,width/2+wall-gap/2]) rotate([180,0,0]){
	translate([0,0,-h]) difference(){
		notches(h=h);
		innerCube(h=h);
	}
}

//pads
difference(){
	translate([-height/2,prof/2,width/2+wall-gap/2-r]) cubeRounded([height,wall,padL],r=[r,r,r]);

	translate([0,prof/2+wall-bolt2HeadPad,width/2+wall-gap/2+padL-2*r-bolt2Head/2]) rotate([-90,0,0]) nut(d1=bolt2,d2=bolt2Head,h1=bolt2H,h2=bolt2H);
}


difference(){
	translate([-height/2,-prof/2-wall,width/2+wall-gap/2-r]) cubeRounded([height,wall,padL],r=[r,r,r]);

	translate([0,-prof/2-wall+bolt2HeadPad,width/2+wall-gap/2+padL-2*r-bolt2Head/2]) rotate([90,0,0]) nut(d1=bolt2,d2=bolt2Head,h1=bolt2H,h2=bolt2H);
	
}

module holder1(){
	difference(){
		union(){
			cylinder(r=tube1/2+wall,h=height);
			translate([-2*wall-gap,-(tube1/2+overlap+wall),0]) cube([tube1/2+gap+3*wall,2*(tube1/2+overlap+wall),height]);
		}
		
		//cut for short bolts
		translate([2*wall,tube1/2+wall,-not]) cube([width+not,overlap+not,height+2*not]);
		translate([2*wall,-tube1/2-wall-overlap-not,-not]) cube([width+not,overlap+not,height+2*not]);
		
		//gaps
		translate([0,0,-nothing]) cylinder(r=tube1/2+tol,h=height+2*nothing);
		translate([0,0,height/2]) cube([gap,2*(tube1/2+2*overlap)+0.001,height+0.001],center=true);	
		
		//holes
		translate([2*wall+gap/2-nut1Thick,tube1/2+overlap*3/4,3/4*height]) rotate([0,90,0]) longBolt();
		
		translate([2*wall+gap/2-nut1Thick,tube1/2+overlap*3/4,1/4*height]) rotate([0,90,0]) longBolt();
		
		translate([2*wall+gap/2-nut1Thick,-tube1/2-overlap*3/4,3/4*height]) rotate([0,90,0]) longBolt();
		
		translate([2*wall+gap/2-nut1Thick,-tube1/2-overlap*3/4,1/4*height]) rotate([0,90,0]) longBolt();
	}
}


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