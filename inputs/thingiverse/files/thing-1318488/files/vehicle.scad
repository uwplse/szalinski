
// No Preview. Just hit Create.   Always leave Part at 1"
part=1;//[1,2,3,4,5,6,7,8,9,10]
/* [Hidden] */

fwd=rnd(30,50);
war=[fwd,fwd,fwd,fwd,fwd,fwd,fwd,fwd,fwd,fwd+fwd*floor(rnd(0,2))];
rwd=war[floor(srnd(0,9))];
tw=rnd(40,60) ;
l=max(rwd*1.5+fwd*1.5,srnd(tw*2.5,350))-abs(rwd-fwd)*4;
h=min(tw*2,(srnd(0,tw)+l*0.2))+abs(rwd-fwd);
   
cabl=max(tw*1.5,srnd(tw,l*abs(rnd(-0.99,0.99)))-l*0.2);

cabw=tw*srnd(0.8,1)+abs(rwd-fwd)*0.5;
cabh=max(tw,h+(l-cabl)*0.1+abs(rwd-fwd)*0.3);
hoodl=max(0.01,srnd(0,(l*0.3)-cabl*0.1)+abs(rwd-fwd)*1.2);
hoodw=tw*srnd(0.6,1.1)-abs(rwd-fwd)*0.1;
hoodh=cabh*0.72-cabl*0.05;

trunkl=l-(cabl+hoodl)-cabl*0.1+40;
trunkw=cabw;
trunkh=max(cabh*0.2,h*srnd(0.5,1.1)+l*0.05);
fax=fwd*0.75;
rax=max(fax+fwd+rwd/2,min(l-trunkl/2+rwd*2,l-rwd)-abs(rwd-fwd));
fenderl=fwd*1.5;
fenderw=(fwd*0.75)+abs(rwd-fwd);
fenderh=max(0,fwd*0.75);
bodyl=max(0,l-abs(rwd-fwd)*3);
bodyw=tw*1.05;
bodyh=fenderh*0.7;
dice=rands(0,2,10);
wildstore=rands(-4,4,1000);
rsize=5;
fn=8;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mirrorcopy() {
difference() {
union() {
 translate([0,0,abs(rwd-fwd)*0.5]) color("red") rcube([hoodl*2, hoodw, hoodh],2,6,10);
if(trunkl<cabl+hoodl&&fwd==rwd) {
    color("red")union() {
     translate([hoodl, 0, 0]) {
   cab(); }

       translate([hoodl+cabl+trunkl-20, 0, 0]) {mirror([-1,0,0]) rcube([trunkl, trunkw, trunkh],rsize,fn,30);


     }}}
else
      {
color("red")translate([hoodl, 0, abs(rwd-fwd)*0.7])cab();
          *hull(){translate([hoodl, 0, abs(rwd-fwd)]) {
      rcube([min(cabl,l*0.25), cabw, cabh],rsize,fn,40);
      translate([cabl-min(cabl,l*0.25), 0, 0])   rcube([min(cabl,l*0.25), cabw, cabh],rsize,fn,50);
         }
     }
     if (fwd==rwd) {  
         if(dice[0]<1.5){ color("white")translate([l-trunkl+35, 0, bodyh])  rotate([0,0,0])  scube([trunkl*1.1, tw*0.95, trunkh*1.2],rsize,fn,60);}
         else {color("darkgrey") if(l<100)
      {*mirror([-1,0,0]) rcube([trunkl, trunkw, trunkh],rsize,fn,70);}
        translate([l-trunkl*0.3,0,bodyh])
        rotate([-85,0,90])wheel(tw*1.2);}}
    }
if (fwd==rwd){
color("red") translate([0, 0, 0]) {rcube([bodyl, bodyw, bodyh],rsize,fn,80);}
    
  color("red") translate([fax, tw, 0]) {
    translate([-fenderl * 0.5, -fenderw*0.7, 0]) rcube([fenderl, fenderw, fenderh],rsize,fn,90);}}
    
if (fwd==rwd) {     color("red") 
if(trunkl * .4 > rwd||l>rwd*5) {
     for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]){
      translate([nax, tw, 0]) translate([-fenderl * 0.5, -fenderw*0.7, 0]) rcube([fenderl, fenderw, fenderh],rsize,fn,100);
    }
  } else {
    translate([rax, tw, 0]) scale(1.1) translate([-fenderl * 0.5, -fenderw*0.7, 0]) rcube([fenderl, fenderw, fenderh],rsize,fn,110);
  }}

/* line([0, 0, 0], [l, 0, 0]);
color("red") translate([fax, tw, 0]) {
  translate([-fenderl * 0.5, -fenderw, 0]) rcube([fenderl, fenderw, fenderh]);    }*/
}
/////////////cutters////////////////////////////////

translate([fax, tw, 0]) union(){
translate([0,-fwd*0.1,0])scale(1.1) flatwheel(fwd);
rotate([0, 0, 180]) translate([0,fwd*0.1,0])scale([1, 3, 1]) flatwheel(fwd);
 color("red") rotate([0, 0, 180]) translate([0,-fwd*0.1,0]) scale([2, 2, 2]) flatwheel(fwd);
}
if(trunkl * .4 > rwd||l>rwd*5) {
  for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]){
  translate([nax, tw, 0]) {
    scale(1.1) flatwheel(rwd);
    rotate([0, 0, 180]) scale([1, 3, 1]) flatwheel(rwd);
  color("red")   rotate([0, 0, 180]) translate([0,-rwd*0.1,0]) scale([6, 6, 6]) flatwheel(rwd);
  }
}
} else {
translate([0,-fwd*0.1,0])translate([rax, tw+abs(rwd-fwd)*0.5, 0]) {
  scale(1.1) flatwheel(rwd);
  rotate([0, 0, 180]) scale([1, 3, 1]) flatwheel(rwd);
 color("red")  rotate([0, 0, 180]) translate([0,-rwd*0.1,0]) scale([6, 6, 6]) flatwheel(rwd);

}
}
}

/////////////////////////////////////////////////
color("lightgray")translate([-5,0,0])hull(){translate([-5,0,0])scube([5,tw*0.45,h*0.2],rsize,fn,120);
translate([-2,0,])scube([15,tw*1.05-abs(rwd-fwd)*0.5,h*0.2],rsize,fn,130);}


color("lightgray")translate([l+10,0,0])mirror([-1,0,0])hull(){translate([-5,0,0])scube([5,tw*0.45,h*0.2],rsize,fn,140);
translate([-2,0,])scube([15,tw*1.05-abs(rwd-fwd)*0.5,h*0.2],rsize,fn,150);}

//line([fax, 0, 0], [fax, tw, 0],3);
color("darkgrey"){line([fax, 0, 0], [fax, tw*0.9, 0],4);
    translate ([fax, 0, 0] )sphere(fwd*0.25) ;
translate([5,0,-2])scube([max(l-tw*0.45,rax),tw*0.45,rwd*0.5],rsize,fn,160);
translate([fax, tw, 0])rotate([rnd(-5,5),0,rnd(-5,5)]) wheel(fwd);
if(trunkl * .4 > rwd||l>rwd*5) {
for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]) {
translate([nax, tw, 0])rotate([rnd(-15,5),0,0]) wheel(rwd);
 line([nax, 0, rwd/2-min(rwd,fwd)/2], [nax, tw*0.9, rwd/2-min(rwd,fwd)/2],5);
  translate ([nax, 0, rwd/2-min(rwd,fwd)/2] )sphere(fwd*0.25) ;
}
} else {
translate([rax, tw+abs(rwd-fwd)*0.5, 0])rotate([rnd(-15,5),0,0]) wheel(rwd);
 line([rax, 0, rwd/2-min(rwd,fwd)/2], [rax, tw*0.9, rwd/2-min(rwd,fwd)/2],5); 
     translate ([rax, 0, rwd/2-min(rwd,fwd)/2] )sphere(rwd*0.25) ;
}



}}
 //end main
////////////////////////////////////////////////
///////////////////////////////////////////////   
module cab(){
      difference(){ rcube([cabl, cabw, cabh],2,6,20);
                   mirrorcopy(){ cutrcube([cabl, cabw, cabh],2,6,20);} }
    }
module rcube(v, r = 2, n = 6,s=0) {
rc = r;
x = v[0];
y = v[1];
z = v[2];
hull() { 
hull() {
    translate(ywilde(s+1)+[rc, 0, rc]) sphere(r, $fn = n);
    translate(wilde(s+1)+[rc, 0.7*y - rc, rc]) sphere(r, $fn = n);
    translate(ywilde(s+3)+[rc, 0, 0.7 * z - rc]) sphere(r, $fn = n);
    translate(wilde(s+3)+[rc, 0.7*y - rc, 0.7 * z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(ywilde(s+5)+[0.4 * x, 0, z - rc]) sphere(r, $fn = n);
    translate(wilde(s+6)+[0.4 * x, 0.7*y - rc, z - rc]) sphere(r, $fn = n);
    translate(ywilde(s+7)+[0.8 * x, 0, z - rc]) sphere(r, $fn = n);
    translate(wilde(s+8)+[0.8 * x, 0.7*y - rc, z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(ywilde(s+9)+[x, 0, rc]) sphere(r, $fn = n);
    translate(wilde(s+10)+[x, y - rc, rc]) sphere(r, $fn = n);
    //translate([x, 0, z - rc]) sphere(r, $fn = n);
    //translate([x, y - rc, z - rc]) sphere(r, $fn = n);
    
    translate(ywilde(s)+[x, 0, 0.9 * z - rc]) sphere(r, $fn = n);
    translate(wilde(s)+[x, 0.7*y - rc, 0.9 * z - rc]) sphere(r, $fn = n);
}}
}

module cutrcube(v, r = 4, n = 4,s=0) {
rc = 3;
    rh=rc*0.3;
r2=1;
x = v[0];
y = v[1]*0.95;
z = v[2];
 

   // translate(ywilde(s+1)+[rc, 0, rc]) sphere(r2, $fn = n);
   // translate(wilde(s+2)+[rc, 0.7*y - rc, rc]) sphere(r2, $fn = n);
 translate([-rc,0,0])hull(){
translate(ywilde(s+3)+[rc, 0, 0.7 * z ]) sphere(r2, $fn = n);
    translate(wilde(s+3)+[rc, 0.7*y - rc, 0.7 * z ]) sphere(r2, $fn = n);
    translate(ywilde(s+5)+[0.4 * x-rc, 0, z - rc*2]) sphere(r2, $fn = n);
  translate(wilde(s+6)+[0.4 * x-rc, 0.7*y - rc, z - rc*2]) sphere(r2, $fn = n);

translate(ywilde(s+3)+[-rc, 0, 0.7 * z + rh]) sphere(r2, $fn = n);
    translate(wilde(s+3)+[-rc, 0.7*y - rc, 0.7 * z + rh]) sphere(r2, $fn = n);
    translate(ywilde(s+5)+[0.4 * x-rc*2, 0, z-rc ]) sphere(r2, $fn = n);
  translate(wilde(s+6)+[0.4 * x-rc*2, 0.7*y - rc, z -rc]) sphere(r2, $fn = n);

}  // translate(ywilde(s+7)+[0.8 * x, 0, z - rc]) sphere(r2, $fn = n);
    //translate(wilde(s+8)+[0.8 * x, 0.7*y - rc, z - rc]) sphere(r2, $fn = n);

    //translate(ywilde(s+9)+[x, 0, rc]) sphere(r2, $fn = n);
    //translate(wilde(s+10)+[x, y - rc, rc]) sphere(r2, $fn = n);
    //translate([x, 0, z - rc]) sphere(r, $fn = n);
    //translate([x, y - rc, z - rc]) sphere(r, $fn = n);
    
    //translate(ywilde(s)+[x, 0, 0.9 * z - rc]) sphere(r2, $fn = n);
  hull(){     translate([0,rh,0]){ 
      translate(wilde(s+8)+[0.8 * x, 0.7*y , z - rc*2]) sphere(r2, $fn = n);
      translate(wilde(s)+[x-rc, 0.7*y , 0.9 * z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[rc*2, 0.7*y , 0.7 * z-rc ]) sphere(r2, $fn = n);
        translate(wilde(s+6)+[0.4 * x, 0.7*y , z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[x-rc*2, 0.76*y , 0.7 * z ]) sphere(r2, $fn = n);}
       translate([0,rc*5,0]){  
            translate(wilde(s+8)+[0.8 * x, 0.7*y , z - rc*2]) sphere(r2, $fn = n);
           translate(wilde(s)+[x-rc, 0.7*y , 0.9 * z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[rc*2, 0.7*y , 0.7 * z-rc ]) sphere(r2, $fn = n);
        translate(wilde(s+6)+[0.4 * x, 0.7*y , z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[x-rc*2, 0.76*y , 0.7 * z ]) sphere(r2, $fn = n);}}
}
module scube(v, r = 2, n = 6,s=0) {
rc = r;
x = v[0];
y = v[1];
z = v[2];
dewild=1;
hull() { 
hull() {
    translate(dewild*ywilde(s)+[rc, 0, rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+1)+[rc, y - rc, rc]) sphere(r, $fn = n);
    translate(dewild*ywilde(s+2)+[rc, 0, z - rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+3)+[rc, y - rc,  z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(dewild*ywilde(s+4)+[ x, 0, z - rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+5)+[ x, y - rc, z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(dewild*ywilde(s+6)+[x, 0, rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+7)+[x, y - rc, rc]) sphere(r, $fn = n);
 
    
 }
}}
function wilde(i)=[wildstore[i],wildstore[i*2],wildstore[i*3]];
function ywilde(i)=[wildstore[i],0,wildstore[i*3]];
module wheel(d){

translate ([0,0,d/2-min(rwd,fwd)/2]) 
rotate([90,0,0]) difference(){ hull(){
    scale([d*0.5,d*0.5,3])sphere(1,$fn=16);
    translate([0,0,d/4])
    scale([d*0.5,d*0.5,3])sphere(1,$fn=16);}
 //cylinder(d/4,d/2,d/2);
      translate([0,0,-1])
    scale([d*0.3,d*0.3,3.5])sphere(1,$fn=16);}
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


function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));