use <sc.scad>
use <thread.scad>

D=6; // min/step/max: [1:0.1:15]
h=14; // min/step/max: [5:0.1:100]
cnt=12; // min/step/max: [0:1:100]
omega=63; // min/step/max: [0:0.1:90]
alpha=360/(cnt*2);
beta=180-omega;
gamma=180-alpha-beta;

r1= D*sin(gamma)/sin(alpha);
r2=r1*sin(beta)/sin(gamma);
echo(r1);
echo(r2);
echo("OD", 2*(r2+D/2)); //47.55
echo("delta", (47.55-2*(r2+D/2))/2);
$fn=128;
d=11;
q=0;
q1=0.2-0.1195;
ri=r2+D/2+q;
rii=r1-D/2-q;
T=2.8;
echo(r2+D/2+T);
case=4; // [1:mounting base, 2:outside, 3:inside, 4:rollers]

// if(case==1) {mount();}
// else if(case==2) {outside();}
// else if(case==3) {inside();}
// else           {rollers(0);}

//mount();
outside();
//inside();
//rollers(0);

module rollers(q){
        for(n=[0:cnt]){Rz((360/cnt)*n) {Tx(r1){Cy(h=h,r=D/2+q); Rz(omega)Tx(D)Cy(h=h,r=D/2+q);}}}
    }

module outside(){
    union(){ring(ri+q1,ri+q1+T,ri+q1,ri+q1+T,h);
    Tz(h/2-0.653)ring(ri+q1,ri+q1+T,ri+q1-0.1,ri+q1+T,1.3);
    Tz(h/2+0.5)ring(ri+q1-3,ri+q1+T,ri+q1-3,ri+q1+T,1);
    }}
    
module inside(){
    union(){Tz(h/2-0.65)ring(d,rii-q1,d,rii+0.15-q1,1.3);
    ring(d,rii-q1,d,rii-q1,h);
    Tz(h/2+0.5)ring(d,rii+5-q1,d,rii+5-q1,1);
    }}

module mount(){
    D(){
    Tz(-h/2+0.5+1)Cy(r=r2+D/2+2,h=5);
    Tz(-h/2+2.05)ring(r1-(D/2)/sqrt(3),r2+(D/2)/sqrt(3),r1-(D/2)/sqrt(3),r2+(D/2)/sqrt(3),4.1);
    Tz(-h/2+0.5)Cy(r=r1-D/2-2,h=8);
    rollers(0.3);}}
   
module ring(ri1,ra1,ri2,ra2,h){
    difference(){
        cylinder(r1=ra1,r2=ra2,h=h,center=true,$fn=511);
        cylinder(r1=ri1,r2=ri2,h=h+0.01,center=true,$fn=511);
        }
    }

//Tz(-7)threading(pitch = 1.25, d=8*(7/5.67), windings=20, full=true, steps = 256);