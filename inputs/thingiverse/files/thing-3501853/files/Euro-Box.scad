

/* [Parameter] */
// Länge X
X=110;   // [10:1:400]
// Breite Y
Y=55;    // [10:1:200]
// Höhe Z
Z=80;    // [10:1:200]
//Boden ZB
ZB=5;    // [1:1:20]
//Abstand
A=2.5;   // [1:1:15]
// Tolleranz
T=0.6;   // [0.05:0.05:2]
//Grad
G=2;      // [0.1:0.1:5]

/* [Muenzen] */
// sortiert (sonst: optimiert)
sort=false;  
t1  ="1";
d1  = 16.3;  // [10:0.1:30]
t2  ="2";
d2  = 18.6;  // [10:0.1:30]
t5  ="5";
d5  = 21.3;  // [10:0.1:30]
t10 ="10";
d10 = 19.7;  // [10:0.1:30]
t20 ="20";
d20 = 22.3;  // [10:0.1:30]
t50 ="50";
d50 = 24.2;  // [10:0.1:30]
t100="1€";
d100= 23.4;  // [10:0.1:30]
t200="2€";
d200= 25.7;  // [10:0.1:30]

/* [Druckereinstellungen] */
// Genauigkeit
$fn = 100;       // [0:1:1000]

// Coin-Slot
module slot(d=0) { 
    linear_extrude(height=Z-ZB+0.01) circle(d=d+T);
}    


// Main
ds=[d200,d1,d2,d5,d10,d20,d50,d100];
do=[d200,d10,d2,d20,d100,d50,d1,d5];
ts=[t200,t1,t2,t5,t10,t20,t50,t100];
to=[t200,t10,t2,t20,t100,t50,t1,t5];

d= (sort==true)? ds : do;
t= (sort==true)? ts : to;

alpha=[0,0+59,90,180-59,180,180+59,270,360-59];

color("darkgrey") union() {
    difference() {
    linear_extrude(height=Z) resize([X,Y])circle(d=X);
        for (i=[0:1:7]) {
          // Position am Rand bestimmen
          x1=   cos(alpha[i])*X/2;
          y1=   sin(alpha[i])*Y/2;  
          // Münzschächte nach innen versetzen
          x2=x1-cos(alpha[i])*(d[i]/2-A);
          y2=y1-sin(alpha[i])*(d[i]/2-A);
          translate([x2,y2,ZB]) slot(d[i]);
          // Textkoordinaten
          x3=x1-cos(alpha[i]+25*(len(t[i])))*(d[i]/2-A);
          y3=y1-sin(alpha[i]+25*(len(t[i])))*(d[i]/2-A);
          #translate([x3,y3,ZB-2*T+0.001]) rotate(alpha[i]+90)  linear_extrude(2*T) text(t[i],direction="ltr",size=8);
          // Gradierung
          color("black") translate([x2,y2,Z-G+0.001]) cylinder(r1=d[i]/2,r2=d[i]/2+G,h=G);
          // Mittelbohrung
          translate([0,0,-0.005]) linear_extrude(Z+0.01) scale([2,1,0]) circle(r=8);
        }
    }
    translate([0,8,Z-1.5*A]) rotate([90,0,0]) cylinder(r=1.5*A,h=16);
}