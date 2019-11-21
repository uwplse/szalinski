//Pierce Mayville
//10-9-19
//MSE5777
//Costumizer assignment

//Smoothness
$fn=100;
//H is height camber;
H=55;
//W is width of the base;
W=90;
//T=thickness of walls
T=2;
//CD is the connector lower diameter;
CD=20;
//HC is hieght of connector
HC=10;
//TOD is top OD of barbs;
TOD=9.5;
//BOP is bottom OD of barbs
BOD=11.5;
//ID is ID of barbs
ID=5.5;
//L is length of barbs;
L=25;


difference(){
union(){
cylinder(H,d1=W,d2=CD);
    translate([0,0,H])
cylinder(HC,d1=CD,d2=BOD);
translate([0,0,H+HC])
cylinder(L,d1=BOD,d2=TOD);
   translate([W/2-CD/2,0,T+CD/2])rotate([0,atan(H/(W/2-CD/2)),0]) 
    difference(){union(){cylinder(HC,d1=CD,d2=BOD);
       translate([0,0,HC])cylinder(L,d1=BOD,d2=TOD);
}
    cylinder(HC,d1=CD-2*T,d2=ID);
translate([0,0,HC])
cylinder(L, d=ID);}
;}
translate([0,0,T])
cylinder(H-T,d1=W-4*T,d2=CD-2*T);
    translate([0,0,H])
    cylinder(HC,d1=CD-2*T,d2=ID);
translate([0,0,H+HC])
cylinder(L, d=ID);
translate([W/2-CD/2,0,T+CD/2])rotate([0,atan(H/(W/2-CD/2)),0])union(){translate([0,0,-2*T])cylinder(2*T,d=CD-2*T);
    cylinder(HC,d1=CD-2*T,d2=ID);}
}