/* [Spring] */
Spring_Length=100;//[10:200]
Spring_Outer_Diameter=50;//[5:0.1:150]
Spring_Wire_Diameter=5;//[1:0.1:10]
Spring_Windings=7;//[3:20]
Spring_Coarseness=80;//[4,6,8,10,40,80,160]
//For better printing
Printing_Helper="No";//[Yes,No]
//Beware!!! Takes some time!!!
Proofread_Spring_Diameter="No";//[Yes,No]
/* [Spring Left End] */
Spring_Left_End=0;//[0:None,1:Ring,2:Full,3:Full with hole]
Left_Hole_Diameter=8;//[1:0.1:140]
Left_Hole_Type=6;//[3:Triangle,4:Square,6:Hexagon,100:Circle]
/* [Spring Right End] */
Spring_Right_End=0;//[0:None,1:Ring,2:Full,3:Full with hole]
Right_Hole_Diameter=8;//[1:0.1:140]
Right_Hole_Type=6;//[3:Triangle,4:Square,6:Hexagon,100:Circle]
/* [Hidden] */
traat_d=Spring_Wire_Diameter;
vedru_r=Spring_Outer_Diameter/2-traat_d/2;
vedru_p=Spring_Length-traat_d;
keerde=Spring_Windings;
samm=vedru_p/keerde/2;
kraadid=asin((samm/2)/(vedru_r));
union(){
ots(Spring_Left_End,Left_Hole_Diameter,Left_Hole_Type);
if(Proofread_Spring_Diameter=="Yes"){
resize([0,0,vedru_r*2+traat_d],auto=[false,false,true])
translate([samm/2,0,0])
for(x=[0:2:(keerde-1)*2]){
translate([samm*x,0,0])poolik(kraadid,1);
translate([samm*(x+1),0,0])poolik(kraadid,-1);}
}else{
translate([samm/2,0,-(samm*kraadid)/221.61])
for(x=[0:2:(keerde-1)*2]){
translate([samm*x,0,0])poolik(kraadid,1);
translate([samm*(x+1),0,0])poolik(kraadid,-1);}}
translate([vedru_p,0,0])ots(Spring_Right_End,Right_Hole_Diameter,Right_Hole_Type);
if(Printing_Helper=="Yes"){
translate([0,-0.5,-vedru_r-traat_d/2])cube([Spring_Length-traat_d,1,0.6]);
for(x=[0:Spring_Windings-1]){
translate([samm+x*samm*2-samm/2,-10,-vedru_r-traat_d/2])cube([samm,20,0.6]);}}}
module poolik(kraadid,suund){
rotate([0,suund*kraadid,0])
difference(){rongas();
translate([0,suund*vedru_r,0])cube([traat_d,vedru_r*2,vedru_r*2+traat_d],center=true);}}
module rongas(){
rotate([0,90,0])
rotate_extrude(convexity = 10,$fn=Spring_Coarseness)
translate([vedru_r, 0, 0])circle(d = traat_d, $fn=30);}
module ots(tyyp,auk=3,kylgi=8){
if(tyyp==1){rongas();}else{if(tyyp>=2){
difference(){
union(){rongas();rotate([0,90,0])cylinder(h=traat_d,r=vedru_r,center=true,$fn=Spring_Coarseness);}
if(tyyp==3)rotate([0,90,0])cylinder(h=traat_d+2,d=auk,center=true,$fn=kylgi);}}}}