// folding cube

// object
object=0;// [0:Plate,1:Ditto Plate,2:Part 1,3:Part 2,4:Part 3,5:Part 4,6:Assembly]
// sub-cube size
L=20;
// radius of pins
R=2;
// tolerance for movement
tol=0.3;

phi=30*1;// angle of supports
$fn=12*1;

l=L-4*R;// length of hinge
n=6*1;// number of motions

if(object==0)plate();
if(object==1){dittoplate();%translate([-33,0,0])dittoplate();}
if(object==2)bit1();
if(object==3)bit2();
if(object==4)bit3();
if(object==5)bit4();
if(object==6)animation();

module animation()
translate([0,L*(T(1)+T(2)+T(3)+T(4)+T(5)+T(6)),0]){
	half();
	rotate([0,180,0])half();
}

module half(){
M6()M5()M3()M2()M1()translate(L/2*[1,1,-1])orient()render()bit1();
color("red")M6()M5()M4()M3()M2()translate(L/2*[1,-1,-1])rotate([-90,0,0])orient()render()bit2();
color("green")M6(-1)M5()M4(-1)M3()M2(-1)translate(L/2*[1,-1,1])rotate([180,0,0])orient()render()bit3();
color("blue")M6(-1)M5()M3()M2(-1)M1()translate(L/2*[1,1,1])rotate([0,-90,0])orient()render()bit4();
}

module M1()
translate([L,0,0])rotate([0,0,-180*T(1)])translate([-L,0,0])child(0);

module M2(neg=1)
translate([0,-L,0])rotate([-neg*90*T(2),0,0])translate([0,L,0])child(0);

module M3()
translate([0,-2*L,0])rotate([0,0,-90*T(3)])translate([0,2*L,0])child(0);

module M4(neg=1)
translate([0,-3*L,-neg*L])rotate([-neg*180*T(4),0,0])translate([0,3*L,neg*L])child(0);

module M5()
translate([0,-4*L,0])rotate([0,0,-90*T(5)])translate([0,4*L,0])child(0);

module M6(neg=1)
translate([0,-5*L,0])rotate([-neg*90*T(6),0,0])translate([0,5*L,0])child(0);

function T(i)=min(max($t,(i-1)/n),i/n)*n-i+1;// split time into n sequential chunks

module dittoplate(){
translate([33,-L,0])bit1();
translate([33,L,0])bit2();
translate([-33,-L,0])bit3();
translate([-33,L,0])bit4();
}

module plate(){
translate([L,-L,0])bit1();
translate([L,L,0])bit2();
translate([-L,-L,0])bit3();
translate([-L,L,0])bit4();
}

module bit1()
bit();

module bit2()
mirror([0,1,0])bit();

module bit3()
bit(R1=[90,90,0]);

module bit4()
mirror([0,1,0])bit(R1=[90,90,0]);

module orient()
rotate([0,-atan(sqrt(2)),45])translate([0,0,-(L-tol)*sqrt(3)/4])child(0);

module bit(R1=[-90,0,90])
difference(){
	translate([0,0,(L-tol)*sqrt(3)/4])rotate([0,atan(sqrt(2)),0])rotate([0,0,-45])union(){
		difference(){
			union(){
				intersection(){
					cube(L-tol,center=true);
					translate(L/2*[1,1,-1])sphere(r=1.42*L,$fn=100);
				}
				translate([L/2,-L/2,0]){
					cylinder(r=R,h=L-tol,center=true);	
					scale([.99,.99,(L-tol)/l])support();
					mirror([1,1,0])scale([.99,.99,(L-tol)/l])support();
				}
			}
			hinge(t=tol);
			rotate(R1)translate([L/2,-L/2,0])difference(){
				union(){
					cylinder(r=R+tol,h=L,center=true);
					scale([.99,.99,3])support(t=tol);
					scale([.99,.99,3])mirror([1,1,0])support(t=tol);
				}
				cylinder(r=3*R,h=l,center=true);
			}
			rotate(R1)translate(-[-L/2,L/2,l/2+.01])cylinder(r1=R,r2=0,h=R);
		}
		rotate(R1)hinge(t=0);
	}
translate([0,0,-L])cube(2*L,center=true);
}

module hinge(t=0)
translate([L/2,-L/2,0])
difference(){
	union(){
		cylinder(r=R+t,h=l+2*t,center=true);
		translate([0,0,l/2-.01])cylinder(r1=R+t,r2=0,h=R+t);
		support(t);
		mirror([1,1,0])support(t);
	}
	translate(-[0,0,l/2+2*t+.01])cylinder(r1=R+t,r2=0,h=R+t);
}

module support(t=0)
difference(){
	rotate([0,0,phi])translate([-.5*R,0,-l/2-t])cube([1.5*R+t,2*R,l+2*t]);
	rotate([0,0,-phi])translate([-2*(R+tol),0,-l])cube([R+tol,4*R,2*l]);
}
