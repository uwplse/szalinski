//globals
//scaling in x,y, and z dimensions
scalex=0.5;
scaley=0.5;
scalez=0.5;
thk=2; //shell thickness

//Pattern parameters
n=2;   //number of turns
angle=n*360;
a=0.0001;  //this determines the od of spiral 0.04
$fn=100;

function sr(t=1) =a*t*t;  
function sx(t)=sr(t) *cos(t);
function sy(t)=sr(t) *sin(t);

module 2d_spiral(){
union(){
for (t=[1:1:angle]){
 hull(){   
translate([sx(t),sy(t),0]) circle(thk,center=true);
translate([sx(t+1),sy(t+1),0]) circle(thk,center=true);
}
}
}
}

module 2d_infinity()
{
2d_spiral();
    translate([n*n*26,0,0]) mirror([1,0,0]) rotate([180,0,0]) 2d_spiral();
}


module horns(){
2d_infinity(); mirror() 2d_infinity();
}

module holder(){
    scale(0.5)
linear_extrude(height=120,twist=0,scale=1.3) 2d_pattern();
}

module base(){
translate([0,0,2.5])
difference(){
cube([150,75,5], center=true);
translate([-0,0,2])
    cube([145,70,4], center=true);
}
}

module 2d_pattern(){
difference(){
square([400,200], center=true);
difference(){
square([400,200], center=true);
horns(); mirror([0,1,0]) horns();
}
}}

module toolstand(){
    union(){
holder();
base();
    }
}

scale([scalex,scaley,scalez])
toolstand();
