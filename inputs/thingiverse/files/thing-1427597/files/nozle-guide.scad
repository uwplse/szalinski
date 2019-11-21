//Internal diameter of motor rocket /mm
ID = 15; //[1:100]
//Angle of nozle
ANGLE = 30; //[1:45]
//Initial nozle clearance
SHOULDER=1; //[0:100]
//Diameter of base
BASE_DIAMETER = 17;//[1:100]
//Height of base
BASE_HEIGHT = 5; //[0:100]

$fn=100;

union(){
translate([0,0,BASE_HEIGHT]){
translate([0,0,SHOULDER]){ 
cylinder(h=ID*tan(ANGLE), r1=ID/2, r2=0);
}
cylinder(h=SHOULDER, r1=ID/2, r2=ID/2);
}
cylinder(h=BASE_HEIGHT, r1=BASE_DIAMETER/2, r2=BASE_DIAMETER/2);
cylinder(h=BASE_HEIGHT+SHOULDER+ID*tan(ANGLE), r1=ID/3, r2=ID/4);
}