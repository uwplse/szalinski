$fn=100;
H=10;
//H is height of flask
B=5;
//B is base of flask;
D=1.5;
//D is opening of flask;
L=3;
//L is length of opening
T=.1;
//T=thickness of wall
difference(){
union(){
cylinder(H,B,D,center);

translate([0,0,H])
cylinder(L,D,D);}
union(){
translate([0,0,T])
cylinder(H-T,B-2*T,D-2*T);

translate([0,0,H])
cylinder(L+.1,D-2*T,D-2*T);}
}