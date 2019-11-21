 //Seed
UserSeed=0;//
/* [Hidden] */

seed=UserSeed==0?round(rnd(1000000000)):UserSeed;

echo (seed);
 
//  invblock([[1,1,0],[-1,1,0],[-1,-1,0],[1,-1,0],[1,1,1],[-1,1,1],[-1,-1,1],[1,-1,1]]);
v1=rnd(10,10,seed+22);
v2=rnd(-0.5,0,seed+33);
v3=rnd(0.25,1.15,seed+34) ;
 

 
fol= 1;//rnd(0,2,seed+4)>1?1:-1;
n0=rnd(60,100,seed*3);
n1=rnd(220,430,seed*4);
n2=rnd(2,n0/2,seed*5);
masterface=[[n1,n2,1],[0,n0,1],[0,-n0,1],[n1,-n2,1]];
masterarea= polyarea(masterface)+polyarea(masterface[1],masterface[2],masterface[3]);

// rotate([0,0,270])
scale([1.7,1.1,1])ext(seed,masterface,v1,v2,v3);

module ext(seed,face,iextrude,ies=0.74,is=0.5,c=4,skip=false)                    
{
par=polyarea(face)+polyarea(face[1],face[2],face[3]);

facenormal=face_normal(face);

extrude=lerp(rnd(0.5,rnd(0.1, (sqrt(par/max(1,6-c)) *max(1,(abs(dot(facenormal,[1,0,0]))+1.5)*c) ),seed),seed ),iextrude*0.9,0.125);
ed=rnd(-0.2,0.2,seed+3);
es=lerp(rnd(ed,0.75,seed+1),ies*0.7,0.125);
s=lerp(rnd(0.25,1.15,seed+2),is*0.7,0.125);



m =avrgp(face);
x =facenormal*extrude;
newface=lerp(face,[m,m,m,m],es)+[x,x,x,x];

dnewface=newface+[x,x,x,x]*0.05;

nfm =avrgp(newface ) ;
center=lerp(m,nfm,0.5);

backface=lerp(face,[m,m,m,m], (ed)) -[x,x,x,x]*0.05;

dbackface=lerp(face,[m,m,m,m],-0.05) -[x,x,x,x]*0.05;

strut=sqrt(sqrt(par))  ;
minl=min( norm(face[0]-face[1]),norm(face[1]-face[2]),norm(face[2]-face[3]),norm(face[3]-face[0]));
 
if (c>0 &&par>10&&minl>1){ 

f0=[backface[0],backface[1],newface[1],newface[0]];
f1=[backface[1],backface[2],newface[2],newface[1]];
f2=[backface[2],backface[3],newface[3],newface[2]];
f3=[backface[3],backface[0],newface[0],newface[3]];
mf0 =avrgp(f0);
mf1 =avrgp(f1);
mf2 =avrgp(f2);
mf3 =avrgp(f3);

io=fol*  ((c%2)==0?-1:1) ;
ef=extrude*io*1.1;
e0=extrude*io*0.8;
e1=extrude*io*1.1;
e2=extrude*io*0.8;
e3=extrude*io*1.1;
seed0=rnd(0,1000000,seed+1);
seed1=rnd(0,1000000,seed+3);
seed2=rnd(0,1000000,seed+1);
seed3=rnd(0,1000000,seed+3);
seedf=rnd(0,1000,seed+0);


union(){
 difference(){ union(){
sphere(0.001);
// if(extrude>0&&skip)


 color(rnd(0,2,seed)>1?"red":"orange")
if(extrude>0&&skip)
intersection(){ union(){line(m,nfm,max(0.1,min(minl,strut)));
                            line(center,mf0,max(0.1,min(minl,strut/3)));
                            line(center,mf1,max(0.1,min(minl,strut/3)));
                            line(center,mf2,max(0.1,min(minl,strut/3)));
                            line(center,mf3,max(0.1,min(minl,strut/3)));


}
 if(extrude>0 )block(concat(backface,newface));
 if(extrude<0 ) invblock(concat(backface,newface));}

 color([0.1,0.1,0.1])if(extrude>0&&!skip)block(concat(backface,newface));
 color([0.1,0.1,0.1])if(extrude<0&&!skip) invblock(concat(backface,newface));
}

if(e0<0)ext(seed0,f0,e0,es,s,0)     ;
if(e1<0)ext(seed1,f1,e1,es,s,0)     ;
if(e2<0)ext(seed2,f2,e2,es,s,0)     ;
if(e3<0)ext(seed3,f3,e3,es,s,0)     ;
if(ef<0)ext(seedf,newface,ef,es,s,0)     ;

}




if(e0>0)ext(seed0,f0,e0,es,s,c-1)     ;
if(e1>0)ext(seed1,f1,e1,es,s,c-1)     ;
if(e2>0)ext(seed2,f2,e2,es,s,c-1)     ;
if(e3>0)ext(seed3,f3,e3,es,s,c-1)     ;
if(ef>0)ext(seedf,newface,ef,es,s,c-1)     ;



if(e0<0)ext(seed0,f0,e0,es,s,c-1,true)     ;
if(e1<0)ext(seed1,f1,e1,es,s,c-1,true)     ;
if(e2<0)ext(seed2,f2,e2,es,s,c-1,true)     ;
if(e3<0)ext(seed3,f3,e3,es,s,c-1,true)     ;
if(ef<0)ext(seedf,newface,ef,es,s,c-1,true)     ;
}






}
else{
if(extrude>0&&!skip) color([0.5,0.5,0.5]) block(concat(backface,newface));
  if(extrude<0&&!skip) color([0.8,0.8,0.3]) invblock(concat(backface,newface));

}


}

function polyarea(p1, p2, p3) =p2==undef? polyarea(p1.x,p1.y,p1.z): heron(norm(p1 - p2), norm(p2 - p3), norm(p2 - p1));


module block(v)
{
 
polyhedron(v,[
[0,1,2],[0,2,3],
[1,0,4],[1,4,5],
[6,7,3],[6,3,2],
[2,1,5],[2,5,6],
[7,4,0],[7,0,3],
[7,6,5],[7,5,4]]);


 panel([v[4],v[5],v[6],v[7]]);

}

module panel(v){

area= polyarea(v)+polyarea(v[1],v[2],v[3]);
if (area>masterarea*0.1)
{
//steps=5 ;
//for( x=[1/steps:1/steps:1-1/steps],y=[1/steps:1/steps:1-1/steps]){
//p1=lerp(lerp(v[0],v[1],x),lerp(v[3],v[2],x),y);
//translate(p1) cube(sqrt(area)/20,center=true);
//
//}
facenormal=face_normal(v);
in= (dot(facenormal,[1,0,0]));
n =avrgp(v) ;
m =avrgp(v)+ facenormal*(1-abs(in))*2 ;
t=m+[rnd(0.125,1.15,seed)*sqrt(area)*(sign(in)+0.5),0,0]+(facenormal*0.05*sqrt(area));

if(abs(facenormal.x)>abs(facenormal.y)|| abs(facenormal.x)>abs(facenormal.z ) ){

if(facenormal.x>0){
line(n,t,max(0.05,sqrt(area)/16));}
else  
hull(){
translate(n    -[facenormal.x,0,0]*sqrt(area)/4                    ) rotate([0,-90,0])cylinder (sqrt(area)/5,sqrt(area)/4,sqrt(area)/4,$fn=12);
translate(n+[facenormal.x,0,0]*sqrt(area)/6) rotate([0,-90,0])cylinder (sqrt(area)/3,sqrt(area)/4,sqrt(area)/3,$fn=12);


}

}else {line(m,t,max(0.05,sqrt(area)/16));


 line(lerp(m,t,0.9),t,sqrt(area)/10);
line(n,m,sqrt(area)/8);
}


}



}

module octaeder(s)
{
h=s*2/3;
hull(){
polyhedron([[h,h,0],[-h,h,0],[-h,-h,0],[h,-h,0],[0,0,s],[0,0,-s]],[[4,0,1],[5,2,3]]);

}
}

module invblock(v)
{
polyhedron(v,[
[3,2,1],
[1,5,0],
[2,3,7],
[6,5,1],
[3,0,4],
[4,5,6],

[3,1,0],
[5,4,0],
[2,7,6],
[6,1,2],
[3,4,7],
[4,6,7]

]);

//panel([v[4],v[5],v[6],v[7]]);
}

 

module line(p1, p2 ,width=0.5) 
{ // single line plotter
    hull() {
        translate(p1) cube(width,center=true);
        translate(p2) cube(width,center=true);
    }
}
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function dot(a,b)=a*b;
function heron(a, b, c) =
    let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));

function face_normal(v)= len(v)>3?un(face_normal([v[0],v[1],v[2]])
    +face_normal(concat([v[0]],[for(i=[2:len(v)-1])v[i]]))):let(u=v[0]-v[1],w=v[0]-v[2])
    un([u[1]*w[2]-u[2]*w[1],u[2]*w[0]-u[0]*w[2],u[0]*w[1]-u[1]*w[0]]);


function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;

function addlp(v, i=0, r=[0,0,0]) = i<len(v) ? addlp(v, i+1, r+v[i]) : r;

function un(v)=v/max(norm(v),1e-64);
