// Customizable Pipe Clamp
// Author Mathias Dietz
// http://gcodeprintr.dietzm.de

//Radius of the pipe 
r1=30; 
//Width of the pipe clamp
h=20; // [10:100] 
//Strength of the pipe clamp
s=10; // [10:Strong,8:Normal, 6:Light]
//Radius of the screw holes 
r4=3.5; // [1.5:0.5:5] 
//Connector Type
con=0; // [0:None,1:Hole,2:Cube]

/* [Hidden] */

r2=r1+s; 
w=14; 
r3=8; 
th=5; 
$fn=50;

oring();
//translate([-3,16.5,0]) rotate([0,0,20]) oring();

difference(){
    uring();
 if (con==1) {
     translate([0,-5,h/2]) rotate([90,0,0]) cylinder(r=r4,h=r2) ;
     translate([0,0,h/2]) rotate([90,0,0]) cylinder(r=r4+2,h=r1+strong/4) ;
 } 
}
if (con==2) {
    difference(){
     translate([-s/2,r2-s/4,0]) cube([s,w+0.5,h]);
     translate([-s,r2+w/2-0.5,h/2]) rotate([90,0,90]) cylinder(r=r4,h=r2) ;
    }
 } 

module uring(){
difference(){
union(){
    ring();
translate([-r2-r3,0,h/3+0.5]) cylinder(r=r3,h=h/3-1);
translate([-r2-r3,-r3,h/3+0.5]) cube([w,r3,h/3-1]);
 translate([r2-2,-th,0]) cube([w,th,h]);
}
translate([-r2-r3,0,h/3]) cylinder(r=r4,h=h/3);
translate([r2+w/2-1,0,h/2]) rotate([90,0,0]) cylinder(r=r4,h=th+1) ;
translate([-r2,-0.5,0]) cube([r2*2+w,r2+1,h+1]);
}
}

module oring(){

difference(){
union(){
      ring();
translate([-r2-r3,0,0]) cylinder(r=r3,h=h/3);
translate([-r2-r3,0,h/3*2]) cylinder(r=r3,h=h/3);
translate([-r2-r3,0,0]) cube([w,r3,h/3]);
    translate([-r2-r3,0,h/3*2]) cube([w,r3,h/3]);
    translate([r2-2,0,0]) cube([w,th,h]);
}
translate([r2+w/2-1,th+1,h/2]) rotate([90,0,0]) cylinder(r=r4,h=th+1) ;
translate([-r2-r3,0,0]) cylinder(r=r4,h=h);
translate([-r2,-r2,0]) cube([r2*2,r2,h+1]); //halbkreis
}
}


module ring(){
    difference(){
        cylinder(r=r2,h=h);
        cylinder(r=r1,h=h+1);
    }
}