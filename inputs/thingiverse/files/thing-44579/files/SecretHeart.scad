// All-at-once Secret Heart Box

assembly();
//animation();

//First word
word1="";
//Second word
word2="";
//Height of words
fontsize=6;
Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
//Length of parallel midsection
L=40;
//Width of flat face
W=35;
//Height of box
H=25;
//Space between hinges
x_hinge=23;
//Wall Thickness
T=0.8;
//Depth of sliding nubs
nub=2;//[1:3]
//Tolerance between moving parts
tol=0.4;
//Smoother renders slower
quality=1;//[1:Draft,2:Medium,4:Fine]

use <utils/build_plate.scad>
use <write/Write.scad> 

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

$fa=12/quality;
$fs=2/quality;
phi=atan(W/L);// heart angle
R=H/2-2*nub-3*T;// clasp radius
R1=H/2-2*nub;// cleave radius
t1=1-2*abs($t-0.5);// makes time loop back and forth

module animation()
assign(phi= t1<0.5 ? 0 : (t1-0.5)*2*90,psi= t1<0.5 ? (t1-0.5)*2*180 : 0){
	LowerLeft();
	translate([0,R1*sqrt(2)+H/2+nub,-H/2+nub])rotate([-phi,0,0])
		translate(-[0,R1*sqrt(2)+H/2+nub,-H/2+nub])UpperLeft();
	rotate([psi,0,0]){
		translate([0,R1*sqrt(2)+H/2+nub,-H/2+nub])rotate([-phi,0,0])
			translate(-[0,R1*sqrt(2)+H/2+nub,-H/2+nub])UpperRight();
		LowerRight();
	}
}

module assembly()
translate([0,0,H/2]){
	LowerLeft();
	UpperLeft();
	LowerRight();
	UpperRight();
}

module UpperLeft()
render()
union(){
	difference(){
		cleave(lower=false)Left();
		translate([-3/2*tol-nub-T,0,0])hingeGap();
		translate([-x_hinge,0,0])mirror([1,0,0])hingeGap();
	}
	translate([-L/2*sin(phi),L/2*cos(phi),H/2+0.49])write(word1,t=1,h=fontsize,center=true,font=Font);
}

module LowerLeft()
render()
union(){
	cleave(lower=true)Left();
	difference(){
		clasp(inside=1);
		translate([0,0,-R+T])rotate([0,-45,0])translate([0,0,-H])cube(2*H,center=true);
	}
	translate([-3/2*tol-nub-T,0,0])hinge();
	translate([-x_hinge,0,0])mirror([1,0,0])hinge();
	brace();
}

module UpperRight()
render()
union(){
	difference(){
		cleave(lower=false)Right();
		translate([3/2*tol+nub+T,0,0])mirror([1,0,0])hingeGap();
		translate([x_hinge,0,0])hingeGap();
		clasp(inside=0);
	}
	translate([L/2*sin(phi),L/2*cos(phi),H/2+0.49])write(word2,t=1,h=fontsize,center=true,font=Font);
}

module LowerRight()
render()
difference(){
	union(){
		cleave(lower=true)Right();
		translate([nub+T,0,T+0.5-H/2])translate([6,5,0])monogram(h=1.01);
		translate([3/2*tol+nub+T,0,0])mirror([1,0,0])hinge();
		translate([x_hinge,0,0])hinge();
		mirror([1,0,0])brace();
	}
	translate([nub+T+tol/2,0,0])rotate([0,90,0])cylinder(r=R+nub+T,h=tol);
	clasp(inside=0);
}

module brace()
intersection(){
	rotate([45,0,0])translate([0,R1,0])difference(){
		cylinder(r=nub+2*T+tol*3/2,h=3*H,center=true);
		translate([L-nub-T,0,0])cube(2*L,center=true);
		translate([L-nub-T-tol*3/2,L,0])cube(2*L,center=true);
	}
	difference(){
		translate([0,0,0])cube([L,2*(R1*sqrt(2)+H/2+nub),H-T],center=true);
		difference(){
			translate([0,0,L+H/2-2*T])cube(2*L,center=true);
			rotate([-45,0,0])cube([2*L,2*L,2*R1],center=true);
		}
	}
}

module cleave(lower=true)
assign(y = lower==true ? L+R1 : -L+R1+tol)
difference(){
	child(0);
	rotate([45,0,0])translate([0,y,0])cube(2*L,center=true);
}

module Right()
difference(){
	union(){
		mirror([1,0,0])hollowbase();
		rotate([-45,0,0])translate([tol/2+.01,0,H/2-nub])point();
	}
	rotate([45,0,0])rotate([0,90,0])track();
}

module Left()
difference(){
	union(){
		hollowbase();
		rotate([-45,0,0])translate([-tol/2-.01,0,H/2-nub])rotate([0,180,0])point();
	}
	rotate([45,0,0])rotate([0,-90,0])track();
}

module clasp(inside=0)
rotate([0,90,0])translate([0,0,-tol/2-.01])
	cylinder(r1=R-tol-tol*inside,r2=R+nub+T-tol*inside,h=nub+T+tol+.02);

module point()
rotate([0,-90,0])cylinder(r1=nub,r2=0,h=nub);

module track()
union(){
	difference(){
		union(){
			rotate_extrude()translate([H/2-nub,-tol/2])rotate(45)square(nub*sqrt(2),center=true);
			translate(-[0,nub-H/2,0])cylinder(r1=nub,r2=0,h=nub);
		}
		translate([H+tol/2,0,0])cube(2*H,center=true);
	}
	translate([0,nub-H/2,0])cylinder(r1=nub,r2=0,h=nub);
}

module hollowbase()
difference(){
	base(inside=0);
	difference(){
		base(inside=1);
		translate([-nub-T,0,0])hinge();
		translate([-L-x_hinge,R1*sqrt(2)+H/2,-H/2])cube([L,2*nub,nub]);
		translate([-L-x_hinge,R1*sqrt(2)+H/2+nub,-H/2+nub])
			rotate([0,90,0])cylinder(r=nub,h=L);
	}
}

module hinge()
translate([-nub/2,R1*sqrt(2)+H/2,-H/2+nub])
difference(){
	union(){
		translate([0,-2*nub,0])cube([nub,6*nub,2*nub],center=true);
		translate([0,nub,0])rotate([0,90,0])cylinder(r=nub,h=nub,center=true);
		translate([nub/2-.01,nub,0])rotate([0,90,0])cylinder(r1=nub,r2=0,h=nub);
	}
	translate([0,-6*nub,2*nub])rotate([45,0,0])cube(6*nub,center=true);
}

module hingeGap()
translate([-nub/2,R1*sqrt(2)+H/2,-H/2+nub])
union(){
	translate([0,tol-nub,0])cube([nub+2*tol,6*nub,2*nub+2*tol],center=true);
	translate([nub/2+tol-.01,nub,0])rotate([0,90,0])cylinder(r1=nub,r2=0,h=nub);
}

module base(inside=0)
assign(W=W-2*T*inside)
intersection(){
	rotate([0,0,90+phi])union(){
		cube([L,W,2*H],center=true);
		translate([L/2,0,0])cylinder(r=W/2,h=2*H,center=true);
		translate([0,W/2-H/2,0])rotate([0,90,0])cylinder(r=H/sqrt(2),h=L,center=true);
		for(i=[-1,1])translate([i*L/2,0,0])
			rotate_extrude(convexity=2)difference(){
				translate([W/2-H/2,0])circle(r=H/sqrt(2));
				translate([-H,0])square(2*H,center=true);
			}
	}
	translate([-L-(nub+T)*inside-tol/2,0,0])cube([2*L,2*L,H-2*T*inside],center=true);
}

module monogram(h=1)
linear_extrude(height=h,center=true)
translate(-[3,2.5])union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}