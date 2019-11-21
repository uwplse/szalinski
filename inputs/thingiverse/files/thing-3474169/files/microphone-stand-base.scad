$fn = 32;
//number of simulation of leg positions, the more, the more precise cut
rotations = 10;

baseD = 130;
baseThick = 20;
baseH = 80;

tube = 35+.3; ///leg
tubeHoleDist = 7+2;
tubeHole2Corner = sqrt(pow(tubeHoleDist,2)+pow(tube/2,2));
tubeAngle = 30; //stop angle of the tube
tubeUp = 10;

tubeMain = 41.1+.3;

bolt = 6;
boltHead = 12.2;
boltPad = 2;
boltLength = 46.75+4;

nut = 11;
nutThick = 5.82+.5;
nutPad = boltPad;


r = 2;
wall = 3;
gap = 0.2;
gapZ = 1; // bigger gap due to bridges
gapBig = 2;
tol = 0.3;
layer=0.25;
not = 0.001;
inf = 200;

d2 = tubeMain;
h=baseH;

d3 = d2+2*wall;
r1 = 1;
r2 = wall-r1;

brakeBolt = 6;
brakeNut = 11;
brakeNutThick = 5;
brakeDepth = 100;
frontWall = wall;
elongateDown = 10; ///for nicer brake hull look
brake = [wall,tubeMain-2*wall,15];
rubberPad=3; ///will be glued to the brake

notches = 0;

//////////////////////////////////////////
difference()
{
	body();
	holderNegative();
	
	for(a=[0,120,240]) rotate(a) leg();
	//tubes();
	
	if(notches) notches();
}

support();
//t([0,0,h-brake.z-wall+gap]) brake(tubeMain+rubberPad);

//////////////////////////////////////////

module tubes(){
///tubes
	#cylinder(d=tubeMain,h=inf);
	#translate([0,-(tubeHole2Corner+tubeMain/2+gapBig),tubeUp]) rotate([90+tubeAngle,0,0]) translate([0,0,-tubeHoleDist]) cylinder(h=inf,d=tube);
	#rotate([0,0,120]) translate([0,-(tubeHole2Corner+tubeMain/2+gapBig),tubeUp]) rotate([90+tubeAngle,0,0]) translate([0,0,-tubeHoleDist]) cylinder(h=inf,d=tube);
	#rotate([0,0,240]) translate([0,-(tubeHole2Corner+tubeMain/2+gapBig),tubeUp]) rotate([90+tubeAngle,0,0]) translate([0,0,-tubeHoleDist]) cylinder(h=inf,d=tube);
}

module body(){
	cylinderRounded(d=[tubeMain+tol+gap,baseD],h=baseThick,r=[r,r,0,r]);

	translate([0,0,baseThick-2*r]) pyramidRounded(d=[tubeMain+tol+gap,baseD,tubeMain+tol+gap,tubeMain+tol+gap+2*wall],h=baseH-(baseThick-2*r),r=[r,r,0.1,r]);

	holderPositive();
}

module staticLeg(i=0){
}

module notches(){
	rotate([0,0,60]) translate([0,-baseD/2,0]) cylinder(h=inf,d=tube+2*tol+2*gap);
	rotate([0,0,180]) translate([0,-baseD/2,0]) cylinder(h=inf,d=tube+2*tol+2*gap);
	rotate([0,0,300]) translate([0,-baseD/2,0]) cylinder(h=inf,d=tube+2*tol+2*gap);
}

module leg(){
	rot = 90/(rotations-1);
	
	translate([0,-(tubeHole2Corner+tubeMain/2+gapBig),tubeUp]){
		
		//bolt
		translate([tube/2+boltPad,0,0]) rotate([0,90,0]) bolt(bolt,boltHead,boltLength);
		
		//nut
		hull(){
			translate([-(nutThick+2*tol+tube/2+nutPad),0,0]) rotate([0,90,0]) nut();
			translate([-(nutThick+2*tol+tube/2+nutPad),0,-inf]) rotate([0,90,0]) nut();
		}
		
		//legs
		hull(){
			for(i = [90:rot:180-tubeAngle]){
				rotate([i+tubeAngle,0,0])	intersection(){
					translate([0,0,-tubeHoleDist]) cylinder(h=inf,d=tube);
					translate([-inf/2,0,0]) cube([inf,inf,inf]);
				}
			}
		}
		
		hull(){
			for(i = [90:rot:180-tubeAngle]){
				rotate([i+tubeAngle,0,0])	intersection(){
					translate([0,0,-tubeHoleDist]) cylinder(h=inf,d=tube);
					translate([-inf/2,-inf,0]) cube([inf,inf,inf]);
				}
			}
		}
		
		hull(){
			for(i = [90:rot:180-tubeAngle]){
				rotate([i+tubeAngle,0,0])	intersection(){
					translate([0,0,-tubeHoleDist]) cylinder(h=inf,d=tube);
					translate([-inf/2,0,-inf]) cube([inf,inf,inf]);
				}
			}
		}
		
		hull(){
			for(i = [90:rot:180-tubeAngle]){
				rotate([i+tubeAngle,0,0])	intersection(){
					translate([0,0,-tubeHoleDist]) cylinder(h=inf,d=tube);
					translate([-inf/2,-inf,-inf]) cube([inf,inf,inf]);
				}
			}
		}		
	}
}


module holderPositive(){
	t([0,-d3/2,h-(brake.z+2*wall+gap+gapZ)-elongateDown]) cubeRounded([d2/2+rubberPad+brake.x+brakeNutThick+frontWall,d3,brake.z+2*wall+gap+gapZ+elongateDown],r=[r2,r2,r2],r0=[0,r2,r2], r2=[0,r2,r2], r4=[0,r2,r2], r6=[0,r2,r2]);
}

module support(){
	a = sqrt(sqr(tubeMain/2)-sqr((brake.y+2*gap)/2));
	#t([a,-d3/2,h-wall+layer]) cubeRounded([d2/2+rubberPad+brake.x+brakeNutThick+frontWall-a,d3,layer],r=[r2,r2,0]);
}

module holderNegative(){
	cylinder(d=d2+2*tol,h=h+not,r=[0,0,r1,r2]);
	
	//space
	t([-not,-brake.y/2,h-brake.z-wall-gapZ]) cube([brake.x+d2/2+rubberPad+gap,brake.y+2*gap,brake.z+not+gap+gapZ]);
	//translate([-not,-brake.y/2,h-brake.z]) cube([d2/2, brake.y,brake.z+not]);
	
	//bolt
	t([0,0,h-wall-gap-brake.z/2]) rotate([0,90,0])  cylinder(d=brakeBolt,h=inf);
	//nut
	t([0,0,h-wall-gap-brake.z/2]) rotate([0,90,0]) cylinder(d=brakeNut,h=d2/2+rubberPad+brake.x+brakeNutThick,$fn=6);
}

module holder(){
	difference(){
		//block
		translate([0,-d3/2,h-(brake.z+2*wall+2*gap)]) cubeRounded([d2/2+brake.x+frontWall,d3,brake.z+2*wall+2*gap],r=[r2,r2,r2],r0=[0,r2,r2], r2=[0,r2,r2], r4=[0,r2,r2], r6=[0,r2,r2]);

		cylinder(d=d2+2*tol,h=h+not,r=[0,0,r1,r2]);
		
		//space
		translate([-not,-brake.y/2,h-brake.z-wall]) cube([brake.x+d2/2,brake.y,brake.z+not+2*gap]);
		translate([-not,-brake.y/2,h-brake.z]) cube([d2/2, brake.y,brake.z+not]);
		
		//bolt
		translate([0,0,h-wall-gap-brake.z/2]) rotate([0,90,0])  cylinder(d=brakeBolt,h=inf);
	}
}

module brake(d=10){
	//rotate([0,0,-90]) translate([0,0,baseH])
	difference(){
		translate([0,-brake.y/2+gap,0]) cube([brake.x+d/2,brake.y,brake.z]);
		//translate([brake.x+d/2-nutThick,-brake.y/2-not,(brake.z-nut)/2]) cube([nutThick+not,brake.y+2*not,brakeNut]);
		translate([0,0,-not]) cylinder(d=d,h=h);
	}
}

////////////////////////////////////////////////////////

module pyramidRounded(d=[20,40],h=30,r=[1,-10,4,1]){
	rotate_extrude(convexity = 10)
	{
		_d = [d[0],d[1],d[2],d[3]];
		
		//square
		difference()
		{
			//translate([_d[0]/2,0,0]) square([(_d[1]-_d[0])/2,h]);
			hull()
			{
				intersection(){
					translate([_d[0]/2+r[0], r[0], 0]) circle(r = r[0]);
					//translate([_d[0]/2,0,0]) square([r[0],r[0]]);
				}
				intersection(){
					translate([_d[1]/2-r[1], r[1], 0]) circle(r = r[1]);
					//translate([_d[1]/2-r[1],0,0]) square([r[1],r[1]]);
				}
				intersection(){
					translate([_d[2]/2+r[2], h-r[2], 0]) circle(r = r[2]);
					//translate([_d[2]/2,h-r[2],0]) square([r[2],r[2]]);
				}
				intersection(){
					translate([_d[3]/2-r[3], h-r[3], 0]) circle(r = r[3]);
					//translate([_d[3]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
				}
			}
			
			
//			if(r[0]>0) translate([_d[0]/2,0,0]) square([r[0],r[0]]);
//			if(r[1]>0) translate([_d[1]/2-r[1],0,0]) square([r[1],r[1]]);
//			if(r[2]>0) translate([_d[2]/2,h-r[2],0]) square([r[2],r[2]]);
//			if(r[3]>0) translate([_d[3]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
		}
		
		//corners
		
		if(r[0]>0){
			intersection(){
				translate([_d[0]/2+r[0], r[0], 0]) circle(r = r[0]);
				translate([_d[0]/2,0,0]) square([r[0],r[0]]);
			}
		} else {
			difference(){
				translate([_d[0]/2+r[0], 0, 0]) square([-r[0],-r[0]]);
				translate([_d[0]/2+r[0], -r[0], 0]) circle(r = -r[0]);
			}
		}
		
		if(r[1]>0){
			intersection(){
				translate([_d[1]/2-r[1], r[1], 0]) circle(r = r[1]);
				translate([_d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			}
		} else {
			difference(){
				translate([_d[1]/2, 0, 0]) square([-r[1],-r[1]]);
				translate([_d[1]/2-r[1], -r[1], 0]) circle(r = -r[1]);
			}
		}
		
		if(r[2]>0){
			intersection(){
				translate([_d[2]/2+r[2], h-r[2], 0]) circle(r = r[2]);
				translate([_d[2]/2,h-r[2],0]) square([r[2],r[2]]);
			}
		} else {
			difference(){
				translate([_d[2]/2+r[2], h+r[2], 0]) square([-r[2],-r[2]]);
				translate([_d[2]/2+r[2], h+r[2], 0]) circle(r = -r[2]);
			}
		}

		if(r[3]>0){
			intersection(){
				translate([_d[3]/2-r[3], h-r[3], 0]) circle(r = r[3]);
				translate([_d[3]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
			}
		} else {
			difference(){
				translate([_d[3]/2, h+r[3], 0]) square([-r[3],-r[3]]);
				translate([_d[3]/2-r[3], h+r[3], 0]) circle(r = -r[3]);
			}
		}		
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

module bolt(bolt=1,head=2,length=10){
	translate([0,0,-length]) cylinder(d=bolt+2*tol,h=length);
	cylinder(d=head+2*tol,h=inf);
}

module nut(bolt=1,head=2,length=10){
	cylinder(d=nut+2*tol,h=nutThick+2*tol,$fn=6);
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

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	intersection(){
		translate([r1, 0, 0]) circle(r = r2);
		translate([r1, 0, 0]) square([2*r2,2*r2]);
	}
}


module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}

function sqr(a) = ((a)*(a));