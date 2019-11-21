/////////////////////////////////////////////////////////////////////////////////
/// ///
/// PIPETTE v15; 2014 02 22 ///
/// by Tom Baden (thingyverse ID: tbaden) ///
/// thomas.baden@uni-tuebingen.de ///
/// tombaden.wordpress.com ///
/// ///
/// *inspired by http://www.thingiverse.com/thing:64977 by kwalus ///
/// ///
/////////////////////////////////////////////////////////////////////////////////


// CUSTOMIZABLE VARIABLES

// 
Show_crossection = 0; // [0,1]
// include?
Expunger = 1; // [0,1]


// (printer precision)
Tolerance = 0.35; // [0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5]

// height of regulator (staircase)
Range_Z = 10; // [3:15]
// number of steps
Range_steps = 10; // [1:20]
// (low r = high precision/low range)
Range_membrane_pin = 4;// [2.5, 3, 3.5, 4, 4.5]

// radius of whatever you found to mount the pipette tip! e.g. a plastic or metal tube (see instructions)
shaft_radius = 2.5; 

biro_radius = 1.8; 
biro_radius_tip = 1.7; 
// (thread)
screw_radius = 2.5;



///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
/// CUSTOMIZER CUTOFF: MODIFY ANYTHING BELOW HERE AT YOUR OWN RISK! ///////////////////
/// ( Yes, I know the code is messy - it grew organically and I havent cleaned it..) //
module customizer_cutoff(){};//////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

// Notes just for me:
// yellowtip canulla radius: 2.5 mm
// bluetip PVC tube radius: 3.1 mm


slide = Tolerance;
sep = 20;
wall = 3;
connect_Z = 5;
connect_R = 7;
connect_X = 2;
crosssection = Show_crossection * 100;


////////////////////////////
//// TOP PART (A) ///////
////////////////////////////

A_Z = 58;
A_Z_top = 16;
A_Y = 18;
A_X = 25;

A_topwall = 5;
A_hole_R = A_Y/2+2;
A_hole_Z = 33;

P1_R = biro_radius+slide; // 2.35 for M4; radius of plunger stalk

P2_R = Range_membrane_pin+1; // radius of plunger head, i.e. the screw
P2_R_minus = Range_membrane_pin;
P2_ZA = (P2_R_minus*2)-1; // 2 for M4; how high is screw head
P2_ZB = 15; // how deep can it go in B

P3_R = 1.5; // how big is the thread hole in bottom bit

P4_ZB = 15; // how deep can it go in B

PD_R = 6; // top plunger radius


screw_Z = 7;
screw_Xoff = 10.5;

A_Z2 = 5;
A_X2 = 12;
A_X3 = 8;


module A_main(){
translate([0,0,A_Z/2+A_Z_top/2])cube([A_X,A_Y,A_Z_top], center = true); // top main

translate([0,0,connect_Z/2])cube([A_X,A_Y,A_Z-connect_Z], center = true); // bottom main
translate([0,0,-A_Z/2+connect_Z/2])cube([connect_X*2,(connect_R-slide/2)*2,connect_Z], center = true); // connect
translate([connect_X,0,-A_Z/2+connect_Z/2])cylinder($fn = 50, r = connect_R-slide/4, h = connect_Z, center = true); // connect
translate([-connect_X,0,-A_Z/2+connect_Z/2])cylinder($fn = 50, r = connect_R-slide/4, h = connect_Z, center = true); // connect
}
module A_main_intersection(){
translate([0,0,0]){rotate([0,0,0]){cylinder($fn = 50, r = A_X/2, h = A_Z*5, center = true);}}} // A_Z*5 is lazy option!!
module A_main_smooth(){intersection(){A_main();A_main_intersection();}}

module A_extension(){
translate([A_X2,0,connect_Z/2+A_Z/2-A_Z2+A_Z_top])cube([A_X,A_Y,A_Z2], center = true); // topextension
rotate([0,-20,0]){translate([A_X2+10,0,connect_Z/2+A_Z/2-A_Z2+A_Z_top-10])cube([A_X,A_Y,A_Z2], center = true);} // topslant
}
module A_extension_intersec(){
translate([A_X2,0,connect_Z/2+A_Z/2-A_Z2+A_Z_top]){rotate([0,0,0]){cylinder($fn = 50, r = A_X/2, h = A_Z2*3, center = true);}}
}
module A_extension_smooth(){intersection(){A_extension();A_extension_intersec();}}


module A_expunger(){
translate([-A_X3,0,connect_Z/2])cube([A_X,A_Y,30*Expunger], center = true); // 
rotate([0,45,0]){translate([-22,0,-10])cube([27*Expunger,A_Y,A_Z+15], center = true);} // topslant
rotate([0,-45,0]){translate([-22,0,34])cube([27*Expunger,A_Y,A_Z+15], center = true);} // bottomslant

}

module A_expunger_intersec(){
translate([-A_X3,0,0]){rotate([0,0,0]){cylinder($fn = 50, r = A_X/2, h = A_Z*3, center = true);}}
}
module A_expunger_smooth(){intersection(){A_expunger();A_expunger_intersec();}}


module A_total(){union(){A_main_smooth();A_extension_smooth();A_expunger_smooth();}}



module A_main_hole(){

translate([0,0,A_Z/2+(A_Z_top)/2-A_topwall/2+PD_R/2])cylinder($fn = 50, r = PD_R+slide, h = A_Z_top-A_topwall, center = true); // tophole
translate([0,0,A_Z/2+1])cylinder($fn = 50, r2 = PD_R+slide, r1 = P1_R, h = PD_R-1.5, center = true);; // tophole_rounding


translate([0,0,(A_Z-A_hole_Z)/2-A_topwall])cylinder($fn = 50, r = A_hole_R, h = A_hole_Z, center = true); // bottomhole
translate([0,0,(A_Z-A_hole_Z)/2-A_topwall-A_hole_Z/2-A_hole_R/2])cylinder($fn = 50, r2 = A_hole_R, r1 = P1_R, h = A_hole_R, center = true);; // bottomhole_rounding

translate([0,0,A_Z/2+A_Z_top-A_topwall/2]){rotate([0,0,0]){cylinder($fn = 50, r = PD_R+slide, h = A_topwall, center = true);}} // mainhole_toptop

translate([0,0,0]){rotate([0,0,0]){cylinder($fn = 50, r = P1_R, h = A_Z, center = true);}} // mainhole
translate([0,0,-A_Z/2+P2_ZA/2]){rotate([0,0,0]){cylinder($fn = 50, r = P2_R, h = P2_ZA, center = true);}} // screwhead

translate([0,30,0])cube([60,60,crosssection], center = true); //crosssection to check whats inside

translate([screw_Xoff,0,A_Z/2+A_Z_top-screw_Z/2]){rotate([0,0,0]){cylinder($fn = 50, r = screw_radius, h = screw_Z, center = true);}} // screw


translate([-A_X/2-2,0,0]){rotate([0,0,0]){cylinder($fn = 50, r = P1_R, h = A_Z*Expunger, center = true);}} // expunger thinhole
translate([-A_X/2-2,0,52]){rotate([0,0,0]){cylinder($fn = 50, r = 4, h = A_Z*2*Expunger, center = true);}} // expunger thickhole

}
difference(){A_total();A_main_hole();}

////////////////////////////
//// BOTTOM PART (B) ///////
////////////////////////////

B_Z = 40; // 
B_exp_Z = 30;
B_exp_Z_hole = 20;

module B_main(){translate([0,0,-(A_Z+B_Z)/2-sep])cube([A_X,A_Y,B_Z], center = true);}

module B_main_intersection(){
translate([0,0,-(A_Z+B_Z)/2-sep]){rotate([0,0,0]){cylinder($fn = 50, r2 = A_X/2, r1 = A_X/4 , h = B_Z, center = true);}}}



module B_expunger(){
translate([-A_X3,0,-(A_Z+B_Z)/2-sep-(B_Z-B_exp_Z)/2])cube([A_X,A_Y,B_exp_Z*Expunger], center = true); // 
//rotate([0,45,0]){translate([-22,0,-10])cube([27,A_Y,A_Z+15], center = true);} // topslant
//rotate([0,-45,0]){translate([-22,0,34])cube([27,A_Y,A_Z+15], center = true);} // bottomslant

}

module B_expunger_intersec(){
translate([-A_X3,0,-sep]){rotate([0,0,0]){cylinder($fn = 50, r = A_X/2, h = A_Z*3*Expunger, center = true);}}
}
module B_expunger_smooth(){intersection(){B_expunger();B_expunger_intersec();}}
module B_main_smooth(){intersection(){B_main();B_main_intersection();}}

module B_total(){ union(){ B_main_smooth();B_expunger_smooth();}}


module B_main_hole(){
translate([0,0,-(A_Z+B_Z)/2-sep+B_Z/2-connect_Z/2])cube([connect_X*2,(connect_R)*2,connect_Z], center = true); // connect
translate([connect_X,0,-(A_Z+B_Z)/2-sep+B_Z/2-connect_Z/2])cylinder($fn = 50, r = connect_R, h = connect_Z, center = true); // connect
translate([-connect_X,0,-(A_Z+B_Z)/2-sep+B_Z/2-connect_Z/2])cylinder($fn = 50, r = connect_R, h = connect_Z, center = true); // connect

translate([0,0,-(A_Z+B_Z)/2-sep]){rotate([0,0,0]){cylinder($fn = 50, r = P3_R, h = B_Z, center = true);}} // mainhole
translate([0,0,-(A_Z+B_Z)/2-sep+B_Z/2-connect_Z-P2_ZB/2]){rotate([0,0,0]){cylinder($fn = 50, r = P2_R, h = P2_ZB, center = true);}} // screwhead
translate([0,0,-(A_Z+B_Z)/2-sep-B_Z/2+P4_ZB/2]){rotate([0,0,0]){cylinder($fn = 50, r = shaft_radius+slide, h = P4_ZB, center = true);}} // bottomconnect


translate([-A_X/2-2,0,-(A_Z+B_Z)/2-sep-(B_Z-B_exp_Z)/2]){rotate([0,0,0]){cylinder($fn = 50, r = P1_R, h = B_exp_Z, center = true);}} // expunger thinhole
translate([-A_X/2-2,0,-(A_Z+B_Z)/2-sep-(B_Z-B_exp_Z)/2-(B_exp_Z-B_exp_Z_hole)/2]){rotate([0,0,0]){cylinder($fn = 50, r = 4, h = B_exp_Z_hole, center = true);}} // expunger thickhole

rotate([0,45,0]){translate([49,0,-9-(A_Z+B_Z)/2-sep])cube([20,A_Y,20], center = true);} // slant cut

translate([0,30,-(A_Z+B_Z)/2-sep])cube([60,60,crosssection], center = true); //crosssection to check whats inside

}

difference(){B_total();B_main_hole();}


////////////////////////////
//// Bottom plunger (C) ///
////////////////////////////


module C_main(){
translate([0,0,-2*sep])sphere($fn = 50, r=P2_R_minus, centre = true); // round
translate([0,0,-2*sep+(P2_R_minus)/2])cylinder($fn = 50, r = P2_R_minus, h = P2_R_minus, center = true); // cylinder
}



module C_hole(){
translate([0,0,-2*sep+1])cylinder($fn = 50, r = biro_radius+slide/3, h = (P2_R_minus-0.5)*2, center = true); // hole

translate([0,30,-2*sep])cube([60,60,crosssection], center = true); //crosssection to check whats inside
}

difference(){C_main();C_hole();}



////////////////////////////
//// Top plunger (D) ///
////////////////////////////


P0_R = 2.1;
P_Zextra = 30;

module D_main(){
translate([0,0,4*sep+7/2])sphere($fn = 50, r=PD_R, centre = true); // round
translate([0,0,4*sep-P_Zextra/2])cylinder($fn = 50, r = PD_R, h = PD_R+P_Zextra, center = true); // cylinder
}



module D_hole(){
translate([0,0,4*sep+PD_R/2-1])cylinder($fn = 50, r = biro_radius_tip+slide/3, h = PD_R*2, center = true); // hole small
translate([0,0,4*sep+PD_R/2-1-3])cylinder($fn = 50, r1 = P0_R+2, r2 = P0_R, h = PD_R, center = true); // hole expand
translate([0,0,4*sep-P_Zextra/2-PD_R/2-1])cylinder($fn = 50, r = P0_R+2, h = P_Zextra, center = true); // hole bigger bottom
translate([0,30,4*sep-P_Zextra/2-PD_R/2])cube([60,60,crosssection], center = true); //crosssection to check whats inside
}

difference(){D_main();D_hole();}


////////////////////////////
//// Regulator plunger (E) ///
////////////////////////////

offset = PD_R+2;

E_R = PD_R+3;
E_Z = Range_Z;
E_steps = Range_steps;
E_hole_R = 2+slide/3;

module E_main(){
translate([0,0,5*sep])cylinder($fn = 50, r = E_R, h = E_Z, center = true); // cylinder
}

module E_hole(){

// translate([0,0,5*sep])cylinder($fn = 50, r = E_hole_R, h = E_Z, center = true); // hole
translate([0,0,5*sep])cylinder($fn = 50, r = PD_R, h = E_Z, center = true); // centre big cut


for ( i = [0 : E_steps-1]){ // steps
assign (angle = i*360/E_steps)
translate([cos(angle)*offset,sin(angle) * offset ,5*sep+(E_Z/E_steps)*(i+1)])
rotate([0,0,angle-180/(E_steps-1)]) {cylinder($fn = 50, r = 4, h = E_Z, center = true);} // cylinder
}
}

difference(){E_main();E_hole();}

/////////////////////////////////
//// EXPUNGER PLUNGER (F)
//////////////////////////////////

F_Z = 30*Expunger;

module Expunger_plunger(){
translate([-A_X/2-2,0,57+sep]){rotate([0,0,0]){cylinder($fn = 50, r = 3.7, h = F_Z, center = true);}} // expunger thickhole
translate([-A_X/2-2,0,57+sep+15]){sphere($fn = 50, r=3.7*Expunger);}
// top

}

module Expunger_plunger_hole(){
translate([-A_X/2-2,0,4*sep+PD_R/2-1])cylinder($fn = 50, r = biro_radius_tip+slide/3, h = PD_R*2, center = true); // hole small
translate([-A_X/2-2,0,4*sep+PD_R/2-1-3])cylinder($fn = 50, r1 = P0_R+0.5, r2 = P0_R, h = PD_R, center = true); // hole expand
translate([-A_X/2-2,0,4*sep-P_Zextra/2-PD_R/2-1])cylinder($fn = 50, r = P0_R+0.5, h = P_Zextra, center = true); // hole bigger bottom
translate([0,30,100])cube([60,60,crosssection], center = true); //crosssection to check whats inside
}


difference(){Expunger_plunger();Expunger_plunger_hole();}

///////////////////////////////////////
//// EXPUNGER PLUNGER BOTTOM part (G)
//////////////////////////////////////

G_Z = 6*Expunger;

module G_main(){

translate([-5,0,-(A_Z+B_Z)/2-B_Z-sep])cube([10,A_X/2,G_Z], center = true); // connect
translate([0,0,-(A_Z+B_Z)/2-B_Z-sep]){rotate([0,0,0]){cylinder($fn = 50, r = A_X/4 , h =G_Z, center = true);}} // main circle
translate([-A_X/2-2,0,-(A_Z+B_Z)/2-B_Z-sep+G_Z*2.2]){rotate([0,0,0]){cylinder($fn = 50, r = 3.7, h = G_Z*2.5, center = true);}} //stick up
rotate([0,45,0]){translate([57,0,-9-(A_Z+B_Z)/2-sep-6])cube([31,A_Y,G_Z], center = true);} // slant
}

module G_main_intersection(){
translate([0,0,-(A_Z+B_Z)/2-B_Z-sep]){rotate([0,0,0]){cylinder($fn = 50, r = A_X/4 , h =G_Z, center = true);}} // main circle
translate([-A_X3-4,0,-(A_Z+B_Z)/2-B_Z-sep+10]){rotate([0,0,0]){cylinder($fn = 50, r = A_X/4 , h =G_Z+20, center = true);}} // side circle
translate([-6,0,-(A_Z+B_Z)/2-B_Z-sep])cube([11,A_X/2,G_Z], center = true); // connect
}

module G_total(){intersection(){G_main();G_main_intersection();}}


module G_main_hole(){
translate([0,0,-(A_Z+B_Z)/2-B_Z-sep]){rotate([0,0,0]){cylinder($fn = 50, r = shaft_radius+slide+0.5, h = G_Z, center = true);}} // mainhole
translate([-A_X/2-2,0,-(A_Z+B_Z)/2-B_Z-sep+2+G_Z*2]){rotate([0,0,0]){cylinder($fn = 50, r = biro_radius+slide/3, h = G_Z*3, center = true);}} // sidehole
translate([0,30,-(A_Z+B_Z)/2-B_Z-sep])cube([60,60,crosssection*Expunger], center = true); //crosssection to check whats inside



}

difference(){G_total();G_main_hole();}


