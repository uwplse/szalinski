VaseSeed=87147589586781;//	
OrnamentSeed=458456630271;//	
//swirls or doodles
Swoodle=0;//[1,0]
GlobalScale=[1,1,1];//
BrushScale=[2,1,0.5];//
BrushRotation=15;//
OrnamentAdjust=0.05;//
OrnamentAdjustR=2;//
Oreps=4;//
OHeight=0.55;//
/* [Hidden] */
dir=un([0,rnd(OrnamentSeed+536,-0.2,0.2),rnd(OrnamentSeed+324,-0.01,1)])*OrnamentAdjust;
dir2=un([0,rnd(OrnamentSeed+546,-1,1),rnd(OrnamentSeed+344,-0.01,0.05)])*OrnamentAdjust;

Calligraphic=2;//
CalligraphicSlant=BrushRotation;//
v=[[0,0],[rnd(VaseSeed+1,25,60),0],[rnd(VaseSeed+2,5,60),rnd(VaseSeed+3,5,60)],[rnd(VaseSeed+4,1,60),rnd(VaseSeed+5,5,60)],[rnd(VaseSeed+6,1,60),rnd(VaseSeed+7,1,60)],[rnd(VaseSeed+8,1,40),60]];

o1=vsmooth([[rnd(OrnamentSeed+9,180),0.03],[rnd(OrnamentSeed+10,180),rnd(OrnamentSeed+11,0.5)],[rnd(OrnamentSeed+12,180),rnd(OrnamentSeed+13,0.5)],[rnd(OrnamentSeed+14,180),rnd(OrnamentSeed+15,0.5)],[rnd(OrnamentSeed+16,180),rnd(OrnamentSeed+17,0.5)],[rnd(OrnamentSeed+18,180),rnd(OrnamentSeed+19,0.5)]]);
o2=concat([o1[5]],vsmooth([[rnd(OrnamentSeed+20,180),rnd(OrnamentSeed+21,0.95,0.0)],[rnd(OrnamentSeed+22,180),rnd(OrnamentSeed+23,0.95,0.0)],[rnd(OrnamentSeed+24,180),rnd(OrnamentSeed+25,0.95,0.0)],[rnd(OrnamentSeed+26,180),rnd(OrnamentSeed+27,0.95,0.0)],[rnd(OrnamentSeed+28,180),rnd(OrnamentSeed+29,0.95,0.0)]]));
o3=concat([o2[5]],vsmooth([[rnd(OrnamentSeed+30,180),rnd(OrnamentSeed+31,0.95,0.5)],[rnd(OrnamentSeed+32,180),rnd(OrnamentSeed+33,0.95,0.5)],[rnd(OrnamentSeed+34,180),rnd(OrnamentSeed+35,0.95,0.5)],[rnd(OrnamentSeed+36,180),rnd(OrnamentSeed+37,0.95,0.5)],[rnd(OrnamentSeed+38,180),0.95]]));
scale(GlobalScale)
difference(){


union(){

color("Moccasin")rotate_extrude($fn=100,convexity = 20){
intersection(){
square([50,100]);
union(){
offset(r=0.75) difference(){
polygon(convexity =20, concat(bzplot(v,100),[[0,60]]));
offset(r=-2)polygon(convexity =20, concat(bzplot(v,30),[[-3,65],[-3,0]]));
translate([0,1,0])offset(r=-2)polygon(convexity =20, concat(bzplot(v,30),[[-3,65],[-3,0]]));
}hull(){translate([7.5,1,0]) scale([2,1,1])circle(1);
 scale([2,1,1])circle(1);}}


}

 }
steps=Oreps;
if(BrushScale[0]>0&&BrushScale[1]>0&&BrushScale[2]>0){
for(r=[0:360/steps:359]){
rotate([0,0,r]){
if (Swoodle==1){
color ("Goldenrod") ornamet(v,o1) ;
color ("Peru") ornamet(v,o2) ;
color ("Darkgoldenrod") ornamet(v,o3) ;
}
else if (Swoodle==0){
 for(tp=[rnd(OrnamentSeed+556,-90,-30):rnd(OrnamentSeed+76,50,70):rnd(OrnamentSeed+546,90,30)]){
color ("Goldenrod") spiral([0,0,OHeight],dir,tp);}
 for(tp=[rnd(OrnamentSeed+516,-90,-30):rnd(OrnamentSeed+716,50,70):rnd(OrnamentSeed+514,90,30)]){
color ("Peru")spiral([0,0,OHeight],dir2,tp+90);}
}
}}}

}
rotate([180,0,0])translate([0,0,0.0001])cylinder(h=10,r=30);
}

module spiral(op,dir,t, i=0){
magfield=[cos(i +t*3)*3.5,0,0];
ndir=dir*0.95+cross(dir,magfield)*0.05;// blend dirction with force ( nonscientific)
np=op+ndir;
hull(){
rotate([0,0,op[1]*90*OrnamentAdjustR])translate(concat(0,bez2(max(0.019,min(0.99,1-op[2])),v)))rotate([0,90,0])brush();
rotate([0,0,np[1]*90*OrnamentAdjustR])translate(concat(0,bez2(max(0.019,min(0.99,1-np[2])),v)))rotate([0,90,0])brush();
}
if(i<24 ){spiral(np,ndir,t,i+0.5);}


}
module line(p1, p2) {
  hull() {
    translate(p1) rotate([0,0,-CalligraphicSlant]) scale([1/Calligraphic,Calligraphic,1])sphere(1);
    translate(p2) rotate([0,0,-CalligraphicSlant])scale([1/Calligraphic,Calligraphic,1])sphere(1);
  }
}
module ornamet(v,o) {
ostep=0.0075;
for(i=[0:ostep:1])
{
hull(){
rotate([0,0,bez2(i,o)[0]])translate(concat(0,bez2(bez2(i,o)[1],v)))rotate([0,90,0])brush();
rotate([0,0,bez2(i+ostep,o)[0]])translate(concat(0,bez2(bez2(i+ostep,o)[1],v)))rotate([0,90,0])brush();
}}}
module brush(){
rotate([0,BrushRotation,0])scale(BrushScale)sphere(1,$fn=10);
}
//ShowControl( concat(bzplot(v,20),[[0,30]]));

  module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(1);
              translate(t(v[i-1])) sphere(1);
              }          }
      } 

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);


function rnd(s=0, a=1,b=0)= (rands(min(a,b),max(a,b),1,s)[0]);

function vsmooth(v) = [
  for(i = [0: 1 / len(v): 1]) bez2(i,v)
];

function bzplot(v,res)=[for(i=[1:-1/res:0])bez2(i,v)];
function lim31(l, v) = v / len3(v) * l;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];     
function srnd(a,b)=rands(a,b,1)[0];     
function t(v) = [v[0], v[1], v[2]];
function y(v) = [v[0], 0, v[2]];
function vsharp(v) = [  for(i = [0: 0.5: len(v) - 1]) v[floor(i)]];
function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));
function  subdv(v)=[let(last=(len(v)-1)*3)for (i=[0:last])  let(j=floor((i+1)/3))i%3 == 0?v[j]:i%3  == 2? v[j]- un(un(pre(v,j))+un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1: v[j] +un(un(pre(v,j)) +un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1];     
function bz2t(v,stop,precision=0.01,t=0,acc=0)=acc>=stop||t>1?t:bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));
function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];