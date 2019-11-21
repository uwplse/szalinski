$fn=50;
ID=6.2;
OD=7.8;
H=10;
BrimOD=12;
BrimT=2;

OAH=H+BrimT;

difference(){
    union(){
        cylinder(h=OAH,d=OD);
        cylinder(h=BrimT,d=BrimOD);
    }
    cylinder(h=OAH,d=ID);
};
