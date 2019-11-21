// new pin connectors

object=0;//[0:Pinpeg,1:Pinhole]
//Pinpeg is twice this length
length=13;
//Of hole; pinpeg is smaller to fit
diameter=7;
//Only affects pinhole
hole_twist=0;//[0:free,1:fixed]
//Pulls the snaps together on the pinpeg to ensure a tight coupling
preload=0.1;
//Allows pins to fit easily into holes
clearance=0.3;
//Thicker makes the pinpeg stiffer
thickness=1.8;
//Height of snap nubs
snap=0.4;
//Put fins on pinhole to help with printing strength
fins=1;//[1:yes,0:no]

$fn=20;

if(object==0)pinpeg(r=diameter/2,l=length,d=2.5-preload,nub=snap,t=thickness,space=clearance);
if(object==1)pinhole(r=diameter/2,l=length,nub=snap,fixed=hole_twist,fins=fins);

//pin(flat=0);
//%pinhole(fixed=true);

//pinpeg();
//translate([10,0,0])difference(){
//	cylinder(r=5.5,h=14);
//	pinhole(fixed=true);
//}
//translate([-10,0,0])difference(){
//	cylinder(r=5.5,h=14);
//	pinhole(fixed=false);
//}

module pin(r=3.5,l=13,d=2.4,slot=10,nub=0.4,t=1.8,space=0.3,flat=1)
translate(flat*[0,0,r/sqrt(2)-space])rotate((1-flat)*[90,0,0])
difference(){
	rotate([-90,0,0])intersection(){
		union(){
			translate([0,0,-0.01])cylinder(r=r-space,h=l-r-0.98);
			translate([0,0,l-r-1])cylinder(r1=r-space,r2=0,h=r-space/2+1);
			translate([nub+space,0,d])nub(r-space,nub+space);
			translate([-nub-space,0,d])nub(r-space,nub+space);
		}
		cube([3*r,r*sqrt(2)-2*space,2*l+3*r],center=true);
	}
	translate([0,d,0])cube([2*(r-t-space),slot,2*r],center=true);
	translate([0,d-slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
	translate([0,d+slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
}

module nub(r,nub)
union(){
	translate([0,0,-nub-0.5])cylinder(r1=r-nub,r2=r,h=nub);
	cylinder(r=r,h=1.02,center=true);
	translate([0,0,0.5])cylinder(r1=r,r2=r-nub,h=5);
}

module pinhole(r=3.5,l=13,d=2.5,nub=0.4,fixed=false,fins=true)
intersection(){
	union(){
		translate([0,0,-0.1])cylinder(r=r,h=l-r+0.1);
		translate([0,0,l-r-0.01])cylinder(r1=r,r2=0,h=r);
		translate([0,0,d])nub(r+nub,nub);
		if(fins)translate([0,0,l-r]){
			cube([2*r,0.01,2*r],center=true);
			cube([0.01,2*r,2*r],center=true);
		}
	}
	if(fixed)cube([3*r,r*sqrt(2),2*l+3*r],center=true);
}

module pinpeg(r=3.5,l=13,d=2.4,nub=0.4,t=1.8,space=0.3)
union(){
	pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
	mirror([0,1,0])pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
}