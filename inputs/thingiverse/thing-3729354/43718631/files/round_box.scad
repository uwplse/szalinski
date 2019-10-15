/*
***Customizable Round Box***
K.Incekara
Jul 4, 2019
*/

/////Parameters/////
// Inside diameter of the box (mm).
ins_dia = 45;
// Wall thickness (mm).
wall_th = 5;
// Top-bottom thickness (mm).
tb_th = 3;
// Outside diameter of the box (mm).
out_dia = ins_dia + 2*wall_th;
// Height of the box from bottom to cover (mm).
h = 20;
// Height of the intersection of the body and the cover (mm).
insc = 10;
// Clerance between the cover and the box (mm).
clr = 0.2; //[0.05,0.1,0.2,0.3,0.4]                     

/////Box/////
difference(){
    cylinder(h, out_dia /2 , out_dia /2, $fn=200);
    cylinder(h+1, ins_dia /2 , ins_dia /2, $fn=200 );
}
difference(){
    cylinder(h+insc, (ins_dia+wall_th-clr)/2, (ins_dia+wall_th-clr)/2, $fn=200);
    cylinder(h+insc+1, ins_dia /2 , ins_dia /2, $fn=200 );
}
cylinder(tb_th, ins_dia /2 , ins_dia /2, $fn=200 ); //bottom

//Cover//
translate([out_dia+10,0,0]){
difference(){
    cylinder(insc+tb_th+clr, out_dia/2, out_dia/2, $fn=200);
    cylinder(insc+tb_th+1, (ins_dia+wall_th+clr)/2, (ins_dia+wall_th+clr)/2, $fn=200 );
}
cylinder(tb_th, out_dia/2 , out_dia/2, $fn=200 ); //top
}