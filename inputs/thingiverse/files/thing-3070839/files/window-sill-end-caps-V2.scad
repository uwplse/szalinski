/*----------------------------------------------------------------------------*/
/*-------                         INFORMATIONS                        --------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/

// CUSTOMIZABLE WINDOW SILL END CAPS (parametric left and right side)
// by Maxim Agapov, August 2018

/*----------------------------------------------------------------------------*/
/*-------                           SETTINGS                          --------*/
/*----------------------------------------------------------------------------*/
a = 24; // размер широкой части // wide part size
b = 16; // размер узкой части // narrow part size
y = 5; //угол наклона 0 или 5 градусов // angle of inclination (0 or 5 degrees)
L1 = 90; // длина широкой части // length of wide part
L2 = 45; // длина узкой части // length of the narrow part
h = 7; // высота бортика // height of the rim
q = "Both"; // Left, Right, if any other value - then both left and right
t = 1; // толщина бортика // thickness of the rim
t1 = 1; // толщина торцевой части // thickness of the butt end
/*----------------------------------------------------------------------------*/
/*-------                             CODE                            --------*/
/*----------------------------------------------------------------------------*/

/*____________________________________________________________________________*/
/* [HIDDEN] */
c = b/2; // радиус скругления // fillet radius
module Telo(a,b,y,c,L1,L2){
union(){
circle(c, $fn=50);
translate ([0,-c,0]) square([L1,a]);
translate ([-c,0,0]) rotate (y,0,0) square ([b,L2-c-b/2]);
translate ([(L2-b)*cos(90+y),(L2-b)*sin(90-y),0]) circle (b/2,b/2, $fn=50);
}
}

module Itog(){
    union(){
    linear_extrude(h) {
difference(){
    offset(r = 0) {
    Telo(a,b,y,c,L1,L2);
    }
    offset(r = -t) {
    Telo(a,b,y,c,L1*1.2,L2);
    }
       }
}
linear_extrude(t1) {
Telo(a,b,y,c,L1,L2);
}
}
}

if (q == "Right") Itog();
else {
if (q == "Left") mirror([1,0,0]) Itog();
else {
Itog();
mirror([1,0,0])
translate ([-L1,L2+5,0]) Itog();
}
}
