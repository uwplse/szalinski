////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
/// OpenSCAD File version 2018.10.13  //////////
///           16 - 04 - 2019              //////
///         by Ken_Applications           //////
///                V1.0                   //////
////////////////////////////////////////////////


//Pin Diameter
pin_dia=6;
// Flange Diameter
flange_dia=11;
//Flange thickness and circlip thickness 
flange_thk=3;
//Pin space between circlip and flange
pin_space=9;


//pin(flange_thk,flange_dia,pin_dia,pin_space)
pin(flange_thk,flange_dia,pin_dia,pin_space);// this shows the pin
clip();//this shows the circlip


module clip(){
translate([0,-20,0]) 
linear_extrude(height=flange_thk){
e_circlip();
}
}



//for circlip
width=8+0.001; 
grip_angle=25+0.001;
Inner_dia=pin_dia-2;


outter_dia=Inner_dia+width;
mid_point=((outter_dia-Inner_dia)/2);
rrad=(mid_point/2)-0.001;
$fn=200;


module the_washer(){
difference(){
circle(outter_dia/2);//radius
circle(Inner_dia/2);
}
}

module tri_1 (){
hull(){
circle(0.05);
rotate([0,0,-grip_angle]) translate([0,-outter_dia*20,0]) circle(.3);
rotate([0,0,grip_angle]) translate([0,-outter_dia*20,0]) circle(.3);
}
}


module tri_2 (){
hull(){
circle(Inner_dia/10);
rotate([0,0,-30]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,-45]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,-60]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
}
}

module tri_3 (){
hull(){
circle(Inner_dia/10);
rotate([0,0,30]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,45]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
rotate([0,0,60]) translate([0,Inner_dia/2+mid_point/2,0]) circle(.2);
}
}
module circlip(){
round2d(OR=rrad,IR=0){
difference(){
the_washer();
tri_1 ();
//tri_2 ();  
//tri_3 ();     
}
}
}

module e_circlip(){
round2d(OR=0.5,IR=Inner_dia/10){
difference(){
circlip();
    tri_2 ();
    tri_3 ();
}
}
}


module round2d(OR,IR){
    offset(OR)offset(-IR-OR)offset(IR)children();
}



$fn=120;


module washer(thk,ext_dia,in_dia){
difference(){
 cylinder( thk, d=ext_dia);
 translate([0,0,-0.002]) cylinder( thk+0.004, d=in_dia);
}
}



module pin(flange_thk,flange_dia,pin_dia,pin_space){
difference(){
cylinder( flange_thk, d=flange_dia);
chamfer_boss (0.8,flange_dia,flange_thk,0);
}

difference(){
cylinder( pin_space+flange_thk*2+2, d=pin_dia);
chamfer_boss (0.8,pin_dia,pin_space+flange_thk*2+2,0);
translate([0,0,pin_space+flange_thk]) washer(flange_thk,flange_dia*2,pin_dia-2);    
}
}


module chamfer_boss(chamfer,boss_dia,cylinder_hgt,both_bot_top){
if ((both_bot_top==2)||(both_bot_top==0))  mirror([0,0,1])
translate([0,0,-cylinder_hgt-0.001])
difference(){
 translate([0,0,-0.001])   
cylinder(chamfer*0.7071,d1=boss_dia+0.3,d2=boss_dia+0.3);
translate([0,0,-0.5]) cylinder(chamfer*0.7071+1,d1=boss_dia-1-chamfer*0.7071*2,d2=boss_dia+1);
}
if ((both_bot_top==1)||(both_bot_top==0))
difference(){
    translate([0,0,-0.001])
cylinder(chamfer*0.7071,d1=boss_dia+0.3,d2=boss_dia+0.3);
translate([0,0,-0.5]) cylinder(chamfer*0.7071+1,d1=boss_dia-1-chamfer*0.7071*2,d2=boss_dia+1);
}
}


