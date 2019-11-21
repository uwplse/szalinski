$fn=128;

innerD=210-66;

disc = [[innerD,200,3,1],[innerD,195,10,1],[innerD,210-42,13,-1]]; ///discs - inner, outer diam., thickness
disc2=[[70,210-42,2,13]];

boltSpan = 91.5;
bolts = 5;
boltsR = boltSpan/2/sin(360/2/bolts);
bolt=5;
boltHead=9;
boltPad=-7;

r=1.5;
layer=0.25;

/////////////////////////////////////

disc1();
t([200,0,0]) disc2();

/////////////////////////////////////

module disc1(){
	difference(){
		for(di=disc){
			ro=min(r,di[2]/2);
			cylinderRounded(d=[di[0],di[1]],h=di[2],r=[ro,ro,di[3]*ro,ro]);
		}
		bolts();
	}
}

module disc2(){
	difference(){
		for(di=disc2){
			ro=min(r,di[2]/2);
			t([0,0,di[3]]) cylinderRounded(d=[di[0],di[1]],h=di[2],r=[ro,ro,ro,ro]);
		}
		bolts();
	}
}

module bolts(){
	for(i=[0:360/bolts:360]){
		rt(i,[boltsR,0,0]) r([180,0,0]) bolt(bolt,boltHead,boltPad=boltPad,nut=0,layer=layer);
	}
}
/////////////////////////////////////

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