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
q = "Both"; // Left, Right, if any other value - both left and right

/*----------------------------------------------------------------------------*/
/*-------                             CODE                            --------*/
/*----------------------------------------------------------------------------*/

/*____________________________________________________________________________*/
/* [HIDDEN] */
c = b/2; //радиус скругления //
module Telo(a,b,y,c,L1,L2){
union(){
cylinder(h,c,c, $fn=50);
translate ([0,-c,0]) cube([L1,a,h]);
translate ([-c,0,0]) rotate (y,0,0) cube ([b,L2-c-b/2,h]);
translate ([(L2-b)*cos(90+y),(L2-b)*sin(90-y),0]) cylinder(h,b/2,b/2, $fn=50);
}
}

module Itog(){
difference(){
    Telo(a,b,y,c,L1,L2);
    translate ([0,0,2])
    Telo(a-2,b-2,y,c-1,L1*2,L2-2);
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
