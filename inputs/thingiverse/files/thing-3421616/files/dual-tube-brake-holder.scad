$fn=128;

d1 = 11.5;
d2 = 14;
h=35;

wall = 3;
frontWall = 5;
d3 = d2+2*wall;
bolt = 6;
nut = 9.8;
nutThick = 3;
r1 = 1;
r2 = wall-r1;

brake = [6,10,15];
//gap around brake
gap = 0.2;

tol = 0.2; //my printer makes 0.3 smaller holes
not = 0.01;
inf = 100;

printHolder = 1;
printBrake = 0;

if (printHolder) holder();
if (printBrake) translate([-5,0,h-brake.z-wall+0.1]) brake();

module holder(){
	difference(){
		union(){
			//cylinder
			cylinderRounded(d=[d2+2*tol,d3],h=h,r=[r1,r2,0,r2]);
			translate([0,0,h/2-wall]) cylinderRounded(d=[d1+2*tol,d2+2*wall],h=h/2+wall,r=[0,0,r1,r2]);
			
			//block
			difference(){
				translate([0,-d3/2,h-brake.z-2*wall-2*gap]) cubeRounded([d2/2+brake.x+frontWall,d3,brake.z+2*wall+2*gap],r=[r2,r2,r2],r0=[0,r2,r2], r2=[0,r2,r2], r4=[0,r2,r2], r6=[0,r2,r2]);

				cylinder(d=d2+2*tol,h=h+not,r=[0,0,r1,r2]);
			}
		}
		
		//space
		translate([-not,-brake.y/2,h-brake.z-wall]) cube([brake.x+d2/2,brake.y,brake.z+not+2*gap]);
		translate([-not,-brake.y/2,h-brake.z]) cube([d2/2, brake.y,brake.z+not]);
		
		//bolt
		translate([0,0,h-wall-gap-brake.z/2]) rotate([0,90,0])  cylinder(d=bolt,h=inf);
	}
}

module brake(){
	difference(){
		translate([0,-brake.y/2+gap,0]) cube([brake.x+d1/2,brake.y-2*gap,brake.z]);
		translate([brake.x+d1/2-nutThick,-brake.y/2-not,(brake.z-nut)/2]) cube([nutThick+not,brake.y+2*not,nut]);
		translate([0,0,-not]) cylinder(d=d1,h=h);
	}
}

module cubeRounded(	
	size=[3,3,3],
	r=[0,0,0],
	r0=[-1,-1,-1],
	r1=[-1,-1,-1],
	r2=[-1,-1,-1],
	r3=[-1,-1,-1],
	r4=[-1,-1,-1],
	r5=[-1,-1,-1],
	r6=[-1,-1,-1],
	r7=[-1,-1,-1],
){
	
	function sat3(a) = [max(0,a.x),max(0,a.y),max(0,a.z)];
	function chg(a, b) = (a.x==-1 && a.y==-1 && a.z==-1) ? b : a;

	_r0 = sat3(chg(r0, r));
	_r1 = sat3(chg(r1, r));
	_r2 = sat3(chg(r2, r));
	_r3 = sat3(chg(r3, r));
	_r4 = sat3(chg(r4, r));
	_r5 = sat3(chg(r5, r));
	_r6 = sat3(chg(r6, r));
	_r7 = sat3(chg(r7, r));
		
	hull(){
		translate(_r0) scale(_r0) sphere(1);
		translate([size.x-_r1.x,_r1.y,_r1.z]) scale(_r1) sphere(1);
		translate([_r2.x,size.y-_r2.y,_r2.z]) scale(_r2) sphere(1);
		translate([size.x-_r3.x,size.y-_r3.y,_r3.z]) scale(_r3) sphere(1);

		translate([_r4.x,_r4.y,size.z-_r4.z]) scale(_r4) sphere(1);
		translate([size.x-_r5.x,_r5.y,size.z-_r5.z]) scale(_r5) sphere(1);
		translate([_r6.x,size.y-_r6.y,size.z-_r6.z]) scale(_r6) sphere(1);
		translate([size.x-_r7.x,size.y-_r7.y,size.z-_r7.z]) scale(_r7) sphere(1);
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

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	intersection(){
		translate([r1, 0, 0]) circle(r = r2);
		translate([r1, 0, 0]) square([2*r2,2*r2]);
	}
}
