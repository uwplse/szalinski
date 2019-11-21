Seed=6547648057;//
Seeded=0;//[1,0]

Oscale=[0.9,0.9];//
plate=45;//
thickness=5;
/*[Hidden]*/
baser=rnd(Seed+1,1.4,2);
phase=rnd(Seed+2,360);

mag1=rnd(Seed+3,6)*baser;
rep1=round(rnd(Seed+4,0,8));
ophase1=rnd(Seed+5,360);

mag2=rnd(Seed+6,6)*baser;
rep2=round(rnd(Seed+7,3,10));
ophase2=rnd(Seed+8,360);

phase0=rnd(Seed+9,360);
r0=rnd(Seed+10,0,1);
phase1=rnd(Seed+1,360);
r1=rnd(Seed+11,0,1)/2;
phase2=rnd(Seed+1,360);
r2=rnd(Seed+12,0,1)/3;
phase3=rnd(Seed+1,360);
r3=rnd(Seed+13,0,1)/4;
phase8=rnd(Seed+1,360);
r8=rnd(Seed+14,0,1)/8;
rsym1=round(rnd(Seed+15,1,8));
rsym2=round(rnd(Seed+16,0,rnd(Seed+16,16)));
msym1=round(rnd(Seed+17,0,rsym1));
msym2=round(rnd(Seed+18,0,rsym2));
rsum=baser+r0+r1+r2+r3+r8;
step=24*rsym1;
d=rnd(Seed+19,360);
e=rnd(Seed+20,-0.1,0.1);

dir=[rnd(Seed+21,-0,-0.5,Seed-23),0.5,0]*10;
golds=["DarkGoldenrod","Goldenrod"];
difference(){
color("DarkGoldenrod")translate([0,0,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=50)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) circle(plate,center=true);
color("Goldenrod")mirror([0,0,1])translate([0,0,-1.99]) linear_extrude(height = 2,  convexity = 10, scale=0.93,$fn=50)offset(delta=3, chamfer=true)offset(r=-6, chamfer=false) circle(plate,center=true);
}

up=[0,0,-2];
intersection(){
color("DarkGoldenrod")translate([0,0,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=50)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) circle(plate,center=true);

color("DarkGoldenrod")translate([0,0,0]) scale([Oscale[0]*plate,Oscale[1]*plate,30]) symmetries(rsym1,msym1){translate([-0.7+0.7/rsym1,0,0])rotate([0,0,d])scale([0.3+0.7/rsym1,e+0.3+0.7/rsym1,1])symmetries(rsym2,msym2){it ();};
}
}
//symmetries(rsym2,msym2){it ();}
module symmetries(rsym,msym){
for(j=[0:360/rsym:360])rotate([0,0,j]){
intersection(){
if(msym==0) children ();else union(){
    intersection(){
    children ();
    translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
    }
    mirror([0,1,0]) intersection(){
    children ();
    translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
    }}

if(rsym>1){intersection(){
rotate ([0,0,(360/rsym)*0.5])translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
mirror([0,1,0])rotate ([0,0,(360/rsym)*0.5])translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
}}else {scale([1,1,0.2])cube(2,center=true);
}
}}}

module it(){
cube(0.03,$fn=10);
for(i=[0:step:360]){hull(){
theta = i+ sin((i+ophase1)*rep1)*mag1+ sin((i+ophase2)*rep2)*mag2;
translate([
sin(theta+phase)*(baser+sin((i+phase0))*r0 +sin((i+phase1)*2)*r1+sin((i+phase2)*3)*r2+sin((i+phase3)*4)*r3+sin((i+phase8)*8)*r8)/rsum
,
cos(theta+phase)*(baser+sin((i+phase0))*r0+sin((i+phase1)*2)*r1+sin((i+phase2)*3)*r2+sin((i+phase3)*4)*r3+sin((i+phase8)*8)*r8)/rsum
,0

])sphere(0.09,$fn=6 );
ii=(i+step)%360;
theta2 = ii+ sin((ii+ophase1)*rep1)*mag1+ sin((ii+ophase2)*rep2)*mag2;
translate([
sin(theta2+phase)*(baser+sin((ii+phase0))*r0 +sin((ii+phase1)*2)*r1+sin((ii+phase2)*3)*r2+sin((ii+phase3)*4)*r3+sin((ii+phase8)*8)*r8)/rsum
,
cos(theta2+phase)*(baser+sin((ii+phase0))*r0+sin((ii+phase1)*2)*r1+sin((ii+phase2)*3)*r2+sin((ii+phase3)*4)*r3+sin((ii+phase8)*8)*r8)/rsum
,0

])sphere(0.09,$fn=6 );
}}}

 
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];

function un(v)=v/max(len3(v),0.000001)*1;
function p2n(pa,pb,pc)=
let(u=pa-pb,v=pa-pc)un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);
function avrg(v)=sumv(v,max(0,len(v)-1))/len(v);
function lerp(start,end,bias)=(end*bias+start*(1-bias));
function len3(v)=len(v)==2?sqrt(pow(v[0],2)+pow(v[1],2)):sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function sumv(v,i,s=0)=(i==s?v[i]:v[i]+sumv(v,i-1,s));
function rnd(S,a=0,b=1)=Seeded==1?(rands(min(a,b),max(a,b),1,S)[0]):(rands(min(a,b),max(a,b),1)[0]);
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];