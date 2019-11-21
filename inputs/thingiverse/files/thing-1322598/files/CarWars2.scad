
// No Preview. Just hit Create.   Always leave Part at 1"
part=1;//[1,2,3,4,5,6,7,8,9,10]
Q=3;//[2:0.5:12]
windows=true;
/* [Hidden] */

fwd=srnd(45,60);
war=[fwd,fwd*3,fwd*2,fwd,fwd,fwd,fwd,fwd,fwd,fwd];
rwd=fwd;
tw=rnd(50,70) ;
l=max(rwd*1.5+fwd*1.5,srnd(tw*3.5,400))-0*4;
h=max(fwd*1.5,min(tw*2,l*srnd(0.01,0.5))+0);
hoodl=max(0.1,l*srnd(0.05,0.3));   
cabl=min(l-hoodl,max(tw*1.5,l*srnd(0,0.9)));

cabw=tw*srnd(0.5,1);
cabh=max(tw,h+(l-cabl)*0.1+0*0.3);

hoodw=tw*srnd(0.1,0.7);
hoodh=max(fwd*1.1,cabh*srnd(0.4,0.6));

trunkl=l-(cabl+hoodl);
trunkw=cabw*srnd(0.2,0.9);
trunkh=max(cabh*0.5,h*srnd(0.5,1));
fax=fwd*srnd(0.75,1.5);
rax=max(fax+fwd+rwd/2,min(l-trunkl/2+rwd*2,l-rwd*1.5)-0);
fenderl=fwd*1.5;
fenderw=(fwd*0.75)+0;
fenderh=max(0,fwd*0.75);
bodyl=max(0,l-0*3);
bodyw=tw*1.05;
bodyh=fenderh*0.7;
dice=rands(0,2,10);
wildstore=rands(-2,2,1000);
rsize=5;
fn=8;
LINE1=vsharp([[0,hoodw,0],[0,tw,0],[hoodl,tw,0]]);
LINE2=vsharp([[0,hoodw,0],[0,tw,0],[0,tw,fenderh],[hoodl,tw,fenderh]]);
LINE3=vsharp([[0,hoodw,0],[0,hoodw,hoodh*0.8],[0,hoodw,hoodh*0.8],[0,cabw,hoodh*0.8],[hoodl,cabw,hoodh]]);
LINE4=vsharp([[0,0,0],[0,0,hoodh*0.8],[0,0,hoodh*0.8],[hoodl,0,hoodh]]);

LINE5=vsharp([[hoodl,tw,0],[hoodl+cabl,tw,0],[hoodl+cabl,tw,0]]);
LINE6=vsharp([[hoodl,tw,fenderh],[hoodl+cabl,tw,trunkh],[hoodl+cabl,tw,trunkh],[hoodl+cabl,tw,trunkh],[l,tw,trunkh]]);
LINE7=vsharp([[hoodl,cabw,hoodh],[hoodl+cabl*0.3,cabw,h],[hoodl+cabl*0.3,cabw,h],[hoodl+cabl,cabw,h],[hoodl+cabl,tw,trunkh],[l,trunkw,trunkh]]);
LINE8=vsharp([[hoodl,0,hoodh],[hoodl+cabl*0.3,0,h],[hoodl+cabl*0.3,0,h],[hoodl+cabl,0,h],[hoodl+cabl,0,trunkh],[l,0,trunkh]]);

LINE5b=vsharp([[hoodl,tw,0],[hoodl+cabl*0.5,tw,0],[hoodl+cabl,tw,0]]);
LINE6b=vsharp([[hoodl,tw,fenderh],[hoodl+cabl,tw,trunkh],[hoodl+cabl,tw,trunkh],[hoodl+cabl,tw,trunkh],[l,tw,trunkh]]);
LINE7b=vsharp([[hoodl,cabw,hoodh],[hoodl+cabl*0.3,cabw,h],[hoodl+cabl*0.3,cabw,h],[hoodl+cabl,cabw,h],[hoodl+cabl,tw,trunkh],[l,trunkw,trunkh]]);
LINE8b=vsharp([[hoodl,0,hoodh],[hoodl+cabl*0.3,0,h],[hoodl+cabl*0.3,0,h],[hoodl+cabl,0,h],[hoodl+cabl,0,trunkh],[l,0,trunkh]]);

LINE9=vsharp([[hoodl+cabl,tw,0],[l,tw,0],[l,trunkw,0]]);
LINE10=vsharp([[l,tw,trunkh],[l,trunkw,0]]);
LINE11=vsharp([[l,trunkw,trunkh],[l,trunkw,0]]);
LINE12=vsharp([[l,0,trunkh],[l,0,0]]);
ch=[3,15,h-fenderh*0.5];
trunkr=ch [floor(srnd(0,3))];
echo(hoodl,cabl,trunkl,trunkr);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 
 mirrorcopy() {
    
   color("red")  difference() {    
union() {    
difference() { 
    union() {  
        Carbody(LINE1,LINE2,LINE3,LINE4,Q*2); 
        Carbody(LINE5,LINE6,LINE7,LINE8,Q*2); 
        Carbody(LINE9,LINE10,LINE11,LINE12,Q*2); 

 }
if (windows){
       windshield  (LINE5,LINE6,LINE7,LINE8,Q*2);   
 windows(LINE5,LINE6,LINE7,LINE8,Q*2);  
 rearwindow  (LINE5,LINE6,LINE7,LINE8,Q);  
}
     }


translate([fax, tw, 0])scale(1.4) wheel(fwd);
 if(trunkl * 0.2 > rwd||l>rwd*8) {
for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]) {
translate([nax, tw, 0])scale(1.4) wheel(rwd);

}
} else {
translate([rax, tw+0*0.5, 0])scale(1.4)  wheel(rwd);

}


        
}
/////////////cutters////////////////////////////////

if(trunkl>cabl+hoodl) {
  

          
  color("white")translate([hoodl+cabl+trunkr, 0, bodyh+rsize])  rotate([0,0,0])  scube([trunkl-trunkr, tw*1.7, trunkh*1.2],6,fn,0);}
if(trunkl>cabl&&trunkh<h*0.8) {
        
  color("white")translate([hoodl+cabl+trunkr+(tw-trunkw), 0, bodyh+rsize])  rotate([0,0,0])  scube([trunkl-trunkr*2-(tw-trunkw), trunkw*0.95-trunkr/2, trunkh*1],5,fn,0);}
        
   translate([fax, tw, 0]) {  scale(1.1) flatwheel(fwd);
    rotate([0, 0, 180]) scale([1.1, 3, 1.1]) flatwheel(fwd);
  color("red")   rotate([0, 0, 180]) translate([0,-rwd*0.2,0]) scale([6, 6, 6]) flatwheel(fwd);
   }


if(trunkl * 0.2 > rwd||l>rwd*8) {
  for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]){
  translate([nax, tw, 0]) {
    scale(1.1) flatwheel(rwd);
    rotate([0, 0, 180]) scale([1.1, 3, 1.1]) flatwheel(rwd);
  color("red")   rotate([0, 0, 180]) translate([0,-rwd*0.2,0]) scale([6, 6, 6]) flatwheel(rwd);
  }
}
} else {
translate([0,-fwd*0.1,0])translate([rax, tw+0*0.5, 0]) {
  scale(1.1) flatwheel(rwd);
  rotate([0, 0, 180]) scale([1.1, 3, 1.1]) flatwheel(rwd);
 color("red")  rotate([0, 0, 180]) translate([0,-rwd*0.2,0]) scale([6, 6, 6]) flatwheel(rwd);

}
}
translate([0,0,-50])cube([l,tw*2,50]);
}

/////////////////////////////////////////////////




color("lightgray")line([fax, 0, 0], [fax, tw, 0],3);
color("darkgrey"){line([fax, 0, 0], [fax, tw*0.9, 0],4);
    translate ([fax, 0, 0] )rotate([0,90,0])sphere(fwd*0.25,$fn=16) ;
//translate([5,0,-2])scube([max(l-tw*0.45,rax),tw*0.45,rwd*0.2],rsize,fn,160);
    
translate([fax, tw, 0])rotate([rnd(-5,5),0,rnd(-5,5)]) wheel(fwd);
if(trunkl * 0.2 > rwd||l>rwd*8) {
for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]) {
translate([nax, tw, 0])rotate([rnd(-15,5),0,0]) wheel(rwd);
 line([nax, 0, rwd/2-min(rwd,fwd)/2], [nax, tw*0.9, rwd/2-min(rwd,fwd)/2],5);
  translate ([nax, 0, rwd/2-min(rwd,fwd)/2] )rotate([0,90,0])sphere(fwd*0.25,$fn=16) ;
}
} else {
translate([rax, tw+0*0.5, 0])rotate([rnd(-15,5),0,0]) wheel(rwd);
 line([rax, 0, rwd/2-min(rwd,fwd)/2], [rax, tw*0.9, rwd/2-min(rwd,fwd)/2],5); 
     translate ([rax, 0, rwd/2-min(rwd,fwd)/2] )rotate([0,90,0])sphere(rwd*0.25,$fn=16) ;
}



}}


color("lightgray")translate([-5,0,0])hull(){translate([-5,0,0])scube([5,tw*0.45,h*0.2],rsize,fn,0);
translate([-2,0,])scube([15,tw*1.05-0*0.5,h*0.2],rsize,fn,0);}


color("lightgray")translate([l+5,0,0])mirror([-1,0,0])hull(){translate([-5,0,0])scube([5,tw*0.45,h*0.2],rsize,fn,0);
translate([-2,0,])scube([15,tw*1.05-0*0.5,h*0.2],rsize,fn,0);}

if(trunkl>cabl+hoodl) {  union(){
line([0,0,0],[l,0,0]);          
  color("white")translate([hoodl+cabl+trunkr, 0, bodyh-rsize])    scube([trunkl-trunkr, tw-trunkr, h*1.2],trunkr,fn*3,0);
      
  }}
 //end main
////////////////////////////////////////////////
///////////////////////////////////////////////   

module Carbody(LINE1,LINE2,LINE3,LINE4,D=Q){
hstep=1/D;
vstep=1/D;

  //  ShowControl(LINE1); 
  //  ShowControl(LINE2); 
  //  ShowControl(LINE3); 
  //  ShowControl(LINE4); 
   
for (t=[0:hstep:1-hstep+0.001]){
spar1=vsharp([ bez2(t, LINE1)+[0,0,0],bez2(t, LINE2),bez2(t, LINE3),bez2(t, LINE3),bez2(t, LINE4)+[0,0,0]]);
spar2=vsharp([ bez2(t+hstep, LINE1)+[0,0,0],bez2(t+hstep, LINE2),bez2(t+hstep, LINE3),bez2(t+hstep, LINE3),bez2(t+hstep, LINE4)+[0,0,0]]);
  
for (v=[0:vstep:1-vstep+0.001]){
 
      
    p1=[((bez2(v, spar1)[0] ) ) ,max(0,bez2(v, spar1)[1] ),bez2(v, spar1)[2]];
    p2=[((bez2(v+vstep, spar1)[0] ) ) ,max(0,bez2(v+vstep, spar1)[1] ),bez2(v+vstep, spar1)[2]];
    p3=[((bez2(v, spar2)[0] ) ) ,max(0,bez2(v, spar2)[1] ),bez2(v, spar2)[2]];
    p4=[((bez2(v+vstep, spar2)[0] ) ) ,max(0,bez2(v+vstep, spar2)[1] ),bez2(v+vstep, spar2)[2]];
    

poly(p1,p2,p3);
 poly(p4,p3,p2);
        
        
        
        
    
}
}
    }
 module windshield(LINE1,LINE2,LINE3,LINE4,D=Q){
hstart=0.7;
hstop=0.95;
vstart=-0.1;
vstop=0.30;
hstep=(hstop-hstart)/D;
vstep=(hstop-hstart)/D;

  //  ShowControl(LINE1); 
  //  ShowControl(LINE2); 
  //  ShowControl(LINE3); 
  //  ShowControl(LINE4); 
   
for (t=[hstart:hstep:hstop-hstep+0.001]){
spar1=vsharp([ bez2(t, LINE1)+[0,0,0],bez2(t, LINE2),bez2(t, LINE3),bez2(t, LINE3),bez2(t, LINE4)+[0,0,0]]);
spar2=vsharp([ bez2(t+hstep, LINE1)+[0,0,0],bez2(t+hstep, LINE2),bez2(t+hstep, LINE3),bez2(t+hstep, LINE3),bez2(t+hstep, LINE4)+[0,0,0]]);
  
for (v=[vstart:vstep:vstop-vstep+0.001]){
 
      
    p1=[((bez2(v, spar1)[0] ) ) ,max(-3,bez2(v, spar1)[1] ),bez2(v, spar1)[2]];
    p2=[((bez2(v+vstep, spar1)[0] ) ) ,max(-3,bez2(v+vstep, spar1)[1] ),bez2(v+vstep, spar1)[2]];
    p3=[((bez2(v, spar2)[0] ) ) ,max(-3,bez2(v, spar2)[1] ),bez2(v, spar2)[2]];
    p4=[((bez2(v+vstep, spar2)[0] ) ) ,max(-3,bez2(v+vstep, spar2)[1] ),bez2(v+vstep, spar2)[2]];
    

poly(p1,p2,p3,3,false);
 poly(p4,p3,p2,3,false);
        
        
        
        
    
}
}
    } 
 module rearwindow(LINE1,LINE2,LINE3,LINE4,D=Q){
hstart=0.2;
hstop=0.3;
vstart=-0.1;
vstop=0.35;
hstep=(hstop-hstart)/D;
vstep=(hstop-hstart)/D;

  //  ShowControl(LINE1); 
  //  ShowControl(LINE2); 
  //  ShowControl(LINE3); 
  //  ShowControl(LINE4); 
   
for (t=[hstart:hstep:hstop-hstep+0.001]){
spar1=vsharp([ bez2(t, LINE1)+[0,0,0],bez2(t, LINE2),bez2(t, LINE3),bez2(t, LINE3),bez2(t, LINE4)+[0,0,0]]);
spar2=vsharp([ bez2(t+hstep, LINE1)+[0,0,0],bez2(t+hstep, LINE2),bez2(t+hstep, LINE3),bez2(t+hstep, LINE3),bez2(t+hstep, LINE4)+[0,0,0]]);
  
for (v=[vstart:vstep:vstop-vstep+0.001]){
 
      
    p1=[((bez2(v, spar1)[0] ) ) ,max(-2,bez2(v, spar1)[1] ),bez2(v, spar1)[2]];
    p2=[((bez2(v+vstep, spar1)[0] ) ) ,max(-2,bez2(v+vstep, spar1)[1] ),bez2(v+vstep, spar1)[2]];
    p3=[((bez2(v, spar2)[0] ) ) ,max(-2,bez2(v, spar2)[1] ),bez2(v, spar2)[2]];
    p4=[((bez2(v+vstep, spar2)[0] ) ) ,max(-2,bez2(v+vstep, spar2)[1] ),bez2(v+vstep, spar2)[2]];
    

poly(p1,p2,p3,2,false);
 poly(p4,p3,p2,2,false);
        
        
        
        
    
}
}
    }
  module windows(LINE1,LINE2,LINE3,LINE4,D=Q){
hstart=0.5;
hstop=0.95;
vstart=0.45;
vstop=0.70;
hstep=(hstop-hstart)/D;
vstep=(hstop-hstart)/D;

  //  ShowControl(LINE1); 
  //  ShowControl(LINE2); 
  //  ShowControl(LINE3); 
  //  ShowControl(LINE4); 
   
for (t=[hstart:hstep:hstop-hstep+0.001]){
spar1=vsharp([ bez2(t, LINE1)+[0,0,0],bez2(t, LINE2),bez2(t, LINE3),bez2(t, LINE3),bez2(t, LINE4)+[0,0,0]]);
spar2=vsharp([ bez2(t+hstep, LINE1)+[0,0,0],bez2(t+hstep, LINE2),bez2(t+hstep, LINE3),bez2(t+hstep, LINE3),bez2(t+hstep, LINE4)+[0,0,0]]);
  
for (v=[vstart:vstep:vstop-vstep+0.001]){
 
      
    p1=[(bez2(v, spar1)[0]  ) 
    ,max(0,bez2(v, spar1)[1] ),
     max(hoodh,bez2(v, spar1)[2])];
    p2=[(bez2(v+vstep, spar1)[0]  ) ,
    max(0,bez2(v+vstep, spar1)[1] ),
     max(hoodh,bez2(v+vstep, spar1)[2])];
    p3=[(bez2(v, spar2)[0]  ) ,
    max(0,bez2(v, spar2)[1] ),
     max(hoodh,bez2(v, spar2)[2])];
    p4=[(bez2(v+vstep, spar2)[0]  ) ,
    max(0,bez2(v+vstep, spar2)[1] ),
    max(hoodh,bez2(v+vstep, spar2)[2])];
    

poly(p1,p2,p3,2,false);
 poly(p4,p3,p2,2,false);
        
        
        
        
    
}
}
    }   
    
    
    
   
    module poly(p1,p2,p3,h1=1,tomidline=true) {
 
  hull() {
      
    translate(t(p1)) sphere(h1,$fn=4);
    translate(t(p2)) sphere(h1,$fn=4);
    translate(t(p3))  sphere(h1,$fn=4);
  if (tomidline){
    translate(y(p1)) sphere(h1,$fn=4);
    translate(y(p2)) sphere(h1,$fn=4);
    translate(y(p3)) sphere(h1,$fn=4);
  }}
}



module scube(v, r = 2, n = 6,s=0) {
rc = r;
x = v[0];
y = v[1];
z = v[2];
dewild=s;
hull() { 

    translate(dewild*ywilde(s)+[rc, -y, rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+1)+[rc, y , rc]) sphere(r, $fn = n);
    translate(dewild*ywilde(s+2)+[rc, -y, z - rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+3)+[rc, y ,  z - rc]) sphere(r, $fn = n);

    translate(dewild*ywilde(s+4)+[ x, -y, z - rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+5)+[ x, y , z - rc]) sphere(r, $fn = n);
    translate(dewild*ywilde(s+6)+[x, -y, rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+7)+[x, y , rc]) sphere(r, $fn = n);
 
    
 
}}
function wilde(i)=[wildstore[i],wildstore[i*2],wildstore[i*3]];
function ywilde(i)=[wildstore[i],0,wildstore[i*3]];
module wheel(d){

translate ([0,0,d/2-min(rwd,fwd)/2]) 
rotate([90,0,0]) difference(){ hull(){
    scale([d*0.5,d*0.5,3])sphere(1,$fn=24);
    translate([0,0,d/4])
    rotate([0,0,7.5]) scale([d*0.5,d*0.5,3])sphere(1,$fn=24);}
 //cylinder(d/4,d/2,d/2);
      translate([0,0,-d/30])
    scale([d*0.3,d*0.3,4.5])sphere(1,$fn=24);
          translate([0,0,d/3.5])
   scale([d*0.3,d*0.3,3.5])sphere(1,$fn=24);}
    }


module flatwheel(d){

translate ([0,0,d/2-min(rwd,fwd)/2]) 
rotate([90,0,0])  cylinder(d/3,d/2,d/2);
}
module extrudeT(v,d=8,start=0,stop=1) {
     detail=1/d;
for(i = [start+detail: detail: stop]) {
   for (j=[0:$children-1]) 
  hull() {
    translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
    translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
  }
}
}

module mirrorextrudeT(v,d=8,start=0,stop=1) {
     detail=1/d;
for(i = [start+detail: detail: stop]) {
   for (j=[0:$children-1]) 
  hull() {mirrorcopy([0,-1,0]){
    translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
    translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
  }}
}
}

module ShowControl(v)  
{  // translate(t(v[0])) sphere(v[0][3]);
  for(i=[1:len(v)-1]){
   // vg  translate(t(v[i])) sphere(v[i][3]);
      hull(){
          translate(t(v[i])) sphere(0.5);
          translate(t(v[i-1])) sphere(0.5);
          }          }
  } 
  
module line(a,b,c=0.5){
    hull(){
        translate(a)sphere(c);
        translate(b)sphere(c);
        
        }
    
    }  
  module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(2);
              translate(t(v[i-1])) sphere(2);
              }          }
      }  
module mirrorcopy(vec=[0,1,0]) 
{ union(){
children(); 
mirror(vec) children(); }
} 

function  subdv(v)=[
let(last=(len(v)-1)*3)
for (i=[0:last])
  let(j=floor((i+1)/3))

i%3 == 0?
v[j]
:
i%3  == 2?
   v[j]- un(un(pre(v,j))+un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1
    :
   v[j] +un(un(pre(v,j)) +un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1

]
;     
function bz2t(v,stop,precision=0.01,t=0,acc=0)=
acc>=stop||t>1?
t:
bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);
function lim31(l, v) = v / len3(v) * l;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];     
  
  function rnd(a,b)=a+gauss(rands(0,1,1)[0])*(b-a);     
  function srnd(a,b)=rands(a,b,1)[0];     

function t(v) = [v[0], v[1], v[2]];
function y(v) = [v[0], 0, v[2]];

function vsharp(v) = [
  for(i = [0: 0.5: len(v) - 1]) v[floor(i)]
];

function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));