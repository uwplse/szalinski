//length of bracket
length = 70;		
//width of bracket	
width = 10;		
//thickness 
thickness = 2.5;	
//number of holes
holecount=3;	
//hole diameter
holediameter=2.5;
//Make outer holes (1=true 0=false)
outers=1;

module Bracket(l,w,t) {
$fn=35;
intersection(){
	difference() {
		union() {
			translate([-t,-t,0]) cube( size=[t,t+1,w]);
			translate([0,-t,0]) cube( size=[l,t,w]);
			rotate ([0,0,90]) cube( size=[l,t,w]);
			translate ([l-t,l-t,0]) hoop(l,w,t);
			}
		smallholes();
		if (outers) largeholes();
		}
	translate([-t,-t,-1]) cube ( size=[l+t,l+t,w+2]); //cylinder(h=w+2,r1=l,r2=l);
	
	}
}

module hoop(l,w,t) {
n=20;
difference(){
			cylinder(h=w,r1=l,r2=l) ;
			cylinder(h=w,r1=l-t,r2=l-t) ;
		}
}

module smallholes() {
	n=length/(holecount+1);
   for (i=[0:holecount-1]) {
		//x axis
		translate ([n-thickness+i*n,0,width/2]) rotate(a=[90,90,0]) cylinder(h=thickness+1,r1=holediameter/2,r2=holediameter/2);
		// y axis		
		translate ([-thickness,n-thickness+i*n,width/2]) rotate([90,0,90]) cylinder(h=thickness,r1=holediameter/2,r2=holediameter/2);		

	}

}
module largeholes() {
	lhm=1.4; //large hole factor
	n=length/(holecount+1);
   for (i=[0:holecount-1]) {
		//x axis
		translate ([n-thickness+i*n,length,width/2]) rotate(a=[90,90,0]) cylinder(h=length,r1=holediameter/lhm,r2=holediameter/lhm);
		// y axis		
		translate ([0,n-thickness+i*n,width/2]) rotate([90,0,90]) cylinder(h=length,r1=holediameter/lhm,r2=holediameter/lhm);		
	}

}


Bracket(length-thickness,width,thickness);
