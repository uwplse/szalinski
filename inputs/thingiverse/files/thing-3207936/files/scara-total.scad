//diam_screw_mot=3.5;
diam_M3=3.5;
diam_GT2_20T=12.2;
M8_pass_thru=9;
M8_nut=15.5;
M3_nut=6.5;
M3_blocked_nut=6.1;
M3_blocked_nut_height=3.1;
diam_rod=11;
diam_LM8UU=15.5;
r_608=11.2;
base_size=37.5;
diam_8mm_rod=8.5;
r_6022=16.2;
center_center_length=107;
diam_M8=8.3;
diam_M5=5.2;
diam_M8_nut=15.5;
pulley_teeth=62;
profile = 12;		// 1=MXL 2=40DP 3=XL 4=H 5=T2.5 6=T5 7=T10 8=AT5 9=HTD_3mm 10=HTD_5mm 11=HTD_8mm 12=GT2_2mm 13=GT2_3mm 14=GT2_5mm

//internal vars, do not modify
hle=center_center_length/2;
r_rod=diam_rod/2;
r_LM8UU=diam_LM8UU/2;

////////////////// ARMS
translate([0,-base_size-hle,70])rotate([0,0,90]){//translate all
//1st arm, top part
difference(){
union(){
translate([0,0,-2.5])cube([center_center_length,32.5,10],center=true);
translate([-hle,0,0]) //left end
    {
translate([0,0,-2.5])    cylinder(r=22,h=10,center=true,$fn=80);
    translate([0,0,-2.5]) cylinder(r1=18,r2=13.9,h=17.5,$fn=80);        
    }
translate([hle,0,0]) //right end
    { 
translate([0,0,-2.5])    cylinder(r=22,h=10,center=true,$fn=80);
translate([0,0,2.5]) CreatePulley(1,pulley_teeth,7);    
    }
//ribs    
sp=2.9;
le=center_center_length-20;
le2=le*2;
hull(){
translate([-hle+10/2,13.9-sp/2,17.5/2-2.5])cube([10,sp,17.5],center=true);
translate([-hle+le-10,13.9-sp/2,17.5/2-7])cube([20,sp,1],center=true);    
}
hull(){
translate([-hle+10/2,-13.9+sp/2,17.5/2-2.5])cube([10,sp,17.5],center=true);
translate([-hle+le-10,-13.9+sp/2,17.5/2-7])cube([20,sp,1],center=true);    
}
    
}//end union
//starting difference

translate([-hle,0,0])//left end
{translate([0,0,-4.5])cylinder(r=r_608,h=10,center=true,$fn=80);
    translate([0,0,17.5+2.5-7])cylinder(r=r_608,h=10,center=true,$fn=80);
cylinder(r=9,h=60,center=true,$fn=80);    
translate([33,0,0]) cylinder(r=diam_M3/2,h=60,center=true,$fn=20);        
}
translate([hle,0,0]) //right end
{
    cylinder(r=12,h=60,center=true,$fn=80);
    translate([0,0,-30+9.5-4])cylinder(r=r_6022,h=60,center=true,$fn=80);
translate([-27,0,0]) cylinder(r=diam_M3/2,h=60,center=true,$fn=20);
}
}

//spacers
translate([hle,0,-15.5]) spacer(7,10,r_LM8UU+0.2);
translate([hle,0,-38]) spacer(4,10,r_LM8UU+0.2);

//pulley
translate([hle,0,-30])
{
    difference(){
    CreatePulley(12*2,pulley_teeth,13); 
    translate([0,0,13/2-2])cylinder(r=r_6022,h=13,center=true,$fn=80);    
    }
}

//1st arm, bottom part
translate([0,0,-40])
difference()
{
hull(){
translate([hle,0,0]) //right end
    { 
    cylinder(r=22,h=25,center=true,$fn=80);
translate([-hle*2+33,0,0]) cylinder(r=6,h=25,center=true,$fn=20);
    }    
}
translate([0,0,6.5])
difference(){
cube([200,200,18],center=true);    
m=8;
hull(){
translate([4+m,0,-30])cylinder(r=hle-27-m,h=70);
translate([-hle,0,-30])cylinder(r=hle-27-m,h=70);    
}
}
//starting difference
translate([hle-27,0,0]) cylinder(r=diam_M3/2,h=60,center=true,$fn=20);
translate([-hle+33,0,0]) cylinder(r=diam_M3/2,h=60,center=true,$fn=20);  
translate([hle,0,0]) //right end
{cylinder(r=12,h=60,center=true,$fn=80);
 translate([0,0,-23/2+5-2])cylinder(r=r_6022,h=10,center=true,$fn=80);   
    }
}

//2nd arm
translate([-hle,0,-30])
{difference(){
    union(){
    hull(){
        translate([0,0,2.5])cylinder(r=22,h=15,center=true,$fn=80);
        translate([-center_center_length,0,0])
        cylinder(r=8,h=10,center=true,$fn=80);        
    }
translate([-hle*2,0,-5]) cylinder(r=18,h=15,$fn=60);
translate([0,0,10])CreatePulley(1,pulley_teeth,7);  
}
//starting difference
cylinder(r=diam_M8/2,h=60,center=true,$fn=20);
translate([-hle*2,0,-10])cylinder(r=8,h=60,center=true,$fn=40);
    hull(){
        translate([-40,0,2.5])cylinder(r=11,h=50,center=true,$fn=80);
        translate([-center_center_length+40,0,0])
        cylinder(r=8,h=50,center=true,$fn=80);      
    }
translate([0,0,-10+9]) cylinder(r=diam_M8_nut/2,h=10,$fn=6,center=true);
translate([-hle*2,0,0]) cube([0.5,100,100],center=true);    
translate([-hle*2,8+5,2])rotate([0,90,0]) cylinder(r=diam_M3/2,h=30,center=true,$fn=15);    
translate([-hle*2,-8-5,2])rotate([0,90,0]) cylinder(r=diam_M3/2,h=30,center=true,$fn=15);        
}
}

}
////////////////// END ARMS

module spacer(height,r_ext,r_int){
translate([0,0,height/2])          
difference(){    
cylinder(r=r_ext,h=height,center=true,$fn=80);
cylinder(r=r_int,h=height+2,center=true,$fn=80);   
}
}

module rod_blocker(height,radius) 
difference(){
union(){
translate([-6,0,0]) cube([12,16,height],center=true);
cylinder(h=height,r=8, center=true, $fn=100);
}
translate([-10,0,0]) cube([20,1,height+4],center=true);
cylinder(h=30,r=radius, center=true, $fn=100);
translate([-7,0,0]) rotate([90,0,0]) cylinder(h=30,r=1.6, center=true, $fn=100);
}

//rod blockers + base spacers
for (angle=[0,120,240]){
rotate([0,0,angle])
    {
     translate([0,-base_size,-30])rod_blocker(7,diam_8mm_rod/2);
     translate([0,-base_size,-80])spacer(23,8,diam_8mm_rod/2);
        }
    
}


//lower motor base
difference(){
union(){  
rotate([0,0,30])  cylinder(r=base_size+10.5,h=10,$fn=3);
for(rotation = [0:120:240]) 
rotate([0,0,rotation]) translate([0,-base_size,0]) 
{ if(rotation==0) {
        cylinder(r=20,h=10,$fn=80);
    translate([0,0,9])cylinder(r=10,h=2,$fn=50);    
    } else {
    cylinder(r=12,h=10,$fn=80);
    translate([0,0,11])difference(){cylinder(r=12,h=2,center=true,$fn=80);cylinder(r=11,h=4,center=true,$fn=80);}
 }
}
translate([0,47,7.5])
 cube([42,48,5],center=true); //NEMA17
}//end union
//starting difference   
for(rotation = [0:120:240]) 
{
rotate([0,0,rotation]) translate([0,-base_size,0]) {cylinder(r=r_rod,h=40,center=true,$fn=80);
translate([0,0,8])cylinder(r=r_LM8UU,h=20,$fn=80);    
}
}
translate([0,0,3]) {cylinder(r=M8_nut/2,h=10,$fn=6);//M8 NUT
cylinder(r=M8_pass_thru/2,h=20,$fn=40,center=true);//M8 thread pass thru    
    }
//two holes for blocked nut    
translate([12,0,5]) cylinder(r=diam_M3/2,h=20,center=true,$fn=20);   
translate([-12,0,5]) cylinder(r=diam_M3/2,h=20,center=true,$fn=20);    
//main screws    
translate([0,-12,5])color([1,0,0])cylinder(r=diam_M3/2,h=20,$fn=40,center=true); 
rotate([0,0,-60])translate([0,base_size-17,-10])color([1,0,0])cylinder(r=diam_M3/2,h=30,$fn=30);
rotate([0,0,60])translate([0,base_size-17,-10])color([1,0,0])cylinder(r=diam_M3/2,h=30,$fn=30);
//NEMA holes
translate([0,50,7]){

cylinder(r=15,h=20,center=true,$fn=80);    
hull(){    
translate([31/2,31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20); 
translate([31/2,31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);    
}    
hull(){
translate([-31/2,31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20); 
translate([-31/2,31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);
}  
hull(){
translate([-31/2,-31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20); 
translate([-31/2,-31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);    
}    
hull(){
translate([31/2,-31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20); 
translate([31/2,-31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);    
}    
}
}


//nut blocker
translate([0,0,20]) {
    difference(){
     hull(){
   translate([12,0,0]) cylinder(r=5,h=3,$fn=20);            
   cylinder(r=9,h=3,$fn=50);         
   translate([-12,0,0]) cylinder(r=5,h=3,$fn=20);
     }   
//starting difference
    cylinder(r=M8_pass_thru/2,h=30,$fn=40,center=true);//M8 thread pass thru    
translate([12,0,0]) cylinder(r=diam_M3/2,h=10,center=true,$fn=20);   
translate([-12,0,0]) cylinder(r=diam_M3/2,h=10,center=true,$fn=20);            
    }
    }


//608zz cap
translate([0,0,110]){    
difference(){    
hull()
{
 cylinder(r=r_608+2-0.3,h=2,$fn=40,center=true); 
  
translate([r_608+4,0,0])cylinder(r=4-0.3,h=2,$fn=40,center=true);      
    
translate([-r_608-4,0,0])cylinder(r=4-0.3,h=2,$fn=40,center=true);          
  
 translate([0,-12,0])cylinder(r=5-0.3,h=2,$fn=40,center=true);     
}
//starting difference
cylinder(r=12.5/2,h= 10,$fn=40,center=true);

translate([r_608+4,0,0])cylinder(r=diam_M3/2,h=10,$fn=40,center=true);
translate([-r_608-4,0,0])cylinder(r=diam_M3/2,h=10,$fn=40,center=true);

//end of 608zz cap
}
}

rotate([0,0,60])translate([0,base_size,30])spacer(44,10.6,r_LM8UU+0.2);
rotate([0,0,-60])translate([0,base_size,30])spacer(44,10.6,r_LM8UU+0.2);

//upper motor base    
translate([0,0,90])    
difference(){
union(){  
rotate([0,0,30])  
    cylinder(r=base_size+10.5,h=10,$fn=3);
for(rotation = [0:120:240]) 
rotate([0,0,rotation]) translate([0,-base_size,0]) 
{ if(rotation==0) {
    
         cylinder(r=20,h=10,$fn=80);
    
translate([0,0,-5])cylinder(r=10,h=5,$fn=50);  
translate([0,base_size-12,-2.5]) cube([9,9,5],center=true);
    //cylinder(r=4.5,h=5,$fn=40,center=true);        

     } else {
    cylinder(r=12,h=10,$fn=80);
    translate([0,0,-1])difference(){cylinder(r=12,h=2,center=true,$fn=80);cylinder(r=11,h=4,center=true,$fn=80);}         
 }
}

translate([0,47,5])
 cube([42,48,10],center=true); //NEMA17
}//end union
 //starting difference  
for(rotation = [0:120:240]) 
{
rotate([0,0,rotation]) translate([0,-base_size,0]) {
translate([0,0,-10+2])cylinder(r=r_LM8UU,h=10,$fn=80);    
cylinder(r=r_rod,h=40,center=true,$fn=80);    
    }

}
translate([0,0,4]) 
cylinder(r=12.5/2,h=20,$fn=40,center=true); //M8 pass inside bearing
translate([0,0,-5+11]) 
cylinder(r=r_608,h=10,$fn=40,center=true); //bearing  
//608zz cap, hole for
translate([0,0,10])
{
hull()
{
 cylinder(r=r_608+2,h=4,$fn=40,center=true);   
translate([r_608+4,0,0])cylinder(r=4,h=4,$fn=40,center=true);      
translate([-r_608-4,0,0])cylinder(r=4,h=4,$fn=40,center=true);    
translate([0,-12,0])cylinder(r=5,h=4,$fn=40,center=true);    
}
}
translate([0,-12,-3])cylinder(r=M3_nut/2,h=12,$fn=30);
//main screws
translate([0,-12,-10])color([1,0,0])cylinder(r=diam_M3/2,h=40,$fn=30);
rotate([0,0,-60])translate([0,base_size-17,-10])color([1,0,0])cylinder(r=diam_M3/2,h=30,$fn=30);
rotate([0,0,60])translate([0,base_size-17,-10])color([1,0,0])cylinder(r=diam_M3/2,h=30,$fn=30);
translate([r_608+4,0,10])cylinder(r=diam_M3/2,h=20,$fn=40,center=true);          
translate([-r_608-4,0,10])cylinder(r=diam_M3/2,h=20,$fn=40,center=true);     

//end of 608zz cap, hole for
//NEMA holes
translate([0,50,5]){

cylinder(r=15,h=20,center=true,$fn=80);    
hull(){    
translate([31/2,31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);       
translate([31/2,31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);
}    
hull(){
translate([-31/2,31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);   
translate([-31/2,31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);       
}    
hull(){
translate([-31/2,-31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);       
translate([-31/2,-31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);     
}    
hull(){
translate([31/2,-31/2-1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);           
translate([31/2,-31/2+1,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);               
}    
}
}

//TOP
translate([0,0,140])    
difference(){
union(){  
rotate([0,0,30])  cylinder(r=base_size+10.5,h=15,$fn=3);
for(rotation = [0:120:240]) 
rotate([0,0,rotation]) translate([0,-base_size,0]) 
{        cylinder(r=12,h=15,$fn=80);
}

}//end union
//starting difference
for(rotation = [0:120:240]) 
{
rotate([0,0,rotation]) translate([0,-base_size,0]) {
translate([0,0,-1])cylinder(r=diam_8mm_rod/2,h=13,$fn=80);
translate([0,-7,3])cube([M3_blocked_nut,M3_blocked_nut_height,16],center=true);
translate([0,-8,6])rotate([90,0,0])cylinder(r=diam_M3/2,h=10,center=true,$fn=20);
    }
}
for(rotation = [60:120:360]) 
{
    rotate([0,0,rotation]) translate([0,base_size/2,7])  cylinder(r=5,h=30,$fn=6,center=true);
}
translate([0,0,7]) {
cylinder(r=M8_pass_thru/2,h=20,$fn=40,center=true);//M8 thread pass thru    
    }
}

//BASE MOTOR
translate([0,0,-50])    
difference(){
union(){  
difference(){    
rotate([0,0,30]) cylinder(r=base_size,h=8,$fn=12);
translate([0,48,3.5])
 cube([base_size*2,45,50],center=true);    
}
for(rotation = [0:120:240]) 
rotate([0,0,rotation]) translate([0,-base_size,0]) 
{        cylinder(r=12,h=8,$fn=80);
}

}//end union

for(rotation = [0:120:240]) 
{
rotate([0,0,rotation]) translate([0,-base_size,0]) {
translate([0,0,-1])cylinder(r=diam_8mm_rod/2,h=12,$fn=80);    }
}
//NEMA holes
translate([0,0,2]){

cylinder(r=15,h=20,center=true,$fn=80);    
translate([31/2,31/2,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);       
translate([-31/2,31/2,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);   
translate([-31/2,-31/2,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);       
translate([31/2,-31/2,0])cylinder(r=diam_M3/2,h=20,center=true,$fn=20);           
}

}

//BOTTOM
translate([0,0,-110])    
difference(){
union(){  
rotate([0,0,30])  cylinder(r2=base_size+10,r1=base_size+28,h=20,$fn=100);
for(rotation = [0:120:240]) 
{    
rotate([0,0,rotation]) translate([0,-base_size,0]) 
{        cylinder(r=12,h=25,$fn=80);
    
}
rotate([0,0,rotation+60]) translate([0,-base_size-20,0]) 
{        cylinder(r=5,h=15,$fn=80);
    
}
}

}//end union
for(rotation = [0:120:240]) 
{
rotate([0,0,rotation+60]) translate([0,-base_size-20,0]) 
{        cylinder(r=diam_M5/2,h=50,$fn=80,center=true);
    
}    
rotate([0,0,rotation]) translate([0,-base_size,0]) {
translate([0,0,4])cylinder(r=diam_8mm_rod/2,h=40,$fn=40);    
translate([0,-7,23])cube([M3_blocked_nut,M3_blocked_nut_height,15],center=true);
translate([0,-8,21])rotate([90,0,0])cylinder(r=diam_M3/2,h=10,center=true,$fn=20);    
    }
}

cylinder(r=29,h=80,$fn=40,center=true);

}

translate([0,-hle*5,0])rotate([90,0,90])color([1,0,0])
{
 
    text(str("BELT 1 length: ",tooth_spacing (2,0.254,pulley_teeth)*3.14+center_center_length*2," mm"));
    C=50+base_size;
    d1=tooth_spacing (2,0.254,pulley_teeth);
    d2=diam_GT2_20T;
    translate([0,-20,0])   text(str("BELT 2 length: ",2*C+1.57*(d1+d2)+((d1-d2)*(d1-d2))/(4*C)," mm"));
          
        
    
}    



// Parametric Pulley with multiple belt profiles
// by droftarts January 2012

// Based on pulleys by:
// http://www.thingiverse.com/thing:11256 by me!
// https://github.com/prusajr/PrusaMendel by Josef Prusa
// http://www.thingiverse.com/thing:3104 by GilesBathgate
// http://www.thingiverse.com/thing:2079 by nophead

// dxf tooth data from http://oem.cadregister.com/asp/PPOW_Entry.asp?company=915217&elementID=07807803/METRIC/URETH/WV0025/F
// pulley diameter checked and modelled from data at http://www.sdp-si.com/D265/HTML/D265T016.html


// tuneable constants

teeth = 62;			// Number of teeth, standard Mendel T5 belt = 8, gives Outside Diameter of 11.88mm
//profile = 12;		 1=MXL 2=40DP 3=XL 4=H 5=T2.5 6=T5 7=T10 8=AT5 9=HTD_3mm 10=HTD_5mm 11=HTD_8mm 12=GT2_2mm 13=GT2_3mm 14=GT2_5mm

motor_shaft = 5.2;	// NEMA17 motor shaft exact diameter = 5
m3_dia = 3.2;		// 3mm hole diameter
m3_nut_hex = 1;		// 1 for hex, 0 for square nut
m3_nut_flats = 5.7;	// normal M3 hex nut exact width = 5.5
m3_nut_depth = 2.7;	// normal M3 hex nut exact depth = 2.4, nyloc = 4

retainer = 0;		// Belt retainer above teeth, 0 = No, 1 = Yes
retainer_ht = 1.5;	// height of retainer flange over pulley, standard = 1.5
idler = 0;			// Belt retainer below teeth, 0 = No, 1 = Yes
idler_ht = 1.5;		// height of idler flange over pulley, standard = 1.5

pulley_t_ht = 12;	// %%%%%%%%%%%%%%%length of toothed part of pulley, standard = 12
pulley_b_ht = 0;		// pulley base height, standard = 8. Set to same as idler_ht if you want an idler but no pulley.
pulley_b_dia = 20;	// pulley base diameter, standard = 20
no_of_nuts = 1;		// number of captive nuts required, standard = 1
nut_angle = 90;		// angle between nuts, standard = 90
nut_shaft_distance = 1.2;	// distance between inner face of nut and shaft, can be negative.


//	********************************
//	** Scaling tooth for good fit **
//	********************************
/*	To improve fit of belt to pulley, set the following constant. Decrease or increase by 0.1mm at a time. We are modelling the *BELT* tooth here, not the tooth on the pulley. Increasing the number will *decrease* the pulley tooth size. Increasing the tooth width will also scale proportionately the tooth depth, to maintain the shape of the tooth, and increase how far into the pulley the tooth is indented. Can be negative */

additional_tooth_width = 0.2; //mm

//	If you need more tooth depth than this provides, adjust the following constant. However, this will cause the shape of the tooth to change.

additional_tooth_depth = 0; //mm

// calculated constants

nut_elevation = pulley_b_ht/2;
m3_nut_points = 2*((m3_nut_flats/2)/cos(30)); // This is needed for the nut trap



// The following calls the pulley creation part, and passes the pulley diameter and tooth width to that module
module CreatePulley(hole,t,h)
{
 // The following set the pulley diameter for a given number of teeth

MXL_pulley_dia = tooth_spacing (2.032,0.254,t);
40DP_pulley_dia = tooth_spacing (2.07264,0.1778,t);
XL_pulley_dia = tooth_spacing (5.08,0.254,t);
H_pulley_dia = tooth_spacing (9.525,0.381,t);
T2_5_pulley_dia = tooth_spaceing_curvefit (0.7467,0.796,1.026,t);
T5_pulley_dia = tooth_spaceing_curvefit (0.6523,1.591,1.064,t);
T10_pulley_dia = tooth_spacing (10,0.93,t);
AT5_pulley_dia = tooth_spaceing_curvefit (0.6523,1.591,1.064,t);
HTD_3mm_pulley_dia = tooth_spacing (3,0.381,t);
HTD_5mm_pulley_dia = tooth_spacing (5,0.5715,t);
HTD_8mm_pulley_dia = tooth_spacing (8,0.6858,t);
GT2_2mm_pulley_dia = tooth_spacing (2,0.254,t);
GT2_3mm_pulley_dia = tooth_spacing (3,0.381,t);
GT2_5mm_pulley_dia = tooth_spacing (5,0.5715,t);
    
    
if ( profile == 1 ) { pulley ( "MXL" , MXL_pulley_dia , 0.508 , 1.321,hole,t,h); }
if ( profile == 2 ) { pulley ( "40 D.P." , 40DP_pulley_dia , 0.457 , 1.226 ,hole,t,h); }
if ( profile == 3 ) { pulley ( "XL" , XL_pulley_dia , 1.27, 3.051 ,hole,t,h); }
if ( profile == 4 ) { pulley ( "H" , H_pulley_dia ,1.905 , 5.359 ,hole,t,h); }
if ( profile == 5 ) { pulley ( "T2.5" , T2_5_pulley_dia , 0.7 , 1.678 ,hole,t,h); }
if ( profile == 6 ) { pulley ( "T5" , T5_pulley_dia , 1.19 , 3.264 ,hole,t,h); }
if ( profile == 7 ) { pulley ( "T10" , T10_pulley_dia , 2.5 , 6.13 ,hole,t,h); }
if ( profile == 8 ) { pulley ( "AT5" , AT5_pulley_dia , 1.19 , 4.268 ,hole,t,h); }
if ( profile == 9 ) { pulley ( "HTD 3mm" , HTD_3mm_pulley_dia , 1.289 , 2.27 ,hole,t,h); }
if ( profile == 10 ) { pulley ( "HTD 5mm" , HTD_5mm_pulley_dia , 2.199 , 3.781 ,hole,t,h); }
if ( profile == 11 ) { pulley ( "HTD 8mm" , HTD_8mm_pulley_dia , 3.607 , 6.603 ,hole,t,h); }
if ( profile == 12 ) { pulley ( "GT2 2mm" , GT2_2mm_pulley_dia , 0.764 , 1.494 ,hole,t,h); }
if ( profile == 13 ) { pulley ( "GT2 3mm" , GT2_3mm_pulley_dia , 1.169 , 2.31 ,hole,t,h); }
if ( profile == 14 ) { pulley ( "GT2 5mm" , GT2_5mm_pulley_dia , 1.969 , 3.952 ,hole,t,h); }
}
// Functions

function tooth_spaceing_curvefit (b,c,d,t)
	= ((c * pow(t,d)) / (b + pow(t,d))) * teeth ;

function tooth_spacing(tooth_pitch,pitch_line_offset,t)
	= (2*((t*tooth_pitch)/(3.14159265*2)-pitch_line_offset)) ;

// Main Module

module pulley( belt_type , pulley_OD , tooth_depth , tooth_width,motor_shaft,teeth,pulley_t_ht)
	{
        
	echo (str("Belt type = ",belt_type,"; Number of teeth = ",teeth,"; Pulley Outside Diameter = ",pulley_OD,"mm "));
	tooth_distance_from_centre = sqrt( pow(pulley_OD/2,2) - pow((tooth_width+additional_tooth_width)/2,2));
	tooth_width_scale = (tooth_width + additional_tooth_width ) / tooth_width;
	tooth_depth_scale = ((tooth_depth + additional_tooth_depth ) / tooth_depth) ;


//	************************************************************************
//	*** uncomment the following line if pulley is wider than puller base ***
//	************************************************************************

//	translate ([0,0, pulley_b_ht + pulley_t_ht + retainer_ht ]) rotate ([0,180,0])

	difference()
	 {	 
		union()
		{
			//base
	
			if ( pulley_b_ht < 2 ) { echo ("CAN'T DRAW PULLEY BASE, HEIGHT LESS THAN 2!!!"); } else {
				rotate_extrude($fn=pulley_b_dia*2)
				{
						square([pulley_b_dia/2-1,pulley_b_ht]);
						square([pulley_b_dia/2,pulley_b_ht-1]);
						translate([pulley_b_dia/2-1,pulley_b_ht-1]) circle(1);
				}
			}
	
		difference()
			{
			//shaft - diameter is outside diameter of pulley
			
			translate([0,0,pulley_b_ht]) 
			rotate ([0,0,360/(teeth*4)]) 
			cylinder(r=pulley_OD/2,h=pulley_t_ht, $fn=teeth*4);
	
			//teeth - cut out of shaft
		
			for(i=[1:teeth]) 
			rotate([0,0,i*(360/teeth)])
			translate([0,-tooth_distance_from_centre,pulley_b_ht -1]) 
			scale ([ tooth_width_scale , tooth_depth_scale , 1 ]) 
			{
			if ( profile == 1 ) { MXL();}
			if ( profile == 2 ) { 40DP();}
			if ( profile == 3 ) { XL();}
			if ( profile == 4 ) { H();}
			if ( profile == 5 ) { T2_5();}
			if ( profile == 6 ) { T5();}
			if ( profile == 7 ) { T10();}
			if ( profile == 8 ) { AT5();}
			if ( profile == 9 ) { HTD_3mm();}
			if ( profile == 10 ) { HTD_5mm();}
			if ( profile == 11 ) { HTD_8mm();}
			if ( profile == 12 ) { GT2_2mm();}
			if ( profile == 13 ) { GT2_3mm();}
			if ( profile == 14 ) { GT2_5mm();}
			}

			}
			
		//belt retainer / idler
		if ( retainer > 0 ) {translate ([0,0, pulley_b_ht + pulley_t_ht ]) 
		rotate_extrude($fn=teeth*4)  
		polygon([[0,0],[pulley_OD/2,0],[pulley_OD/2 + retainer_ht , retainer_ht],[0 , retainer_ht],[0,0]]);}
		
		if ( idler > 0 ) {translate ([0,0, pulley_b_ht - idler_ht ]) 
		rotate_extrude($fn=teeth*4)  
		polygon([[0,0],[pulley_OD/2 + idler_ht,0],[pulley_OD/2 , idler_ht],[0 , idler_ht],[0,0]]);}
	
		}
	   
		//hole for motor shaft
		translate([0,0,-1])cylinder(r=motor_shaft/2,h=pulley_b_ht + pulley_t_ht + retainer_ht + 2,$fn=motor_shaft*4);
				
		//captive nut and grub screw holes
	
		if ( pulley_b_ht < m3_nut_flats ) { echo ("CAN'T DRAW CAPTIVE NUTS, HEIGHT LESS THAN NUT DIAMETER!!!"); } else {
		if ( (pulley_b_dia - motor_shaft)/2 < m3_nut_depth + 3 ) { echo ("CAN'T DRAW CAPTIVE NUTS, DIAMETER TOO SMALL FOR NUT DEPTH!!!"); } else {
	
			for(j=[1:no_of_nuts]) rotate([0,0,j*nut_angle])
			translate([0,0,nut_elevation])rotate([90,0,0])
	
			union()
			{
				//entrance
				translate([0,-pulley_b_ht/4-0.5,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) cube([m3_nut_flats,pulley_b_ht/2+1,m3_nut_depth],center=true);
	
				//nut
				if ( m3_nut_hex > 0 )
					{
						// hex nut
						translate([0,0.25,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) rotate([0,0,30]) cylinder(r=m3_nut_points/2,h=m3_nut_depth,center=true,$fn=6);
					} else {
						// square nut
						translate([0,0.25,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) cube([m3_nut_flats,m3_nut_flats,m3_nut_depth],center=true);
					}
	
				//grub screw hole
				rotate([0,0,22.5])cylinder(r=m3_dia/2,h=pulley_b_dia/2+1,$fn=8);
			}
		}}
	 }
	   
	}


// Tooth profile modules

module MXL()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-0.660421,-0.5],[-0.660421,0],[-0.621898,0.006033],[-0.587714,0.023037],[-0.560056,0.049424],[-0.541182,0.083609],[-0.417357,0.424392],[-0.398413,0.458752],[-0.370649,0.48514],[-0.336324,0.502074],[-0.297744,0.508035],[0.297744,0.508035],[0.336268,0.502074],[0.370452,0.48514],[0.39811,0.458752],[0.416983,0.424392],[0.540808,0.083609],[0.559752,0.049424],[0.587516,0.023037],[0.621841,0.006033],[0.660421,0],[0.660421,-0.5]]);
	}

module 40DP()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-0.612775,-0.5],[-0.612775,0],[-0.574719,0.010187],[-0.546453,0.0381],[-0.355953,0.3683],[-0.327604,0.405408],[-0.291086,0.433388],[-0.248548,0.451049],[-0.202142,0.4572],[0.202494,0.4572],[0.248653,0.451049],[0.291042,0.433388],[0.327609,0.405408],[0.356306,0.3683],[0.546806,0.0381],[0.574499,0.010187],[0.612775,0],[0.612775,-0.5]]);
	}

module XL()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.525411,-1],[-1.525411,0],[-1.41777,0.015495],[-1.320712,0.059664],[-1.239661,0.129034],[-1.180042,0.220133],[-0.793044,1.050219],[-0.733574,1.141021],[-0.652507,1.210425],[-0.555366,1.254759],[-0.447675,1.270353],[0.447675,1.270353],[0.555366,1.254759],[0.652507,1.210425],[0.733574,1.141021],[0.793044,1.050219],[1.180042,0.220133],[1.239711,0.129034],[1.320844,0.059664],[1.417919,0.015495],[1.525411,0],[1.525411,-1]]);
	}

module H()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-2.6797,-1],[-2.6797,0],[-2.600907,0.006138],[-2.525342,0.024024],[-2.45412,0.052881],[-2.388351,0.091909],[-2.329145,0.140328],[-2.277614,0.197358],[-2.234875,0.262205],[-2.202032,0.334091],[-1.75224,1.57093],[-1.719538,1.642815],[-1.676883,1.707663],[-1.62542,1.764693],[-1.566256,1.813112],[-1.500512,1.85214],[-1.4293,1.880997],[-1.353742,1.898883],[-1.274949,1.905021],[1.275281,1.905021],[1.354056,1.898883],[1.429576,1.880997],[1.500731,1.85214],[1.566411,1.813112],[1.625508,1.764693],[1.676919,1.707663],[1.719531,1.642815],[1.752233,1.57093],[2.20273,0.334091],[2.235433,0.262205],[2.278045,0.197358],[2.329455,0.140328],[2.388553,0.091909],[2.454233,0.052881],[2.525384,0.024024],[2.600904,0.006138],[2.6797,0],[2.6797,-1]]);
	}

module T2_5()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-0.839258,-0.5],[-0.839258,0],[-0.770246,0.021652],[-0.726369,0.079022],[-0.529167,0.620889],[-0.485025,0.67826],[-0.416278,0.699911],[0.416278,0.699911],[0.484849,0.67826],[0.528814,0.620889],[0.726369,0.079022],[0.770114,0.021652],[0.839258,0],[0.839258,-0.5]]);
	}

module T5()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.632126,-0.5],[-1.632126,0],[-1.568549,0.004939],[-1.507539,0.019367],[-1.450023,0.042686],[-1.396912,0.074224],[-1.349125,0.113379],[-1.307581,0.159508],[-1.273186,0.211991],[-1.246868,0.270192],[-1.009802,0.920362],[-0.983414,0.978433],[-0.949018,1.030788],[-0.907524,1.076798],[-0.859829,1.115847],[-0.80682,1.147314],[-0.749402,1.170562],[-0.688471,1.184956],[-0.624921,1.189895],[0.624971,1.189895],[0.688622,1.184956],[0.749607,1.170562],[0.807043,1.147314],[0.860055,1.115847],[0.907754,1.076798],[0.949269,1.030788],[0.9837,0.978433],[1.010193,0.920362],[1.246907,0.270192],[1.273295,0.211991],[1.307726,0.159508],[1.349276,0.113379],[1.397039,0.074224],[1.450111,0.042686],[1.507589,0.019367],[1.568563,0.004939],[1.632126,0],[1.632126,-0.5]]);
	}

module T10()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-3.06511,-1],[-3.06511,0],[-2.971998,0.007239],[-2.882718,0.028344],[-2.79859,0.062396],[-2.720931,0.108479],[-2.651061,0.165675],[-2.590298,0.233065],[-2.539962,0.309732],[-2.501371,0.394759],[-1.879071,2.105025],[-1.840363,2.190052],[-1.789939,2.266719],[-1.729114,2.334109],[-1.659202,2.391304],[-1.581518,2.437387],[-1.497376,2.47144],[-1.408092,2.492545],[-1.314979,2.499784],[1.314979,2.499784],[1.408091,2.492545],[1.497371,2.47144],[1.581499,2.437387],[1.659158,2.391304],[1.729028,2.334109],[1.789791,2.266719],[1.840127,2.190052],[1.878718,2.105025],[2.501018,0.394759],[2.539726,0.309732],[2.59015,0.233065],[2.650975,0.165675],[2.720887,0.108479],[2.798571,0.062396],[2.882713,0.028344],[2.971997,0.007239],[3.06511,0],[3.06511,-1]]);
	}

module AT5()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-2.134129,-0.75],[-2.134129,0],[-2.058023,0.005488],[-1.984595,0.021547],[-1.914806,0.047569],[-1.849614,0.082947],[-1.789978,0.127073],[-1.736857,0.179338],[-1.691211,0.239136],[-1.653999,0.305859],[-1.349199,0.959203],[-1.286933,1.054635],[-1.201914,1.127346],[-1.099961,1.173664],[-0.986896,1.18992],[0.986543,1.18992],[1.099614,1.173664],[1.201605,1.127346],[1.286729,1.054635],[1.349199,0.959203],[1.653646,0.305859],[1.690859,0.239136],[1.73651,0.179338],[1.789644,0.127073],[1.849305,0.082947],[1.914539,0.047569],[1.984392,0.021547],[2.057906,0.005488],[2.134129,0],[2.134129,-0.75]]);
	}

module HTD_3mm()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.135062,-0.5],[-1.135062,0],[-1.048323,0.015484],[-0.974284,0.058517],[-0.919162,0.123974],[-0.889176,0.206728],[-0.81721,0.579614],[-0.800806,0.653232],[-0.778384,0.72416],[-0.750244,0.792137],[-0.716685,0.856903],[-0.678005,0.918199],[-0.634505,0.975764],[-0.586483,1.029338],[-0.534238,1.078662],[-0.47807,1.123476],[-0.418278,1.16352],[-0.355162,1.198533],[-0.289019,1.228257],[-0.22015,1.25243],[-0.148854,1.270793],[-0.07543,1.283087],[-0.000176,1.28905],[0.075081,1.283145],[0.148515,1.270895],[0.219827,1.252561],[0.288716,1.228406],[0.354879,1.19869],[0.418018,1.163675],[0.477831,1.123623],[0.534017,1.078795],[0.586276,1.029452],[0.634307,0.975857],[0.677809,0.91827],[0.716481,0.856953],[0.750022,0.792167],[0.778133,0.724174],[0.800511,0.653236],[0.816857,0.579614],[0.888471,0.206728],[0.919014,0.123974],[0.974328,0.058517],[1.048362,0.015484],[1.135062,0],[1.135062,-0.5]]);
	}

module HTD_5mm()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.89036,-0.75],[-1.89036,0],[-1.741168,0.02669],[-1.61387,0.100806],[-1.518984,0.21342],[-1.467026,0.3556],[-1.427162,0.960967],[-1.398568,1.089602],[-1.359437,1.213531],[-1.310296,1.332296],[-1.251672,1.445441],[-1.184092,1.552509],[-1.108081,1.653042],[-1.024167,1.746585],[-0.932877,1.832681],[-0.834736,1.910872],[-0.730271,1.980701],[-0.62001,2.041713],[-0.504478,2.09345],[-0.384202,2.135455],[-0.259708,2.167271],[-0.131524,2.188443],[-0.000176,2.198511],[0.131296,2.188504],[0.259588,2.167387],[0.384174,2.135616],[0.504527,2.093648],[0.620123,2.04194],[0.730433,1.980949],[0.834934,1.911132],[0.933097,1.832945],[1.024398,1.746846],[1.108311,1.653291],[1.184308,1.552736],[1.251865,1.445639],[1.310455,1.332457],[1.359552,1.213647],[1.39863,1.089664],[1.427162,0.960967],[1.467026,0.3556],[1.518984,0.21342],[1.61387,0.100806],[1.741168,0.02669],[1.89036,0],[1.89036,-0.75]]);
	}

module HTD_8mm()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-3.301471,-1],[-3.301471,0],[-3.16611,0.012093],[-3.038062,0.047068],[-2.919646,0.10297],[-2.813182,0.177844],[-2.720989,0.269734],[-2.645387,0.376684],[-2.588694,0.496739],[-2.553229,0.627944],[-2.460801,1.470025],[-2.411413,1.691917],[-2.343887,1.905691],[-2.259126,2.110563],[-2.158035,2.30575],[-2.041518,2.490467],[-1.910478,2.66393],[-1.76582,2.825356],[-1.608446,2.973961],[-1.439261,3.10896],[-1.259169,3.22957],[-1.069074,3.335006],[-0.869878,3.424485],[-0.662487,3.497224],[-0.447804,3.552437],[-0.226732,3.589341],[-0.000176,3.607153],[0.226511,3.589461],[0.447712,3.552654],[0.66252,3.497516],[0.870027,3.424833],[1.069329,3.33539],[1.259517,3.229973],[1.439687,3.109367],[1.608931,2.974358],[1.766344,2.825731],[1.911018,2.664271],[2.042047,2.490765],[2.158526,2.305998],[2.259547,2.110755],[2.344204,1.905821],[2.411591,1.691983],[2.460801,1.470025],[2.553229,0.627944],[2.588592,0.496739],[2.645238,0.376684],[2.720834,0.269734],[2.81305,0.177844],[2.919553,0.10297],[3.038012,0.047068],[3.166095,0.012093],[3.301471,0],[3.301471,-1]]);
	}

module GT2_2mm()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[0.747183,-0.5],[0.747183,0],[0.647876,0.037218],[0.598311,0.130528],[0.578556,0.238423],[0.547158,0.343077],[0.504649,0.443762],[0.451556,0.53975],[0.358229,0.636924],[0.2484,0.707276],[0.127259,0.750044],[0,0.76447],[-0.127259,0.750044],[-0.2484,0.707276],[-0.358229,0.636924],[-0.451556,0.53975],[-0.504797,0.443762],[-0.547291,0.343077],[-0.578605,0.238423],[-0.598311,0.130528],[-0.648009,0.037218],[-0.747183,0],[-0.747183,-0.5]]);
	}

module GT2_3mm()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.155171,-0.5],[-1.155171,0],[-1.065317,0.016448],[-0.989057,0.062001],[-0.93297,0.130969],[-0.90364,0.217664],[-0.863705,0.408181],[-0.800056,0.591388],[-0.713587,0.765004],[-0.60519,0.926747],[-0.469751,1.032548],[-0.320719,1.108119],[-0.162625,1.153462],[0,1.168577],[0.162625,1.153462],[0.320719,1.108119],[0.469751,1.032548],[0.60519,0.926747],[0.713587,0.765004],[0.800056,0.591388],[0.863705,0.408181],[0.90364,0.217664],[0.932921,0.130969],[0.988924,0.062001],[1.065168,0.016448],[1.155171,0],[1.155171,-0.5]]);
	}

module GT2_5mm()
	{
	linear_extrude(height=pulley_t_ht+2) polygon([[-1.975908,-0.75],[-1.975908,0],[-1.797959,0.03212],[-1.646634,0.121224],[-1.534534,0.256431],[-1.474258,0.426861],[-1.446911,0.570808],[-1.411774,0.712722],[-1.368964,0.852287],[-1.318597,0.989189],[-1.260788,1.123115],[-1.195654,1.25375],[-1.12331,1.380781],[-1.043869,1.503892],[-0.935264,1.612278],[-0.817959,1.706414],[-0.693181,1.786237],[-0.562151,1.851687],[-0.426095,1.9027],[-0.286235,1.939214],[-0.143795,1.961168],[0,1.9685],[0.143796,1.961168],[0.286235,1.939214],[0.426095,1.9027],[0.562151,1.851687],[0.693181,1.786237],[0.817959,1.706414],[0.935263,1.612278],[1.043869,1.503892],[1.123207,1.380781],[1.195509,1.25375],[1.26065,1.123115],[1.318507,0.989189],[1.368956,0.852287],[1.411872,0.712722],[1.447132,0.570808],[1.474611,0.426861],[1.534583,0.256431],[1.646678,0.121223],[1.798064,0.03212],[1.975908,0],[1.975908,-0.75]]);
	}