$fn=16;

bolt=5.83+1.2;
boltPad=2;
boltHead=12.18+1;
nut=11.11+.5;
nutPad=boltPad;

handleD=40;
handleL=200;
r=10;

profile=25+.3;
profileWall=2;
profileCut=0.85*handleD;

topCut=2;

wall=2;

tol=0.2;

difference(){
	rotate([90,0,0]) translate([0,handleD/2,-handleL/2]) cylinderRounded(d=[0,handleD],h=handleL,r=[0,r,0,r]);
	
	#translate([0,0,handleD/2]) rotate([90,0,0]) bolt(bolt=bolt,boltL=handleL,boltHeadL=handleL,boltHead=boltHead,boltPad=profile/2+boltPad,nut=nut,nutPad=profile/2+nutPad,nutL=handleL,sideCutL=0, sideCutSlot=4,layer=0,tol=tol);

	translate([-profile/2,-profile/2,0]) cube([profile,profile,profileCut]);
	
	translate([-handleL/2,-handleL/2,handleD-topCut]) cube([handleL,handleL,2*topCut]);
}


///////////////////////////////////////////////

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

module bolt(bolt=3, boltHead=6, boltPad=3, boltHeadL=50, boltL=50, nut=6.3, nutPad=5, nutL=4, nutR=0, sideCutL=50, sideCutSlot=4, layer=0.2,tol=0.2,not=0.01){
	
	translate([0,0,-boltL+not+boltPad]) cylinder(d=bolt+tol,h=boltL);

	translate([0,0,boltPad-2*layer]) difference(){
		cylinder(d=boltHead+tol,h=boltHeadL);
		
		//easy print
		if(layer>0){
			translate([(bolt+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer+not]);
			translate([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer+not]);
			translate([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer+not]);
			translate([-(boltHead+tol)/2,(bolt+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer+not]);
		}
	}
	
	//nut
	if(nut>0 && nutL>0){
		rotate([0,0,nutR]){
			translate([0,0,-nutPad-nutL-sideCutSlot]){
				cylinder(d=nut+tol,h=nutL+sideCutSlot,$fn=6);
				hull(){
					 cylinder(d=nut+tol,h=nutL,$fn=6);
					translate([sideCutL,0,0]) cylinder(d=nut+tol,h=nutL,$fn=6);
				}
			}
		}
	}
}
