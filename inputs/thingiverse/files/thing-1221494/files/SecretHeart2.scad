// All-at-once Secret Heart Box

assembly();
//animation();

//First Initial
first="";
//Last Initial
last="";
//Wall Thickness
wallT=1.6;
//Tolerance between moving parts
tol=0.3;

use <write/Write.scad> 

//Height of words
fontsize=14+0;
//Length of parallel midsection
L=30+0;
//Width of flat face
W=25+0;
//Height of box
H=20+0;
//Space between hinges
x_hinge=16+0;
//Depth of sliding nubs
nub=2+0;
//Smoother renders slower
quality=4+0;//[1:Draft,2:Medium,4:Fine]
//Angle of opening (deg)
cleaveAngle=40+0;
//Number of zigzags
n=1+0;

T=wallT/2;
$fa=12/quality;
$fs=2/quality;
phi=atan(W/L);// heart angle
R=H/2-2*nub;// clasp radius
R1=H/2-2*nub;// cleave radius
t1=1-2*abs($t-0.5);// makes time loop back and forth

module animation(){
phi= t1<0.5 ? 0 : (t1-0.5)*2*90;
psi= t1<0.5 ? (t1-0.5)*2*180 : 0;
	LowerLeft();
	translate([0,R1/cos(cleaveAngle)+H/2+nub/2,-H/2+nub])rotate([-phi,0,0])
		translate(-[0,R1/cos(cleaveAngle)+H/2+nub/2,-H/2+nub])UpperLeft();
	rotate([psi,0,0]){
		translate([0,R1/cos(cleaveAngle)+H/2+nub/2,-H/2+nub])rotate([-phi,0,0])
			translate(-[0,R1/cos(cleaveAngle)+H/2+nub/2,-H/2+nub])UpperRight();
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
difference(){
    cleave(lower=false)Left();
    translate([-3/2*tol-nub-T,0,0])hingeGap();
    translate([-x_hinge,0,0])mirror([1,0,0])hingeGap();
    #translate([-L/2*sin(phi)-.05*W,L/2*cos(phi),H/2])letter(first);
}

module LowerLeft()
render()
difference(){
    union(){
        cleave(lower=true)Left();
        difference(){
            clasp(inside=1);
            translate([-tol/2,0,-R+T+nub+2*tol])rotate([0,-25,0])translate([0,0,-H])cube(2*H,center=true);
        }
        translate([-3/2*tol-nub-T,0,0])hinge();
        translate([-x_hinge,0,0])mirror([1,0,0])hinge();
        brace();
    }
    #translate([-0.28*L,0.2*L,-H/2])rotate([0,180,180])letter(first);
}

module UpperRight()
render()
difference(){
    cleave(lower=false)Right();
    translate([3/2*tol+nub+T,0,0])mirror([1,0,0])hingeGap();
    translate([x_hinge,0,0])hingeGap();
    clasp(inside=0);
    #translate([L/2*sin(phi)+.05*W,L/2*cos(phi),H/2])letter(last);
}

module LowerRight()
render()
difference(){
	union(){
		cleave(lower=true)Right();
		translate([nub+T,0,2*T-H/2])translate([6,5,0])scale(0.8)monogram(h=1);
		translate([3/2*tol+nub+T,0,0])mirror([1,0,0])hinge();
		translate([x_hinge,0,0])hinge();
		mirror([1,0,0])brace();
	}
	translate([nub+T+tol/2,0,0])rotate([0,90,0])cylinder(r=R,h=tol);
	clasp(inside=0);
    #translate([0.28*L,0.2*L,-H/2])rotate([0,180,180])letter(last);
}

module letter(word)
translate([0,.2*fontsize,0])write(word,t=1,h=fontsize,center=true,font="../write/BlackRose.dxf");

//module letter1()
//scale(14/15)render()
//union(){
//    letter("A");
//    letter("B");
//    letter("C");
//    letter("D");
//    letter("E");
//    letter("F");
//    letter("G");
//    letter("H");
//    letter("I");
//    letter("J");
//    letter("K");
//    letter("L");
//    letter("M");
//    letter("N");
//    letter("O");
//    letter("P");
//    letter("Q");
//    letter("R");
//    letter("S");
//    letter("T");
//    letter("U");
//    letter("V");
//    letter("W");
//    letter("X");
//    letter("Y");
//    letter("Z");
//}

module brace()
intersection(){
	rotate([cleaveAngle,0,0])translate([0,R1,0])difference(){
		cylinder(r=nub+2*T+tol*3/2,h=3*H,center=true);
		translate([L-nub-T,0,0])cube(2*L,center=true);
		translate([L-nub-T-tol*3/2,L,0])cube(2*L,center=true);
	}
	difference(){
		translate([0,0,0])cube([L,2*(R1*sqrt(2)+H/2+nub),H-T],center=true);
		difference(){
			translate([0,0,L+H/2-3*T])cube(2*L,center=true);
			rotate([cleaveAngle-90,0,0])cube([2*L,2*L,2*R1],center=true);
		}
	}
}

module cleave(lower=true){
y = lower==true ? L+R1 : -L+R1+tol;
difference(){
	children(0);
	rotate([cleaveAngle,0,0])translate([0,y,0])cube(2*L,center=true);
}
}

module Right()
difference(){
	union(){
		mirror([1,0,0])hollowbase();
        intersection(){
            cube([L+W,L+W,H],center=true);
            for(i=[0:n-1])rotate([0,-90,0])ring(H/2+(4*i+1)*nub);
        }
        intersection(){
            rotate([0,-90,0])ring(R=H/2-nub);
            rotate([cleaveAngle,0,0])translate([-H/2,H/2-2*nub+tol/2,-H-tol/2])cube(H);
        }
	}
    difference(){
        rotate([0,-90,0])ring(R=H/2-nub);
        rotate([cleaveAngle,0,0])translate([0,2*nub,-H/2-tol/2])cube([3*nub,H,H],center=true);
    }
    for(i=[0:n-1])rotate([0,-90,0])ring(H/2+(4*i+3)*nub);
}

module Left()
difference(){
	union(){
		hollowbase();
        intersection(){
            cube([L+W,L+W,H],center=true);
            for(i=[0:n-1])rotate([0,90,0])ring(H/2+(4*i+3)*nub);
        }
        intersection(){
            rotate([0,90,0])ring(R=H/2-nub);
            rotate([cleaveAngle,0,0])translate([-H/2,H/2-2*nub+tol/2,tol/2])cube(H);
        }
	}
	difference(){
        rotate([0,90,0])ring(R=H/2-nub);
        rotate([cleaveAngle,0,0])translate([0,2*nub,H/2+tol/2])cube([3*nub,H,H],center=true);
    }
    for(i=[0:n-1])rotate([0,90,0])ring(H/2+(4*i+1)*nub);
}

module clasp(inside=0)
rotate([0,90,0])translate([0,0,tol/2+.01])union(){
	translate([0,0,T-nub])cylinder(r1=R-2*nub-tol*inside,r2=R-tol*inside,h=2*nub+.02);
    //cylinder(r=R-2*T-tol*inside,h=2*(nub+T),center=true);
}

module ring(R)
rotate_extrude()translate([R,-tol/2])rotate(45)square(nub*sqrt(2),center=true);

module hollowbase()
difference(){
	base(inside=0);
	difference(){
		base(inside=1);
		translate([-nub-T,0,0])hinge();
		translate([-L-x_hinge,R1/cos(cleaveAngle)+H/2,-H/2])cube([L,2*nub,nub]);
		translate([-L-x_hinge,R1/cos(cleaveAngle)+H/2+nub/2,-H/2+nub])
			rotate([0,90,0])cylinder(r=nub,h=L);
	}
}

module hinge()
translate([-nub/2,R1/cos(cleaveAngle)+H/2-nub/2,-H/2+nub])
difference(){
	union(){
		translate([0,-2*nub,0])cube([nub,6*nub,2*nub],center=true);
		translate([0,nub,0])rotate([0,90,0])cylinder(r=nub,h=nub,center=true);
		translate([nub/2-.01,nub,0])rotate([0,90,0])cylinder(r1=nub,r2=0,h=nub);
	}
	translate([0,-6*nub,2*nub])rotate([45,0,0])cube(6*nub,center=true);
}

module hingeGap()
translate([-nub/2,R1/cos(cleaveAngle)+H/2-nub/2,-H/2+nub])
union(){
	translate([0,tol-nub,0])cube([nub+2*tol,6*nub,2*nub+2*tol],center=true);
	translate([nub/2+tol-.01,nub,0])rotate([0,90,0])cylinder(r1=nub,r2=0,h=nub);
}

module base(inside=0){
W=W-4*T*inside;
intersection(){
	rotate([0,0,90+phi])union(){
		cube([L,W,2*H],center=true);
		translate([L/2,0,0])rotate([0,0,90])cylinder(r=W/2,h=2*H,center=true);
		translate([0,W/2-H/2,0])rotate([0,90,0])rotate([0,0,90])cylinder(r=H/sqrt(2),h=L,center=true);
		for(i=[-1,1])translate([i*L/2,0,0])rotate([0,0,90])
			rotate_extrude(convexity=2)difference(){
				translate([W/2-H/2,0])circle(r=H/sqrt(2));
				translate([-H,0])square(2*H,center=true);
			}
	}
	translate([-L-(nub+T)*inside-tol/2,0,0])cube([2*L,2*L,H-4*T*inside],center=true);
}
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