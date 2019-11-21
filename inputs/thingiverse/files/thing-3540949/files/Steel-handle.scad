$fn=16;

layer=0.25;

bolt=9.8;
boltHead=19.3;
boltHeadL=16.4; //6.7+9.7;

handleD=40;
handleL=120;
r=10;

topCut=2;

//coverIntersect=5;
coverL=22;
wall=2;

tol=0.2;

difference(){
	rotate([90,0,0]) translate([0,handleD/2,-handleL/2]) cylinderRounded(d=[0,handleD],h=handleL,r=[0,r,0,r]);
	
	translate([0,0,handleD-topCut-boltHeadL]) boltHex(bolt=bolt,boltHead=boltHead,boltPad=0,layer=layer,tol=tol);
	
	translate([-handleL/2,-handleL/2,handleD-topCut]) cube([handleL,handleL,2*topCut]);
}

//thread cover
translate([0,0,-coverL]) cylinderRounded(d=[bolt+tol,bolt+2*wall],h=coverL+handleD/2,r=[0,wall,0,0]);


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

module boltHex(bolt=3, boltHead=6, boltPad=3, boltHeadL=100, boltL=100,layer=0.2,tol=0.2,not=0.01){
	translate([0,0,-boltL+not+boltPad]) cylinder(d=bolt+tol,h=boltL);

	translate([0,0,boltPad-2*layer]) difference(){
		rotate([0,0,30]) cylinder(d=boltHead+tol,h=boltHeadL,$fn=6);
		
		//easy print
		translate([(bolt+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer+not]);
		translate([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer+not]);
		translate([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer+not]);
		translate([-(boltHead+tol)/2,(bolt+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer+not]);
	}
}
