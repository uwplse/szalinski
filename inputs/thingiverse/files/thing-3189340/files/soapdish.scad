//globals

n=2;   //number of turns
angle=n*360; //360,320
a=0.0001;  //this determines the od of spiral 0.04
thk=2;
$fn=100;

function sr(t=1) =a*t*t;  //Archimedean spiral
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


module hip(){
2d_spiral();
translate([n*26,0,0]) 
mirror() 2d_spiral(); }

module hmh(){
    union(){
hip(); mirror() hip();
    }
}

module rounded_cube (w=40,d=20,h=10,r=2){
    translate([r,r,r])
minkowski() {
    cube(size=[w-2*r,d-2*r,h-2*r]);
    sphere(r=r,$fn=100);
}
}


module hoh(){
union(){
translate([0,-n*21,0]) hmh(); mirror([0,1]) hmh();
}
}

//
module soapdish(){
difference(){
linear_extrude(height=14, scale=1.13) scale([0.7,0.6,0.6]) hoh();

translate([-110/2, -73/2-13.5, 3]) rounded_cube (w=110,d=73,h=50,r=3);
translate([-90/2, -150/2-13.5, 8]) rounded_cube (w=90,d=150,h=50,r=20);    
}}

soapdish();
